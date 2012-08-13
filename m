Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Aug 2012 16:51:59 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 02/20] Bluetooth: Process HCI callbacks in a workqueue
Message-ID: <20120813135157.GA20518@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724203647.GB20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724203647.GB20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 24, 2012 at 05:36:47PM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-24 16:21:43 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Use workqueue to process HCI callbacks.
> 
> Could elaborate more on why a new workqueue is needed, I tried to figure this
> out this but was unable to find a user for this function in the following
> patches.

workqueue processing was removed in RFCv3.

Best regards 
Andrei Emeltchenko 
