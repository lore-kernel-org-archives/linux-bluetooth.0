Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200909261237.58379.sgrubb@redhat.com>
References: <200909261237.58379.sgrubb@redhat.com>
Date: Sun, 27 Sep 2009 00:01:08 -0300
Message-ID: <2d5a2c100909262001h731c8c7bxcebc9a07b4fd470d@mail.gmail.com>
Subject: Re: [PATCH] init and extra checking fixups
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Sat, Sep 26, 2009 at 1:37 PM, Steve Grubb <sgrubb@redhat.com> wrote:
> diff -urp bluez-4.54.orig/audio/control.c bluez-4.54/audio/control.c
> --- bluez-4.54.orig/audio/control.c     2009-09-26 08:43:56.000000000 -0400
> +++ bluez-4.54/audio/control.c  2009-09-26 11:24:04.000000000 -0400
> @@ -472,7 +472,7 @@ static gboolean control_cb(GIOChannel *c
>        struct avrcp_header *avrcp;
>        int ret, packet_size, operand_count, sock;
>
> -       if (!(cond | G_IO_IN))
> +       if (!(cond & G_IO_IN))
>                goto failed;

I don't think this is actually right, if we change it to AND operation
it would mean we won't process any other error condition if it happens
together with G_IO_IN, but still the OR seems wrong here, normally we
use the following check which I believe is more appropriate:


	if (cond & (G_IO_HUP | G_IO_ERR))
		goto failed;

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
