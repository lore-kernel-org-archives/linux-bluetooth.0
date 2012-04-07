Return-Path: <cyrus@holtmann.org>
Message-ID: <1333799079.16897.24.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Remove err parameter from alloc_skb()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 07 Apr 2012 13:44:39 +0200
In-Reply-To: <1333754148-18796-1-git-send-email-gustavo@padovan.org>
References: <1333754148-18796-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Use ERR_PTR maginc instead.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_core.c    |   30 +++++++++++++-----------------
>  net/bluetooth/l2cap_sock.c    |   12 ++++++++----
>  3 files changed, 22 insertions(+), 22 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


