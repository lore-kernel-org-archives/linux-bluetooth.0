Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Apr 2013 23:48:03 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 03/18] Bluetooth: rename hci_conn_put to hci_conn_drop
Message-ID: <20130406024803.GC10666@joana>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365166670-3271-4-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365166670-3271-4-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-04-05 14:57:35 +0200]:

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
> ---
>  include/net/bluetooth/hci_core.h |  2 +-
>  net/bluetooth/hci_conn.c         |  6 +++---
>  net/bluetooth/hci_event.c        | 36 ++++++++++++++++++------------------
>  net/bluetooth/l2cap_core.c       |  6 +++---
>  net/bluetooth/mgmt.c             |  6 +++---
>  net/bluetooth/sco.c              |  6 +++---
>  net/bluetooth/smp.c              |  2 +-
>  7 files changed, 32 insertions(+), 32 deletions(-)

This patch doesn't apply anymore. Maybe you didn't rebase it on the latest
bluetooth-next before send it. Please do this and resend. You can already add
Marcel's acks to your patches when you resend it.

	Gustavo
