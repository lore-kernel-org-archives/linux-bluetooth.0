Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC627990C
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260142; cv=none; b=dFz8yfjCP2tUktzZMLoDgAyVujY+c3IWScRa1qb5zA8WQbg64nC95/aBg8hSGvRldfQIWf/GWKost7Nw0NOerFqztyNggwilaucHVREkeLgkP4COIJy8HqyYMPcVSV9Ot20wobKw+s7HqV+b70w1hMSZjedowtp3cQv0/cS2KwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260142; c=relaxed/simple;
	bh=qfeUaZTzfF440q82Rsa0y7mpjGrsgtZ00papoZvVZUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lI7vSKxADoey5j6Z4KPI+IKFnmSh1dKPLiPbPELUedN6RIN13zX9imkZlnFxhyixtmFYdy1i+wMLtD6v4Cv0GISi/uL4lqbi4zm0Hea5dmkkhvS16EF8epsJ5NNnYTlZ9D82QK91Emj8s8kUcwga0KOzNCHUVY+LJNHE/swesSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E96BC43142;
	Wed, 23 Jul 2025 08:42:16 +0000 (UTC)
Message-ID: <cde4be7634e9e3d80bec19c138432eb39bd205d5.camel@hadess.net>
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
From: Bastien Nocera <hadess@hadess.net>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com, Vijay Satija <vijay.satija@intel.com>
Date: Wed, 23 Jul 2025 10:42:16 +0200
In-Reply-To: <20250723062644.1296860-1-kiran.k@intel.com>
References: <20250723062644.1296860-1-kiran.k@intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeifffgheettdeggfejgefgffeguedvgeevkeevjeefkeekudejheetffeufeffueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepkhhirhgrnhdrkhesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrvhhishhhrghnkhgrrhdrshhri
 hhvrghtshgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhijhgrhidrshgrthhijhgrsehinhhtvghlrdgtohhm

On Wed, 2025-07-23 at 11:56 +0530, Kiran K wrote:
> Need to add support for BlazarIW Bluetooth core used in Wildcat Lake
> platform.
>=20
> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>

Do you have a "tested-by" too?

Is there an "lspci" or similar output that could be added to the commit
message that would help identify this device?

Typo mentioned in the comments below.

Cheers

> ---
> =C2=A0drivers/bluetooth/btintel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> =C2=A0drivers/bluetooth/btintel_pcie.c | 1 +
> =C2=A02 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btintel.c
> b/drivers/bluetooth/btintel.c
> index be69d21c9aa7..ea1521c6b2d3 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev
> *hdev,
> =C2=A0	case 0x1d:	/* BlazarU (BzrU) */
> =C2=A0	case 0x1e:	/* BlazarI (Bzr) */
> =C2=A0	case 0x1f:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Scorpious Peak */
> +	case 0x22:	/* BlazarIW (BzrIW */

Missing closing paren

<snip>
