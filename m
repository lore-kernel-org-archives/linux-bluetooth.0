Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v6 3/4] Bluetooth: Add error mapping for Directed Advertising Timeout
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395685313-26085-3-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 13:31:26 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A5D4FAAA-B216-4762-81E8-36C00D0E815F@holtmann.org>
References: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com> <1395685313-26085-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When a timeout occurs using directed advertising a 0x3c error gets
> generated. Since the operation is analogous to conventional connection
> creation map this to the usual EHOSTDOWN error.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/lib.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

