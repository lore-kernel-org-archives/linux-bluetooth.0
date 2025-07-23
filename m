Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75027603B
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260461; cv=none; b=rSSdrdUHBpRrCwsQ+FyTej6B2pNjDRY21+XhQhQ3fjyJNKYVeKit+Cc2G2egwZdTBpLWcvAOXQfEc5lXTBK6EXmmAso8jcWf5KAs0XJ5YrD7jzCVs9qYSYY2AdqzHds1yLI/Y/bFIl5bpR8Mp764nXWYsxO6Njy1fVIkWotN69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260461; c=relaxed/simple;
	bh=w4mX8SAjh6ziuWp0G3cQ6f70OOuMPuNc7TIJVFwli5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBCQNi2z3VgkYENq8BiCHzgxiYk1bDN1LL5bsZ0AOxuLct7ojcbedd9L1x6h1pQDvBLJUtI76F+gGESxAxhZJfcFEsTWVKtw2JfCUmN7ahgWHiXzKSYWpm9p31DRN5M1fFG3trmgOty6tS0kepFJ41apSiTZezf/iYH1QfR7+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA48643175;
	Wed, 23 Jul 2025 08:47:29 +0000 (UTC)
Message-ID: <21d03904980f3de2e2f18e68f4a6b7ec76324d00.camel@hadess.net>
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
From: Bastien Nocera <hadess@hadess.net>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com, Vijay Satija <vijay.satija@intel.com>
Date: Wed, 23 Jul 2025 10:47:28 +0200
In-Reply-To: <cde4be7634e9e3d80bec19c138432eb39bd205d5.camel@hadess.net>
References: <20250723062644.1296860-1-kiran.k@intel.com>
	 <cde4be7634e9e3d80bec19c138432eb39bd205d5.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeifffgheettdeggfejgefgffeguedvgeevkeevjeefkeekudejheetffeufeffueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepkhhirhgrnhdrkhesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrvhhishhhrghnkhgrrhdrshhri
 hhvrghtshgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhijhgrhidrshgrthhijhgrsehinhhtvghlrdgtohhm
X-GND-Sasl: hadess@hadess.net

On Wed, 2025-07-23 at 10:42 +0200, Bastien Nocera wrote:
> On Wed, 2025-07-23 at 11:56 +0530, Kiran K wrote:
> > Need to add support for BlazarIW Bluetooth core used in Wildcat
> > Lake
> > platform.
> >=20
> > Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> > Signed-off-by: Kiran K <kiran.k@intel.com>
>=20
> Do you have a "tested-by" too?
>=20
> Is there an "lspci" or similar output that could be added to the
> commit
> message that would help identify this device?

FWIW, Vijay's address doesn't work. Would be good to have a working
one, otherwise please remove his name from the commit message.

>=20
> Typo mentioned in the comments below.
>=20
> Cheers
>=20
> > ---
> > =C2=A0drivers/bluetooth/btintel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> > =C2=A0drivers/bluetooth/btintel_pcie.c | 1 +
> > =C2=A02 files changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/btintel.c
> > b/drivers/bluetooth/btintel.c
> > index be69d21c9aa7..ea1521c6b2d3 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev
> > *hdev,
> > =C2=A0	case 0x1d:	/* BlazarU (BzrU) */
> > =C2=A0	case 0x1e:	/* BlazarI (Bzr) */
> > =C2=A0	case 0x1f:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Scorpious Peak */
> > +	case 0x22:	/* BlazarIW (BzrIW */
>=20
> Missing closing paren
>=20
> <snip>
