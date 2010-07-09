Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Remove 'sport' field from l2cap_pinfo
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1278701753-25682-1-git-send-email-gustavo@padovan.org>
References: <1278701753-25682-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 17:46:46 -0300
Message-ID: <1278708406.10421.151.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> 'sport' is pointless, is always has the value of l2cap_pinfo.psm, so we
> can just use the psm field instead of this one.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |    2 --
>  net/bluetooth/l2cap.c         |    8 +++-----
>  2 files changed, 3 insertions(+), 7 deletions(-)

NAK here since this part is needed to differentiate server and client
connections.

Regards

Marcel


