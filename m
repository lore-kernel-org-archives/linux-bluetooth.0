Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 13:40:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 05/14] thermometer: Update API document
Message-ID: <20120928104022.GB25415@x220>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348584763-22824-6-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348584763-22824-6-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Sep 25, 2012, Andrzej Kaczmarek wrote:
> This patch updates Thermometer API document to reflect changes in
> Thermometer interface and introduction of ThermometerManager
> interface.
> ---
>  doc/thermometer-api.txt | 59 +++++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
> index 2271270..b0b0fe2 100644
> --- a/doc/thermometer-api.txt
> +++ b/doc/thermometer-api.txt
> @@ -3,28 +3,14 @@ BlueZ D-Bus Thermometer API description
>  
>  	Santiago Carot-Nemesio <sancane@gmail.com>
>  
> -Health Thermometer Profile hierarchy
> -=====================================

Could you please fix minor formatting inconsistencies like the
underlines (====) being different length than the text above it.

> -Service		org.bluez
> -Interface	org.bluez.Thermometer
> -Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> -
> -
> -Methods		void SetProperty(string name, variant value)
> -
> -			Changes the value of the specified property. Only
> -			read-write properties can be changed. On success
> -			this will emit a PropertyChanged signal.
> +Health Thermometer Manager hierarchy
> +============================
>  
> -			Possible Errors: org.bluez.Error.InvalidArguments
> +Service 	org.bluez

Theres some weird space-tab stuff going on with the line above please
fix.

Johan
