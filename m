Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3715284678
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196031; cv=none; b=p3BOw/odQncYRepx2CsLv28J9Hfwa4T/UHVYa5kDHZQtHEcFD7IB8jTnJSpZ7NkIItra7CldR0dOHIFPzIgY3uGg+ykFsl26W75ZEwp/Lk8QvKZsQpX6/yop+qid/OZUkZzK4oKolOTvBahSHsPIVFfZxk5O6TXIhyA8yT3f5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196031; c=relaxed/simple;
	bh=m9VRhtXUT+wafcgqHYSkXlE4Ct9YjAjTjUhhsweetxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvwONEApEWuTzEDrQThSjPPlqpehOQt0Wg8CwSFptwVknhGPINw77UYkHeUvzBlkd/PPkHLihT+D/b//KIitpIib0YHVlTbk2C+lEux+3mImINjvxRCSzdJplM2Dr51mN5uufnnO0OoDFse7c9B+ZRsW8MI1PbQhQG7Ly4VaLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B1BE1F47D;
	Tue, 26 Aug 2025 08:13:41 +0000 (UTC)
Message-ID: <b2bff28854b723d59831b6c9482677df44d4ca6d.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 1/2] lib: Add missing includes in
 bluetooth/hci.h
From: Bastien Nocera <hadess@hadess.net>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 26 Aug 2025 10:13:40 +0200
In-Reply-To: <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
References: <153fce6357dee9d70a04fb4a6c19a975e5c710b4.camel@hadess.net>
	 <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeegjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopegrrhhkrgguihhushiirdgsohhkohifhiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

Both patches look good, thanks!

On Mon, 2025-08-25 at 20:31 +0200, Arkadiusz Bokowy wrote:
> Compilation fails when using bluetooth/hci.h without other includes.
>=20
> > /usr/include/bluetooth/hci.h:310:9: error: unknown type name
> > =E2=80=98uint8_t=E2=80=99
> > =C2=A0 310 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lap[3];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~
> > ...
> > /usr/include/bluetooth/hci.h:383:9: error: unknown type name
> > =E2=80=98bdaddr_t=E2=80=99; did you mean =E2=80=98daddr_t=E2=80=99?
> > =C2=A0 383 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdaddr_t=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdaddr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~
> > ...
> ---
> =C2=A0lib/bluetooth/hci.h | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
> index 8f59a535a..732477ec4 100644
> --- a/lib/bluetooth/hci.h
> +++ b/lib/bluetooth/hci.h
> @@ -17,8 +17,11 @@
> =C2=A0extern "C" {
> =C2=A0#endif
> =C2=A0
> +#include <stdint.h>
> =C2=A0#include <sys/socket.h>
> =C2=A0
> +#include <bluetooth/bluetooth.h>
> +
> =C2=A0#define HCI_MAX_DEV	16
> =C2=A0
> =C2=A0#define HCI_MAX_AMP_SIZE	(1492 + 4)
