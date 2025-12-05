Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69830DEA6
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952273; cv=pass; b=uwQShf/qheV12mvAyZ6APeVm2oQuiP+NREfUnfDuFrFg0vUzHsdBvpgI3YMvvh2h+Q5LnX3oVpa2Bq/UDsFj9gjR/at71Ond2osPy4bY8JCaCvtqQcO5x/ALPP0ZAk9E3+UYbPMdfCEnJTLPkywMrke+C39i9/2JWlYwzxcUzcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952273; c=relaxed/simple;
	bh=ZkWI5NrKcexZrH44VOccuqzoQkJogJc0UFuxlT14oDw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncxzFWWm5IbcB3Oaue7W4eRx4gR1TmgvEATVK5s4t2ACh/btVY3U1CdtN6+f+6oSM5BaLVbPsSIkrxcBiI/+qsb4tyHau56b6YW4i1H6iNpTFtdPjKgw2G6uKwDcTgrpklNfBww4U7FRgSrghIe01205E9vKCrvS4sN4CaJlBSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=f90Y/bf1; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="f90Y/bf1"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dNH1T596Lz49QB2;
	Fri, 05 Dec 2025 18:30:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764952254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKBEZF0KXF8+/wl3jM6dv3dJPbHWz1TxyHpa2TA/WoA=;
	b=f90Y/bf1mJp+Y7I8xktO+waMI6DxEqgUIGQX8BIfsnoDdCiJM0mWxMLi7B4IoEtJIbUl30
	99mefEU1juZI0xsjYcXniTsiQ/FaQqt6Mubo93nno4g7itfESyh5ZdF7kIh4u04k4F9Y/S
	5XEwVGsfQWcXoduYTSxTLkP1MUeGy2laxvDhkspSZw6/GP7RlRGpCDxcG4JGX+34nEkz3S
	RjEZPaYVO4Xt55XCD02O3wRTomMvi3SLSyi5uCX2tSuUwr8jBjbKF4Np4Gq2KSqvAAV2vX
	yuxf+FFgRDMPMhW6L/zYiKAbbGilPmo+vU0qIJcRxbg7FvyS5pqIzkFILFRLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1764952254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKBEZF0KXF8+/wl3jM6dv3dJPbHWz1TxyHpa2TA/WoA=;
	b=WfMSDYuU+94ZzW/yGITgiuGZyE7WjZ4YseatD3NZwlHg3N6qoH43i/uBtSzt9k4N3ivJgw
	iA6SB5Xto5JP7lgxl7CmCYSzDnLXA9FjchY0vjx4AGZOdKnCzkwH4o5MV9Pu+aqVatfShS
	jqP90+v1YoyQ4SrUBmWu8x9HlhDu48hxtiha1USvDiISrp9K5hLjM0jjSi7NNOP1tYOrTY
	Q6ga8WmEZkSG+s1Dj6i+r6aAVrGtyUXJE0RyDLj5G4/CS6cncHyvQrf427jAYUslMIuEFo
	dj146ub+1dc3za0BKil/cZXmjpAby2QJYQ90oNu5FqYVXkOORBsHHKehIkgXNg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1764952254;
	b=bg7ad45TAH1Zs25dlkU9br9L4pYblXG2KEURd9dbU4KSRttFMKzfTN4c9enLaMAB5chzcy
	orvDkm05H6HaMrxZFMdr/TP/oqh5xOKOlEMkAdK/cf/3FEDbbgZAQzIgVLaziHzj2cTTFD
	h4HJmQqUZmgNT9wtp1VCQuErCpAoS+W9GM8osOJVCLFsbrnIpPaCEaHsVbwJfr9uWFsxAr
	gYSbEn8VO5UdLjP0+9Fpdg2S2BahFYjmCeEIv5aZ6h6XPXtBXiVBXCjlsUkBu4T6By9mSP
	G4EshUZAIVcaR7vay9eNTSNMTVFdeKD1giRjgnu9ogzFMpw/kfJsY8NVRGB/SQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <26b2371d176809498b19758a36ec8f05a3ecadd8.camel@iki.fi>
