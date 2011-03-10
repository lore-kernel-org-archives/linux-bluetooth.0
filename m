Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 10 Mar 2011 20:33:49 +0800
Message-ID: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
Subject: some questions about Bluez
From: loody <miloody@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi all:
I have some questions about bluetooth.
1. how many additional libs that I need to successfully compile bluez?
so far as I know are:
    a. DBUS
    b. GLIB
    c. ALSA
    d. GSTREAMER
    e. USB
    f. SNDFILE
    g.CAPNG
am I right?

2. I try to compile Bluez to run on mips platform.
What I need is a simple tool which can tell me what kind of bluetooth
device around my usb bluetooth controller.
it seems I only need to enable USB lib above, right?

3. from configure, I found we can turn off features by setting
"--disable-xxxx", so I use below configure command for configuring
./configure --prefix=/media/sdb1/bluez-4.89.mips/build
--host=mipsel-linux-gnu --disable-optimization --disable-fortify
--disable-pie --disable-network --disable-serial --disable-input
--disable-audio --disable-service

but it still complain to me that he cannot find alsa header files and libs.

Thanks for your help in advance,
miloody
