Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix valid LE PSM check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386306533-32239-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 6 Dec 2013 07:52:00 +0200
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <1250EB31-28C6-4324-8F0E-39937D9660FC@holtmann.org>
References: <1386306533-32239-1-git-send-email-johan.hedberg@gmail.com> <1386306533-32239-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The range of valid LE PSMs is 0x0001-0x00ff so the check should be for
> "less than or equal to" instead of "less than".
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

