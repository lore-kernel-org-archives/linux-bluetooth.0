Return-Path: <cyrus@holtmann.org>
Message-ID: <1356369191.29264.45.camel@aeonflux>
Subject: Re: [PATCH 2/2] lib: Use SOCK_CLOEXEC where needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Cristian =?ISO-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 24 Dec 2012 09:13:11 -0800
In-Reply-To: <1356367487-1610-1-git-send-email-crrodriguez@opensuse.org>
References: <1356367487-1610-1-git-send-email-crrodriguez@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cristian,

> Calling programs might fork().. execve() and we will end
> up leaking fds.
> ---
>  lib/hci.c |  8 ++++----
>  lib/sdp.c | 13 ++++++-------
>  2 files changed, 10 insertions(+), 11 deletions(-)

you need to pay more attention to your patches.

Applying: lib: Use SOCK_CLOEXEC where needed
/data/devel/bluez/.git/rebase-apply/patch:64: trailing whitespace.
	
fatal: 1 line adds whitespace errors.
Patch failed at 0001 lib: Use SOCK_CLOEXEC where needed

I fixed this up now as well.

> diff --git a/lib/hci.c b/lib/hci.c
> index 66b2d5f..1f9058f 100644
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -817,7 +817,7 @@ int hci_for_each_dev(int flag, int (*func)(int dd, int dev_id, long arg),
>  	int dev_id = -1;
>  	int i, sk, err = 0;
>  
> -	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> +	sk = socket(AF_BLUETOOTH, SOCK_RAW|SOCK_CLOEXEC, BTPROTO_HCI);

This needs an extra space between the socket flags. And so on...

Regards

Marcel


