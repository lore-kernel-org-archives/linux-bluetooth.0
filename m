Return-Path: <cyrus@holtmann.org>
Message-ID: <1324583000.1965.219.camel@aeonflux>
Subject: Re: [PATCH 07/12] Bluetooth: Remove lock from inquiry_cache
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 22 Dec 2011 11:43:20 -0800
In-Reply-To: <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> It was never used, so removing it.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/hci_core.h |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


