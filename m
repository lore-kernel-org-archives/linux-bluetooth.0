Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC41EE033
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333079; cv=none; b=Th2huAKnG6YZueNLomizDIYNV+R09xrIUX2LbHlAPOuNbdwyyx0Uz0IxVr6hEBBZP0LhYwwHDCJVRBb41vZA/OXxiw6BBkkZUJeme5xsVcF/tfKk4n2o46prl8vPBGL1XNBjNHEyDFd2Srvb84gbybr6KfAn1e5iWrHSvSBA/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333079; c=relaxed/simple;
	bh=+bv3S5yLOFzB2JEuxVxutMAnxRwYMP64O7TmMRHXN7w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QEHamSchYZV6eW7xBqx+9KO20FNIwQCdkgsCoUz1/C/4IyZestHYkibIRlFhMirZtLf/BDMB09PnMFjEUSIJTNWmqEU9YoZqSviJodys80vmFnBTxiI575dfJa6MsEwhYdEfMTctqFPI6AZcjetrmOtZHRBWs/te1nAG0RaFvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 069AE58B141
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 11:30:41 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 134A842FF4;
	Mon,  8 Sep 2025 11:30:34 +0000 (UTC)
Message-ID: <9cdb3f9d63725c9146a4b6060dca58d7989e6fac.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] main.conf: Add FilterDiscoverable option
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 08 Sep 2025 13:30:33 +0200
In-Reply-To: <20250904163343.688862-1-luiz.dentz@gmail.com>
References: <20250904163343.688862-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieekleetvddtheekieehieegledujeeggffffefhteetheekhfdvhedtgeeujeehnecuffhomhgrihhnpegsrhdrphgrghgvnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Thu, 2025-09-04 at 12:33 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This adds FilterDiscoverable option which can be use to control if
> devices in non-discoverable mode shall be filtered or not, the
> default
> is true to adhere to core spec:

This needs more explanation as to where the filter is defined.

What happens if no filter is defined and FilterDiscoverable is set to
true?

In which circumstances would a system builder, integrator or admin want
to set this to false?

> =C2=A09.2. Discovery modes and procedures
>=20
> =C2=A0All devices shall be in either non-discoverable mode or one of the
> =C2=A0discoverable modes. A device in the discoverable mode shall be in
> =C2=A0either the general discoverable mode or the limited discoverable
> mode.
> =C2=A0A device in the non-discoverable mode is not discoverable. Devices
> =C2=A0operating in either the general discoverable mode or the limited
> =C2=A0discoverable mode can be found by the discovering device.
> ---
> =C2=A0src/adapter.c | 4 +++-
> =C2=A0src/btd.h=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0src/main.c=C2=A0=C2=A0=C2=A0 | 4 ++++
> =C2=A0src/main.conf | 5 +++++
> =C2=A04 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/adapter.c b/src/adapter.c
> index 549a6c0b8324..dc5ba65d73fa 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7239,8 +7239,10 @@ static bool device_is_discoverable(struct
> btd_adapter *adapter,
> =C2=A0
> =C2=A0	if (bdaddr_type =3D=3D BDADDR_BREDR || adapter-
> >filtered_discovery)
> =C2=A0		discoverable =3D true;
> -	else
> +	else if (btd_opts.filter_discoverable)
> =C2=A0		discoverable =3D eir->flags & (EIR_LIM_DISC |
> EIR_GEN_DISC);
> +	else
> +		discoverable =3D true;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Mark as not discoverable if no client has requested
> discovery and
> diff --git a/src/btd.h b/src/btd.h
> index 18a5eb88696a..5c952bf17956 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -142,6 +142,7 @@ struct btd_opts {
> =C2=A0	bool		refresh_discovery;
> =C2=A0	bool		experimental;
> =C2=A0	bool		testing;
> +	bool		filter_discoverable;
> =C2=A0	struct queue	*kernel;
> =C2=A0
> =C2=A0	uint16_t	did_source;
> diff --git a/src/main.c b/src/main.c
> index a542d0fc50b0..1c7390e6329d 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -91,6 +91,7 @@ static const char *supported_options[] =3D {
> =C2=A0	"Testing",
> =C2=A0	"KernelExperimental",
> =C2=A0	"RemoteNameRequestRetryDelay",
> +	"FilterDiscoverable",
> =C2=A0	NULL
> =C2=A0};
> =C2=A0
> @@ -1062,6 +1063,8 @@ static void parse_general(GKeyFile *config)
> =C2=A0	parse_config_u32(config, "General",
> "RemoteNameRequestRetryDelay",
> =C2=A0					&btd_opts.name_request_retry
> _delay,
> =C2=A0					0, UINT32_MAX);
> +	parse_config_bool(config, "General", "FilterDiscoverable",
> +						&btd_opts.filter_dis
> coverable);
> =C2=A0}
> =C2=A0
> =C2=A0static void parse_gatt_cache(GKeyFile *config)
> @@ -1239,6 +1242,7 @@ static void init_defaults(void)
> =C2=A0	btd_opts.refresh_discovery =3D TRUE;
> =C2=A0	btd_opts.name_request_retry_delay =3D
> DEFAULT_NAME_REQUEST_RETRY_DELAY;
> =C2=A0	btd_opts.secure_conn =3D SC_ON;
> +	btd_opts.filter_discoverable =3D true;
> =C2=A0
> =C2=A0	btd_opts.defaults.num_entries =3D 0;
> =C2=A0	btd_opts.defaults.br.page_scan_type =3D 0xFFFF;
> diff --git a/src/main.conf b/src/main.conf
> index 86759d53c1f2..55618be5c923 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -148,6 +148,11 @@
> =C2=A0# The value is in seconds. Default is 300, i.e. 5 minutes.
> =C2=A0#RemoteNameRequestRetryDelay =3D 300
> =C2=A0
> +# Filter out non-discoverable devices based on discoverable flags
> (General or
> +# Limited).
> +# Defaults to true
> +#FilterDiscoverable =3D true
> +
> =C2=A0[BR]
> =C2=A0# The following values are used to load default adapter parameters
> for BR/EDR.
> =C2=A0# BlueZ loads the values into the kernel before the adapter is
> powered if the
