Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Test 'count' value before enter the loop
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279946094-17478-1-git-send-email-gustavo@padovan.org>
References: <1279946094-17478-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 12:34:24 -0700
Message-ID: <1280259264.2621.89.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> From: Gustavo F. Padovan <padovan@profusion.mobi>
> 
> Testing first we avoid enter the loop when count = 0.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/hci_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


