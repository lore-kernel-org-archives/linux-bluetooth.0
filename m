Return-Path: <cyrus@holtmann.org>
Message-ID: <1325542881.1965.398.camel@aeonflux>
Subject: Re: [PATCH 5/5] Bluetooth: Remove *_bh from socket list lock.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:21:21 -0800
In-Reply-To: <1325006928-3338-5-git-send-email-padovan@profusion.mobi>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
	 <1325006928-3338-2-git-send-email-padovan@profusion.mobi>
	 <1325006928-3338-3-git-send-email-padovan@profusion.mobi>
	 <1325006928-3338-4-git-send-email-padovan@profusion.mobi>
	 <1325006928-3338-5-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> We don't need it anymore.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/af_bluetooth.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


