Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 1/3] Bluetooth: L2CAP: Introduce proper defines for PSM ranges
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 27 Jan 2016 16:26:10 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <043FD449-435E-4C69-A9BC-7C733B17C13D@holtmann.org>
References: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Having proper defines makes the code a bit readable, it also avoids
> duplicating hard-coded values since these are also needed when
> auto-allocating PSM values (in a subsequent patch).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 6 ++++++
> net/bluetooth/l2cap_sock.c    | 6 +++---
> 2 files changed, 9 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

