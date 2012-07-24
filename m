Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 02/20] Bluetooth: Process HCI callbacks in a workqueue
Date: Tue, 24 Jul 2012 16:15:42 +0200
Message-ID: <1419233.g706sEMuzE@linux-lqwf.site>
In-Reply-To: <20120724134639.GD11981@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1947498.TVTnpXyGtm@linux-lqwf.site> <20120724134639.GD11981@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 24 July 2012 16:46:41 Andrei Emeltchenko wrote:
> Hi Oliver,
> 
> On Tue, Jul 24, 2012 at 03:31:37PM +0200, Oliver Neukum wrote:
> > On Tuesday 24 July 2012 16:21:43 Andrei Emeltchenko wrote:
> > > +void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
> > > +                 struct workqueue_struct *workqueue)
> > > +{
> > > +       struct hci_cb_work *work;
> > > +
> > > +       BT_DBG("%s queue cmd %p", hdev->name, cmd);
> > > +
> > > +       work = kmalloc(sizeof(*work), GFP_KERNEL);
> > 
> > This looks like prone to deadlocks. You can run networked file
> > systems over the link and allocating memory with GFP_KERNEL
> > could run into a recursion problem.
> 
> Sorry, how this might run into recursion problem?

Suppose you transfer something necessary for writing out a dirty
page over the HCI and you call hci_queue_cb() to do so. Then
GFP_KERNEL causes another page to be written out over the same path.
(eg. NFS over PAN)

	Regards
		Oliver

