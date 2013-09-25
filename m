Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 2/7] Bluetooth: Clean up socket locking in l2cap_sock_recvmsg
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380104770-8022-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 25 Sep 2013 12:30:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <43CF03E6-4637-40F1-ACF1-2740C624C1F6@holtmann.org>
References: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com> <1380104770-8022-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch cleans up the locking login in l2cap_sock_recvmsg by pairing
> up each lock_sock call with a release_sock call. The function already
> has a "done" label that handles releasing the socket and returning from
> the function so the fix is rather simple.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

