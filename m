Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Mar 2012 11:22:15 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/2] Bluetooth: Process HCI callbacks in a workqueue
Message-ID: <20120307092214.GD3647@aemeltch-MOBL1>
References: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331039789-31519-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikYKJqpOj0JQ9x2DUQ2pYGos66WD4oodFchTDKA2UKFY0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikYKJqpOj0JQ9x2DUQ2pYGos66WD4oodFchTDKA2UKFY0A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Mar 06, 2012 at 12:02:11PM -0300, Ulisses Furquim wrote:
> >
> > +struct cb_work {
> 
> Again, maybe hci_cb_work?

OK.

> > +       struct work_struct work;
> > +       struct hci_dev *hdev;
> > +       struct cb_cmd *cmd;
> > +};
> > +
> > +static void hci_cb_work(struct work_struct *w)
> 
> And here hci_cb_worker?

Sounds good.

> > +{
> > +       struct cb_work *work = (struct cb_work *) w;
> > +       struct cb_cmd *cmd = work->cmd;
> > +       struct hci_dev *hdev = work->hdev;
> > +
> > +       cmd->cb(hdev, cmd);
> > +
> > +       hci_dev_put(hdev);
> > +
> > +       hci_remove_cb(cmd);
> > +       kfree(w);
> > +}
> > +
> > +void hci_queue_cb(struct hci_dev *hdev, struct cb_cmd *cmd,
> > +                                       struct workqueue_struct *workqueue)
> > +{
> > +       struct cb_work *work;
> > +
> > +       BT_ERR("Queue cmd %p opt %p", cmd, cmd->opt);
> > +
> > +       work = kmalloc(sizeof(*work), GFP_ATOMIC);
> 
> Why not GFP_KERNEL?

Sure.

> 
> > +       if (!work)
> > +               return;
> > +
> > +       INIT_WORK(&work->work, hci_cb_work);
> > +       work->hdev = hdev;
> > +       work->cmd = cmd;
> > +       hci_dev_hold(hdev);
> > +
> > +       if (!queue_work(workqueue, &work->work)) {
> > +               kfree(work);
> > +               hci_dev_put(hdev);
> > +       }
> > +}
> > +
> >  void hci_remove_cb(struct cb_cmd *cmd)
> >  {
> >        list_del(&cmd->list);
> 
> And again, no callers of hci_queue_cb so I'm assuming you'll only use
> in for AMP, is that it?

Yes, so far.

Thanks for the review.

Best regards 
Andrei Emeltchenko 

