Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 14:57:39 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Antti Julku <antti.julku@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add blacklisting support for mgmt
 interface
Message-ID: <20110615175739.GA23248@joana>
References: <1308128475-11670-1-git-send-email-antti.julku@nokia.com>
 <1308128475-11670-2-git-send-email-antti.julku@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308128475-11670-2-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Antti Julku <antti.julku@nokia.com> [2011-06-15 12:01:15 +0300]:

> Management interface commands for blocking and unblocking devices.
> 
> Signed-off-by: Antti Julku <antti.julku@nokia.com>
> ---
>  include/net/bluetooth/mgmt.h |   10 ++++++
>  net/bluetooth/mgmt.c         |   70 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 4899286..45bea25 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -199,6 +199,16 @@ struct mgmt_cp_remove_remote_oob_data {
>  
>  #define MGMT_OP_STOP_DISCOVERY		0x001C
>  
> +#define MGMT_OP_BLOCK_DEVICE		0x001D
> +struct mgmt_cp_block_device {
> +	bdaddr_t bdaddr;
> +} __packed;
> +
> +#define MGMT_OP_UNBLOCK_DEVICE		0x001E

To make hci code consistent call replace _DEVICE by _ADDR in both macros.

	Gustavo
