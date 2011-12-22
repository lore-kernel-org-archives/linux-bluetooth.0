Return-Path: <cyrus@holtmann.org>
Message-ID: <1324583358.1965.225.camel@aeonflux>
Subject: Re: [PATCH 05/12] Bluetooth: Don't use *_bh locks anymore
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 22 Dec 2011 11:49:18 -0800
In-Reply-To: <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Those locks are not shared between interrupt and process context anymore,
> so remove the part that disable interruption. We are stiff safe because
> preeption is disabled.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap_core.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)

any reason why this can not be converted into RCU usage?

Regards

Marcel


