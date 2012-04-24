Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Apr 2012 10:10:52 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix coding style in the code
Message-ID: <20120424131052.GA9343@joana>
References: <1335240565-5582-1-git-send-email-gustavo@padovan.org>
 <20120424070100.GA2650@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120424070100.GA2650@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-04-24 10:01:02 +0300]:

> Hi Gustavo,
> 
> On Tue, Apr 24, 2012 at 01:09:25AM -0300, Gustavo Padovan wrote:
> > New code added to the Bluetooth subsystem need to be complaint with the
> > new syle rules.
> 
> Would it be better if we change coding style only when changing code,
> otherwise people need to rebase too much without a reason. Though for mgmt
> code which is new it does make sense.

Yes, it would, but we weren't careful and let this ones go into the
tree. Now we need to fix them otherwise DaveM can block our code from
going mainline.

	Gustavo
