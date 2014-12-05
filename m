Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Remove redundant reverse_base_uuid variable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417779601-9394-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 5 Dec 2014 12:50:05 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3A2D9E6C-CEFE-41EF-800D-0BE3C81DEEB3@holtmann.org>
References: <1417779601-9394-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The mgmt.c file already has a bluetooth_base_uuid variable which has the
> exact same value as the reverse_base_uuid one. This patch removes the
> redundant variable.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> This should apply both before and after my cmd_complete patch set, but
> I've only tested it after it.
> 
> net/bluetooth/mgmt.c | 12 ++----------
> 1 file changed, 2 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

