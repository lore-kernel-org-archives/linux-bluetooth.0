Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: Wireshark and new BlueZ BTSNOOP format
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALkxMhFHWv7kxfRKrN3kq8NVRgVyk0vNpiR8ryKTm8s2b_exKQ@mail.gmail.com>
Date: Mon, 4 Nov 2013 15:40:30 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <AF259BFC-2022-4280-9F98-D4679A280A84@holtmann.org>
References: <CALkxMhFHWv7kxfRKrN3kq8NVRgVyk0vNpiR8ryKTm8s2b_exKQ@mail.gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> There is a need to add support for latest BTSNOOP format currently
> used in BlueZ (5). I have two questions:
> 
> 1. Is BlueZ btsnoop format official and stable? Or invented by BlueZ
> team? (stable? safe?)

the original btsnoop format was done by Symbian and adopted by Frontline. We started using that as well since it was better than what we had before. These are the ones with 1xxx link types.

With BlueZ 5 and kernels 3.5 and newer we introduced a Bluetooth monitor to the kernel that can catch all controllers and can catch early messages as well. Previous hcidump could only read one interface at a time and was not able to catch early init frames.

The link type 2001 is stable.

> 2. Is there any documentation describes this format?

It is documented inside the kernel as include/net/bluetooth/hci_mon.h and that is as close as it gets to documentation. btsnoop v2 takes the BTSnoop header and uses the 2001 link type and then encodes the opcode and index into the flags field. The frame data is always a raw HCI message similar to link type 1001.

> In code I saw two new magic numbers:
> 2001                   Bluetooth monitor
> 2002                   Bluetooth simulator
> Is Bluetooth simulator completed now?

The simulator is a low-level Low Energy Link Layer simulator. And it is not completed and not stable yet.

> For now Wireshark (>= 1.10, trunk is recommended) provide probably
> full Bluetooth support, all protocols, colours, filtering,
> reassembling. If you find a bug or need new feature please create a
> bug at https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=---&query_format=advanced&list_id=11093

What also would be interesting is an integration of Bluetooth monitor socket with libpcap so Wireshark can do live capture.

Regards

Marcel

