Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361197591.4983.1.camel@dellpc>
References: <1361197591.4983.1.camel@dellpc>
Date: Wed, 20 Feb 2013 16:19:33 +0100
Message-ID: <CANq1E4Q_hTOpePWuviVBd-iuUyeLjoiZeMMiqYqJnGoEiW+p9Q@mail.gmail.com>
Subject: Re: Resend RFC [PATCH] hci: Fix race between hidp_session and hci code
From: David Herrmann <dh.herrmann@gmail.com>
To: Karl Relton <karllinuxtest.relton@ntlworld.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl

On Mon, Feb 18, 2013 at 3:26 PM, Karl Relton
<karllinuxtest.relton@ntlworld.com> wrote:
> From: Karl Relton <karllinuxtest.relton@ntlworld.com>
>
> Fix race between hidp_session and hci code that can lead to
>  hci device being removed from sysfs before its children
>  devices. The removal is now delayed until the last
>  reference to it in the hci code is removed.
>
> Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
> ---
>  include/net/bluetooth/hci_core.h |   10 +++-------
>  net/bluetooth/hci_core.c         |   15 +++++++++++++--
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 90cf75a..47c9d30 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -198,6 +198,7 @@ struct hci_dev {
>
>         unsigned long   quirks;
>
> +       atomic_t        ref_cnt;

We used to have this field here in the past and I worked hard to
remove it. Please don't reintroduce it.

The thing is, if you start adding a comment what this field
represents, you would end up with:
  /* reference count for hci_dev object */

However, how do you describe the refcnt inside of "hci_dev.dev"?
Exactly! It does the same. It's the refcnt for an hci_dev object.
Hence, please introduce this field only if you can add a proper
comment.

Apart from that, see below:

>         atomic_t        cmd_cnt;
>         unsigned int    acl_cnt;
>         unsigned int    sco_cnt;
> @@ -646,19 +647,14 @@ static inline void hci_conn_put(struct hci_conn *conn)
>  }
>
>  /* ----- HCI Devices ----- */
> -static inline void hci_dev_put(struct hci_dev *d)
> -{
> -       BT_DBG("%s orig refcnt %d", d->name,
> -              atomic_read(&d->dev.kobj.kref.refcount));
> -
> -       put_device(&d->dev);
> -}
> +void hci_dev_put(struct hci_dev *d);
>
>  static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
>  {
>         BT_DBG("%s orig refcnt %d", d->name,
>                atomic_read(&d->dev.kobj.kref.refcount));
>
> +       atomic_inc(&d->ref_cnt);
>         get_device(&d->dev);
>         return d;
>  }
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 618ca1a..c187a84 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -891,6 +891,19 @@ int hci_dev_close(__u16 dev)
>         return err;
>  }
>
> +void hci_dev_put(struct hci_dev *d)
> +{
> +       BT_DBG("%s orig refcnt %d", d->name,
> +              atomic_read(&d->dev.kobj.kref.refcount));
> +
> +       if(atomic_dec_and_test(&d->ref_cnt)) {
> +               hci_del_sysfs(d);
> +       }

If you want to move hci_del_sysfs() to the place where the refcnt
drops to zero, then move it to bt_host_release() in hci_sysfs.c. This
is the place where hci_dev is destroyed.

However, apart from this being in the wrong place, the patch itself is
wrong. We remove devices from sysfs exactly when the physical device
disappears! This is just how we do it, and there are many reasons to
do it this way.
So if stuff breaks because we remove the device from sysfs, then fix
the stuff that breaks! In this case this means removing all
sub-protocols from sysfs exactly at the same point when we remove the
hci-dev from sysfs!

Besides, what do you think happens when hci_add_sysfs() itself takes a
reference and drops it in hci_del_sysfs() (which is totally legal)? It
would cause the device to never get deleted.

So please describe what exactly breaks so we can fix it properly.

Thanks
David

> +       put_device(&d->dev);
> +}
> +EXPORT_SYMBOL(hci_dev_put);
> +
> +
>  int hci_dev_reset(__u16 dev)
>  {
>         struct hci_dev *hdev;
> @@ -1884,8 +1897,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
>                 rfkill_destroy(hdev->rfkill);
>         }
>
> -       hci_del_sysfs(hdev);
> -
>         destroy_workqueue(hdev->workqueue);
>         destroy_workqueue(hdev->req_workqueue);
>
> --
> 1.7.9.5
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
