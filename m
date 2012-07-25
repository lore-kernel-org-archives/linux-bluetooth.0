Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 12:16:24 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 04/20] Bluetooth: AMP: Use HCI callback for Read AMP Info
Message-ID: <20120725091622.GB2056@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724204605.GC20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724204605.GC20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 24, 2012 at 05:46:05PM -0300, Gustavo Padovan wrote:
> > +process_cb:
> > +	hci_process_cb(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
> 
> So do we really need an workqueue for the callback here?

Let's first decide are we going to use callbacks and then I will think can
I remove workqueues. When I have created them it solved some locking
issues with lockdep...

Best regards 
Andrei Emeltchenko 
