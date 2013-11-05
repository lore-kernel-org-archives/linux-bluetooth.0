Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH 1/5] adapter: Move MGMT_VERSION macro to mgmt.h
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 5 Nov 2013 17:57:18 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <42B6D284-6653-4EB8-A133-BFB598DB5E64@holtmann.org>
References: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This will be also used in Android daemon.
> ---
> src/adapter.c     | 1 -
> src/shared/mgmt.h | 2 ++
> 2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 30bcc4d..d904a56 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -99,7 +99,6 @@ static GSList *adapters = NULL;
> 
> static struct mgmt *mgmt_master = NULL;
> 
> -#define MGMT_VERSION(v, r) ((v << 16) + (r))
> static uint8_t mgmt_version = 0;
> static uint8_t mgmt_revision = 0;
> 
> diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> index 60a2128..99ea96f 100644
> --- a/src/shared/mgmt.h
> +++ b/src/shared/mgmt.h
> @@ -24,6 +24,8 @@
> #include <stdbool.h>
> #include <stdint.h>
> 
> +#define MGMT_VERSION(v, r) ((v << 16) + (r))

you also need (v) here.

Regards

Marcel

