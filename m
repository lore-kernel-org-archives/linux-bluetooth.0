Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8EA3D647E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442127; cv=none; b=dP0whQlvAcNMK4sSrrBq3X5P7h/S7UXAsrnwb8ba4Af1X2gtVLqeLGyOqVC9wTWHNg9bybYaJCyvQw3WkL2HtnPnB1tifZuONelcrAmsxb3Ybp35T/78wOhZfTaVo72JzL8yET1BdRyM4OUfcTJdxGkYAt3YWeQ53AUriX5TPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442127; c=relaxed/simple;
	bh=pqKHXkTOI7mJo8fWXUfYYR0/2DeSruCqfvm/3x7k9dU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqUtPnqDkzkU2lDayfxsd7Up7KN/QJ70E+b6tYeeX3Z3EbnCDhzd2xH18k2/5bbI1eKFxqI2+8ALdnCSDiP1D0/T/CEp9uZAp/Q88O2C0mfuhGHmY8qRCWxZy7273yZjtXmOAwwpOyS2jAnsBwvF/LxeQKQz6msPFG9u3+fPvn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1w5NSF-001mdO-2Y;
	Wed, 25 Mar 2026 12:35:22 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1w5NSD-00000004cOI-0wO9;
	Wed, 25 Mar 2026 13:35:21 +0100
Message-ID: <249b111f2618ea16b98201dae672b578d501ec4a.camel@decadent.org.uk>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix invalid response to
 L2CAP_ECRED_RECONF_REQ
From: Ben Hutchings <ben@decadent.org.uk>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 25 Mar 2026 13:35:16 +0100
In-Reply-To: <20260205195742.55530-1-luiz.dentz@gmail.com>
References: <20260205195742.55530-1-luiz.dentz@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DIEN7iFsNYMEWa+7tW4j"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-DIEN7iFsNYMEWa+7tW4j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-02-05 at 14:57 -0500, Luiz Augusto von Dentz wrote:
[...]
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
[...]
> +		/* If more than one channel is being configured, the MPS field
> +		 * shall be greater than or equal to the current MPS size of
> +		 * each of these channels. If only one channel is being
> +		 * configured, the MPS field may be less than the current MPS
> +		 * of that channel.
> +		 */
> +		if (chan[i]->remote_mps >=3D mps && i) {

The comment and the actual condition here don't match, so one of them is
wrong:

1. This rejects an attempt to set an MPS size equal to the current
value, but the comment says an equal value is OK.
2. This checks whether a second or subsequent channel is being
configured, but the comment says we should consider the number of
channels being configured, which would mean num_scid > 1 rather than
i !=3D 0.

Ben.

> +			BT_ERR("chan %p decreased MPS %u -> %u", chan[i],
> +			       chan[i]->remote_mps, mps);
> +			result =3D L2CAP_RECONF_INVALID_MPS;
> +			goto respond;
> +		}
> +	}
> +
> +	/* Commit the new MTU and MPS values after checking they are valid */
> +	for (i =3D 0; i < num_scid; i++) {
> +		chan[i]->omtu =3D mtu;
> +		chan[i]->remote_mps =3D mps;
>  	}
> =20
>  respond:

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice - John Levine

--=-DIEN7iFsNYMEWa+7tW4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnD1oQACgkQ57/I7JWG
EQne5w/4niyQFE5BWeMx50NkkcLn/ma7lXDNS9nvgydZerlnCF/HnP04yxVCal46
UmE39DE1oWPB+jb5nVOd7MSQDr+Jo1rQPzHF60L+3pL759YClTFXGH/Oj7ERxFSs
YNHRkAgt8Pm3AltCyuMs7+STX2wYP3nXkcmQP6y20oFob+q+yXadaPWieUDeLNyy
lOhQ8wRPfyr+f4bu/qdyZdOCTS3AzGhh+kvtIdfWIPrqz2vvcjTtiQkP247x3ncY
caNTuh2LOjcXkRaFXfISyHppc7lHATDyp14Ca5aUkdl458YsTdnw4RU4gYnnxAF6
VExM3Z5F0l8BsF2IrR/2sEZV/pYyfQjtwe3+xXywKg7DIUmwhx+gXZv/R3fFKbWr
hUUGrDNsinLjmVzZL6lp6442uNOme3AmCpxktxPL6EZAJQtx9QB1MPNBSUfPEjMo
hlg/S72HQ+QnGPxEVdvz0oy1BIvP5k3mJc123Nu28bZP53e7SQ1Gi49Zjz5k5xul
Yz7MheDtbKIgC4Unn9t3UHi5ZOXG+0KdCjPRRCz28Fu7haqQpO60Te4dCI59IoVe
zAtxdfKn/mv++kUPxLG69eIQtrnW/gM18jjfChVrCTiUfVQ9Srx1X9FhE+sc4zd1
NA1GKcaVOQb77R3pu5h3JyBGcXOyiqb5G8D0rImsth6lPe8PKQ==
=xm56
-----END PGP SIGNATURE-----

--=-DIEN7iFsNYMEWa+7tW4j--
