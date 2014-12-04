Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC BlueZ] shared/mgmt: Remove unnecessary code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417708419-25772-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 4 Dec 2014 20:31:11 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <32156A77-A9BF-4542-8E26-61A398273B53@holtmann.org>
References: <1417708419-25772-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This flags were added because calling function like queue_foreach were
> not safe as the callbacks may remove or destroy the queue before
> returning but this has been fixed and it is now safe to do that.
> ---
> src/shared/mgmt.c | 89 +++++++------------------------------------------------
> 1 file changed, 11 insertions(+), 78 deletions(-)
> 
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 5dae7a9..ec574c9 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -51,9 +51,6 @@ struct mgmt {
> 	struct queue *notify_list;
> 	unsigned int next_request_id;
> 	unsigned int next_notify_id;
> -	bool need_notify_cleanup;
> -	bool in_notify;
> -	bool destroyed;

this makes no sense to me. The handling he is for reentrant support. So a lot of this handling is needed. You want to be able to remove notifications handlers while in callback or the other way around. We know that this is needed since years back we needed that with oFono and GLib. So just claiming queue_foreach has some magic fix is not going to do it.

Especially since some of the corner cases in mgmt.c might not be hit since bluetoothd does not exercise them. It does not mean they are not there.

I am also not really in favor of just hacking src/shared/queue.c without considering the implications to ELL and how things are done. This is not a playground for quickly hacking stuff together. The long term goal is to run bluetoothd on top of ELL.

Regards

Marcel

