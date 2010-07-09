Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: Fix bug in kzalloc allocation size
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1278704315-28192-1-git-send-email-gustavo@padovan.org>
References: <1278704315-28192-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 17:46:02 -0300
Message-ID: <1278708362.10421.149.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Probably a typo error. We were using the wrong struct to get size.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


