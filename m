Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 2/2] Bluetooth: Add support for returning the encryption
 key size
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
In-Reply-To: <1302825888-5359-3-git-send-email-vinicius.gomes@openbossa.org>
References: <1302825888-5359-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1302825888-5359-3-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Apr 2011 17:57:20 -0700
Message-ID: <1302915440.2503.26.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This will be useful when userspace wants to restrict some kinds of
> operations based on the length of the key size used to encrypt the
> link.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/bluetooth.h |    1 +
>  net/bluetooth/l2cap_sock.c        |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index acf186d..28ae91a 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -56,6 +56,7 @@
>  #define BT_SECURITY	4
>  struct bt_security {
>  	__u8 level;
> +	__u8 key_size;
>  };

there is one thing we need to keep in mind. Who is enforcing the
encryption key size and triggers are re-pairing if needed? Do we wanna
do that inside kernel space or have userspace involved?

Essentially besides maybe exporting the current encryption key size, you
also wanna enforce a minium encryption key size.

We can do this with this socket option in one go. I am fine with that,
but we need to have a way to ensure minium encryption key size or 0 if
we do not care.

And of course the same now applies for PIN code length. Even if with
Simple Pairing this does not matter anymore. For Legacy Pairing this is
still relevant.

Regards

Marcel


