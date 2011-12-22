Return-Path: <cyrus@holtmann.org>
Message-ID: <1324583121.1965.221.camel@aeonflux>
Subject: Re: [PATCH 09/12] Bluetooth: remove *_bh usage from hci_dev_list
 and hci_cb_list
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 22 Dec 2011 11:45:21 -0800
In-Reply-To: <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> They don't need to disable interruption anymore, we only run in interrupt
> context now.

I assume you mean process context here.

> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/hci_core.h |   16 ++++++++--------
>  net/bluetooth/hci_conn.c         |    4 ++--
>  net/bluetooth/hci_core.c         |   24 ++++++++++++------------
>  3 files changed, 22 insertions(+), 22 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


