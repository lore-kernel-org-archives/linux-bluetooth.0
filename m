Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: Marcel Holtmann <marcel@holtmann.org>, Edd Dumbill <edd@usefulinc.com>,
   Peter Klausler <peter@klausler.com>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031204085314.GA1780@smartdata.ch>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus>  <20031204085314.GA1780@smartdata.ch>
Content-Type: text/plain
Message-Id: <1071001915.13464.33.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Tue, 09 Dec 2003 21:31:55 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

I have still some small glitches with my MX900. I have done the
following procedure :

1. XFree patch

I patched my XFree (gentoo xfree-4.3.99.16) with this patch
(http://www.yhbt.net/normalperson/files/linux/LogitechMX_kernel_and_X_patch/4.3.0-XFree86_logitech_ps2.patch), to make it understand PS/2+ protocol. Do I need this for the MX900 ?

2. bthid patches

- started with the bthid 0.8 stock source
- applied Edd Dumbill's uinput patch
- applied Olivier Bornet's patch-bthid-0.6-for-lt.txt
- modified out.c to use /dev/misc/uinput (Marcel says devfs produce
this, I don't see exactly what I do wrong or what I should do to get
/dev/input/uinput).

3. XF86Config-4

--------
Section "InputDevice"
        Identifier              "LogitechUSBMouse"
        Driver                  "mouse"
        Option "Protocol"       "ExplorerPS/2"
        Option "Device"         "/dev/input/mice"
        Option "ZAxisMapping"   "7 8"
        Option "Resolution"     "800"
        Option "SmartScroll"    "1"
        Option "Buttons"        "8"
        Option "Emulate3Buttons" "false"
EndSection
----------------

works : 

- mouse movements : clean, precise, perfect
- buttons : 1,2,3 (2 = wheel-press)

problems :

- wheel doesn't work, even if I see button-7 and button-8 in xev output when I move the wheel.

do I use the correct protocol ?

Hints welcome...

TIA,
Charles
