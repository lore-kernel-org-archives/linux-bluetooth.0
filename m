Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 4/8] Bluetooth: Fix busy return for mgmt_set_powered in some cases
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380031363-1266-5-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 20:17:34 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <43159E62-159A-4A4D-9798-0E42CFB884EF@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-5-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We should return a "busy" error always when there is another
> mgmt_set_powered operation in progress. Previously when powering on
> while the auto off timer was still set the code could have let two or
> more pending power on commands to be queued. This patch fixes the issue
> by moving the check for duplicate commands to an earlier point in the
> set_powered handler.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

