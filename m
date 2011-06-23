Return-Path: <cyrus@holtmann.org>
From: Hendrik Sattler <post@hendrik-sattler.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: SRM support in OBEX
Date: Thu, 23 Jun 2011 14:04:43 +0200
References: <BANLkTi=T4dqgKW_7WA9BT7EQ9UY4mRZ7JA@mail.gmail.com> <EC94610F2568494D8D9291885C48D3103D01AC@nasanexd01a.na.qualcomm.com> <BANLkTinqMv7Qr+FPWf0njyf0KKGcMNXHQA@mail.gmail.com>
In-Reply-To: <BANLkTinqMv7Qr+FPWf0njyf0KKGcMNXHQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201106231404.43589.post@hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, 23. Juni 2011, 10:31:26 schrieb Luiz Augusto von Dentz:
> I guess he meant that to make this work properly the socket must be
> non-blocking so that OpenOBEX needs to detected when a packet could
> not be written and somehow wake-up the application whenever it can
> resume.

I mean that currently OpenOBEX uses non-blocking sockets like blocking socket 
by busy-looping until all data of one packet is written. On slow devices, this 
is maybe not wanted, especially when using non-blocking sockets in the first 
place :)
The control of re-calling OpenOBEX is still on the application side.

HS
