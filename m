Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 3/3] doc/mgmt-api: Add advertising phys support to flags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1510655538-12883-5-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Tue, 14 Nov 2017 12:39:02 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <45F5B873-D619-4EDB-89F9-BA14447AA7F6@holtmann.org>
References: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1510655538-12883-5-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> Technically it is possible to advertise on LE Coded in Primary
> and LE 1M/2M in secondary, but that is not added in the interface
> since advertising in Coded means that scanners are expected to be
> in long range and then advertising in other phys in secondary
> does not make sense.
> ---
> doc/mgmt-api.txt | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 25739cc..fe1c0a5 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2613,6 +2613,8 @@ Add Advertising Command
> 		4	Add TX Power field to Adv_Data
> 		5	Add Appearance field to Scan_Rsp
> 		6	Add Local Name in Scan_Rsp
> +		7 	Advertise in Coded PHY
> +		8	Advertise in 2M PHY
> 
> 	When the connectable flag is set, then the controller will use
> 	undirected connectable advertising. The value of the connectable
> @@ -2640,6 +2642,16 @@ Add Advertising Command
> 	supported to provide less air traffic for devices implementing
> 	broadcaster role.
> 
> +	Advertising PHY flags should be used only if the controller
> +	supports the corresponding phy which can be retrieved using
> +	Get Supported Phys command otherwise Invalid Parameter would
> +	be returned. If none of the flags are set and if controller

this has nothing to do with supported PHYs command. We have supported flags here and for advertising we need to treat this independent.

> +	supports extended advertising then 1M would be used for both
> +	Primary and Secondary channel. If 2M is set then 1M
> +	would be selected for primary and 2M for secondary channel.
> +	If Coded is set then it would be used for both primary
> +	and secondary channels.
> +

I think it might be more important that we use it like this:

	7  Secondary Channel with LE 1M
	8  Secondary Channel with LE 2M
	9  Secondary Channel with LE Coded

Specifying either of the three bits will result in extended advertising to be used. If not of them are set, then legacy advertising is used.

Combining them will result into multiple advertising sets to be created. If you specify all 3, then we actually required 3 advertising sets to be programmed.

Regards

Marcel

