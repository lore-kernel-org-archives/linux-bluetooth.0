Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 14:58:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v13 12/14] audio: Add DUN GW to org.bluez.Telephony
Message-ID: <20120718115801.GC15775@x220.ger.corp.intel.com>
References: <1342532440-730-1-git-send-email-frederic.danis@linux.intel.com>
 <1342532440-730-13-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342532440-730-13-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Jul 17, 2012, Frédéric Danis wrote:
> +static void client_connect_cb(GIOChannel *chan, GError *err,
> +				gpointer user_data)
> +{
> +	struct tel_client *client = user_data;
> +	char hs_address[18];
> +
> +	if (err) {
> +		error("%s", err->message);
> +		goto done;
> +	}
> +
> +	ba2str(&client->dst, hs_address);
> +
> +	telephony_device_connecting(chan, client->btd_dev, client,
> +				    client->agent);

Firstly, you've got the wrong indentation above. Only tabs please.

Secondly, this is exactly the kind of crap that happens when you start
using void * everywhere instead of proper types. The function
telephony_device_connecting casts the third parameter ("client" above)
to struct audio_device. See the problem?

Johan
