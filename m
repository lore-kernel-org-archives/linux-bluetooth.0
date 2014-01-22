Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] btproxy: Fix resource leak
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390388442-1192-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 22 Jan 2014 07:54:56 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <66C847F1-1E17-43C8-AFE0-2AB1BB6431B0@holtmann.org>
References: <1390388442-1192-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Close file descriptors if setup_proxy fails.
> ---
> tools/btproxy.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/btproxy.c b/tools/btproxy.c
> index 4429a16..9f409c3 100644
> --- a/tools/btproxy.c
> +++ b/tools/btproxy.c
> @@ -330,8 +330,11 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
> 	struct proxy *proxy;
> 
> 	proxy = new0(struct proxy, 1);
> -	if (!proxy)
> +	if (!proxy) {
> +		close(host_fd);
> +		close(dev_fd);
> 		return NULL;
> +	}

this is the wrong fix for this.

You are returning an error with side effects of closing the file descriptors. You need to leave the error handling of the parameters that got handed in to the caller. I fixed that upstream now.

Regards

Marcel

