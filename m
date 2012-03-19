Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Andre Guedes <andre.guedes@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: LE/BR/EDR interleaved scanning
Date: Mon, 19 Mar 2012 13:58:10 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B4521BD@DNCE02.ent.ti.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B452173@DNCE02.ent.ti.com>
 <CACJA=fW5vX008p7w8fcgLS=nHLkq91EaYpskpf6TkJxBA_+bPw@mail.gmail.com>
In-Reply-To: <CACJA=fW5vX008p7w8fcgLS=nHLkq91EaYpskpf6TkJxBA_+bPw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Andre,

> -----Original Message-----
> From: Andre Guedes [mailto:andre.guedes@openbossa.org]
> Sent: Monday, March 19, 2012 3:55 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: LE/BR/EDR interleaved scanning
> 
> Hi Chen Ganir,
> 
> On Mon, Mar 19, 2012 at 9:55 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> > Hi.
> >
> > The current implementation of the Bluetooth-next interleaved scan
> will currently do LE scan , and then BR/EDR scan, although the specs
> clearly defines that BR/EDR device search should be performed first,
> and only when done, LE device scan should start. Is there a specific
> reason why the spec was not followed here ?
> 
> Implementing LE scan first had some advantages:
> 1. From the implementation point of view, we don't need to change
> anything in BR/EDR discovery neither name resolution code. All logic
> in inquiry_complete_event keeps the same.
> 2. Doing BR/EDR + LE + name resolution we have a 5.12 sec gap between
> finding BR/EDR devices and resolving its names. During LE discovery,
> BR/EDR devices may be out of range and we'll waste time trying to
> resolve its names. By doing LE scan first, we don't have this problem.
> 
> Besides, we didn't find any constrain in GAP TS spec about that. Also,
> the Core spec clearly says performing BR/EDR + LE is just a
> recommendation about how to implement interleaving (see Vol 3, page
> 386).

Thanks for clearing that out.

> 
> BR,
> 
> Andre

Chen Ganir
Texas Instruments.
