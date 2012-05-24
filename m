Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 05:14:05 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Reorganizing the BlueZ source tree
Message-ID: <20120524081405.GA30941@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Everyone,

The last profiles addition to BlueZ increased a lot the number of folders we
have in the root dir of the project and it looks like more profiles (and more
folders) are expected to come.

I talked a bit with Johan about changing the hierarchy of the BlueZ tree and
the following proposal where 2 new folders are created, 'profiles' and 'libs'
and things are moved to them.

compat          -> /dev/null (will be removed on 5.0)
alert           -> profiles
audio           -> profiles
cups            -> profiles
deviceinfo      -> profiles
health          -> profiles
input           -> profiles
lib             -> profiles
network         -> profiles
proximity       -> profiles
sap             -> profiles
serial          -> profiles
thermometer     -> profiles
time            -> profiles
btio            -> libs
gdbus           -> libs
sbc             -> libs
emulator        -> tools
mgmt            -> tools
monitor         -> tools
attrib
doc
plugins
scripts
src
test
tools
unit


In the end we will have 10 folders instead of 28 in the current configuration.
Folders like 'tools' can also be reorganized.

	Gustavo
