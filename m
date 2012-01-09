Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138039.6454.153.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: Remove bogus inline declaration from
 l2cap_chan_connect
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Jan 2012 11:40:39 -0800
In-Reply-To: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
References: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> As reported by Dan Carpenter this function causes a Sparse warning and
> shouldn't be declared inline:
> 
> include/net/bluetooth/l2cap.h:837:30 error: marked inline, but without a
> definition"
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_core.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


