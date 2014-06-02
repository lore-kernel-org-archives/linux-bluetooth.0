Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 4/5] android/hal-audio-aptx: Load aptX encoder library
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401708011-12828-5-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Mon, 2 Jun 2014 13:51:49 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <249307BB-42C3-44F9-A2C4-CFEED915D3EF@holtmann.org>
References: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com> <1401708011-12828-5-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch adds loading of aptX encoder library which should be provided
> by user. hal-audio-aptx will try to load 'libbt-aptx.so' so it should be
> available in search patch, preferably in /system/lib.
> ---
> android/hal-audio-aptx.c | 51 ++++++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
> index b7b5dfc..28db0f6 100644
> --- a/android/hal-audio-aptx.c
> +++ b/android/hal-audio-aptx.c
> @@ -27,6 +27,8 @@
> #include "../src/shared/util.h"
> #include "../profiles/audio/a2dp-codecs.h"
> 
> +#define APTX_SO_NAME	"libbt-aptx.so"
> +
> struct aptx_data {
> 	a2dp_aptx_t aptx;
> 
> @@ -61,20 +63,61 @@ static const a2dp_aptx_t aptx_presets[] = {
> 	},
> };
> 
> +static void *aptx_dl;

this is a horrible name for a variable. I had to wrap my brain around to where the _dl comes from ;)

The dlopen manpage calls it handle so lets use aptx_handle here as variable name

> +static int aptx_sizeof = 0;

This name also give me a headache. aptx_btencsize seems to be more natural and clearer on what we store here.

I am also not sure you need to initialize this to 0. It is protected by the aptx_handle variable.

> +static int (*aptx_init)(void *, short);
> +static int (*aptx_encode)(void *, void *, void *, void *);
> +

> static bool aptx_load(void)
> {
> -	/* TODO: load aptX codec library */
> -	return false;
> +	const char * (*aptx_version)(void);
> +	const char * (*aptx_build)(void);
> +	int (*aptx_sizeofenc)(void);

> +
> +	aptx_dl = dlopen(APTX_SO_NAME, RTLD_LAZY);
> +	if (!aptx_dl) {
> +		error("APTX: failed to open library %s (%s)", APTX_SO_NAME,
> +								dlerror());
> +		return false;
> +	}
> +
> +	aptx_version = dlsym(aptx_dl, "aptxbtenc_version");
> +	aptx_build = dlsym(aptx_dl, "aptxbtenc_build");
> +
> +	if (aptx_version && aptx_build)
> +		info("APTX: using library version %s build %s", aptx_version(),
> +								aptx_build());
> +	else
> +		warn("APTX: cannot retrieve library version");
> +
> +	aptx_sizeofenc = dlsym(aptx_dl, "SizeofAptxbtenc");
> +	aptx_init = dlsym(aptx_dl, "aptxbtenc_init");
> +	aptx_encode = dlsym(aptx_dl, "aptxbtenc_encodestereo");
> +	if (!aptx_sizeofenc || !aptx_init || !aptx_encode) {
> +		error("APTX: failed initialize library");
> +		dlclose(aptx_dl);
> +		aptx_dl = NULL;
> +		return false;
> +	}
> +
> +	aptx_sizeof = aptx_sizeofenc();
> +
> +	info("APTX: codec library initialized (size=%d)", aptx_sizeof);
> +
> +	return true;
> }
> 
> static void aptx_unload(void)
> {
> -	/* TODO: unload aptX codec library */
> +	if (aptx_dl) {
> +		dlclose(aptx_dl);
> +		aptx_dl = NULL;
> +	}
> }
> 
> static bool aptx_available(void)
> {
> -	return false;
> +	return aptx_dl != NULL;

At some point we need to start using !!aptx_handle syntax here instead of the != NULL. But this is more a general comment on how I like the coding style to change. Nothing that needs to be done right away. Just keep it in mind.

Regards

Marcel

