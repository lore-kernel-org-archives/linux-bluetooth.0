Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 01/11] mgmt-api: Update the commands for
 exchanging LTK's
Date: Wed, 18 Jan 2012 07:17:02 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B41DE13@DNCE02.ent.ti.com>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Vinicius,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> Sent: Wednesday, January 18, 2012 1:29 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Vinicius Costa Gomes
> Subject: [PATCH BlueZ 01/11] mgmt-api: Update the commands for
> exchanging LTK's
> 
> For restoring the device from storage we need to have the Address type
> of the device, the LTK is a good place for this.

Storing the address type in the LTK is not perfect. For this to work properly, you will store the address type only for devices which exchanged keys. What if we have devices which do not do pairing or exchange keys at all ? What if we use the CreateDevice instead of CreatePairedDevice? In that case we will not have the address type for future reconnections. We need to store the device address type in a separate file (for example, addresstypes) and manage it separately from the LTK management.

> 
> In some cases, we may be notified of keys that were generated in the
> Host, that key key would be used when the Host is the slave role in
> a later connection, we should be able to differentiate this type of
> key because it doesn't mean that we have a bonding with the Remote
> Device.
> ---
>  doc/mgmt-api.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 3e188c2..8fe7c94 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -477,7 +477,9 @@ Load Long Term Keys Command
>  	Command Parameters:	Key Count (2 Octets)
>  				Key1 {
>  					Address (6 Octets)
> +					Type (1 Octet)
>  					Authenticated (1 Octet)
> +					Master (1 Octet)
>  					Encryption Size (1 Octet)
>  					Enc. Diversifier (2 Octets)
>  					Random Number (8 Octets)
> @@ -758,7 +760,9 @@ Controller Index	<controller id>
>  Event Parameters	Store Hint (1 Octet)
>  			Key {
>  				Address (6 Octets)
> +				Type (1 Octet)
>  				Authenticated (1 Octet)
> +				Master (1 Octet)
>  				Encryption Size (1 Octet)
>  				Enc. Diversifier (2 Octets)
>  				Random Number (8 Octets)
> --
> 1.7.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Thanks,
Chen Ganir

