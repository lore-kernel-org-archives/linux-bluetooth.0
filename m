Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth: l2cap and rfcomm: fix 1 byte infoleak to userspace.
From: Marcel Holtmann <marcel@holtmann.org>
To: Filip Palian <s3810@pjwstk.edu.pl>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <BANLkTik7WyQ977-+8XapTgBrVRMyexyHKg@mail.gmail.com>
References: <BANLkTik7WyQ977-+8XapTgBrVRMyexyHKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 May 2011 18:30:00 -0700
Message-ID: <1305163800.15916.169.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filip,

> Structures "l2cap_conninfo" and "rfcomm_conninfo" have one padding
> byte each. This byte in "cinfo" is copied to userspace uninitialized.
> 
> patch no.1:
> -- cut --
> --- a/net/bluetooth/l2cap_sock.c        2011-05-04 03:59:13.000000000 +0100
> +++ b/net/bluetooth/l2cap_sock.c        2011-05-08 18:57:20.000000000 +0100
> @@ -446,6 +446,7 @@ static int l2cap_sock_getsockopt_old(str
>                         break;
>                 }
> 
> +               memset(&cinfo, 0, sizeof(cinfo));
>                 cinfo.hci_handle = l2cap_pi(sk)->conn->hcon->handle;
>                 memcpy(cinfo.dev_class, l2cap_pi(sk)->conn->hcon->dev_class, 3);

nice catch, but please create a patch via git format-patch and don't
forget a Signed-off-by line.

Regards

Marcel


