Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76C36827B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149513; cv=pass; b=lgI+1ubxy4lb6INsiR2x9o+0oxyOT/bAwsWGnWVvkCHqKohYD+CBQJZZbMOgHsDCA9hf2Xe+H+0Dedj58yoqz+oDq0r52mDBTjxvAZWbKnZ8Y1KOxLn94BLXVfZRZYG9c19No/RI1mPm4zg8pm3y5kUF28wwgFUX1jB8ycs0m2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149513; c=relaxed/simple;
	bh=VGYROLSR0uUZ/MXEij6qIM1cYOFVVUCNR/UBeTHYt7Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Yi/PGC+Ay8D0Geh2cbSfFeB8H0Sxraow9H5X/ndh9myQhvsqM+6ArOEikX+zIVh3C9bh/G8ymwbDVi0ImZTg9y0SOvwVH4QVwf/J0JAcAq9IBnZuAgkl8SSWjFtFpUTcd08qEnqcuwhN01rSpqer14MtXOhX+T5OXA3fZdiZwcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=oQyLJ6m2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="oQyLJ6m2"
Received: from ehlo.thunderbird.net (unknown [185.65.133.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4f5F4Y2mhQz49PvY
	for <linux-bluetooth@vger.kernel.org>; Tue, 03 Feb 2026 22:11:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1770149501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrdAxm+eUs3g0r8Ctwk1Hmrj94eSFbYgAbWKHX3SUb0=;
	b=oQyLJ6m25d6pUQMrR3My6TjC3skst95jhX6lOecbDK47LkFJBzH6f07ZPohRfK2gdDBgOT
	3OadiMa6Z+c1JhdMqoV9A2PA9B/WkWwHiq/07Lj7nhUCsnTQDBxkw0cdb4GdMuTK7geXyB
	Z/GaalMEDFdds/QhabWzC4zyhlmoCjNIHvg6rpXzptLTSVxCJ18Umar8nIlzZUwbUxGFQf
	eytojaeKI0528p/mcvDQih8bQ7LHNUOl521q3M1O2jETHpNWv5S+3EsmdR0H/VUDo8hqXw
	kf/3uErBihsFwQg6UfackBvNMbdeLcVDHvBpDM4bOcTCxIo0I0kIZOnTW+Gf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1770149501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrdAxm+eUs3g0r8Ctwk1Hmrj94eSFbYgAbWKHX3SUb0=;
	b=I23hDi+mBYYb8BJY9sG20l07rn1UrHwBq2u0NodIodzmPEODKt+Ncf/eQLFb1F/OvyhuC7
	idrUz04Y97ArcSejU8O0cz74pO2G/XPPuNsji3w5lMtMGRzOv6Ta+HZRosaPx1VObFqsrq
	49CHPqDRigihjYlIHiiFjUqrfEiaITLVtD1KEEJQdBpmA59+CmJhqa985ZmamVY/bN6HU5
	+YLYFvza5ognyAoxAjGhouTmjo2NcZ7WpGLySkFAGcdba0/Sor62Pm/aJ8wQS75wTgdMKG
	r6kj7VQC3wBqQJh3DMoVsBJuKRDeIddIK04OkKhJoqIvlRMPkWj87JJ8mEa1cg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1770149501;
	b=Ld7QKoqOmY1y6oC681XU1FHL6gXKVu+dre6EaXcsMDRK4MK2Qj0sFzzLVR5u5ZmqUNih2L
	eKXnB+jl32zzaCQrfu1CY5DaS4twsPWnPc3h7CfSV9tXaXESTyeTYMtwMKNEsnn7dCfWxV
	qZxIT/TxOEBhYvGPObIL6wfHQnVsrGEU82UDM8RwwhoFsx6+k0kZXFxqsut1fmCzfwP/h+
	rPBsUq8b9ue4DgrhFcM5kmRZOsgi5fHnulYDJOYwfjrKkMxt+h3xQBIyRiBdsvIOs7te6M
	0zp6Ebrn5rxaDuCOxXP3deDS9kxFigqfxVBeUOlsOht2E2vCge1/1V1wkNMeqQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Date: Tue, 03 Feb 2026 20:11:40 +0000
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_Bluetooth=3A_hci=5Fcore=3A_Rate_?=
 =?US-ASCII?Q?limit_the_logging_of_invalid_ISO_handle?=
In-Reply-To: <a62daa4ff8e59ef01438d96484b45cc2273db1f3.1770146705.git.pav@iki.fi>
References: <a62daa4ff8e59ef01438d96484b45cc2273db1f3.1770146705.git.pav@iki.fi>
Message-ID: <60314649-9D1B-44CB-B5C3-1F90E2744AE7@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



3=2E helmikuuta 2026 19=2E57=2E21 UTC Pauli Virtanen <pav@iki=2Efi> kirjoi=
tti:
>Some controller firmwares (eg for MT7925) continuously send invalid ISO
>packet, which result to "ISO unknown handle" error spam in logs=2E  It's
>not important to show all of them to the user=2E
>
>Rate limit these ISO error messages, similarly as we do for SCO=2E

Possibly, the mtk driver should classify these packets for the invalid Han=
dle 0 as some debug packets, or drop them=2E

But probably it makes sense to rate limit these messages regardless of whe=
ther it's driver or firmware issue=2E


>
>Signed-off-by: Pauli Virtanen <pav@iki=2Efi>
>---
> net/bluetooth/hci_core=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/bluetooth/hci_core=2Ec b/net/bluetooth/hci_core=2Ec
>index b069607b145b=2E=2Eeb32802f6296 100644
>--- a/net/bluetooth/hci_core=2Ec
>+++ b/net/bluetooth/hci_core=2Ec
>@@ -3917,8 +3917,8 @@ static void hci_isodata_packet(struct hci_dev *hdev=
, struct sk_buff *skb)
>=20
> 	err =3D iso_recv(hdev, handle, skb, flags);
> 	if (err =3D=3D -ENOENT)
>-		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
>-			   handle);
>+		bt_dev_err_ratelimited(hdev, "ISO packet for unknown connection handle=
 %d",
>+				       handle);
> 	else if (err)
> 		bt_dev_dbg(hdev, "ISO packet recv for handle %d failed: %d",
> 			   handle, err);
