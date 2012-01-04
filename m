Return-Path: <cyrus@holtmann.org>
Message-ID: <1325692073.6454.32.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix using an absolute timeout on
 hci_conn_put()
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 04 Jan 2012 07:47:53 -0800
In-Reply-To: <1325689037-19540-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1325689037-19540-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> queue_delayed_work() expects a relative time for when that work
> should be scheduled.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


