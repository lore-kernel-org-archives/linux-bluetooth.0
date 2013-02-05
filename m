Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: linux-bluetooth@vger.kernel.org
Subject: cross-compilation setup
Date: Tue, 05 Feb 2013 13:03:26 -0500
Message-ID: <87vca6hc41.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to ./configure, make, and make install bluez 5.2 into my
embedded linux project. I have a few questions on where things are
placed, which I would think are specified in the configure stage. Here
is my skeleton configure.mak with the specific questions.

So, apart from --sysconfdir, I don't see the options in README to
specify what I need. Can someone please help?

--Randy

# Author: Randy Yates
# Function: Bluez ./configure makefile
#
# this is my bluez configuration makefile. i wanted to have the
# configuration options recorded somewhere, and a makefile seemed to be
# a good choice. make -f configure.mak
#
# requires the following variables
# 
#   TARGET_ROOTFS
#   DEVELOPMENT_ROOTFS

# 1. what output does "make" generate? what executables, shared libraries, etc?
#
# 2. how do you specify the cross-compiler to use in make?
# 
# 3. what does "make install" install?
# 
#   a. the output in 1? to where? (needs to go into $(TARGET_ROOTFS)/usr/bin)
# 
#   b. the .h and other developer files? to where? (needs to go into $(DEVELOPMENT_ROOTFS)/inc, $(DEVELOPMENT_ROOTFS)/lib, etc. 
# 
#   c. documentation (manpages, etc.)? to where? (needs to go to /dev/null)
# 
#   d. what else and to where?
# 

-include Rules.make

.PHONY += configure
configure :
	./configure --prefix=/usr --sysconfdir=$(TARGET_ROOTFS)/rootfs-partial/etc --localstatedir=/var --disable-cups 


-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
