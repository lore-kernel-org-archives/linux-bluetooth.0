Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 12 Oct 2016 09:22:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hieu Le <hieu.le@veriksystems.com>
Cc: Steve Gladden <steve@michiganbroadband.com>,
        Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: How can you set Transmit power level in Bluetooth LE mode for an
 LE beacon?
Message-ID: <20161012072244.GA29209@x1c>
References: <FEFD25773376F6448FE2884F5C1FA527F5E8622404@X2.michiganbb.local>
 <FEFD25773376F6448FE2884F5C1FA5270117A63D4D2C@X2.michiganbb.local>
 <CAAu3APZmaK_npAwEk9cd=KB8zqt2=DFnKJqV8Wd_QTUNi5vHrQ@mail.gmail.com>
 <FEFD25773376F6448FE2884F5C1FA5270117A63D4D2D@X2.michiganbb.local>
 <CADEmUHMF3gRai_kUHcKwA5RMi3WevMsE00NL2_NqWZWgu27OuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADEmUHMF3gRai_kUHcKwA5RMi3WevMsE00NL2_NqWZWgu27OuA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 12, 2016, Hieu Le wrote:
> In my opinion, the only way I can find to increase the tx_power is to
> recompile the linux kernel. There may be a better way
> 
> It seems that bluetooth stack within kernel separated into two classes:
> 1. Inquiry Tx_power.
> 2. Advertise Tx_power.
> 
> And the default value is 0.
> 
> You can take a look at:
> *hci_alloc_dev(void)  function within net/bluetooth/hci_core.c file
> hdev->inq_tx_power = HCI_TX_POWER_INVALID;
> hdev->adv_tx_power = HCI_TX_POWER_INVALID;

The adv_tx_power is not used for changing the controller advertising TX
power. It's only used for reading the current controller setting and
storing it in this variable. The reason for all this is that currently
(as of Bluetooth 4.2) there is no standard HCI command for changing the
advertising TX power.

Johan
