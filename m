Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598468;
	b=NHJk/q8kEWk6uz5nxbXDGF/sK7CYo+nHMVUgcuTo/g9c/fH8kZdcN6JVGZcLneYoKsXm
	 azWl+lmcxasGBkjtkjTaROcAwJklqM1gek61d6/WKBUeHHM8j5vJZ1ZJQI0Aqm6z7WWJ/
	 9glFXX6Rx8LWAymKG/uy/Ucd1Ex/iVCe3Ie0sB84GQDt3zhWEOjIex9wmJ1y4EvEwA8YZ
	 NN7AOxVrAHa5heNKrqXKGzgsUdfcRVbb8FwQ2kll1necdvUqRw8l6PNMS2ltpCLC2tdbS
	 FL0xgUntGmDmFJhEneY/Yi4MLM6AGYgvUFmoPKlWkqND+wxqFy0905Nteb3R0TJNkNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598468;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=JdQlUqfLFMhWQs22lhWDmlscSioCFhIzQD00PJGNPQM=;
	b=on9fYGrhLl8MBa+Km1LfPUsS2S7L6p9w73xoveRVNM6iBz7bEPKRb0G9QUvTtTt6MvbP
	 JHJURyUV3f9+4XP4b75wOZIJPSx8yKQ8Y6toT0MrGgd89wXrV2LyyERakvWd+5/K0YB2H
	 1jZLizRPWvLwZQr5ccHF/GfB3mn5UE5rCwoO8V0fmSLyC3isAWAfvoAgugtcfgNgF8Qt/
	 aA12a0/uMnadCwXcaN4bPysEYZSoMvObvAmuJMb6U9Tk5fiYAamhEgapRo6dfU6L5IYr9
	 JJ4d48O/k/2omhXpbgT3DUUVkkeOhfiYxVesm4XDlj0+txx9E7UzjemTPfbQS4LzwSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E910606A690
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E910606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17B973EB1A;
	Wed, 25 Nov 2026 09:20:59 +0000 (UTC)
Message-ID: <6b7836f674530e930c8fc7431a50b5d2eec017f4.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/1] mpris-proxy: Fix possible crash on OBEX
 transfer
From: Bastien Nocera <hadess@hadess.net>
To: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 10:20:59 +0100
In-Reply-To: <20261106080515.2296-1-kaichuan.hsieh@canonical.com>
References: <20261106080515.2296-1-kaichuan.hsieh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTFxkS0HACo4fRl07RQ3HSthCAIOpRdDMx4b6ydAOJfHePYxfOJC0kl1JalDYfL9ywkHpWuG1ppb+jxYwkOP6czt8ld4NNRmuKw0c8CH9oFX2i4I4wTeYS4J0/ITX+QR/r+zmIhnHVgifBD4vEr1C4P7EClEsZnD8WqslY2QsQ9qk9sumt1AHu5w47J+L4OhzdqzENFs5/60IP8Cur6aoQJYe9TzLBBJ4BWr3V/VhyLIb+UhodXXAky1cDkwlOZRyPIiPk8xA0GBQHMWsHKSnxZepzM/GNFVrq/ScjkT0h+F/PdSWT6h80dAGi3nU+Uw8TtLp63Hwpg+Uow/v/7TShusf2yKEbftppDnbJBeIJVd5oujvq383lVJWj1xUskyeWvJDnr1NWIi3+qdWyBE0oRmJ+Y7iMQwY8rM0MJXPZ/moeyCBQrVForj4s3V5mKMWKZ3CoGv1Ofl8rDTD0ERpQIzPc2CuUitEptTXN/ONI+DfacdudwTPu8Pb7ogAnLr98vkrBkgFaQGptyjCK5Mrqn1rA2HQR4DlNjEbNBSwEIZvvjfX3FycHYyEFTfbjO4WV1SBs1nEPL1eofXZLTuSaoQWTBkVQTJYluzvyKmne/+gyPYJvnMMt6+u/azIlAeAu0gQwvWjlrQnhcDWfPaZNVJptSwI7FLn5dB0/N0OOL58w
X-GND-State: clean

On Fri, 2026-11-06 at 08:05 +0000, Kai-Chuan Hsieh wrote:
> This fixes a mpris-proxy crash (NULL dereference) that triggers on
> every
> OBEX transfer, most visibly when a remote peer pushes a file to the
> host
> over Bluetooth OBEX Object Push.
>=20
> find_player_by_obex() is called from obex_property_changed() on every
> Status change of any org.bluez.obex.Transfer1 object. Since the OBEX
> g_dbus_client_new() client is rooted at "/", mpris-proxy proxies all
> of
> obexd's objects, including the server-side transfer objects obexd
> registers for an incoming push. Those never belong to a player, so
> the
> list walk dereferences a NULL player->obex / session->obex and
> crashes.
> A second, narrower crash exists in obex_get_image() when a failed
> CreateSession leaves the inner proxy NULL and a Track change carries
> an
> ImgHandle.
>=20
> The affected code path (BIP cover art / find_player_by_obex) was
> introduced between 5.77 and 5.80 and is still present in 5.88/master.

Regression fixes are usually annotated with:
Fixes: <sha> ("commit subject")
in the commit message.

See:
https://www.kernel.org/doc/html/v7.0/process/submitting-patches.html#using-=
reported-by-tested-by-reviewed-by-suggested-by-and-fixes

This makes it easier to spot mandatory fixes and when bugs were
introduced.

>=20
> This change consolidates two earlier fixes that were proposed but
> never
> merged, because the project moved off GitHub pull requests:
>=20
> =C2=A0 - PR #2098 (Bastien Nocera, "mpris-proxy: Fix possible crash"),
> =C2=A0=C2=A0=C2=A0 https://github.com/bluez/bluez/pull/2098=C2=A0-- passe=
d CI, auto-
> closed.
> =C2=A0 - issue #2569 / PR #2631, the additional inner-proxy (session-
> >obex)
> =C2=A0=C2=A0=C2=A0 guard for the failed-CreateSession case,
> =C2=A0=C2=A0=C2=A0 https://github.com/bluez/bluez/issues/2569
> =C2=A0=C2=A0=C2=A0 https://github.com/bluez/bluez/pull/2631
>=20
> Resending here on linux-bluetooth so it can land for the next
> release.

I'm not super-happy with the way this was all merged together.

My original fixes had 2 separate patches, which I think should still be
sent and applied separately. That would make it easier to see your
actual contribution.

As a matter of etiquette, it's usually fine re-sending people's patches
if the patches lapsed, or even making them better and adding yourself
as a "Co-Authored-by:" if the contribution was significant.

In this case, it looks like my 2 patches should be re-sent, and a 3 one
added to the set, is that correct?

I've also mentioned on https://github.com/bluez/bluez/issues/2569 that
I think the crash should be added to our own regression tests. I don't
know whether there's a good place for those right now.

Regards

> The change is confined to tools/mpris-proxy.c and only adds NULL /
> early-
> return guards before existing dereferences, plus a g_clear_pointer()
> when releasing session->obex; it adds no new dereferences.
>=20
> Downstream bug report (reproducer and SRU analysis):
> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/2172906
>=20
>=20
> Kai-Chuan Hsieh (1):
> =C2=A0 mpris-proxy: Fix possible crash on OBEX transfer
>=20
> =C2=A0tools/mpris-proxy.c | 20 ++++++++++++++++----
> =C2=A01 file changed, 16 insertions(+), 4 deletions(-)
