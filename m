Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix properly ignoring LTKs of unknown types
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401381413-12782-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 31 May 2014 06:26:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2BB9FD3D-AB40-4269-934A-5F4BC76E2944@holtmann.org>
References: <1401381413-12782-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In case there are new LTK types in the future we shouldn't just blindly
> assume that != MGMT_LTK_UNAUTHENTICATED means that the key is
> authenticated. This patch adds explicit checks for each allowed key type
> in the form of a switch statement and skips any key which has an unknown
> value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

