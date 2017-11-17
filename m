Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH 3/3 v1] doc/mgmt-api: Add advertising phys support to
 flags
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
References: <1510809661-23067-1-git-send-email-jaganathx.kanakkassery@intel.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <0e524d27-13c7-be5c-a17a-2c62aab2a379@jp.fujitsu.com>
Date: Fri, 17 Nov 2017 14:32:57 +0900
MIME-Version: 1.0
In-Reply-To: <1510809661-23067-1-git-send-email-jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On 11/16/2017 02:21 PM, Jaganath Kanakkassery wrote:
> ---
>  doc/mgmt-api.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index b59bf0c..c138f47 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2504,6 +2504,9 @@ Read Advertising Features Command
>  		4	Add TX Power field to Adv_Data
>  		5	Add Appearance field to Scan_Rsp
>  		6	Add Local Name in Scan_Rsp
> +		7	Secondary Channel with LE 1M
> +		8	Secondary Channel with LE 2M
> +		9	Secondary Channel with LE Coded
>  
>  	The Flags bit 0 indicates support for connectable advertising
>  	and for switching to connectable advertising independent of the
> @@ -2553,6 +2556,15 @@ Read Advertising Features Command
>  	space is limited a short version or no name information. The
>  	Local Name will be added at the end of the scan response data.
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
>  	The valid range for Instance identifiers is 1-254. The value 0
>  	is reserved for internal use and the value 255 is reserved for
>  	future extensions. However the Max_Instances value for indicating
> @@ -2613,6 +2625,9 @@ Add Advertising Command
>  		4	Add TX Power field to Adv_Data
>  		5	Add Appearance field to Scan_Rsp
>  		6	Add Local Name in Scan_Rsp
> +		7	Secondary Channel with LE 1M
> +		8	Secondary Channel with LE 2M
> +		9	Secondary Channel with LE Coded
>  
>  	When the connectable flag is set, then the controller will use
>  	undirected connectable advertising. The value of the connectable
> @@ -2640,6 +2655,13 @@ Add Advertising Command
>  	supported to provide less air traffic for devices implementing
>  	broadcaster role.
>  
> +	Secondary channel flags can be used to avertise in secondary

s/avertise/advertise/

> +	channel with the corresponding PHYs. In case of 2M, the primary
> +	channel used would be 1M. If none of them are set then secondary
> +	channel advertising would be disable for this insance which is as

Perhaps, s/insance/instance/

> +	good as legacy adveritsing. Combining the sets would result in

s/adveritsing/advertising/

> +	multiple adv sets being created.
> +
>  	The Duration parameter configures the length of an Instance. The
>  	value is in seconds.
>  
> 

Regards,
Eramoto

