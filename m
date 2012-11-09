Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Nov 2012 10:41:23 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3 v2] Bluetooth: Fix updating advertising state flags
 and data
Message-ID: <20121109094123.GA9183@joana>
References: <1352334181-19198-1-git-send-email-johan.hedberg@gmail.com>
 <1352334181-19198-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352334181-19198-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-11-08 01:23:01 +0100]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds a callback for the HCI_LE_Set_Advertise_Enable command.
> The callback is responsible for updating the HCI_LE_PERIPHERAL flag
> updating as well as updating the advertising data flags field to
> indicate undirected connectable advertising.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |    2 ++
>  net/bluetooth/hci_event.c   |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)

All 3 patches have been applied to bluetooth-next. Thanks.

	Gustavo
