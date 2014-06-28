Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/3] Bluetooth: Use kzalloc instead of kmalloc for pending mgmt commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 28 Jun 2014 18:54:26 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <29AA7F07-CD19-4880-8AA3-3255916164A6@holtmann.org>
References: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> By using kzalloc we ensure that there are no struct members, such as the
> user_data pointer, left uninitialized.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

