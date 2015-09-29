Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 1/2] Bluetooth: Add hci_cmd_sync
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443531945-31344-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 29 Sep 2015 15:17:40 +0200
Cc: broonie@kernel.org,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Message-Id: <1600B955-5DC9-4868-AD89-BA4DB1EACCD1@holtmann.org>
References: <1443531945-31344-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Send a HCI command and wait for command complete event.
> This function serializes the requests by grabbing the req_lock.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v1: v2: no patch 1/2
> v3: Add hci_cmd_sync function, used by regmap-ibt
> 
> include/net/bluetooth/hci_core.h |  3 +++
> net/bluetooth/hci_core.c         | 19 +++++++++++++++++++
> 2 files changed, 22 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

