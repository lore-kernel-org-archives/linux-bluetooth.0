Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1104111437440.1975-100000@iolanthe.rowland.org>
References: <BANLkTikNb7FEDMbX3wSMti2e3muiaLZh-g@mail.gmail.com>
	<Pine.LNX.4.44L0.1104111437440.1975-100000@iolanthe.rowland.org>
Date: Tue, 12 Apr 2011 11:33:04 +0200
Message-ID: <BANLkTin0bKs1D3JxVODw3F+qH0ZqRwh5KA@mail.gmail.com>
Subject: Re: Endless print of uhci_result_common: failed with status 440000
From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB list <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/4/11 Alan Stern <stern@rowland.harvard.edu>:
> On Mon, 11 Apr 2011, Zdenek Kabelac wrote:
>
>> > I've created:
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=33062
>> >
>> > and I'm cc-ing linux-bluetooth.
>> >
>>
>> In fact this Ooops might be related to:
>>
>> http://marc.info/?l=linux-kernel&m=130207593728273&w=2
>
> It might be.  Did you try reverting the patch mentioned in that email?
>

Yep - it looks like the patch
http://marc.info/?l=linux-bluetooth&m=130230770920378&w=2
solved my problem with weird deadlocks.

Zdenek
