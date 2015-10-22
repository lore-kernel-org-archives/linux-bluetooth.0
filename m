Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH v4 2/3] Bluetooth: Take advantage of connection abort helpers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445500179-5316-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 22 Oct 2015 11:38:35 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A6762E7E-48E5-4AF6-B712-4D42984BA3F0@holtmann.org>
References: <1445500179-5316-1-git-send-email-johan.hedberg@gmail.com> <1445500179-5316-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Convert the various places mapping connection state to
> disconnect/cancel HCI command to use the new hci_abort_conn helper
> API.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 79 +++++-------------------------------------------
> net/bluetooth/mgmt.c     | 36 ++--------------------
> 2 files changed, 11 insertions(+), 104 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

