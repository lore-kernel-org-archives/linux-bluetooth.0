Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>,
	'Vikrampal' <vikram.pal@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1414764241-2459-1-git-send-email-gowtham.ab@samsung.com>
 <00a501cff515$0d93ebb0$28bbc310$@samsung.com>
 <CABBYNZKZ1XuRWz6shfXRf4mEmeXJZT7-ubZ0rcUGdBy7=RbM5A@mail.gmail.com>
In-reply-to: <CABBYNZKZ1XuRWz6shfXRf4mEmeXJZT7-ubZ0rcUGdBy7=RbM5A@mail.gmail.com>
Subject: RE: [PATCH 0/6] Add support for RFCOMM in btmon
Date: Mon, 03 Nov 2014 11:02:52 +0530
Message-id: <000c01cff727$b17d0720$14771560$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Monday, November 03, 2014 12:28 AM
> To: Vikrampal
> Cc: Gowtham Anandha Babu; linux-bluetooth@vger.kernel.org; Dmitry
> Kasatkin; Bharat Panda; cpgs@samsung.com
> Subject: Re: [PATCH 0/6] Add support for RFCOMM in btmon
> 
> Hi,
> 
> On Fri, Oct 31, 2014 at 4:14 PM, Vikrampal <vikram.pal@samsung.com>
> wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> >> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> >> Sent: Friday, October 31, 2014 7:34 PM
> >> To: linux-bluetooth@vger.kernel.org
> >> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
> >> cpgs@samsung.com; Gowtham Anandha Babu
> >> Subject: [PATCH 0/6] Add support for RFCOMM in btmon
> >>
> >> Adds an initial implementation for RFCOMM in Bluetooth monitor.
> >>
> >> Implementation for Decoding MSC, RPN, RLS, PN, NSC frames will  be
> >> covered in the next patch-set.
> >>
> >> Bharat Panda (2):
> >>   monitor/rfcomm: Add handlers for mcc frame type
> >>   monitor/rfcomm: Add mcc type handlers code
> >>
> >> Gowtham Anandha Babu (4):
> >>   monitor/rfcomm: Add RFCOMM support to btmon
> >>   monitor/rfcomm: Add support for RFCOMM commands
> >>   monitor/rfcomm: Add support for UIH frame decoding
> >>   monitor/rfcomm: Add support for mcc frame decoding
> >>
> >>  Makefile.tools   |   1 +
> >>  monitor/l2cap.c  |   4 +
> >>  monitor/l2cap.h  |   1 +
> >>  monitor/rfcomm.c | 333
> >> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 339 insertions(+)
> >>  create mode 100644 monitor/rfcomm.c
> >>
> >> --
> >> 1.9.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> > in
> >> the body of a message to majordomo@vger.kernel.org More majordomo
> >> info at  http://vger.kernel.org/majordomo-info.html
> >
> > Please note that android/Android.mk needs to be updated if we change
> > anything on the build of btmon.
> 
> Yes, and apparently Android.mk has not been updated so we need this fixing
> before we can apply.

I have updated the Andoird.mk file and submitted v1 for the same. Thanks for pointing out the mistake. 

Regards,
Gowtham Anandha Babu

