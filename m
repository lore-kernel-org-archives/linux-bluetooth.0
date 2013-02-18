Return-Path: <cyrus@holtmann.org>
Message-ID: <1361229298.1583.48.camel@aeonflux>
Subject: Re: [PATCH v3 2/5] Bluetooth: Add option for SCO socket mode
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 19 Feb 2013 00:14:58 +0100
In-Reply-To: <1359986188-24432-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1359986188-24432-2-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch extends the current SCO socket option to add a 'mode' field. This
> field is intended to choose data type at runtime. Current modes are CVSD and
> transparent SCO, but adding new modes could allow support for CSA2 and fine
> tuning a sco connection, for example latency, bandwith, voice setting. Incoming
> connections will be setup during defered setup. Outgoing connections have to
> be setup before connect(). The selected type is stored in the sco socket info.
> This patch declares needed members, modifies getsockopt() and implements
> setsockopt(). Setting the mtu is not supported.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
>  include/net/bluetooth/sco.h |    7 +++++
>  net/bluetooth/sco.c         |   59 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> index 1e35c43..4de67ef 100644
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -41,8 +41,14 @@ struct sockaddr_sco {
>  
>  /* SCO socket options */
>  #define SCO_OPTIONS	0x01
> +
> +#define SCO_MODE_CVSD		0x00
> +#define SCO_MODE_TRANSPARENT	0x01
> +#define SCO_MODE_MAX		0x01
> +
>  struct sco_options {
>  	__u16 mtu;
> +	__u8 mode;
>  };
>  
>  #define SCO_CONNINFO	0x02
> @@ -73,6 +79,7 @@ struct sco_conn {
>  struct sco_pinfo {
>  	struct bt_sock	bt;
>  	__u32		flags;
> +	__u8		mode;
>  	struct sco_conn	*conn;
>  };

so I have been reading the 4.0 core spec and CSA2 again. So with CSA2
and the enhanced eSCO setup they are splitting the PCM data format from
the the content format and make them independent in output and input.
While 4.0 core spec is essentially based around the 2-byte voice
setting.

I think we have two choices here, one is to just ignore CSA2 for now and
add a uint16 for voice setting value here, or go ahead with the full
blown crazy that is CSA2.

Splitting out voice setting into 5 byte content format and 1 byte PCM
data format seems straight forward, but then you have input and output
and also the routing path. And instead of a socket option, that looks
more like things for the socket address.

So I would actually propose to add a voice settings uint16 value as SCO
socket field. Using the full voice settings make sense since then we can
also retrieve the fact if we are doing 8-bit or 16-bit PCM. One detail
we kinda ignored since we always defaulted to 16-bit, but would be worth
while fixing while at it.

Regards

Marcel


