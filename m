Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 3/3] Bluetooth: Fix CID initialization for fixed channels
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390687809-14408-3-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 27 Jan 2014 05:51:09 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <45C5029B-7FC7-4337-BEBA-AAFB62CC9E48@holtmann.org>
References: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com> <1390687809-14408-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Fixed channels have the same source and destination CID. Ensure that the
> values get properly initialized when receiving incoming connections and
> deriving values from the parent socket.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 --
> net/bluetooth/l2cap_sock.c | 5 +++++
> 2 files changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

