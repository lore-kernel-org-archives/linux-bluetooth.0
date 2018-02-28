Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [v5 PATCH 1/3] doc/mgmt-api: Add support for Get PHY
 Configuration command
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
References: <1519804151-4850-1-git-send-email-jaganathx.kanakkassery@intel.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <4390da8e-d690-0343-9903-f30bca4e5b3d@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 17:26:29 +0900
MIME-Version: 1.0
In-Reply-To: <1519804151-4850-1-git-send-email-jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On 02/28/2018 04:49 PM, Jaganath Kanakkassery wrote:
> ---
>  doc/mgmt-api.txt | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 8e7de14..c07c48c 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2871,6 +2871,7 @@ Read Extended Controller Information Command
>  		13	Privacy
>  		14	Controller Configuration
>  		15	Static Address
> +		16  	PHY configuration

nitpick: better to use tab instead of whitespaces


Regards,
Eramoto

>  
>  	The EIR_Data field contains information about class of device,
>  	local name and other values. Not all of them might be present. For
> @@ -2916,6 +2917,33 @@ Set Appearance Command
>  				Invalid Parameters
>  				Invalid Index
>  
> +Get PHY Configuration Command
> +==========================
> +
> +	Command Code:		0x0043
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Supported_phys (2 Octet)
> +				Selected_phys (2 Octet)
> +
> +	This command is used to retrieve the supported PHYs and currently
> +	selected PHYs.
> +
> +	Supported_phys and Selected_phys is a bitmask with the following bits.
> +		0	LE 1M TX
> +		1	LE 1M RX
> +		2	LE 2M TX
> +		3	LE 2M RX
> +		4	LE CODED TX
> +		5	LE CODED RX
> +
> +	LE 1M TX and LE 1M RX would be supported by default.
> +
> +	This command is only available for LE capable controllers.
> +	It will return Not Supported otherwise.
> +
> +	Possible errors:	Not Supported
> +				Invalid Index
>  
>  Command Complete Event
>  ======================
> 

