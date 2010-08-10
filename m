Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: new sockopt to enter active state when
 sending data
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1281443393-31160-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1281443393-31160-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 09:07:23 -0400
Message-ID: <1281445643.12579.210.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Patch adds new socket option to enter active state when sending
> data. Modified version of Fabien Chevalier patch (Sep/2008).
> Discussions:
> http://www.spinics.net/lists/bluez-devel/msg00567.html
> http://www.spinics.net/lists/linux-bluetooth/msg03765.html
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/l2cap.h    |    1 +
>  net/bluetooth/hci_conn.c         |    7 ++++++-
>  net/bluetooth/l2cap.c            |    3 +++
>  4 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e42f6ed..477a492 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -178,6 +178,7 @@ struct hci_conn {
>  	__u8             auth_type;
>  	__u8             sec_level;
>  	__u8             power_save;
> +	__u8             force_active;
>  	__u16            disc_timeout;
>  	unsigned long	 pend;
>  
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 7c695bf..0a8ac4c 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -57,6 +57,7 @@ struct l2cap_options {
>  	__u8  mode;
>  	__u8  fcs;
>  	__u8  max_tx;
> +	__u8  force_active;
>  	__u16 txwin_size;
>  };

this is a clear NAK. You are breaking API and ABI compatibility with
this change.

Also don't overload the l2cap_options, create a new one.

Regards

Marcel


