Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Questions on event masks (specifically in tools/3dsp.c)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
Date: Fri, 16 Jun 2017 07:29:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <15900B5C-F25F-4077-B1BA-A4C3F59FD95C@holtmann.org>
References: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
To: Marcos Scriven <marcos@scriven.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcos,

> (NB I've resent this as plain text)
> 
> I've been trying out /tools/3dsp.c on a Raspberry Pi 3. There's some
> background in this thread that Marcel mentioned
> http://www.spinics.net/lists/linux-bluetooth/msg62198.html
> 
> The Raspberry Pi uses the Broadcom bcm43438 chip, which according to
> the registration documents does support connectionless slave broadcast
> 
> I don't see any errors, but nothing seems to happen, so have been
> taking a close look at the code, especially the start_glasses method.
> 
> In there I see the event masks:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.c#n316
> 
> uint8_t evtmask1[] = { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> uint8_t evtmask2[] = { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00 };

run btmon -w trace.log and post the binary trace.log file. Also look at Bluetooth 4.1 or later core spec.

Regards

Marcel

