Return-Path: <cyrus@holtmann.org>
Message-ID: <1349963540.27233.173.camel@aeonflux>
Subject: Re: [PATCH -v2 7/8] Bluetooth: Use locked l2cap_state_change()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Thu, 11 Oct 2012 15:52:20 +0200
In-Reply-To: <1349938311-25101-7-git-send-email-gustavo@padovan.org>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
	 <1349938311-25101-7-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> No one was protecting the state set in l2cap_send_disconn_req()
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


