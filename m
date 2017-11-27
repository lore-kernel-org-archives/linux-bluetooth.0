Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 27 Nov 2017 15:32:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH 3/3 v2] doc/mgmt-api: Add advertising phys support to
 flags
Message-ID: <20171127133255.GA24336@x1c.home>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-4-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511173617-25442-4-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Nov 20, 2017, Jaganath Kanakkassery wrote:
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
> +	Secondary channel flags can be used to advertise in secondary
> +	channel with the corresponding PHYs. In case of 2M, the primary
> +	channel used would be 1M. If none of them are set then secondary
> +	channel advertising would be disabled for this instance which is as
> +	good as legacy advertising. Combining the sets would result in
> +	multiple advertising sets being created.

What kind of combination of parameters would we select LE Coded for the
primary channel? Don't we need a flag for it? It should either way be
documented when LE Coded gets used for the primary PHY.

Johan
