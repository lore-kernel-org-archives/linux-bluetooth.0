Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix enabling BR/EDR SC when powering on
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418383811-15178-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 12 Dec 2014 13:22:49 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B65E2003-FC99-461E-8A12-4C6AC431B47C@holtmann.org>
References: <1418383811-15178-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we're in the AUTO_OFF stage the powered_update_hci() function is
> responsible for doing the updates to the HCI state that were not done
> during the actual mgmt command handlers. One of the updates needing done
> is for BR/EDR SC support. This patch adds the missing HCI command for SC
> support to the powered_update_hci() function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

