Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4711FB4D.2010609@free.fr>
Date: Sun, 14 Oct 2007 13:19:41 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <000001c80cca$eff9ed00$c72915ac@NOE.Nokia.com>
In-Reply-To: <000001c80cca$eff9ed00$c72915ac@NOE.Nokia.com>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils -
	fix-a2dp-buffer-constraints
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Kai,

Please find a few comments below

> Hello,
> 
> I've been having some problems in using the Bluez ALSA/A2DP plugin
> with applications that use the ALSA API in event driven fashion (so
> 'write samples at last possible moment' instead of 'write samples when 
> there is free room in the buffer'). One test application I've used is
> Pulseaudio. 
> 
> Here're couple of patches (against CVS HEAD) that solve the 
> problems for me (for instance pulseaudio starts working with
> the plugin, less CPU usage with other apps).

Could you provide some details on the problems you experienced, as well 
the hardware platform you experienced them on ?

> diff -ruN bluez-utils.orig/audio/pcm_bluetooth.c bluez-utils/audio/pcm_bluetooth.c
> --- bluez-utils.orig/audio/pcm_bluetooth.c	2007-10-12 12:57:28.000000000 +0300
> +++ bluez-utils/audio/pcm_bluetooth.c	2007-10-12 15:04:49.000000000 +0300
> @@ -45,7 +45,8 @@
>  
>  #define MIN_PERIOD_TIME 1
>  
> -#define BUFFER_SIZE 2048
> +#define MIN_BUFFER_SIZE 256    /* minimum size of buffer */
> +#define MAX_BUFFER_SIZE 16384  /* allocated RAM for buffer */
>  
>  #ifdef ENABLE_DEBUG
>  #define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg)
> @@ -123,7 +124,7 @@
>  	sbc_t sbc;			/* Codec data */
>  	int codesize;			/* SBC codesize */
>  	int samples;			/* Number of encoded samples */
> -	uint8_t buffer[BUFFER_SIZE];	/* Codec transfer buffer */
> +	uint8_t buffer[MAX_BUFFER_SIZE];/* Codec transfer buffer */
>  	int count;			/* Codec transfer buffer counter */
>  
>  	int nsamples;			/* Cumulative number of codec samples */
> @@ -137,7 +138,7 @@
>  	struct ipc_data_cfg cfg;	/* Bluetooth device config */
>  	struct pollfd stream;		/* Audio stream filedescriptor */
>  	struct pollfd server;		/* Audio daemon filedescriptor */
> -	uint8_t buffer[BUFFER_SIZE];	/* Encoded transfer buffer */
> +	uint8_t buffer[MAX_BUFFER_SIZE];/* Encoded transfer buffer */
>  	int count;			/* Transfer buffer counter */
>  	struct bluetooth_a2dp a2dp;	/* A2DP data */
>  
> @@ -932,14 +933,24 @@
>  	if (err < 0)
>  		return err;
>  
> -	/* supported block size */
> +	/* supported block sizes:
> +	 *   - lower limit is A2DP codec size
> +	 *   - total buffer size is the upper limit (with two periods) */
>  	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
> -						a2dp->codesize, a2dp->codesize);
> +					      a2dp->codesize, MAX_BUFFER_SIZE / 2);
> +	if (err < 0)
> +		return err;
> +
> +	/* supported buffer sizes */
> +	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_BUFFER_BYTES,
> +					      MIN_BUFFER_SIZE, MAX_BUFFER_SIZE);
>  	if (err < 0)
>  		return err;

This part of the code is useless, you don't need to set 
SND_PCM_IOPLUG_HW_BUFFER_BYTES if you set SND_PCM_IOPLUG_HW_PERIODS, you 
just have to choose one of the two alternatives :-)

>  
> +	/* supported period count: 
> +	 *   - derived from max buffer size and minimum period size */
>  	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
> -									2, 50);
> +					      2, MAX_BUFFER_SIZE / a2dp->codesize);
>  	if (err < 0)
>  		return err;
>  
> 

Apart from that i'd say this is a foot step in the right direction :-)

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
