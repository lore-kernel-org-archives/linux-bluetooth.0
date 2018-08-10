Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] Bluetooth: Add definitions for LE set address
 resolution
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1533627995-11330-1-git-send-email-ankit.p.navik@intel.com>
Date: Fri, 10 Aug 2018 17:01:40 +0200
Cc: linux-bluetooth@vger.kernel.org, bharat.b.panda@intel.com
Message-Id: <FB889290-2964-4631-8BE7-F477F41DBE32@holtmann.org>
References: <1533627995-11330-1-git-send-email-ankit.p.navik@intel.com>
To: Ankit Navik <ankit.p.navik@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankit,

> Add the definitions for LE address resolution enable HCI commands.
> When the LE address resolution enable gets changed via HCI commands
> make sure that flag gets updated.
> 
> Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
> ---
> include/net/bluetooth/hci.h |  3 +++
> net/bluetooth/hci_event.c   | 28 ++++++++++++++++++++++++++++
> 2 files changed, 31 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
