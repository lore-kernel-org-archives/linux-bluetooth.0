Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Mar 2012 13:55:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0 1/2] audio: fix missing unref in case of error
Message-ID: <20120313115515.GB30313@x220.ger.corp.intel.com>
References: <1331630772-11438-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1331630772-11438-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Mar 13, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> audio_adapter_get() increases the reference counter of the adapter, so
> it's necessary to decrement it in case of error.
> ---
>  audio/manager.c |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)

Please test at least that your patches compile before submitting them:

  CC     audio/bluetoothd-manager.o
audio/manager.c: In function ‘avrcp_server_probe’:
audio/manager.c:1058:2: error: ‘err’ undeclared (first use in this function)
audio/manager.c:1058:2: note: each undeclared identifier is reported only once for each function it appears in
audio/manager.c: In function ‘avrcp_server_remove’:
audio/manager.c:1070:6: error: unused variable ‘err’ [-Werror=unused-variable]
audio/manager.c: In function ‘avrcp_server_probe’:
audio/manager.c:1063:1: error: control reaches end of non-void function [-Werror=return-type]

Also:

> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -877,6 +877,7 @@ static void audio_adapter_unref(struct audio_adapter *adp)
>  		return;
>  
>  	adapters = g_slist_remove(adapters, adp);
> +
>  	btd_adapter_unref(adp->btd_adapter);
>  	g_free(adp);
>  }

This added line seems completely unrelated to the patch.

Johan
