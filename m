Return-Path: <cyrus@holtmann.org>
Message-ID: <1329547182.28848.194.camel@aeonflux>
Subject: Re: [RFC v2 1/4] Bluetooth: Prepare start_discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 18 Feb 2012 07:39:42 +0100
In-Reply-To: <1329521978-8537-2-git-send-email-andre.guedes@openbossa.org>
References: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
	 <1329521978-8537-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch does some code refactoring in start_discovery function
> in order to prepare it for interleaved discovery support.
> 
> MGMT_ADDR_* macros were moved to hci_core.h since they are now used
> to define discovery type macros.
> 
> Discovery type macros were defined according to mgmt-api.txt
> specification:
> 
> Possible values for the Type parameter are a bit-wise or of the
> following bits:
> 
> 	1	BR/EDR
> 	2	LE Public
> 	3	LE Random
> 
> By combining these e.g. the following values are possible:
> 
> 	1	BR/EDR
> 	6	LE (public & random)
> 	7	BR/EDR/LE (interleaved discovery)
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |   12 ++++++++++++
>  include/net/bluetooth/mgmt.h     |    5 -----
>  net/bluetooth/mgmt.c             |   15 ++++++++++-----
>  3 files changed, 22 insertions(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


