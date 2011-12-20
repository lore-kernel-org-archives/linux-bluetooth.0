Return-Path: <cyrus@holtmann.org>
Message-ID: <1324399877.1965.120.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: convert security timer to delayed_work
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Dec 2011 08:51:17 -0800
In-Reply-To: <1324385848-19101-2-git-send-email-padovan@profusion.mobi>
References: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
	 <1324385848-19101-2-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This one also needs to run in process context
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_core.c    |   12 ++++++------
>  net/bluetooth/smp.c           |    7 ++++---
>  3 files changed, 11 insertions(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


