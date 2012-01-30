Return-Path: <cyrus@holtmann.org>
Message-ID: <1327963788.1955.199.camel@aeonflux>
Subject: Re: [PATCH 7/8] Bluetooth: Clean up structures left unused
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 14:49:48 -0800
In-Reply-To: <1327962558-25720-8-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1327962558-25720-8-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> With the use of the new structures and lists for the SMP LTK's
> we may remove some code that is now unused. No need to have extra
> fields of information inside link_key now that it is only used
> for Link Keys.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    4 ----
>  include/net/bluetooth/hci_core.h |   16 ----------------
>  2 files changed, 0 insertions(+), 20 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


