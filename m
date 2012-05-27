Return-Path: <cyrus@holtmann.org>
Message-ID: <1338095392.15105.105.camel@aeonflux>
Subject: Re: [PATCH -v2 09/12] Bluetooth: check for already existent channel
 before create new one
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sun, 27 May 2012 07:09:52 +0200
In-Reply-To: <1337949064-26187-10-git-send-email-gustavo@padovan.org>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
	 <1337949064-26187-10-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Move this check to before the channel time creation simplifies the code
> and avoid memory allocation if the channel already exist.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


