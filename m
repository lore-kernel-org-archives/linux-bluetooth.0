Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Switch ATT channels to use L2CAP_CHAN_FIXED
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390552541-11729-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 24 Jan 2014 00:46:15 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <5431B36B-96CA-404C-80BF-AC050BF813CE@holtmann.org>
References: <1390552541-11729-1-git-send-email-johan.hedberg@gmail.com> <1390552541-11729-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> ATT channels are not connection oriented so having them use
> L2CAP_CHAN_CONN_ORIENTED is quite confusing. Instead, use the new
> L2CAP_CHAN_FIXED type and ensure that the MTU and CID values get
> properly set.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 21 +++++++++------------
> net/bluetooth/l2cap_sock.c |  9 +++++++++
> 2 files changed, 18 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

