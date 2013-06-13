Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jun 2013 11:32:47 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Daniel Drake <dsd@laptop.org>
Cc: marcel@holtmann.org, bzhao@marvell.com, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btmrvl: fix thread stopping race
Message-ID: <20130613103247.GB16835@joana>
References: <20130611194020.9EFBEFAACD@dev.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130611194020.9EFBEFAACD@dev.laptop.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

* Daniel Drake <dsd@laptop.org> [2013-06-11 15:40:20 -0400]:

> There is currently a race condition in the btmrvl_remove_card() which
> is causing hangs on suspend for OLPC. When the race occurs,
> kthread_stop() never returns.
> 
> The problem is that btmrvl_service_main_thread() calls kthread_should_stop()
> and then does a fair number of things before restarting the loop and
> sleeping.
> 
> If the thread gets stopped after kthread_should_stop() is checked, but
> before the sleep happens, the thread will go to sleep and won't necessarily
> be woken up.
> 
> Move the kthread_should_stop() check into a race-free place.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/bluetooth/btmrvl_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
