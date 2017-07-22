Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170722190323.mt5mrnioql7z2uj2@earth>
Date: Sat, 22 Jul 2017 21:08:15 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DC17CA45-3AB5-4272-A12A-1C7BD4811258@holtmann.org>
References: <20170722095747.101069-1-marcel@holtmann.org>
 <20170722190323.mt5mrnioql7z2uj2@earth>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

>> The Nokia devices require the setup of its Public Bluetooth Device
>> Address and for that it is required to depend on vendor specific
>> commands. For Broadcom based Nokia devices, that is part of btbcm
>> module and can be selected via BT_BCM config option.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

btw. we need to also provide the set_bdaddr for TI chips.

Regards

Marcel

