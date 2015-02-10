Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Query: HCI_RAW mode in Kernel 3.18
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAE2MWkn0RBeZpiJy_6t0-3zs_DCikX4Qxqpa-FGr0MYWnOM_vw@mail.gmail.com>
Date: Tue, 10 Feb 2015 06:21:21 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <FC39A264-7D93-4BAA-9A85-7ACA6B762583@holtmann.org>
References: <CAE2MWkn0RBeZpiJy_6t0-3zs_DCikX4Qxqpa-FGr0MYWnOM_vw@mail.gmail.com>
To: Ujjal Roy <royujjal@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ujjal,

> I have a question regarding RAW mode.
> 
> Is it still possible to use RAW mode in Kernel 3.18? If so how to use
> the RAW mode? Please help me. I had an app which used to change the
> the mode to RAW (HCISETRAW command). This feature is removed from
> Kernel. Please reply and help me if there is any way to use the RAW
> mode.

what you want is to use the HCI User Channel if you need direct access to the HCI layer of a controller. Look at tools/3dsp.c and tools/ibeacon.c for examples on how to use it. In src/shared/hci.c you find the internal details of the HCI User Channel. It is a lot cleaner way of using a controller's HCI interface exclusively.

Regards

Marcel

