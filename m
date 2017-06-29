Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ravi Minnikanti <ravi.minnikanti@gslab.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: How to make GATT only accessible over LE connection
Message-ID: <f612968b-a3c5-c047-80c5-5f3b6ad711ac@gslab.com>
Date: Thu, 29 Jun 2017 17:58:14 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a GATT service implemented with "encrypt-write" characteristic 
flags on a dual-mode chipset. It works well over a LE connection with 
AES-CCM encryption.
But, my GATT characteristics are accessible over BR/EDR connection which 
uses a Link key encryption.
Can someone please help me to know, Is there any way I can make my GATT 
only accessible over a LE connection ?
I understand that this cannot be done from bluez and should be done at 
kernel.

Thanks,

Ravi

