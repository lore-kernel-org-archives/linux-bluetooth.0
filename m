Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C215887C
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170644; cv=none; b=n6O7e+xSyi+qWJvJKPAjCM/w9nmta4ppzxnjT8EWVYpONrEjYvBnNBgK3f20zEATzTFeKYinlSwjajMFU0U2iQeLEtPY5XXcM0tcG/C/ssz7EZyR+2oClXWw9Na3j2k3s9bjKxm0B5O1VnqBmOWUoNzG5laPQ1h3t6waOY86be8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170644; c=relaxed/simple;
	bh=M2vWxMddQ8y3W+TJWkQ04/VxT9aKSlpNx5Mtqncq3hk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8BESdgvVFv3jxaNLY+QF3NoPQDNlyBBgycDx8VaXJDqbl1f6XJCQXivdqLtuo16p4hMzP6oL+48kiofBW8cpTdJTA13dj6ApwHlsQXs6TVnxpdgLHFdLcByVOAPSE/XmeBdBbcUWwny3vuNEeTbhNOYLICuE45BqNiaVO+WS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 018691C0005;
	Fri, 31 May 2024 15:50:33 +0000 (UTC)
Message-ID: <727c93065d8d1e56e9fcd5b5bed724d63dfbe871.camel@hadess.net>
Subject: Re: [BlueZ 9/9] avdtp: Fix manipulating struct as an array
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Fri, 31 May 2024 17:50:33 +0200
In-Reply-To: <8c979897beeb8316616bb7c15f60093be177577c.camel@iki.fi>
References: <20240530150057.444585-1-hadess@hadess.net>
	 <20240530150057.444585-10-hadess@hadess.net>
	 <8c979897beeb8316616bb7c15f60093be177577c.camel@iki.fi>
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

On Thu, 2024-05-30 at 19:57 +0300, Pauli Virtanen wrote:
> Hi,
>=20
> to, 2024-05-30 kello 16:58 +0200, Bastien Nocera kirjoitti:
> > Don't manipulate the "req" structs as if they were flat arrays,
> > static
> > analysis and humans are both equally confused by this kind of
> > usage.
>=20
> struct start_req {
> 	union {
> 		struct seid required[1];
> 		struct seid seids[0];
> 	};
> } __attribute__ ((packed));
>=20
> and access only via req->seids?

That's a good idea, I'll give it a try.

> <snip>
> > +#define
> > REQ_GET_NTH_SEID(x)						\
> > +	static struct seid
> > *						\
> > +	x##_req_get_nth_seid(struct x##_req *req, int count, int
> > i)	\
> > +	{						=09
> > 	\
> > +		if (count =3D=3D 0 || i >=3D
> > count)				\
> > +			return
> > NULL;					\
> > +		if (i =3D=3D
> > 1)						\
> > +			return &req-
> > >first_seid;			\
> > +		return &req-
> > >other_seids[i];				\
>=20
> (i =3D=3D 0) and [i - 1]?

*facepalm*

Yes, this will need a v2, thanks for spotting that.

