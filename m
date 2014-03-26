Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix returning peer address in pending connect state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395841758-14792-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 26 Mar 2014 09:36:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <717BB461-A7A4-4EA6-9BE6-4DDFFBFF7C66@holtmann.org>
References: <1395841758-14792-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We should let user space request the peer address also in the pending
> connect states, i.e. BT_CONNECT and BT_CONNECT2. There is existing user
> space code that tries to do this and will fail without extending the set
> of allowed states for the peer address information.
> 
> This patch adds the two states to the allowed ones in the L2CAP and
> RFCOMM sock_getname functions, thereby preventing ENOTCONN from being
> returned.
> 
> Reported-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Tested-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> This was reported as a regression on its way to 3.15 so we should either
> send an immediate pull with it for wireless-next or then have it go in
> in the very first patch to the 3.15-rc kernels.
> 
> net/bluetooth/l2cap_sock.c  | 3 ++-
> net/bluetooth/rfcomm/sock.c | 3 ++-
> 2 files changed, 4 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

I also rebased the tree and inserted this patch just after the origin/for-upstream tag so that we can just move the tag forward and include this fix.

Regards

Marcel

