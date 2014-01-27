Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 3/3] Bluetooth: Fix disconnecting L2CAP when a credits overflow occurs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390864295-4259-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 00:36:04 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <014FE307-5EE8-402D-A261-57EBD8CC73F6@holtmann.org>
References: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com> <1390864295-4259-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The L2CAP specification requires us to disconnect an L2CAP channel if
> the remote side gives us credits beyond 65535. This patch makes sure we
> disconnect the channel in such a situation.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

