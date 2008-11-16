Return-Path: <cyrus@holtmann.org>
Message-ID: <491FA329.5020106@comcast.net>
Date: Sat, 15 Nov 2008 20:35:53 -0800
From: Brian Rogers <brian_rogers@comcast.net>
MIME-Version: 1.0
To: XazZ XazZ <xazz.xazz@googlemail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Problem with bluez and a bluetooth headset
References: <5a14e9b50811111406m5e9e56c4u598b93506cbb8372@mail.gmail.com>
In-Reply-To: <5a14e9b50811111406m5e9e56c4u598b93506cbb8372@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

XazZ XazZ wrote:
> good evening everyone
>
> Few days ago I got a new, beautiful bluetooth headset.
> It's a Nokia BH-503
> My PC got an "ID 1131:1001 Integrated System Solution Corp. KY-BT100
> Bluetooth Adapter"
>   
I've got that same exact dongle on my desktop. It can't talk to my 
headset either, or my phone, or my laptop, or a Wiimote. I suspect it 
has issues with the new btusb in 2.6.27. I can list devices, but when I 
try to pair, it just waits until eventually the following appears in dmesg:
hci_cmd_task: hci0 command tx timeout

I had that dongle working in an earlier kernel version. On 2.6.27, my 
laptop's Bluetooth is working fine.

