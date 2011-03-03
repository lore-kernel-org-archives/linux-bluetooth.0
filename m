Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6FF23D.5020608@codeaurora.org>
Date: Thu, 03 Mar 2011 11:55:41 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: vinicius.gomes@openbossa.org, johan.hedberg@gmail.com
Subject: RFC: LE Security Manager and next steps
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Vinicius & All,

I am starting to move forward on the LE Security Manager for bluez.  I 
am currently using the patches submitted by Vinicius for bluetooth-next, 
and hope that they are accepted by Gustavo soon, but at some point, I 
will be forced to move forward with or without that acceptance.

My more immediate attention is therefore placed on key storage (LTK, 
IRK, CSRK), and high level APIs, in particular Passkey agents for MITM 
support.

If anyone is working these problem already, I would like to discuss 
details, so that we are not coming up with competing solutions.  The 
main reason I would like Vinicius' patches accepted sooner rather than 
later is so that I (and others) can start contributing these next pieces 
without creating a divergence headache.

To begin with, I am planning on making the key storage part of the 
existing system used by BR/EDR. I am primarily concerned with Dual Mode 
devices, and we believe that from a "big system" point of view, that 
most of the differences between remote dual-mode and remote LE-only can 
be largely abstracted and out of sight by high level apps.  The main 
differences between LE keys and BR/EDR keys of course is that there are 
multiple keys per "pairs of devices", and except for LTKs, they are used 
very differently.

Also, I understand that some people think that Write-Cmd signing (CSRK) 
and verification should be a function of GATT/ATT in User space, and 
others think it should be handled down in the SM kernel on the way out 
(and in).  I know that the crypto library is being brought into the 
kernel for STK resolution, and this would seem to point towards kernel 
based signing and verification.

Privacy is the biggest problem however.  Identity *resolution* can of 
course be done at the kernel level but if addresses change, we will need 
to come up with a plan as to how to deal with everything up to and 
including dbus object-paths that currently include an ascii 
representation of the BD Addr as part of the path.  At the highest 
(DBus) level I am thinking that a signal on the original object path 
might work when we connect/detect a new address for an existing device, 
and an object path which is then an extension of the originally paired 
device:

If Original was:
/org/bluez/3456/hci0/dev_XX_XX_XX_XX_XX_XX

The Private could be:
/org/bluez/3456/hci0/dev_XX_XX_XX_XX_XX_XX/priv_YY_YY_YY_YY_YY_YY


Anyway, we are starting work on this soon, so if there is 
competing/complimentary work being done, I would really like to hear 
from you.  There is a lot to be done here, and I'd like to have the 
architectural conversations sooner rather than later.

I would also like to hear from you if you simply have a good idea of how 
you think these LE pieces should be architected, and haven't started 
writing code.



-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
