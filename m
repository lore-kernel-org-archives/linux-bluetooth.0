Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Ravi Minnikanti <ravichandraminnikanti@gmail.com>
Subject: Re: SCO unknown connection handle issue
Message-ID: <824df95f-7069-fe0f-c124-b239da5c9216@gmail.com>
Date: Sat, 29 Jul 2017 19:41:25 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have HFP 1.5 implementation on my Linux box which doesn't work with 
specific HFP AG devices.
Issue is, once I accept HF-AG incoming audio, I see that the existing 
SCO connection is getting disconnected and my device receives a new SCO 
connection from AG device.

I checked HFP 1.5 specifications and bluetooth 4.0 specifications. But, 
unable to figure out the issue. Link supervision timeout is also not the 
problem.
Can someone please help me to understand in which case this issue may 
happen.

dmesg shows: Bluetooth: hci0 SCO packet for unknown connection handle 63

Thanks,
Ravi
