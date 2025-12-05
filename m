Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C41FF7C7
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 05:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764998965; cv=none; b=OW+BlhawEWw66PtE/BZb+uHQiee77DWFuGMghWeyjKBT7pf6BmCnJpWM6ehJD3ltWGdlXR57ORjxoVoCcDm7ZEKTO5R32tBdIdnt7uyKA+9I/TCkGnPzGKdv3jWFunXdHVxYHDazMRIXCgEU3JDcPJVG16EbKoH+ny0I7bi6u2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764998965; c=relaxed/simple;
	bh=kvaVICPJgckVprAkO1PTzdwxzYwo/eA1iHNuVj+VMmQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gH0wd24KxoP0T9X0y1NW/i+43qu4LxMxVgdDL4QmiR2YJUATP6b5BZAQAoGGhhaHBWiEOWVe8qO8ZUN9mQ6n2xIafZG1SJbp68ZCmUcNzpCM1TM+zafW7Vj86+dhdoFEw69PWJ9mkd75UaGkTF+lCWpQJhF/2QEikXMZbqxGh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7F1E158BEFF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 15:14:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78B694322F;
	Fri,  5 Dec 2025 15:13:58 +0000 (UTC)
Message-ID: <4efd49cd5fa6897706742d8907b56aaff3b475b3.camel@hadess.net>
Subject: Re: [PATCH BlueZ] main: fix bool vs. gboolean type in
 g_option_context_parse()
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Fri, 05 Dec 2025 16:13:57 +0100
In-Reply-To: <36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
References: 
	<36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepphgrvhesihhkihdrfhhipdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Thu, 2025-12-04 at 22:38 +0200, Pauli Virtanen wrote:
> btd_opts.experimental and testing are bool, not gboolean, which may
> cause memory to be clobbered and crash.

Can you please explain why it crashes in the commit message?

IIRC, it's because a gboolean is a typedef for an int, and bool/_Bool
for a single bit.

>=20
> Fix with separate variable for cmdline option.
>=20
> Log:
> ERROR: AddressSanitizer: BUS on unknown address
> =C2=A0=C2=A0=C2=A0 #0 0x0000005b9914 in queue_find ../src/shared/queue.c:=
230
> =C2=A0=C2=A0=C2=A0 #1 0x00000057c0ff in btd_kernel_experimental_enabled
> ../src/main.c:721
> =C2=A0=C2=A0=C2=A0 #2 0x0000004ff52f in read_exp_features_complete
> ../src/adapter.c:10230
> =C2=A0=C2=A0=C2=A0 #3 0x0000005be40b in request_complete ../src/shared/mg=
mt.c:306
> ---
> =C2=A0src/main.c | 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/main.c b/src/main.c
> index 558bf2888..61e5ef983 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -1330,6 +1330,8 @@ static char *option_noplugin =3D NULL;
> =C2=A0static char *option_configfile =3D NULL;
> =C2=A0static gboolean option_compat =3D FALSE;
> =C2=A0static gboolean option_detach =3D TRUE;
> +static gboolean option_experimental =3D FALSE;
> +static gboolean option_testing =3D FALSE;
> =C2=A0static gboolean option_version =3D FALSE;
> =C2=A0
> =C2=A0static void free_options(void)
> @@ -1420,9 +1422,9 @@ static GOptionEntry options[] =3D {
> =C2=A0			"Specify an explicit path to the config
> file", "FILE"},
> =C2=A0	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
> =C2=A0				"Provide deprecated command line
> interfaces" },
> -	{ "experimental", 'E', 0, G_OPTION_ARG_NONE,
> &btd_opts.experimental,
> +	{ "experimental", 'E', 0, G_OPTION_ARG_NONE,
> &option_experimental,
> =C2=A0				"Enable experimental D-Bus
> interfaces" },
> -	{ "testing", 'T', 0, G_OPTION_ARG_NONE, &btd_opts.testing,
> +	{ "testing", 'T', 0, G_OPTION_ARG_NONE, &option_testing,
> =C2=A0				"Enable testing D-Bus interfaces" },
> =C2=A0	{ "kernel", 'K', G_OPTION_FLAG_OPTIONAL_ARG,
> G_OPTION_ARG_CALLBACK,
> =C2=A0				parse_kernel_experimental,
> @@ -1464,6 +1466,9 @@ int main(int argc, char *argv[])
> =C2=A0		exit(0);
> =C2=A0	}
> =C2=A0
> +	btd_opts.experimental =3D option_experimental;
> +	btd_opts.testing =3D option_testing;
> +
> =C2=A0	umask(0077);
> =C2=A0
> =C2=A0	btd_backtrace_init();
