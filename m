Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14924886A;
	Mon, 14 Jul 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516189; cv=pass; b=G349ynmegvliEciMOZaEOHDMEgkU4Aw2vpLLcg0tDjZ/wFfn9TYlKV7D5t3VTZaSNyF7L9Uj1tZqaxmbl0h3ZqD+N5JcelG0/dHPnQiVt8S+mztatxHjU0fi/G21f3czySdPHASbJP2SHF4WU00Bhn6gxvSmdArjKMUQzp17Ie8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516189; c=relaxed/simple;
	bh=Aaj5bi2iGaSdPMLsdzQ71K2CzWOCsTf4rwaa3YuS1go=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+dVOWuhJj2+7nM7XrakOhVys8z9S5mhSxfbX08XqTa2kBrLLIVFyF6JpZKZlSN8ZXeUT7+u/goj5fpCmwJQ0yp2lmclX2XoTbNspr1Ox1J5bjV9WZTyRjXmCDk7X7dj0r+v09tm/LkBiDiMrjLeC90eo+IOul1G+AxZvVD6upM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iOlfDSrr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iOlfDSrr"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bgqtB3ZdBz49Px4;
	Mon, 14 Jul 2025 21:02:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752516179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JoAEW3dPfmTmw+yh1yZuX1ysxv8VcKrgQe1cUgKWvPA=;
	b=iOlfDSrrLzPS4vvD0d/2GW4F7SHv6yaT7ka/TgMO+rhmF04Pfhquc1s1svMYDAEpnGmJ8h
	amkOuUZf+xuo6MDQvdLX+/JlJhG/3e5v2Pf2w7n+gg2KSsp5pj892l3UWRY4ytXeojFAXP
	Us73/bRvEH63LoDGTmZyfB57Y9DUF81pKSJw2nOHAro0jc9vDA6nkp+gPLkUhH0EaeI6vy
	nLMF5Do5yw1vjfuSQ3D+8w3uTMeij5sWU1bNv+aAAfZmgFLEvuq3deELUj1OP5yoIH/gcQ
	5EjrFkTQGd9VvOs9CcOaLGiDXnd/hFar3wqVBrf03ZBJNNjKODIerbwCQJ2CbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752516179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JoAEW3dPfmTmw+yh1yZuX1ysxv8VcKrgQe1cUgKWvPA=;
	b=Eo4ikBjl52Z5LTb1cMBwR06Mp46wLhD4JPlKMJrrG/vJAqdsVf8vGZ0l33r63I2skkweEa
	m4Cc20xO/E/oEwF5ELDKyDlH1LNf3X+EF68iykJmwrcFTZEpCwl8L63MkICRPVPHh4aPzZ
	Smh4XOJ113+hlivEjhIuckCztIs4n5ArmxJ8HUh6BRuwAbsy+rIa1ymgItCLuNtSdNlgV4
	Cl1fJFN47DsWYb/LJud7Qny7qgRm5HlopZP2WIkKfDG5Yl+P/YOal+Uxqp5McBDG7SqRFr
	zEIQYWXMZ3Fo7jLPB9YxG3s4/4SSr8rc+7p4oLq3AZNadyZIdKNZpt+MFPB4xA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752516179; a=rsa-sha256;
	cv=none;
	b=cawJOHc/Fek0lIDpY3gStnLo9AcYdhCft+pnqxPNEipqcZwXjpobtMEoyP63ogJ0YD+Y1C
	QhA98WNuMYJs6z5z/CordH/t2hjI24DsV73uw9aoFNnNB+N5erHpWVJmjEq2e7MrFmpTOA
	sS8RarlKYO2X940cYWKGyXE3ArgXLMZnzSvQg+iE/MD25pklOLXoR2EpxmDfMR4tqx/jk9
	iIl9cYSBT/xeq983B9BXusdVquQZkjdywYwiPNCnz98sa/dTYTw8qaxHmqbNb03WT5a2WK
	8E0E+/C3QNEv12SDfRuJ9bs6E2vKXq+DYmwecAJk7M3pXQx1RrBgiJD5AzxU6g==
Message-ID: <f14e501d2d478604554cc5280d863caabf6d5e94.camel@iki.fi>
Subject: Re: struct hci_dev::quirks is running out of bits on 32-bit
 platforms
From: Pauli Virtanen <pav@iki.fi>
To: Christian Eggers <ceggers@arri.de>, linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 21:02:56 +0300
In-Reply-To: <22185131.4csPzL39Zc@n9w6sw14>
References: <22185131.4csPzL39Zc@n9w6sw14>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ma, 2025-07-14 kello 19:09 +0200, Christian Eggers kirjoitti:
> I just tried to introduce another quirk for Realtek Bluetooth controllers=
=20
> when I recognized that the underlying data type (unsigned long) has alrea=
dy
> run out available bits on system where sizeof(unsigned long) =3D=3D 4.
> The number of entries in the (anonymous) quirks enum has already reached =
34=20
> in the latest kernels.
>=20
> My first temptation was to simply change the data type to something like =
__u64,
> but this is not as easy as it seems. The test_bit() macro used almost eve=
rywhere
> for assigning quirks is guaranteed to be atomic and my platform (ARMv7) s=
eems
> not to have support for atomic operations on __u64.
>=20
> I mainly see two options:
>=20
> 1. Introducing a 'quirks2' member (bad)
>=20
> This obviously would work, but requires another enum and will (I think)
> introduce stupid bugs if the wrong quirks member is exercised.

The pattern used for hci_dev::dev_flags is

	struct hci_dev {
		DECLARE_BITMAP(quirk_flags, __HCI_NUM_QUIRKS);
		...
	}
	#define hci_set_quirk(hdev, nr) set_bit((nr), (hdev)->quirk_flags)
	#define hci_clear_quirk(hdev, nr) clear_bit((nr), (hdev)->quirk_flags)
	#define hci_test_quirk(hdev, nr) test_bit((nr), (hdev)->quirk_flags)

> 2. Switch to using __64 with non atomic operations
>=20
> About 99% of write accesses to the quirks member happen from probe() or
> setup() routines which should (I hope) not allow simultaneous access from=
 other
> contexts. I found 2 exceptions (as of linux-6.12):
>=20
> a. btusb_setup_qca() is called from 'struct hci_dev::open()' (maybe uncri=
tical).
> b. Two quirks (strict_duplicate_filter, simultaneous_discovery) can be to=
ggled=20
>    via debugfs.
>=20
> So it looks like using non atomic operations can also introduce trouble i=
f
> not well reviewed. But as the 'strict_duplicate_filter' and=20
> 'simultaneous_discovery' quirks are only used at very few locations, mayb=
e
> these should be moved to a new member for "atomic quirks", allowing to
> convert the remaining ones to non atomic.
>=20
>=20
> Are there any alternatives? Anything I missed?
>=20
> regards,
> Christian
>=20
>=20

--=20
Pauli Virtanen
