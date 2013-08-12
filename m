Return-Path: <cyrus@holtmann.org>
Message-ID: <52089E1F.60704@linux.intel.com>
Date: Mon, 12 Aug 2013 10:34:39 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] sco-tester: Update ECONNABORTED to EOPNOTSUPP
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com> <09231CA6-E5F3-453E-9479-68F08072893A@holtmann.org>
In-Reply-To: <09231CA6-E5F3-453E-9479-68F08072893A@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> can we please have a proper thread on what error is appropriate to send  > from a socket interface when this situation happens. I see that
 > we are flipping errors, but my request to discuss this gets ignored.
>

I already gave my opinion previously. Let's recall it :"About the error 
ECONNABORTED, it is what the patch does : abort a connection. It is not 
used for other purposes. If you really want to change, I'm ok with 
EOPNOTSUPP, otherwise please suggest."

Regarding EOPNOTSUPP. Most use case are when a pointer in an interface 
is not implemented. We could consider that SetupSyncConn is not 
implemented in 2.0 adapter interfaces.


 > Please look for a good reference of the error code usage in other 
socket protocols or manpages

It is not obvious to find one good reference. But for example there is : 
Documentation/ioctl/hdio.txt:     EOPNOTSUPP    Hardware interface does 
not support bus power

Another option could be:
[ENODEV]
     No such device An attempt was made to apply an inappropriate 
function to a device; for example, trying to read a write-only device 
such as a printer.

BR,
Fred
