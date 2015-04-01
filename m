Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Stefan Seyfried' <stefan.seyfried@googlemail.com>
Cc: 'BlueZ devel list' <linux-bluetooth@vger.kernel.org>,
	'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
References: <551BD9BD.9040501@message-id.googlemail.com>
 <CABBYNZ+EzzcX2uMMrSQvrPhMqnruDxLf5d-vfqHNcZJOD=BCuA@mail.gmail.com>
In-reply-to: <CABBYNZ+EzzcX2uMMrSQvrPhMqnruDxLf5d-vfqHNcZJOD=BCuA@mail.gmail.com>
Subject: RE: unit/test-gatt broken again (as always :-)
Date: Wed, 01 Apr 2015 17:53:51 +0530
Message-id: <001e01d06c76$bf04adc0$3d0e0940$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Wednesday, April 01, 2015 5:38 PM
> To: Stefan Seyfried
> Cc: BlueZ devel list; Gowtham Anandha Babu
> Subject: Re: unit/test-gatt broken again (as always :-)
> 
> Hi Stefan,
> 
> On Wed, Apr 1, 2015 at 2:42 PM, Stefan Seyfried
> <stefan.seyfried@googlemail.com> wrote:
> > Hi all,
> >
> > in bluez-5.30, the testsuite again does not complete with
> >
> > MALLOC_CHECK_=3 MALLOC_PERTURB_=69 make check
> >
> > Valgrind complains about a use-after-free.
> >
> > I simply bisected the issue, this is the broken commit.
> >
> > commit 9a0d6d99c79e5cecb76b7a61b53556447f0ccbd1
> > Author: Gowtham Anandha Babu <gowtham.ab@samsung.com>
> > Date:   Thu Mar 26 18:29:06 2015 +0530
> >
> >     unit/test-gatt: Add TP/GAW/CL/BV-05-C test
> >
> >     Verify that a Generic Attribute Profile client can write a long
> >     Characteristic Value selected by handle.
> >
> > This is on plain x86_64, gcc-4.8.3 (old)
> 
> This is actually a fault in our code that the test uncovered which is good but
> we failed to see it happening, I actually have some plans to have a check-
> valgrind target to catch this type of problems or maybe there is a way to add
> MALLOC_CHECK_=3 MALLOC_PERTURB_=69 directly.
> 
> 

Good catch. I got the above error, after updating my gcc. The patch sent by Luiz resolved this issue.
Yes there may be a way for adding valgrind directly as done in
 "android/system-emulator.c" & "android/bluetoothd-wrapper.c".

Regards,
Gowtham Anandha Babu

> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

