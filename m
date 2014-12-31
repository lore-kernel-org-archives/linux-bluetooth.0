Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/4] Bluetooth: btmrvl: fix race issue while stopping main thread
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420024442-12137-1-git-send-email-akarwar@marvell.com>
Date: Wed, 31 Dec 2014 03:33:18 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	patila@marvell.com, Cathy Luo <cluo@marvell.com>,
	Marc Yang <yangyang@marvell.com>
Message-Id: <B54F0CE9-1DE7-4985-851A-CD7E06AB7DA8@holtmann.org>
References: <1420024442-12137-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> btmrvl_remove_card() calls kthread_stop() to stop the main thread,
> but kthread_should_stop() is checked when all the activities are done
> in the main thread before sleeping.
> We will have kthread_should_stop() check as soon as main thread is
> woken up. This fixes a crash issue caused due to an invalid memory
> access while unnecessarily processing interrupts after card removal.
> 
> Signed-off-by: Avinash Patil <patila@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>

I can not apply the patches like this. I assume that Avinash wrote the patch and with that he should be listed as patch author. So the email needs a proper From: line that allows git am to pick this up properly.

Same applies to the other 3 patches.

Regards

Marcel

