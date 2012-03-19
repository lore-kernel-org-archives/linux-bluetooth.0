Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B0260B452173@DNCE02.ent.ti.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B452173@DNCE02.ent.ti.com>
Date: Mon, 19 Mar 2012 10:54:36 -0300
Message-ID: <CACJA=fW5vX008p7w8fcgLS=nHLkq91EaYpskpf6TkJxBA_+bPw@mail.gmail.com>
Subject: Re: LE/BR/EDR interleaved scanning
From: Andre Guedes <andre.guedes@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir,

On Mon, Mar 19, 2012 at 9:55 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Hi.
>
> The current implementation of the Bluetooth-next interleaved scan will currently do LE scan , and then BR/EDR scan, although the specs clearly defines that BR/EDR device search should be performed first, and only when done, LE device scan should start. Is there a specific reason why the spec was not followed here ?

Implementing LE scan first had some advantages:
1. From the implementation point of view, we don't need to change
anything in BR/EDR discovery neither name resolution code. All logic
in inquiry_complete_event keeps the same.
2. Doing BR/EDR + LE + name resolution we have a 5.12 sec gap between
finding BR/EDR devices and resolving its names. During LE discovery,
BR/EDR devices may be out of range and we'll waste time trying to
resolve its names. By doing LE scan first, we don't have this problem.

Besides, we didn't find any constrain in GAP TS spec about that. Also,
the Core spec clearly says performing BR/EDR + LE is just a
recommendation about how to implement interleaving (see Vol 3, page
386).

BR,

Andre
