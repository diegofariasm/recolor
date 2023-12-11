from setuptools import setup

setup(
    name='recolor',
    version='0.1.0',
    scripts=[
        'recolor.py',
    ],
    entry_points={
        'console_scripts': [
            'recolor=recolor:main',
        ],
    },
)
