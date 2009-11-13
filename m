Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 13 Nov 2009 19:47:43 +0100
Message-ID: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
Subject: Getting/setting Inquiry trasmit power level unsolved
From: Natale Vinto <ebballon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
I've this issue: while trying to get/set inquiry transmit power level
from a bluetooth usb dongle on 2.6 kernels I got always this error:

Can't read inquiry transmit power level on hci0: Input/output error (5)

I've tried with any bluetooth usb dongle class (1.1, 2 and 2.1) from
many vendors (ex. Sitecom, Trust, D-Link, Belkin, etc), in many 2.6.x
kernels ( 2.6.{27,31} ) on Debian and Ubuntu machines using BlueZ 3.x
and 4.x stack and I got always that error while trying to get the TPL
with:

hciconfig <device> inqtpl

I searched a lot in mailing list archives and I haven't seen any
solution for this issue, I've found maybe useful only this old email

http://osdir.com/ml/bluez.devel/2003-06/msg00140.html

where is suggested a CSR chipset based hardware.
Also looking in sources I found that the problem comes from this pieces of code:

int8_t level;

        if (hci_read_inquiry_transmit_power_level(dd, &level, 1000) < 0) {
            fprintf(stderr, "Can't read inquiry transmit power level
on hci%d: %s (%d)\n",
                        hdev, strerror(errno), errno);
            exit(1);
        }

My question is : how can I have the inqtpl option working? Should I
buy only CSR hardware dongle? I'm considering usb dongle because they
are the most common in the market, although it could be a linux-usb
issue I wonder how to try to fix it!

I'm working as sys admin (part-time, do the evolution baby!) for
embedded devices for a company that deal with proximity marketing
using linux and they would be very pleased to make you a donation if
you could suggest us a solution in order to have this issue fixed
cause it would optimize inquiries so fine, this is a primary goal for
the development team itself.

Thank you

Best Regards

--
Natale Vinto
http://www.hictech.com
http://bluesman.gotext.org
