Return-Path: <cyrus@holtmann.org>
Message-ID: <1324484301.1965.178.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Make HCI call directly into SCO and L2CAP
 event functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Wed, 21 Dec 2011 08:18:21 -0800
In-Reply-To: <1324469493-1949-1-git-send-email-ulisses@profusion.mobi>
References: <1324469493-1949-1-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

H Ulisses,

> The struct hci_proto and all related register/unregister and dispatching
> code was removed. HCI core code now call directly the SCO and L2CAP
> event functions.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  include/net/bluetooth/hci_core.h |  138 ++++++++++++++++----------------------
>  net/bluetooth/hci_core.c         |   59 +---------------
>  net/bluetooth/l2cap_core.c       |   51 ++------------
>  net/bluetooth/sco.c              |   38 +---------
>  4 files changed, 74 insertions(+), 212 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


