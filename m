Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH] Bluetooth: Fix handling of L2CAP Command Reject over LE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386665568-7801-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Dec 2013 10:17:00 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <33DB36F0-A8C8-49CF-8CE6-56B4177B918D@holtmann.org>
References: <1386665568-7801-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we receive an L2CAP command reject message over LE we should take
> appropriate action on the corresponding channel. This is particularly
> important when trying to interact with a remote pre-4.1 system using LE
> CoC signaling messages. If we don't react to the command reject the
> corresponding socket would not be notified until a connection timeout
> occurs.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

