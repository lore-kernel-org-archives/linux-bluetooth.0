Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Mar 2012 11:23:36 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 2/2] Bluetooth: Process HCI callbacks in a workqueue
Message-ID: <20120307092334.GE3647@aemeltch-MOBL1>
References: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331039789-31519-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <201203061604.02445.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201203061604.02445.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Janc,

On Tue, Mar 06, 2012 at 04:04:02PM +0100, Szymon Janc wrote:
> > +void hci_queue_cb(struct hci_dev *hdev, struct cb_cmd *cmd,
> > +					struct workqueue_struct *workqueue)
> > +{
> > +	struct cb_work *work;
> > +
> > +	BT_ERR("Queue cmd %p opt %p", cmd, cmd->opt);
> 
> BT_DBG I guess?

Sure.

Thanks for the review.

Best regards 
Andrei Emeltchenko 

