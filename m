Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 02:39:29 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 02/16] Bluetooth: remove unneeded
 hci_conn_hold/put_device()
Message-ID: <20130417053929.GA3480@joana>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-3-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365272932-571-3-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-04-06 20:28:38 +0200]:

> hci_conn_hold/put_device() is used to control when hci_conn->dev is no
> longer needed and can be deleted from the system. Lets first look how they
> are currently used throughout the code (excluding HIDP!).
> 
> All code that uses hci_conn_hold_device() looks like this:
>     ...
>     hci_conn_hold_device();
>     hci_conn_add_sysfs();
>     ...
> On the other side, hci_conn_put_device() is exclusively used in
> hci_conn_del().
> 
> So, considering that hci_conn_del() must not be called twice (which would
> fail horribly), we know that hci_conn_put_device() is only called _once_
> (which is in hci_conn_del()).
> On the other hand, hci_conn_add_sysfs() must not be called twice, either
> (it would call device_add twice, which breaks the device, see
> drivers/base/core.c). So we know that hci_conn_hold_device() is also
> called only once (it's only called directly before hci_conn_add_sysfs()).
> 
> So hold and put are known to be called only once. That means we can safely
> remove them and directly call hci_conn_del_sysfs() in hci_conn_del().
> 
> But there is one issue left: HIDP also uses hci_conn_hold/put_device().
> However, this case can be ignored and simply removed as it is totally
> broken. The issue is, the only thing HIDP delays with
> hci_conn_hold_device() is the removal of the hci_conn->dev from sysfs.
> But, the hci_conn device has no mechanism to get notified when its own
> parent (hci_dev) gets removed from sysfs. hci_dev_hold/put() does _not_
> control when it is removed but only when the device object is created
> and destroyed.
> And hci_dev calls hci_conn_flush_*() when it removes itself from sysfs,
> which itself causes hci_conn_del() to be called, but it does _not_ cause
> hci_conn_del_sysfs() to be called, which is wrong.
> 
> Hence, we fix it to call hci_conn_del_sysfs() in hci_conn_del(). This
> guarantees that a hci_conn object is removed from sysfs _before_ its
> parent hci_dev is removed.
> 
> The changes to HIDP look scary, wrong and broken. However, if you look at
> the HIDP session management, you will notice they're already broken in the
> exact _same_ way (ever tried "unplugging" HIDP devices? Breaks _all_ the
> time).
> So this patch only makes HIDP look _scary_ and _obviously broken_. It does
> not break HIDP itself, it already is!
> 
> See later patches in this series which fix HIDP to use proper
> session-management.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  4 ----
>  net/bluetooth/hci_conn.c         | 17 +----------------
>  net/bluetooth/hci_event.c        |  4 ----
>  net/bluetooth/hidp/core.c        | 20 +++-----------------
>  4 files changed, 4 insertions(+), 41 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
