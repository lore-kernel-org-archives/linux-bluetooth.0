Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	bharat.panda@samsung.com, p.sinha@samsung.com, cpgs@samsung.com
References: <004201cf6a99$bbc7d590$335780b0$@samsung.com>
 <20140514075617.GA28535@t440s.lan>
In-reply-to: <20140514075617.GA28535@t440s.lan>
Subject: RE: Add SDP discovery support to gatttool with BR
Date: Thu, 15 May 2014 16:19:51 +0530
Message-id: <008401cf702b$67556cb0$36004610$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>-----Original Message-----
>From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
>Sent: Wednesday, May 14, 2014 1:26 PM
>To: Vikrampal
>Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin;
bharat.panda@samsung.com; p.sinha@samsung.com; cpgs@samsung.com
>Subject: Re: Add SDP discovery support to gatttool with BR
>
>Hi Vikram,
>
>On Thu, May 08, 2014, Vikrampal wrote:
>> I am new to BlueZ community. I'd like to contribute to BlueZ 
>> community. I went through BlueZ's TODO items.
>> To get started, I have selected adding SDP discovery support to 
>> gatttool with BR as my first work.
>> 
>> - Add sdp discovery support to gatttool with BR (--sdp, default is 
>> 0x1f)
>
>Not sure what exactly you mean here. ATT over BR/EDR uses a fixed PSM so
separate discovery of this is not necessary. The core spec says:
>
>"The use of a fixed PSM allows rapid reconnection of the L2CAP channel for
Attribute Protocol as a preliminary SDP query is not required."
>
>Based on git blame this item was added 5th Oct 2010, i.e. in the very early
days of the LE specification. I suspect that there might have been some
confusion regarding >the ATT PSM back then. While this kind of PSM discovery
it's not completely pointless, we don't do it for any other fixed PSM
profiles either (e.g. A2DP & AVRCP) so I >think it's better to spend time on
more valuable tasks instead.
>
>I've now removed the ATT PSM related items from the TODO file (which btw
could use much more cleanups in general).
>
>Johan

Thanks for your kind advice. Could you please suggest me as to which all
topics are of more value currently so that
I may pick up one of them as my maiden contribution. 

Regards,
Vikram

