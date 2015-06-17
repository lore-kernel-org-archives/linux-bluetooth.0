Return-Path: <cyrus@holtmann.org>
Message-id: <55817325.8070100@samsung.com>
Date: Wed, 17 Jun 2015 22:16:21 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Query on how to use btmon/hcidump regarding FM packets on TI WiLink7
 Driver
Content-type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

May I ask how to use btmon/hcidump when FM packet is over HCI uart in
Texas Instruments WiLink7 driver?

As far as I understand FM command and events are not captured in 
btmon/hcidump.

I think RX is simple because FM packet could be copied to hci_core.c. 
but I am not clear about TX.

Thanks in advance
Chanyeol
