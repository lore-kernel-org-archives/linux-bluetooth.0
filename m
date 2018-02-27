Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/4 v4] doc/mgmt-api: Add advertising phys support to
 flags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1511938373-22396-4-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Tue, 27 Feb 2018 14:11:22 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <53CB0FBB-5A49-4056-BD0E-10A8D34BA5D7@holtmann.org>
References: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511938373-22396-4-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> ---
> doc/mgmt-api.txt | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 628ff18..e7453ea 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2504,6 +2504,9 @@ Read Advertising Features Command
> 		4	Add TX Power field to Adv_Data
> 		5	Add Appearance field to Scan_Rsp
> 		6	Add Local Name in Scan_Rsp
> +		7	Secondary Channel with LE 1M
> +		8	Secondary Channel with LE 2M
> +		9	Secondary Channel with LE Coded
> 
> 	The Flags bit 0 indicates support for connectable advertising
> 	and for switching to connectable advertising independent of the
> @@ -2553,6 +2556,15 @@ Read Advertising Features Command
> 	space is limited a short version or no name information. The
> 	Local Name will be added at the end of the scan response data.
> 
> +	The Flags bit 7 indicates support for advertising in secondary
> +	channel in LE 1M PHY.
> +
> +	The Flags bit 8 indicates support for advertising in secondary
> +	channel in LE 2M PHY. Primary channel would be on 1M.
> +
> +	The Flags bit 9 indicates support for advertising in secondary
> +	channel in LE CODED PHY.
> +
> 	The valid range for Instance identifiers is 1-254. The value 0
> 	is reserved for internal use and the value 255 is reserved for
> 	future extensions. However the Max_Instances value for indicating
> @@ -2613,6 +2625,9 @@ Add Advertising Command
> 		4	Add TX Power field to Adv_Data
> 		5	Add Appearance field to Scan_Rsp
> 		6	Add Local Name in Scan_Rsp
> +		7	Secondary Channel with LE 1M
> +		8	Secondary Channel with LE 2M
> +		9	Secondary Channel with LE Coded
> 
> 	When the connectable flag is set, then the controller will use
> 	undirected connectable advertising. The value of the connectable
> @@ -2640,6 +2655,15 @@ Add Advertising Command
> 	supported to provide less air traffic for devices implementing
> 	broadcaster role.
> 
> +	Secondary channel flags can be used to advertise in secondary
> +	channel with the corresponding PHYs. These flag bits are mutually
> +	exclusive and setting multiple will result in Invalid Parameter
> +	error. Choosing LE 1M and LE 2M will result in using extended
> +	advertising with the primary channel being 1M and secondary channel

I think this needs to be phrased differencing.

Choosing either LE 1M or LE 2M will result in using extended advertising on the primary channel with LE 1M and the respectively LE 1M or LE 2M on the secondary channel. Choosing LE Coded will result in using extended advertising on the primary and secondary channels.

> +	with the respective PHY. Choosing LE Coded will result in extended
> +	advertising with both primary and secondary channel in LE Coded.
> +	Choosing none of these flags will result in legacy advertising.
> +

Regards

Marcel

