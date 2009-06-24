Return-Path: <cyrus@holtmann.org>
Subject: Wacom Graphire Bluetooth HID driver - big lag
From: =?UTF-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1244390002.23850.105.camel@localhost.localdomain>
References: <1243543413.21667.23.camel@pldmachine>
	 <1243549749.21144.816.camel@cookie.hadess.net>
	 <1243588429.4951.22.camel@pldmachine>
	 <1244377549.30768.5467.camel@cookie.hadess.net>
	 <1244390002.23850.105.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 21:49:43 +0100
Message-Id: <1245876583.3880.56.camel@pldmachine>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,
I'm testing wacom bluetooth driver and there are 2 problems. One of them
is that I have to switch on tablet twice to get it working. Next problem
is that the lag is huge and I had to switch to "low speed" in bluez
patch (see here for the details:
http://cvs.fedoraproject.org/viewvc/rpms/bluez/devel/bluez-activate-wacom-mode2.patch?revision=1.1&view=markup)

I'm using:
-patched bluez-4.42
-the latest kernel 2.6.30-08503-g4e8a237-dirty
-PLD Th 3.0 distro on NC4200 HP laptop

I'm downloading Fedora LiveCD to check if these problems are
distro-related, but I had similar issues before, so I'm not expecting
any change.

Any ides what can I test/change to get rid of those problems?
Regards,
Przemo Firszt

