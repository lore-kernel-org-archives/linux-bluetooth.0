Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Floris Bos <bos@je-eigen-domein.nl>
Subject: Setting bd address in the device-tree era
To: linux-bluetooth@vger.kernel.org
Message-ID: <f4874a2b-9832-2d11-7c9d-d48e6512f3e8@je-eigen-domein.nl>
Date: Sun, 12 Aug 2018 13:57:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When using newer upstream Linux kernels on Raspberry Pi 3+ that have the 
brcm,bcm43438-bt serial slave device-tree entries, all devices get the 
same BD address 43:45:C0:00:1F:AC.

What is the recommend way of fixing that up nowadays?

The vendor's standard start-up script makes up a BD address derived from 
SoC serial number, and pass that as parameter to hciattach.
But that doesn't work when the kernel is managing the hci connection 
instead.
And cannot find any device-tree parameter to pass address either.


Yours sincerely,

Floris Bos