Subject: Re: [PATCH BlueZ] main: fix bool vs. gboolean type in
 g_option_context_parse()
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Fri, 05 Dec 2025 18:30:51 +0200
In-Reply-To: <4efd49cd5fa6897706742d8907b56aaff3b475b3.camel@hadess.net>
References: 
	<36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
	 <4efd49cd5fa6897706742d8907b56aaff3b475b3.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2025-12-05 kello 16:13 +0100, Bastien Nocera kirjoitti:
> On Thu, 2025-12-04 at 22:38 +0200, Pauli Virtanen wrote:
> > btd_opts.experimental and testing are bool, not gboolean, which may
> > cause memory to be clobbered and crash.
>=20
> Can you please explain why it crashes in the commit message?
>=20
> IIRC, it's because a gboolean is a typedef for an int, and bool/_Bool
> for a single bit.

bool is 1 byte, gboolean 4, and writing to btd_opts.experimental
clobbers btd_kernel list head.

>=20
> >=20
> > Fix with separate variable for cmdline option.
> >=20
> > Log:
> > ERROR: AddressSanitizer: BUS on unknown address
> > =C2=A0=C2=A0=C2=A0 #0 0x0000005b9914 in queue_find ../src/shared/queue.=
c:230
> > =C2=A0=C2=A0=C2=A0 #1 0x00000057c0ff in btd_kernel_experimental_enabled
> > ../src/main.c:721
> > =C2=A0=C2=A0=C2=A0 #2 0x0000004ff52f in read_exp_features_complete
> > ../src/adapter.c:10230
> > =C2=A0=C2=A0=C2=A0 #3 0x0000005be40b in request_complete ../src/shared/=
mgmt.c:306
> > ---
> > =C2=A0src/main.c | 9 +++++++--
> > =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/src/main.c b/src/main.c
> > index 558bf2888..61e5ef983 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -1330,6 +1330,8 @@ static char *option_noplugin =3D NULL;
> > =C2=A0static char *option_configfile =3D NULL;
> > =C2=A0static gboolean option_compat =3D FALSE;
> > =C2=A0static gboolean option_detach =3D TRUE;
> > +static gboolean option_experimental =3D FALSE;
> > +static gboolean option_testing =3D FALSE;
> > =C2=A0static gboolean option_version =3D FALSE;
> > =C2=A0
> > =C2=A0static void free_options(void)
> > @@ -1420,9 +1422,9 @@ static GOptionEntry options[] =3D {
> > =C2=A0			"Specify an explicit path to the config
> > file", "FILE"},
> > =C2=A0	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
> > =C2=A0				"Provide deprecated command line
> > interfaces" },
> > -	{ "experimental", 'E', 0, G_OPTION_ARG_NONE,
> > &btd_opts.experimental,
> > +	{ "experimental", 'E', 0, G_OPTION_ARG_NONE,
> > &option_experimental,
> > =C2=A0				"Enable experimental D-Bus
> > interfaces" },
> > -	{ "testing", 'T', 0, G_OPTION_ARG_NONE, &btd_opts.testing,
> > +	{ "testing", 'T', 0, G_OPTION_ARG_NONE, &option_testing,
> > =C2=A0				"Enable testing D-Bus interfaces" },
> > =C2=A0	{ "kernel", 'K', G_OPTION_FLAG_OPTIONAL_ARG,
> > G_OPTION_ARG_CALLBACK,
> > =C2=A0				parse_kernel_experimental,
> > @@ -1464,6 +1466,9 @@ int main(int argc, char *argv[])
> > =C2=A0		exit(0);
> > =C2=A0	}
> > =C2=A0
> > +	btd_opts.experimental =3D option_experimental;
> > +	btd_opts.testing =3D option_testing;
> > +
> > =C2=A0	umask(0077);
> > =C2=A0
> > =C2=A0	btd_backtrace_init();

--=20
Pauli Virtanen
