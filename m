Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321A2F25F3
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763661; cv=none; b=Sa3Mrqc543CeE9XMs4a15SnePRucaoMfr88o5o4yF8ZKVO+xI7h/Kef3xhoMH8hdTRGh0z3gyQQ/dq6eRlCnKtyzD9HdtcUhHpnnBlF62ymdt1VfKu4czbKA1AVvWl6tyjzInSPX6ry3d8kl2skVQUFLdBYfwYM5baZgejyQMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763661; c=relaxed/simple;
	bh=OJhzxl3vGfw9Wv7+Vt7jelqganMVmgdI6DCr7lUWDuY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hU2RiSgjv6/VNkZTN41Lyqj5xEQ5+M+eExB73OPF1h8b+XJC7WQJvB4mlguG6HGK9wLJnBkBQadZZwgM45P4MIiDyEggHBUBuh7VMW16b2tY/IvNP9amPd48fo1/2ZzuFEEk9NqocPf2G+uPzfnb/KsmPmAElyUfqaclCm6sEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82A8A3EC43;
	Tue, 17 Mar 2026 16:07:37 +0000 (UTC)
Message-ID: <9388604ecf44cfb629f68e25d2357a9772e86dd9.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1] shared/ad: Fix not checking length on
 ad_replace_name
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 17 Mar 2026 17:07:37 +0100
In-Reply-To: <20260316204320.57220-1-luiz.dentz@gmail.com>
References: <20260316204320.57220-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeekvdetkeetfefgveegfedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhuihiiuggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvg
 hgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: -100

On Mon, 2026-03-16 at 16:43 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> iov may carry move then HCI_MAX_NAME_LENGTH in which case it is
> truncated so it doesn't overflow utf8_name.
> ---
> =C2=A0src/shared/ad.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index ac238014bcea..b1d1b84611aa 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -278,7 +278,8 @@ static bool ad_replace_name(struct bt_ad *ad,
> struct iovec *iov)
> =C2=A0	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> =C2=A0
> =C2=A0	memset(utf8_name, 0, sizeof(utf8_name));
> -	strncpy(utf8_name, (const char *)iov->iov_base, iov-
> >iov_len);
> +	strncpy(utf8_name, (const char *)iov->iov_base,
> +			MIN(iov->iov_len, HCI_MAX_NAME_LENGTH));

As I mentioned in my review, utf8_name could also have been shrunk by
one byte.

> =C2=A0
> =C2=A0	if (strisutf8(utf8_name, iov->iov_len))
> =C2=A0		goto done;
