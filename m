Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] rtlbt: Add Realtek Bluetooth profiling support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0551C926975A174EA8972327741C7889ED340CE5@RS-MBS01.realsil.com.cn>
Date: Sat, 11 Feb 2017 09:44:43 +0100
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <74212B17-7307-41ED-B2DA-C40CBBA508CF@holtmann.org>
References: <20170209182341.4977-1-Larry.Finger@lwfinger.net>
 <485E2AC8-A0F6-4D02-9CB0-D73A231E6FB5@holtmann.org>
 <0551C926975A174EA8972327741C7889ED340CE5@RS-MBS01.realsil.com.cn>
To: =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> First, let me explain the BT profiling.
> BT profiling parses some packets like connection complete event, l2cap conn req/rsp, ... to get profiles information for firmware.
> Firmware uses the information to balance packet transmission priority to get good user experience.
> The typical scenarios:
> 1. a2dp transmission and opp transmission at the same time.

that should work just fine with SO_PRIORITY. There is no need for the firmware to play tricks. Just trust that we prioritise the packets correctly. Which we already do.

> 2. a2dp transmission and WiFi data transmission with one shared antenna at the same time.
> a2dp transmission needs higher priority.

I wonder why not use the SO_PRIORITY setting we have anyway. It is actually more precise than what you have based on ACL handles. Since it will even prioritise between different L2CAP connections on the same ACL handle.

> Currently I found there is no filter for the specific packets except checking packets from hci raw/monitor socket or hack in btusb.c
> If I miss something, please let me know, thanks.

There is nothing for it since it was never needed. As I said, doing this for Bluetooth vs Bluetooth connections inside the firmware, that is totally pointless. Just trust the host stack that it sends you the packets in the right order. Which is what we do.

For WiFi sharing the same antenna, I am fine adding extra callbacks to the driver. However this has to be internal and handed to the driver as extra information. As I said above, we already have SO_PRIORITY and so we know which ACL handle gets priority over another. We actually also know this for L2CAP connections and RFCOMM channels since it works all the way through the stack.

> For the vendor commands HCI_VENDOR_SET_PF_REPORT_CMD and HCI_VENDOR_SET_BITPOOL_CMD, the former is used to send BT profiles information to firmware.
> The other is used to send bitpool value(from a2dp) to firmware.

I want the full description here. Especially the SET_PF_REPORT_CMD. What are the parameters and how is it suppose to work. How often does it need to be used. How to clear that information, do they survive HCI_Reset etc. The best way is if you send me the Realtek HCI vendor documentation (privately if you want to).

As I said, I see the point for WiFi vs Bluetooth if you share the same antenna. And we can certainly make this work. I am however not trying to optimise Bluetooth vs Bluetooth since that actually does work correctly.

For the SBC bitpool setting of A2DP, I am not even sure on how that is relevant, but I would clearly do that as a second patch (if ever).

Regards

Marcel

