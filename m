Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj0YytpeGZpKC3rgh2eDVE1V9L1eZK29oGJfX_6rCesZ0wRrw@mail.gmail.com>
References: <CAMj0YytpeGZpKC3rgh2eDVE1V9L1eZK29oGJfX_6rCesZ0wRrw@mail.gmail.com>
From: Ajay Parashar <ajay.parasha@gmail.com>
Date: Wed, 10 Aug 2016 12:17:20 +0530
Message-ID: <CAMj0Yyt8HirDhQXXNqC3ipGoO3oYxeOPnv5QkyQ7LuXkv9XsRQ@mail.gmail.com>
Subject: Re: connection breaks after 2 seconds ?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 9, 2016 at 4:54 PM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
> Hi,
>
> I have two USB Bluetooth controller and connected on same Ubuntu 15.10
> PC.(kernel  4.2.0-42)
> I want to set a connection between them using blueZ 5.35.
>
> I verified by hciconfig command
> hciconfig
> ------------------------------------------------------------------------------------------------------
> hci2: Type: BR/EDR  Bus: USB
> BD Address: 00:1A:7D:DA:71:05  ACL MTU: 310:10  SCO MTU: 64:8
> UP RUNNING PSCAN ISCAN
> RX bytes:6922 acl:12 sco:0 events:171 errors:0
> TX bytes:5775 acl:12 sco:0 commands:112 errors:0
>
> hci1: Type: BR/EDR  Bus: USB
> BD Address: 00:1A:7D:DA:71:07  ACL MTU: 310:10  SCO MTU: 64:8
> UP RUNNING PSCAN ISCAN
> RX bytes:2808 acl:13 sco:0 events:155 errors:0
> TX bytes:6689 acl:12 sco:0 commands:113 errors:0
> -----------------------------------------------------------------------------------------------------------
>
>
> I opened two shell session for each controller and execute bluetoothctl.
> when i executed below command then connection established only for 2
> second and then it disconnects?
>
> [bluetooth]# connect 00:1A:7D:DA:71:05
> Attempting to connect to 00:1A:7D:DA:71:05
> [CHG] Device 00:1A:7D:DA:71:05 Connected: yes
> Failed to connect: org.bluez.Error.Failed
> [CHG] Device 00:1A:7D:DA:71:05 Connected: no
>
> Please let me know why it disconnects after 2 seconds?
>
> Regards
> Ajay

This issue has solved when I executed commands with bluetoothctl
prompt in below order.

1) agent  NoInputNoOutput
2) default-agent
3) pair
4) connect

Thanks
Ajay
