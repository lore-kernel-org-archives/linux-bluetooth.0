Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 16:45:38 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 01/16] Bluetooth: rename hci_conn_put to hci_conn_drop
Message-ID: <20130411194538.GH28775@joana>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-2-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365272932-571-2-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-04-06 20:28:37 +0200]:

> We use _get() and _put() for device ref-counting in the kernel. However,
> hci_conn_put() is _not_ used for ref-counting, hence, rename it to
> hci_conn_drop() so we can later fix ref-counting and introduce
> hci_conn_put().
> 
> hci_conn_hold() and hci_conn_put() are currently used to manage how long a
> connection should be held alive. When the last user drops the connection,
> we spawn a delayed work that performs the disconnect. Obviously, this has
> nothing to do with ref-counting for the _object_ but rather for the
> keep-alive of the connection.
> 
> But we really _need_ proper ref-counting for the _object_ to allow
> connection-users like rfcomm-tty, HIDP or others.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  2 +-
>  net/bluetooth/hci_conn.c         |  6 +++---
>  net/bluetooth/hci_event.c        | 36 ++++++++++++++++++------------------
>  net/bluetooth/l2cap_core.c       |  6 +++---
>  net/bluetooth/mgmt.c             |  6 +++---
>  net/bluetooth/sco.c              |  6 +++---
>  net/bluetooth/smp.c              |  2 +-
>  7 files changed, 32 insertions(+), 32 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
