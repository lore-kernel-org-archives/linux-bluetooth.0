Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Support scanning for devices using RPA
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404331764-24731-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 3 Jul 2014 09:45:39 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <86B74E15-F91C-4B60-AA5C-8310CDC3892A@holtmann.org>
References: <1404331764-24731-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're scanning for specific devices that use an RPA we need to
> convert the RPA to the identity address before looking up the entry in
> the connection parameters. This patch adds the necessary code to do this
> in the process_adv_report() function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

