Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Bluez 5.43 - Problems with btmgmt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANdxJyqO3mPKdsL4iy2JNq8111Ags+9Af-S0Vi+X+1AEdUextQ@mail.gmail.com>
Date: Wed, 26 Jul 2017 11:25:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <354B5E5A-BEFA-434F-AAF3-EBE782D718E3@holtmann.org>
References: <CANdxJyqO3mPKdsL4iy2JNq8111Ags+9Af-S0Vi+X+1AEdUextQ@mail.gmail.com>
To: Alvin Lovi <alvinlovi80@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alvin,

> Hi, I'm trying to use the btmgmt command line tool integrated in the
> above Bluez version and i've found the following problems/doubts:
> 
> 1. btmgmt pair -c  [cap] -t [type] <rem addr.>
> The tool automatically sends Passkey or PIN negative reply without
> waiting any user input
> 
> 2. btmgmt pair -c 0x04 -t 0x00 <rem addr.>
> The sniffed pcap gives "IO Capability: Display Yes/NO (0x01)"
> 
> 3. I've found the "disconnect" command but i haven't found the
> "connect" one: is it present or not?

can you run btmon at the same time. Recent kernels should also provide proper mgmt tracing capabilities.

Regards

Marcel

