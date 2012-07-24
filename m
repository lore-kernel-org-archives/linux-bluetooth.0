Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 17:25:48 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 02/20] Bluetooth: Process HCI callbacks in a workqueue
Message-ID: <20120724142546.GE11981@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1947498.TVTnpXyGtm@linux-lqwf.site>
 <20120724134639.GD11981@aemeltch-MOBL1>
 <1419233.g706sEMuzE@linux-lqwf.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419233.g706sEMuzE@linux-lqwf.site>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 24, 2012 at 04:15:42PM +0200, Oliver Neukum wrote:
> On Tuesday 24 July 2012 16:46:41 Andrei Emeltchenko wrote:
> > Hi Oliver,
> > 
> > On Tue, Jul 24, 2012 at 03:31:37PM +0200, Oliver Neukum wrote:
> > > On Tuesday 24 July 2012 16:21:43 Andrei Emeltchenko wrote:
> > > > +void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
> > > > +                 struct workqueue_struct *workqueue)
> > > > +{
> > > > +       struct hci_cb_work *work;
> > > > +
> > > > +       BT_DBG("%s queue cmd %p", hdev->name, cmd);
> > > > +
> > > > +       work = kmalloc(sizeof(*work), GFP_KERNEL);
> > > 
> > > This looks like prone to deadlocks. You can run networked file
> > > systems over the link and allocating memory with GFP_KERNEL
> > > could run into a recursion problem.
> > 
> > Sorry, how this might run into recursion problem?
> 
> Suppose you transfer something necessary for writing out a dirty
> page over the HCI and you call hci_queue_cb() to do so. Then
> GFP_KERNEL causes another page to be written out over the same path.
> (eg. NFS over PAN)

Still I do not get it. We use GFP_KERNEL quite a lot in Bluetooth, how
this case is special?

Best regards 
Andrei Emeltchenko 

