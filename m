Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 3/4] Bluetooth: Refuse peer RFCOMM address reading when not connected
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390951011-30576-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 15:31:30 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <BC255801-E54E-4EDB-AECB-EF2201E54BF7@holtmann.org>
References: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com> <1390951011-30576-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're not connected the peer address information is undefined. This
> patch fixes the remote address getting to return a proper error in case
> the sate is anything else than BT_CONNECTED.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/rfcomm/sock.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

