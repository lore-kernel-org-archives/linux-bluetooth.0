Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jul 2013 14:39:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 2/6] btio: Add option for SCO voice setting
Message-ID: <20130709113942.GA22976@x220.p-661hnu-f1>
References: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1373039207-20959-3-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1373039207-20959-3-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Fri, Jul 05, 2013, Frédéric Dalleau wrote:
> -static gboolean sco_set(int sock, uint16_t mtu, GError **err)
> +static gboolean sco_set(int sock, uint16_t mtu, uint16_t voice, GError **err)
>  {
>  	struct sco_options sco_opt;
> +	struct bt_voice bt_voice;
>  	socklen_t len;
>  
>  	if (!mtu)
> @@ -745,6 +747,13 @@ static gboolean sco_set(int sock, uint16_t mtu, GError **err)
>  		return FALSE;
>  	}
>  
> +	bt_voice.setting = voice;
> +	if (setsockopt(sock, SOL_BLUETOOTH, BT_VOICE, &bt_voice,
> +						sizeof(bt_voice)) < 0) {
> +		ERROR_FAILED(err, "setsockopt(BT_VOICE)", errno);
> +		return FALSE;
> +	}
> +

Why are you calling setsockopt even when a value was not explicitly
passed to BtIO? There's an MTU check "if (!mtu)" so surely there should
also be a check for "if (!voice)", right?

Johan
