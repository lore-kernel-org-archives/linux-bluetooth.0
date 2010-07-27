Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Bluetooth: Add __init and __exit marks to RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279947885-19304-2-git-send-email-gustavo@padovan.org>
References: <1279947885-19304-1-git-send-email-gustavo@padovan.org>
	 <1279947885-19304-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 12:37:19 -0700
Message-ID: <1280259439.2621.92.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Those annotation save memory and space on the binary. __init code is
> discarded just after execute and __exit code is discarded if the module is
> built into the kernel image or unload of modules is not allowed.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/sock.c |    2 +-
>  net/bluetooth/rfcomm/tty.c  |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


