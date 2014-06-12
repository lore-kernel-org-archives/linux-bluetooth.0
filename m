Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] android/gatt: Fix wrong check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402567085-26830-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 12 Jun 2014 12:08:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7D349CBE-361A-4F82-8D38-BE57012D65C1@holtmann.org>
References: <1402567085-26830-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> android/gatt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index cc3746c..08da856 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4133,7 +4133,7 @@ static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
> 
> 	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> 							UINT_TO_PTR(handle));
> -	if (entry) {
> +	if (!entry) {
> 		DBG("No pending response found! Bogus android response?");
> 		return;

on a different note, if this is a case that is not suppose to happen and indicates a bug in Android Bluetooth service, we should at minimum print a warning here and not debug. Maybe even just print an error.

Regards

Marcel

