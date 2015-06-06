Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: As Slave: Disable/Delay  the sending of Connection Parameter Update Request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010E5DB58388@EMBSVR01.ember.local>
Date: Sat, 6 Jun 2015 07:05:16 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <572A78AB-9B31-48AA-9CFE-BC03F9E2944A@holtmann.org>
References: <BD5E516FF3711A41B93DC005170007BB010E5DB58388@EMBSVR01.ember.local>
To: Ankur Patel <ankur@embertec.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

> Using Bluez 5.30 based controller acting as Slave Role, I would like to prevent/delay the send Connection Parameter Update Request just after successful connection. 
> 
> Steps of Communication b/w Host and Controller:
> 1. Contoller prepared in connectable mode by issuing command:  hciconfig hci0 leadv

you are really looking for btmgmt advertising on here.

> 2) Below is the communication sequence:
>        (H -> C): Type: Command opcode: 0x200d - Create Connection
>        (C -> H): Type: Event   opcode: 0x200d - Command Status
>        (C -> H): Type: Event                  - LE Connection Complete
>        (C -> H): ACL Data:  Connection Parameter Update Request
> 
> Is it possible to disable/delay controller to send Connection Parameter Update Request or send it with any delay?

We could delay this of course. Do you have a btmon trace that shows this. I remember that at some point there was a discussion to add L2CAP socket options to define connection parameter details on a per socket basis.

Regards

Marcel

