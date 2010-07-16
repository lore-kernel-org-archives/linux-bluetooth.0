Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Move bit-field var to data->flags
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279311633-12131-1-git-send-email-gustavo@padovan.org>
References: <1279311633-12131-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jul 2010 13:54:27 -0700
Message-ID: <1279313667.6282.85.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> did_iso_resume keeps only a bit-field value, so moving that to a proper
> flags place.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  drivers/bluetooth/btusb.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


