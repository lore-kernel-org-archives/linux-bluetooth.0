Return-Path: <cyrus@holtmann.org>
Message-ID: <1327963183.1955.190.camel@aeonflux>
Subject: Re: [PATCH 2/8] Bluetooth: Rename smp_key_size to enc_key_size
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 14:39:43 -0800
In-Reply-To: <1327962558-25720-3-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1327962558-25720-3-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This makes clear that this is the size of the key used to
> encrypt the link.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/smp.h |    2 +-
>  net/bluetooth/smp.c         |   18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


