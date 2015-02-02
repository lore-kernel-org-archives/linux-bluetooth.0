Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Remove mgmt_rp_read_local_oob_ext_data struct
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422876222-14858-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 2 Feb 2015 09:31:20 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8D5C444B-AD8E-4FF5-B2B3-88917491C3D2@holtmann.org>
References: <1422876222-14858-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This extended return parameters struct conflicts with the new Read Local
> OOB Extended Data command definition. To avoid the conflict simply
> rename the old "extended" version to the normal one and update the code
> appropriately to take into account the two possible response PDU sizes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/mgmt.h |  4 ----
> net/bluetooth/mgmt.c         | 25 +++++++++----------------
> 2 files changed, 9 insertions(+), 20 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

