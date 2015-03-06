Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v4 1/7] Bluetooth: Add mgmt HCI channel registration API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425668936-23234-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 6 Mar 2015 11:17:55 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B46FF9BD-42B2-4358-99B9-3BB5992776B7@holtmann.org>
References: <1425668936-23234-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds an API for registering HCI channels with mgmt-like
> semantics. For now the only user will be HCI_CHANNEL_CONTROL, but e.g.
> 6lowpan is intended to use this as well in the future.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 17 ++++++++
> net/bluetooth/hci_sock.c         | 85 ++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 99 insertions(+), 3 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

