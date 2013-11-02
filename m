Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC 0/5] Disconnect complete refactoring
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
Date: Sat, 2 Nov 2013 19:17:11 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <8BF10002-95E2-4ECE-8F17-6684A9424FBB@holtmann.org>
References: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch set does some code refactoring in disconnect complete event handler
> and related functions from Mgmt layer.
> 
> This refactoring used to be one patch from LE auto connection patch set, but
> since Marcel asked me to do more changes, I put all these refactoring patches
> in its own patch set.
> 
> Regards,
> 
> Andre Guedes (5):
>  Bluetooth: Check address in mgmt_disconnect_failed()
>  Bluetooth: Add an extra check in mgmt_device_disconnected()
>  Bluetooth: Remove link type check in hci_disconn_complete_evt()
>  Bluetooth: Remove unneeded check in hci_disconn_complete_evt()
>  Bluetooth: Refactor hci_disconn_complete_evt
> 
> net/bluetooth/hci_event.c | 61 ++++++++++++++++++++++-------------------------
> net/bluetooth/mgmt.c      | 15 +++++++++++-
> 2 files changed, 43 insertions(+), 33 deletions(-)

I applied the first 3 patches of this series to bluetooth-next tree. You need to fix up patch 4 and resend the rest.

Regards

Marcel

