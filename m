Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 02/20] Bluetooth: Process HCI callbacks in a workqueue
Date: Tue, 24 Jul 2012 15:31:37 +0200
Message-ID: <1947498.TVTnpXyGtm@linux-lqwf.site>
In-Reply-To: <1343136121-22476-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1343136121-22476-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 24 July 2012 16:21:43 Andrei Emeltchenko wrote:
> +void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
> +                 struct workqueue_struct *workqueue)
> +{
> +       struct hci_cb_work *work;
> +
> +       BT_DBG("%s queue cmd %p", hdev->name, cmd);
> +
> +       work = kmalloc(sizeof(*work), GFP_KERNEL);

This looks like prone to deadlocks. You can run networked file
systems over the link and allocating memory with GFP_KERNEL
could run into a recursion problem.

> +       if (!work)
> +               return;
> +
> +       INIT_WORK(&work->work, hci_cb_worker);
> +       work->hdev = hdev;
> +       work->cmd = cmd;
> +       hci_dev_hold(hdev);
> +
> +       if (!queue_work(workqueue, &work->work)) {
> +               kfree(work);
> +               hci_dev_put(hdev);
> +       }
> +}

	Regards
		Oliver

