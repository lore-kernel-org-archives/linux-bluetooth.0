Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix checking for pending Set SSP in Set HS handler
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424360287-2379-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 19 Feb 2015 08:08:21 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AB8274A2-F930-4343-8C09-97DBA1755746@holtmann.org>
References: <1424360287-2379-1-git-send-email-johan.hedberg@gmail.com> <1424360287-2379-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Changing the HS setting requires that SSP is enabled, however so far the
> code only checked for the SSP flag but not a potentially ongoing Set SSP
> operation. This patch adds a check for a pending Set SSP command in the
> Set HS handler, and returns a 'busy' error if one is found.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

