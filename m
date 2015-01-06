Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2 1/4] Bluetooth: btmrvl: fix race issue while stopping main thread
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420100022-4134-1-git-send-email-akarwar@marvell.com>
Date: Tue, 6 Jan 2015 07:21:19 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>, Marc Yang <yangyang@marvell.com>
Message-Id: <1BD6A1FB-C22E-43CE-8011-8D54D44DB982@holtmann.org>
References: <1420100022-4134-1-git-send-email-akarwar@marvell.com>
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
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

