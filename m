Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix advertising data flags with disabled BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380718944-28164-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Oct 2013 15:19:13 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A17C3A88-E4AA-4627-9028-5FD16B36C1A9@holtmann.org>
References: <1380718944-28164-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We shouldn't include the simultaneous LE & BR/EDR flags in the LE
> advertising data if BR/EDR is disabled on a dual-mode controller. This
> patch fixes this issue and ensures that the create_ad function generates
> the correct flags when BR/EDR is disabled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

