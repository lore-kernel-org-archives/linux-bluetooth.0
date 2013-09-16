Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v5 8/8] Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379325919-19003-9-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Sep 2013 09:13:49 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AA138BE9-DD44-45E9-930D-577124C66165@holtmann.org>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com> <1379325919-19003-9-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In the case of blocking sockets we should not proceed with sendmsg() if
> the socket has the BT_SK_SUSPEND flag set. So far the code was only
> ensuring that POLLOUT doesn't get set for non-blocking sockets using
> poll() but there was no code in place to ensure that blocking sockets do
> the right thing when writing to them.
> 
> This patch adds a new bt_sock_wait_ready helper function to sleep in the
> sendmsg call if the BT_SK_SUSPEND flag is set, and wake up as soon as it
> is unset. It also updates the L2CAP and RFCOMM sendmsg callbacks to take
> advantage of this new helper function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |  1 +
> net/bluetooth/af_bluetooth.c      | 40 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/l2cap_sock.c        |  6 ++++++
> net/bluetooth/rfcomm/sock.c       |  7 ++++++-
> 4 files changed, 53 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

