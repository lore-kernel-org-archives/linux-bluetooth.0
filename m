Return-Path: <cyrus@holtmann.org>
Message-ID: <039f01c88a15$a848aaa0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <marcel@holtmann.org>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <1205440348.12951.9.camel@californication>
Subject: Re: [Bluez-devel] Moving towards a new API for BlueZ 4.0
Date: Wed, 19 Mar 2008 18:04:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Thanks for all of the great effort, especially in moving toward the DBus model.

I am currently going through the work done to date in audio/control.c (the implementation of AVRCP), and am trying to apply that to 
an application connecting with an AVRCP on CSR's BlueLab 4.0 framework (implements BT2.1+).  I have some ideas, although I am still 
making sure I understand what has been done to this point, and would like to participate in further development (although I am not 
the best C developer).

As things stand, it appears we could use more functions and callbacks to support UnitInfo, SubUnitInfo, Passthrough, and 
VendorDependent (wherein Metadata resides), etc., and at the same time, I think we should not constrain the use cases to the simple 
10-button remote that has been implemented to date.

At any rate, I would like to get involved, as I have immediate interest in moving this forward.  I do have the official Bluetooth 
specs and the CSR IDE, so I think I could contribute from that front.

Any interest?  Who should I communicate with?

David Stockwell


----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Thursday, March 13, 2008 3:32 PM
Subject: [Bluez-devel] Moving towards a new API for BlueZ 4.0


Hi Folks,

so we are near to the end-of-lifetime for the BlueZ 3.x series. We will
have only a few release left and the plan is to end it with the magic
number 3.33 in a few weeks.

Everybody is currently working hard at implemented the new features and
API changes for the 4.x series. We will deprecated a big chunk of the
D-Bus API and basically do major simplifications. For a preview you can
check the new doc/ directory in the bluez-utils CVS repository. It
contains documentation for the new manager, adapter, device and agent
interfaces. The real new stuff is the device interface which will
represent paired and known remote device. Also the agent interface
changes a lot to implement what we have learned during the last two
years of D-Bus usage within BlueZ.

Most of the new API is already implemented and will be part of the 3.29
release within the next few days. All new features are marked as
experimental until we reach 4.0 and you have to start hcid with the -x
option to enable them.

Please review the interface APIs and do some early testing.

More to come soon :)

Regards

Marcel
