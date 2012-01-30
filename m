Return-Path: <cyrus@holtmann.org>
Message-ID: <1327948323.1955.142.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Remove unneeded locking
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Date: Mon, 30 Jan 2012 10:32:03 -0800
In-Reply-To: <1327704123-31313-2-git-send-email-andre.guedes@openbossa.org>
References: <1327704123-31313-1-git-send-email-andre.guedes@openbossa.org>
	 <1327704123-31313-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> We don't need locking hdev in hci_conn_timeout() since it doesn't
> access any hdev's shared resources, it basically queues HCI commands.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>
Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


