Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 17:55:09 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: Rename L2CAP_LE_DEFAULT_MTU
Message-ID: <20120531205509.GC24769@joana>
References: <1338494495-21447-1-git-send-email-andre.guedes@openbossa.org>
 <1338494495-21447-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338494495-21447-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-05-31 17:01:35 -0300]:

> This patch renames L2CAP_LE_DEFAULT_MTU macro to L2CAP_LE_MIN_MTU
> since it represents the minimum MTU value, not the default MTU
> value for LE.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_sock.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

All 3 patches have been applied to bluetooth-next, thanks.

	Gustavo
