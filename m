Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 4/6] Bluetooth: Don't store debug keys if flag for them is not set
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403604953-19539-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 12:38:47 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0E075841-C6C1-4847-B74E-9F5522FFCCD6@holtmann.org>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com> <1403604953-19539-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Instead of waiting for a disconnection to occur to remove a debug key
> simply never store it in the list to begin with. This means we can also
> remove the debug keys check when looking up keys in
> hci_link_key_request_evt().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

