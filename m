Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Sep 2009 11:41:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] init and extra checking fixups
Message-ID: <20090927084151.GB18495@jh-x301>
References: <200909261237.58379.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200909261237.58379.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Sat, Sep 26, 2009, Steve Grubb wrote:
> In audio/avdtp.c, the avdtp_setconf_cmd function has an exit jump for failed.
> There are several calls to the goto that do not set err to something, meaning
> that the stack contents are what's used. I set err =0 in the beginning so that
> we no longer use the stack contents, but it seems like there should be some
> general error code that says we failed for an unspecified reason.

> diff -urp bluez-4.54.orig/audio/avdtp.c bluez-4.54/audio/avdtp.c
> --- bluez-4.54.orig/audio/avdtp.c	2009-09-26 08:43:56.000000000 -0400
> +++ bluez-4.54/audio/avdtp.c	2009-09-26 11:17:07.000000000 -0400
> @@ -1248,7 +1248,7 @@ static gboolean avdtp_setconf_cmd(struct
>  	struct conf_rej rej;
>  	struct avdtp_local_sep *sep;
>  	struct avdtp_stream *stream;
> -	uint8_t err, category = 0x00;
> +	uint8_t err = 0, category = 0x00;
>  	struct audio_device *dev;
>  	bdaddr_t src, dst;
>  	GSList *l;

The right error for the two places is AVDTP_BAD_STATE. Setting that error
before jumping to failed also means that we avoid the initialization upon
declaration for the err variable.

David and Luiz commented already on a few other issues which would be good
to fix too. Furthermore, don't be afraid to split your patches into
smaller logical chunks. That way some of them could have been already
applied and pushed upstream. And please leave out the Signed-off-by line
since we don't use it in bluez.

Johan
