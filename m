Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE/BR/EDR interleaved scanning
Date: Mon, 19 Mar 2012 12:55:19 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B452173@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

The current implementation of the Bluetooth-next interleaved scan will currently do LE scan , and then BR/EDR scan, although the specs clearly defines that BR/EDR device search should be performed first, and only when done, LE device scan should start. Is there a specific reason why the spec was not followed here ?

Thanks,


Chen Ganir
Texas Instruments
