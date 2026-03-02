Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837DB3630AF
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451785; cv=none; b=uTuU3bz2zHABLhutgvmJYe4D5+zCxXZdHHSyfIInnwZeNpMvyxOqHt6yQHlRzrJyVC+0uIiqWecaOkuufMZ3T4FtT2jYXCge7ToRh0DXgqvwQddHrN87ASCz05TqYmSCuyQ7UH1bPvxg7rUaCBQhI6al9sPqC2UJ9WhfM1DL3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451785; c=relaxed/simple;
	bh=HXTjLsDExdZWibfyIYkfM/XRcho0rdkPdQ+ngsIJIHs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQ2qpQTkHjNwfdLUOnbCxXoptInyAmlsnqilSwsC13muFq+vxEXhpTzYRmlWejGTa9anUgDdZosyF/KdxPwxpcCImL3ZNqAX8HbA8KOjmOca5EAmrI2SWdnduhrY3/C2pw9xBT/1wPcV2S3yDCnyGsTWdZHflnmbJBPnvRzascY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AA9F43208;
	Mon,  2 Mar 2026 11:42:54 +0000 (UTC)
Message-ID: <e4ef2b5dc4789347eb4f3f5005148bd68205b845.camel@hadess.net>
Subject: Re: [PATCH BlueZ 3/5] device: Add btd_device_set_alias()
From: Bastien Nocera <hadess@hadess.net>
To: Martin BTS <martinbts@gmx.net>, linux-bluetooth@vger.kernel.org
Date: Mon, 02 Mar 2026 12:42:54 +0100
In-Reply-To: <20260301152930.221472-4-martinbts@gmx.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
	 <20260301152930.221472-4-martinbts@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefgvddvtdeihfejfefffedtieehtdefkedtudevhedtieejhfeliefgkeekkefgffenucffohhmrghinhepghhtkhdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeekteetlefhgeefvddtkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepmhgrrhhtihhnsghtshesghhmgidrnhgvthdprhgtphhtthhopehlihhnu
 higqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Sun, 2026-03-01 at 16:29 +0100, Martin BTS wrote:
> Add a function that lets plugins set the device alias
> programmatically.=C2=A0 This is useful for devices whose Bluetooth name
> is generic (e.g. a bare BD address) but whose identity is known to
> the plugin after protocol-level interrogation.
>=20
> The function updates the in-memory alias, persists it via
> store_device_info(), and emits a D-Bus PropertyChanged signal.
> ---
> =C2=A0src/device.c | 14 ++++++++++++++
> =C2=A0src/device.h |=C2=A0 1 +
> =C2=A02 files changed, 15 insertions(+)
>=20
> diff --git a/src/device.c b/src/device.c
> index 3ea683667..39344579a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5105,6 +5105,20 @@ void btd_device_device_set_name(struct
> btd_device *device, const char *name)
> =C2=A0						DEVICE_INTERFACE,
> "Alias");
> =C2=A0}
> =C2=A0
> +void btd_device_set_alias(struct btd_device *device, const char
> *alias)
> +{
> +	if (g_strcmp0(device->alias, alias) =3D=3D 0)
> +		return;
> +
> +	g_free(device->alias);
> +	device->alias =3D (alias && *alias) ? g_strdup(alias) : NULL;

g_strdup(NULL) is documented as returning NULL, so no need to consider
alias being NULL:
https://docs.gtk.org/glib/func.strdup.html

More generally, is there any way to reduce code duplication with
set_alias() as well?

> +
> +	store_device_info(device);
> +
> +	g_dbus_emit_property_changed(dbus_conn, device->path,
> +					DEVICE_INTERFACE, "Alias");
> +}
> +
> =C2=A0void device_get_name(struct btd_device *device, char *name, size_t
> len)
> =C2=A0{
> =C2=A0	if (name !=3D NULL && len > 0) {
> diff --git a/src/device.h b/src/device.h
> index c7b8b2a16..bb51bd2f5 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -22,6 +22,7 @@ char *btd_device_get_storage_path(struct btd_device
> *device,
> =C2=A0
> =C2=A0
> =C2=A0void btd_device_device_set_name(struct btd_device *device, const
> char *name);
> +void btd_device_set_alias(struct btd_device *device, const char
> *alias);
> =C2=A0void device_store_cached_name(struct btd_device *dev, const char
> *name);
> =C2=A0void device_get_name(struct btd_device *device, char *name, size_t
> len);
> =C2=A0bool device_name_known(struct btd_device *device);
