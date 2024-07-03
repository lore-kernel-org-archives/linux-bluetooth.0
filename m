Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DF288B1
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997299; cv=none; b=SEt8Dm64KRIkt06kAolxoZnM84/XYS7bJkhbjt3wNh1xfJ/t67OCrJIqoZPGA1n5QGJEFR11KLyTpVzVzfjvjm4qmx6cZ49ipNYQC5iGoDxDMB2y0zQBUqJ24VowsrtOIXL1QsI7ZOy966RrDpXn/oAgGjr21raKeC7eYSKZxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997299; c=relaxed/simple;
	bh=rfhP2lLHpEdlNy7M96fSOR8aCq05RPy2FNw82mD0anU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1XWjO+nityRFPQeOBmm6g/jBwk3No+P1ooFTQBRcKuQ2ycAD2qLqi/eFrx3lsa/GIPHyVj+I57/NaGiKqOnEtB8Tk+AHWxqpGWhxH/HcbgjbkNb7DeCi+s53PbmJDHHsuu7wVqKiARmJXnGuF/ODGgKNIDgwnkGthSxupNJc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 880AE24000B;
	Wed,  3 Jul 2024 09:01:34 +0000 (UTC)
Message-ID: <6f19078b7bc02585eb8a038e7b20164bc8e25c28.camel@hadess.net>
Subject: Re: [BlueZ resend 1/9] main: Simplify parse_config_string()
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 03 Jul 2024 11:01:34 +0200
In-Reply-To: <CABBYNZLu+kU0C63F_+GPj8k99t78HKU+aX46Y2sJB_dVQxuJ3A@mail.gmail.com>
References: <20240702142436.833138-1-hadess@hadess.net>
	 <20240702142436.833138-2-hadess@hadess.net>
	 <CABBYNZLu+kU0C63F_+GPj8k99t78HKU+aX46Y2sJB_dVQxuJ3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Tue, 2024-07-02 at 11:08 -0400, Luiz Augusto von Dentz wrote:
> >=20
<snip>
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D g_key_file_get_string(con=
fig, group, key, &err);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_return_val_if_fail(val, false);
>=20
> Nah, let's just use if (!val) return false as we normally do.

g_return_val_if_fail() will print a warning when passed NULL as a
holder for the value, which I think is correct given that it's a
programmer error to pass NULL.

I changed this to open code a warning instead.

> >=20
> > =C2=A0static void parse_general(GKeyFile *config)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parse_config_string(config, "Gene=
ral", "Name",
> > &btd_opts.name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *str =3D NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (parse_config_string(config, "=
General", "Name", &str)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 g_free(btd_opts.name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 btd_opts.name =3D str;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Yeah, I skip this on purpose, I don't quite like the idea that we
> have
> to do this for 1 specific entry, perhaps the better option is to
> incorporate the default values into the table table so we avoid
> having
> this problem of having to free like this.

It's the only option that has an already set default value that
requires allocating. Look at btd_opts in src/btd.h, and you'll see its
the only string and the only allocated memory in the struct.

This code isn't so different from parse_privacy(),
parse_multi_profile(), or many of the other calls to
parse_config_string().

I don't understand what you mean by incorporating "the default values
into the table table". If you want to have the default values in the
arrays pointed to by valid_groups[], then we would still need a special
case because this entry is the only one that requires memory
allocation.

I can send out this patch with the g_return_if_fail() removal and no
other changes if you'll take it. Otherwise it seems like too big a
change for a static analysis fix to be making, especially when that
change will probably not simplify the code we want to simplify.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parse_config_hex(config, "Ge=
neral", "Class",
> > &btd_opts.class);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parse_config_u32(config, "Ge=
neral", "DiscoverableTimeout",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &btd_opts.d=
iscovto,
> > --
> > 2.45.2
> >=20
> >=20
>=20
>=20

