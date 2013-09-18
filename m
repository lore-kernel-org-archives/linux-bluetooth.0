Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Sep 2013 17:04:17 -0500
From: Gustavo Padovan <gustavo@padovan.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 8/8] Bluetooth: Fix waiting for clearing of
 BT_SK_SUSPEND flag
Message-ID: <20130918220417.GC4006@joana>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
 <1379325919-19003-9-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379325919-19003-9-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2013-09-16 johan.hedberg@gmail.com <johan.hedberg@gmail.com>:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
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
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/af_bluetooth.c      | 40 +++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_sock.c        |  6 ++++++
>  net/bluetooth/rfcomm/sock.c       |  7 ++++++-
>  4 files changed, 53 insertions(+), 1 deletion(-)

All patches have been applied to bluetooth-next. Thanks.

	Gustavo
