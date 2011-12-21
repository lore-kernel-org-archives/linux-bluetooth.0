Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Dec 2011 02:22:08 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Always compile SCO and L2CAP in
 Bluetooth Core
Message-ID: <20111221042207.GD2729@joana>
References: <1324438330-9887-1-git-send-email-ulisses@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324438330-9887-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

* Ulisses Furquim <ulisses@profusion.mobi> [2011-12-21 01:32:09 -0200]:

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

This one is also applied, thanks.

	Gustavo
