Return-Path: <cyrus@holtmann.org>
Message-ID: <1324583057.1965.220.camel@aeonflux>
Subject: Re: [PATCH 08/12] Bluetooth: Remove local_bh_disable() from
 hci_sock.c
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 22 Dec 2011 11:44:17 -0800
In-Reply-To: <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Everything is in process context now, we do not need such a call.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/hci_sock.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

this should hold true even without any of the other preceding patches.
Or did I overlook something?

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


