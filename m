Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] core: Add ControllerMode to list of supported options
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413877738-23941-1-git-send-email-jacob@teenageengineering.com>
Date: Tue, 21 Oct 2014 04:08:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3055BAC9-79FC-42D1-B8ED-292E8B5D2665@holtmann.org>
References: <1413877738-23941-1-git-send-email-jacob@teenageengineering.com>
To: Jacob Siverskog <jacob@teenageengineering.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jacob,

> Signed-off-by: Jacob Siverskog <jacob@teenageengineering.com>

we do not add signed-off-by for userspace patches. That is only required for kernel patches.

> Prevent warning message 'Unknown key ControllerMode in main.conf'.
> ---
> src/main.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/src/main.c b/src/main.c
> index 191dc11..061060d 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -79,6 +79,7 @@ static const char * const supported_options[] = {
> 	"ReverseServiceDiscovery",
> 	"NameResolving",
> 	"DebugKeys",
> +	"ControllerMode",
> };

Good catch. Please resend the patch without signed-off-by line.

Regards

Marcel

