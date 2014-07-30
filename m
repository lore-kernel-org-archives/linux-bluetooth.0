Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] bluetooth: Fix crash in the driver initialization codepath
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406761023-21290-1-git-send-email-anatol.pomozov@gmail.com>
Date: Wed, 30 Jul 2014 16:10:04 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <731A6E64-436D-4D62-82EE-0157F44C8E2A@holtmann.org>
References: <1406761023-21290-1-git-send-email-anatol.pomozov@gmail.com>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anatol,

> btmrvl_add_card() function calls kthread_run that might return error
> (e.g. if current thread is killed). If one tries to use the error
> value as a pointer then invalid memory access oops happens.
> 
> Check kthread_run() return value, if it is an error then release resources correctly.
> 
> TEST=boot computer with BT modules enabled. I see the error message that BT device
> initialization failed. Now kernel does not crash. Hint: to enable BT run
> 'rmmod btmrvl_sdio; modprobe btmrvl_sdio'
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

