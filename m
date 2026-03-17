Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334C3A5E76
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741704; cv=none; b=L6jCAsxHF/lm4ydBHAneAVmbhG3PoNJsyJpfKz9Gka9ywGh2BBKS7Tdi5m/jO/1HWTdPMu2OsBi+7cdXCeTW+rtJQRBlcPA6V037xiwJ8jhYmzcbH0OvZ8gIxgfeGjJWV6t+MNLpvK3UAgxOJlaxqImzyt0h5XBq/zUHoQ7Tivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741704; c=relaxed/simple;
	bh=g/2gq8MhfhRsJaazRpX6U/r6uj/VyZc0k/zaN6cBAiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bk2Ox5+xZgYedN96Ka0b4lRWUs1WkKWtynfZ0f6JVfIA6g3cjAOF/Y/DPy0vWQ+F1p4EjABXYDk8YMH0LDMTN8NWRBkQpn4LxoGmTXY8E9IGBxt+tfHyRtL81jSsmFhf7ElHBBQGGROEFYHtxyhmnQiy2Qj6XufDpasHbHh4MbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id C62B0582793
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 09:50:12 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1F553E97A;
	Tue, 17 Mar 2026 09:50:03 +0000 (UTC)
Message-ID: <d054c110dc64a6278e052259bc315d442828228c.camel@hadess.net>
Subject: Re: [BUG] `ad_replace_name()` copies AD name payloads up to 254
 bytes into `utf8_name[250]`
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 =?UTF-8?Q?=E4=BE=AF=E6=9C=8B=E6=9C=8B?=
	 <pengpeng@iscas.ac.cn>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 17 Mar 2026 10:50:03 +0100
In-Reply-To: <CABBYNZ+PDWDN2Bn8=Trwu3PP4_qYzKa0P4tj0aqGNYu_zSFqrA@mail.gmail.com>
References: <1d62d5cd.57f7e.19cdb8402e8.Coremail.pengpeng@iscas.ac.cn>
	 <CABBYNZ+PDWDN2Bn8=Trwu3PP4_qYzKa0P4tj0aqGNYu_zSFqrA@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepveduhfehheefgfeljeetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehluhhiiiguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvnhhgphgvnhhgsehishgtrghsrdgrt
 gdrtghnpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: -100

On Mon, 2026-03-16 at 16:38 -0400, Luiz Augusto von Dentz wrote:
> Hi,
>=20
> On Wed, Mar 11, 2026 at 2:12=E2=80=AFAM =E4=BE=AF=E6=9C=8B=E6=9C=8B <peng=
peng@iscas.ac.cn> wrote:
> >=20
> > Hello BlueZ maintainers,
> >=20
> > I would like to report what appears to be a real current-head
> > bounded stack overflow in the advertising-data name parser. I
> > rechecked current upstream head on 2026-03-10 before writing this
> > report.
> >=20
> > The destination buffer is:
> >=20
> > ```c
> > char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> > ```
> >=20
> > with:
> >=20
> > ```c
> > #define HCI_MAX_NAME_LENGTH 248
> > ```
> >=20
> > so the total stack buffer size is `250` bytes.
> >=20
> > The vulnerable copy is:
> >=20
> > ```c
> > memset(utf8_name, 0, sizeof(utf8_name));
> > strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
> > ```
> >=20
> > The length passed to this helper comes from
> > `bt_ad_new_with_data()`, where the AD element length is read as a
> > `uint8_t`, then decremented once for the type byte:
> >=20
> > ```c
> > while (util_iov_pull_u8(&iov, &elen)) {
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 if (!util_iov_pull_u8(&iov, &type))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto failed;
> > =C2=A0=C2=A0=C2=A0 elen--;
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 data =3D util_iov_pull_mem(&iov, elen);
> > ```
> >=20
> > So the payload length delivered to `ad_replace_name()` can be as
> > large as `254`, while the destination buffer is only `250` bytes.
> >=20
> > I am deliberately not overstating this:
> >=20
> > - this is protocol-bounded, not arbitrary length
> > - the maximum overwrite amplitude is small, about 4 bytes
> >=20
> > But it still looks like a real current-head bug:
> >=20
> > - fixed stack buffer of 250 bytes
> > - copy length can reach 254
> > - no local guard `iov->iov_len <=3D sizeof(utf8_name)`
> >=20
> > The fix seems straightforward: clamp or reject `iov->iov_len >
> > sizeof(utf8_name) - 1` before the copy, and preserve explicit
> > termination.
>=20
> So something like:
>=20
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index ac238014bcea..b1d1b84611aa 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -278,7 +278,8 @@ static bool ad_replace_name(struct bt_ad *ad,
> struct iovec *iov)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char utf8_name[HCI_MAX_NAME_LE=
NGTH + 2];
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(utf8_name, 0, sizeof(ut=
f8_name));
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(utf8_name, (const char *)io=
v->iov_base, iov-
> >iov_len);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(utf8_name, (const char *)io=
v->iov_base,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(iov->iov_l=
en, HCI_MAX_NAME_LENGTH));

In which case you'll want to also shorten "utf8_name" to
HCI_MAX_NAME_LENGTH+1.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strisutf8(utf8_name, iov->=
iov_len))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto done;
>=20
> > Best regards,
> > Pengpeng Hou
>=20
>=20
