Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 20:31:28 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Consider the type param in start_discovery
Message-ID: <20111201113128.GA2894@joana>
References: <1321991425-1783-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1321991425-1783-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

* Andre Guedes <andre.guedes@openbossa.org> [2011-11-22 16:50:25 -0300]:

> The Management Interface API has been changed and now the Start
> Discovery Command has the 'type' parameter. This parameters has
> been define as follows:
> 
> Possible values for the Type parameter are a bit-wise or of the
> following bits:
> 
> 	1       BR/EDR
> 	2       LE Public
> 	3       LE Random
> 
> By combining these e.g. the following values are possible:
> 
> 	1       BR/EDR
> 	6       LE (public & random)
> 	7       BR/EDR/LE (interleaved discovery)
> 
> Further information about Start Discovery Command see mgmt-api.txt
> in BlueZ source.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/mgmt.c             |   27 ++++++++++++++++++++++++++-
>  3 files changed, 28 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
