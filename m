Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch]fix memory leak in fixed btusb_close
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-bluetooth@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <200911131426.24001.oliver@neukum.org>
References: <200911131426.24001.oliver@neukum.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Nov 2009 15:17:19 +0100
Message-ID: <1258121839.3299.21.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Linus,

> If the waker is killed before it can replay outstanding URBs,
> these URBs won't be freed or will be replayed at the next open.
> This patch closes the window by explicitely discarding outstanding
> URBs.
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.org>
> 
> Linus,
> 
> this fixes a memory leak in your fix of btusb.
> 
> 	Regards
> 		Oliver
> 
> --
> 
> commit 8a3e793888c75bc7a49ff8b0be7ec6bd5438d985
> Author: Oliver Neukum <oliver@neukum.org>
> Date:   Thu Nov 12 16:41:46 2009 +0100
> 
>     btusb: close race in disconnect leading to a memory leak
>     
>     if the waker work is cancelled any deferred IO must be discarded
>     in close to free the memory and make sure the data isn't replayed
>     later

Acked-by: Marcel Holtmann <marcel@holtmann.org>

In case you wanna take it this late. Otherwise let me know and I queue
it up for the next merge window.

Regards

Marcel


