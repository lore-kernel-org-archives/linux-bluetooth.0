Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331039789-31519-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1331039789-31519-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 6 Mar 2012 12:02:11 -0300
Message-ID: <CAA37ikYKJqpOj0JQ9x2DUQ2pYGos66WD4oodFchTDKA2UKFY0A@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: Process HCI callbacks in a workqueue
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 6, 2012 at 10:16 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/hci_core.c         |   42 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2ef515e..47f1631 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1103,5 +1103,7 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
>        void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd), void *opt,
>                                void (*destructor)(struct cb_cmd *cmd));
>  void hci_remove_cb(struct cb_cmd *cmd);
> +void hci_queue_cb(struct hci_dev *hdev, struct cb_cmd *cmd,
> +                                       struct workqueue_struct *workqueue);
>
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cdc0220..2bd97b4 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2273,6 +2273,48 @@ struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
>        return NULL;
>  }
>
> +struct cb_work {

Again, maybe hci_cb_work?

> +       struct work_struct work;
> +       struct hci_dev *hdev;
> +       struct cb_cmd *cmd;
> +};
> +
> +static void hci_cb_work(struct work_struct *w)

And here hci_cb_worker?

> +{
> +       struct cb_work *work = (struct cb_work *) w;
> +       struct cb_cmd *cmd = work->cmd;
> +       struct hci_dev *hdev = work->hdev;
> +
> +       cmd->cb(hdev, cmd);
> +
> +       hci_dev_put(hdev);
> +
> +       hci_remove_cb(cmd);
> +       kfree(w);
> +}
> +
> +void hci_queue_cb(struct hci_dev *hdev, struct cb_cmd *cmd,
> +                                       struct workqueue_struct *workqueue)
> +{
> +       struct cb_work *work;
> +
> +       BT_ERR("Queue cmd %p opt %p", cmd, cmd->opt);
> +
> +       work = kmalloc(sizeof(*work), GFP_ATOMIC);

Why not GFP_KERNEL?

> +       if (!work)
> +               return;
> +
> +       INIT_WORK(&work->work, hci_cb_work);
> +       work->hdev = hdev;
> +       work->cmd = cmd;
> +       hci_dev_hold(hdev);
> +
> +       if (!queue_work(workqueue, &work->work)) {
> +               kfree(work);
> +               hci_dev_put(hdev);
> +       }
> +}
> +
>  void hci_remove_cb(struct cb_cmd *cmd)
>  {
>        list_del(&cmd->list);

And again, no callers of hci_queue_cb so I'm assuming you'll only use
in for AMP, is that it?

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
