Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
References: <1415358545-10145-1-git-send-email-gowtham.ab@samsung.com>
 <1415358545-10145-3-git-send-email-gowtham.ab@samsung.com>
 <20141107114531.GA12813@t440s.lan>
In-reply-to: <20141107114531.GA12813@t440s.lan>
Subject: RE: [PATCH  2/4] monitor/rfcomm: Add support for printing RFCOMM hdr
Date: Fri, 07 Nov 2014 18:39:50 +0530
Message-id: <000c01cffa8c$37d4c490$a77e4db0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Friday, November 07, 2014 5:16 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; d.kasatkin@samsung.com;
> bharat.panda@samsung.com; cpgs@samsung.com
> Subject: Re: [PATCH 2/4] monitor/rfcomm: Add support for printing
> RFCOMM hdr
> 
> Hi Gowtham,
> 
> On Fri, Nov 07, 2014, Gowtham Anandha Babu wrote:
> > Changes made to decode RFCOMM hdr and print the same.
> >
> >       RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
> 
> Could you add a space here between (UIH) and (0xef)
> 
> >          Address : (0x01)
> 
> No space before ':' and no need to have parenthesis around the hex value.
> The reason why that exists elsewhere is to make it clear that the value is
> separate of the preceding string translation (which you don't have here).
> 
> >            Command/Response Bit: 0
> >            DLCI : (0x00)
> >          Control : (0xef)
> >            Poll/Final Bit : 0
> >          Length : 10
> >          FCS : (0xaa)
> >         81 11 20 e0 27 00 9a 02 00 07 aa                 .. .'......
> 
> I'd prefer if we could try to stick to the hcidump-style decoding and make
this
> more compact. I.e. you could have something like:
> 
> 	Address: 0x01 cr 0 dlci 0
> 	Control: 0xef poll/final 0
> 	Length: 10
> 	...
> 
> Johan

I have incorporated the comments and submitted v1 for the same.

Regards,
Gowtham

