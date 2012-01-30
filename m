Return-Path: <cyrus@holtmann.org>
Message-ID: <1327959054.1955.163.camel@aeonflux>
Subject: Re: [PATCH v4 2/2] Bluetooth: Fix possible use after free in delete
 path
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Mon, 30 Jan 2012 13:30:54 -0800
In-Reply-To: <1327955189-4604-2-git-send-email-ulisses@profusion.mobi>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
	 <1327955189-4604-2-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> We need to use the _sync() version for cancelling the info and security
> timer in the L2CAP connection delete path. Otherwise the delayed work
> handler might run after the connection object is freed.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


