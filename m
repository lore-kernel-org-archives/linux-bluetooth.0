Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] tools/btattach: Add detach option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170201171431.9633-1-carlo@caione.org>
Date: Wed, 1 Feb 2017 20:41:14 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux@endlessm.com, Carlo Caione <carlo@endlessm.com>
Message-Id: <D130D4FB-7AF0-46BF-9BC7-D9050C596E1A@holtmann.org>
References: <20170201171431.9633-1-carlo@caione.org>
To: Carlo Caione <carlo@caione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carl,

> Signed-off-by: Carlo Caione <carlo@endlessm.com>

user space does not use signed off by statements.

> ---
> tools/btattach.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/btattach.c b/tools/btattach.c
> index 5adbc8d..f1f115d 100644
> --- a/tools/btattach.c
> +++ b/tools/btattach.c
> @@ -194,6 +194,7 @@ static void usage(void)
> 		"\t-P, --protocol <proto> Specify protocol type\n"
> 		"\t-S, --speed <baudrate> Specify which baudrate to use\n"
> 		"\t-N, --noflowctl        Disable flow control\n"
> +		"\t-D, --detach           Open device and then fork\n"
> 		"\t-h, --help             Show help options\n”);

And is this really a good idea. I think that I had removed all the fork calls from the standard tools. Mainly since we fail to maintain the signals and more important child signals correctly. So we quickly end up with zombies or orphaned processes. My thinking instead was to leave this to systemd to handle.

In addition, we are close to getting serdev bus which means btattach will be something of the past really soon.

Regards

Marcel

