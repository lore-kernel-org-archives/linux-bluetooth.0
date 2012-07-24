Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 18:40:50 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Naujoks <nautsch2@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Secure Simple Pairing with old software
Message-ID: <20120724214050.GI20029@joana>
References: <500EBBCB.5070905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <500EBBCB.5070905@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Naujoks <nautsch2@googlemail.com> [2012-07-24 17:14:19 +0200]:

> Hi all.
> 
> I am currently trying to evaluate the bluetooth capabilities of an
> embeded device I am currently using and I feel kind of stupid asking
> this here, because I am probably missing something.
> 
> I have a 2.6.28.10 kernel and 3.32 bluez-utils and bluez-libs on a
> MPC5200 PowerPC. Is it possible to get this combination to do SSP? I
> found some old threads in the mailing lists, but there was no real solution.

Heh, you are living in the past, SSP support only arrived in the 4.x series
and that was like 4 years ago. 3.x is deprecated these days, you won't get any
support for it here.

	Gustavo
