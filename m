Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] android/daemon: Solves warnings when compiling for Android
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053394-22664-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 29 Oct 2013 14:34:43 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <7DDFBD1F-03E5-469A-9609-4F336890D521@holtmann.org>
References: <1383053394-22664-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When compiling for Android I get very annoying warnings shown below.
> Though the issue is with android this really helps to clear Android
> build screen.
> 
> external/bluetooth/bluez/android/main.c: In function 'cmd_watch_cb':
> external/bluetooth/bluez/android/main.c:192:3: warning: format '%zd' expects
>  argument of type 'signed size_t', but argument 2 has type 'ssize_t' [-Wformat]
> external/bluetooth/bluez/android/main.c:197:3: warning: format '%zd' expects
>  argument of type 'signed size_t', but argument 2 has type 'ssize_t' [-Wformat]

do we actually know piece inside Android is causing this stupid warning. Is this a bug in bionic and should be fixed.

> ---
> Let me know if this solution is OK and I will change other parts as well.
> 
> android/main.c |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/main.c b/android/main.c
> index 6ff30a9..63c9eda 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -171,7 +171,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
> {
> 	char buf[BLUEZ_HAL_MTU];
> 	struct hal_hdr *msg = (void *) buf;
> -	ssize_t ret;
> +	int ret;
> 	int fd;
> 
> 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
> @@ -189,12 +189,12 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
> 	}
> 
> 	if (ret < (ssize_t) sizeof(*msg)) {

And why is this cast still ssize_t.

> -		error("HAL command too small, terminating (%zd)", ret);
> +		error("HAL command too small, terminating (%d)", ret);
> 		goto fail;
> 	}
> 
> 	if (ret != (ssize_t) (sizeof(*msg) + msg->len)) {

And here as well.

> -		error("Malformed HAL command (%zd bytes), terminating", ret);
> +		error("Malformed HAL command (%d bytes), terminating", ret);
> 		goto fail;
> 	}

Regards

Marcel

