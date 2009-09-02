Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SSP double paring fix: init auth_type with
 HCI_AT_GENERAL_BONDING
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <508e92ca0907020657o561effbeg1911f8f84af27f37@mail.gmail.com>
References: <508e92ca0907020657o561effbeg1911f8f84af27f37@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 02:50:04 -0700
Message-Id: <1251885004.1266.57.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> I have a simple patch which fixes issues with SSP mentioned below.
> 
> ---
>  net/bluetooth/hci_conn.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fa47d5d..d863bda 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -211,6 +211,7 @@ struct hci_conn *hci_conn_add(struct hci_dev
> *hdev, int type, bdaddr_t *dst)
>  	conn->type  = type;
>  	conn->mode  = HCI_CM_ACTIVE;
>  	conn->state = BT_OPEN;
> +	conn->auth_type = HCI_AT_GENERAL_BONDING;
> 
>  	conn->power_save = 1;
>  	conn->disc_timeout = HCI_DISCONN_TIMEOUT;

I need a proper patch create with git format-patch that contains a
detailed commit message.

Regards

Marcel


