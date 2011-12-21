Return-Path: <cyrus@holtmann.org>
Message-ID: <1324438744.1965.160.camel@aeonflux>
Subject: Re: [PATCH v2 1/2] Bluetooth: Always compile SCO and L2CAP in
 Bluetooth Core
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Tue, 20 Dec 2011 19:39:04 -0800
In-Reply-To: <1324438330-9887-1-git-send-email-ulisses@profusion.mobi>
References: <1324438330-9887-1-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> The handling of SCO audio links and the L2CAP protocol are essential to
> any system with Bluetooth thus are always compiled in from now on.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  include/net/bluetooth/bluetooth.h |   22 ----------------------
>  net/bluetooth/Kconfig             |   37 +++++++++----------------------------
>  net/bluetooth/Makefile            |    5 ++---
>  net/bluetooth/bnep/Kconfig        |    2 +-
>  net/bluetooth/cmtp/Kconfig        |    2 +-
>  net/bluetooth/hidp/Kconfig        |    2 +-
>  net/bluetooth/rfcomm/Kconfig      |    2 +-
>  7 files changed, 15 insertions(+), 57 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


