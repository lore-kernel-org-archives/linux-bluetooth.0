Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: Rename l2cap_check_security()
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Nov 2011 08:56:02 +0900
In-Reply-To: <1320677128-25949-1-git-send-email-padovan@profusion.mobi>
References: <1320677128-25949-1-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320710165.15441.310.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> rename to l2cap_chan_check_security() to make it consistent with other
> l2cap_exported functions. This function will be exported in a later
> commit.

export it right away in this commit as well. Having it exported by the
commit that also uses this is the wrong separation.

> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap_core.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

Otherwise.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


