Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Query: HCI_RAW mode in Kernel 3.18
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAE2MWkmrdftQjzqkVwHTjYZYH_XRyvPmG=q0ZJzCxJ5MAEt4Tw@mail.gmail.com>
Date: Thu, 12 Feb 2015 11:20:15 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <5E858F60-A4F6-4D58-834F-AE2F01AAF229@holtmann.org>
References: <CAE2MWkn0RBeZpiJy_6t0-3zs_DCikX4Qxqpa-FGr0MYWnOM_vw@mail.gmail.com> <FC39A264-7D93-4BAA-9A85-7ACA6B762583@holtmann.org> <CAE2MWkmrdftQjzqkVwHTjYZYH_XRyvPmG=q0ZJzCxJ5MAEt4Tw@mail.gmail.com>
To: Ujjal Roy <royujjal@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ujjal,

>> what you want is to use the HCI User Channel if you need direct access to the HCI layer of a controller. Look at tools/3dsp.c and tools/ibeacon.c for examples on how to use it. In src/shared/hci.c you find the internal details of the HCI User Channel. It is a lot cleaner way of using a controller's HCI interface exclusively.
> 
> So, can you please help me to write an app? Is it possible to compile
> an app without using the bluez? I mean without placing and compiling
> the app inside bluez source code.
> If I want to create an app then what library should I have to include
> to compile successfully. Please suggest a way to build my own app to
> use user channel.

look at src/shared/hci.c and the bt_hci_new_user_channel(). That shows you on how to open the HCI User Channel. If you have it, you can send H:4 framed HCI commands, events, ACL and SCO data. It is one packet per read() / write() and thus pretty simple straight forward.

You can easily do this outside of bluez.git. The advantage of src/shared/hci.c is that it gives you the basic HCI command + event handling. However you do not have to use it.

Regards

Marcel

