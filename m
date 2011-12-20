Return-Path: <cyrus@holtmann.org>
Message-ID: <1324399902.1965.121.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: Rename info_work to info_timer
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Dec 2011 08:51:42 -0800
In-Reply-To: <1324385848-19101-3-git-send-email-padovan@profusion.mobi>
References: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
	 <1324385848-19101-2-git-send-email-padovan@profusion.mobi>
	 <1324385848-19101-3-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> It makes more sense this way, since info_timer is a timer using delayed
> work API.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_core.c    |   14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


