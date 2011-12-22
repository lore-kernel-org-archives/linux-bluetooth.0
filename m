Return-Path: <cyrus@holtmann.org>
Message-ID: <1324583232.1965.223.camel@aeonflux>
Subject: Re: [PATCH 10/12] Bluetooth: Don't disable interrupt when locking
 the queue
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 22 Dec 2011 11:47:12 -0800
In-Reply-To: <1324580173-24957-10-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-10-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> We run everything in iterrupt context now.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/hci_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


