Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFC20DE7
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003955; cv=pass; b=SsCYZ1vk4YL9c3+p7kCZsgvSlpnsbHAdrHjMYBWto52nBGiXL1uRdE3pvEuVPzhV+y0mWriN6CuwFej90qey1N6CJvFqjVn8EPEQiSqCOV6rOMJI0nEXBxpwHGgvPAKkDPJNAoHClL3HYTbmpFSseLEKr8nQqiLwpAPqUsl01l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003955; c=relaxed/simple;
	bh=juENqjduFNW/3Ki2UqMcZT040ITYXTMrQV/kh2fjB04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sb9wpCejN/hGccy8TR4kzciDM3UDZXPifukf4BoSsX6N/PyKr86K7HFI2n1itKK8m4c5FyZ2vyPn498vP5YBDMh5umPdhbWUlz+tTwqZTxTdpKKRBWTv+siF0jqpPFbgjL2Rtadwrm0IexUeA3htx4LWdGagKpmGFo9rlNMwPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KlpksF9Y; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KlpksF9Y"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V7jXt0LP1z49Ptk;
	Mon,  1 Apr 2024 23:39:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712003950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p+ffdm98Zd/RYcRzCmqzEES9oVZO0M5ut9quXFU5cBk=;
	b=KlpksF9Y19brK5s7psgFD8DP8+zPnt+ouIn4rt+Hklm2Ir5PnHcqN7/5CbSmk6u0COBVUv
	LWzfaNKJd348i+nILetV0z44QI6VUke/iC1/iUVuriUbe+8JCFGXUz+Fk/HfreDZ9yDJpH
	pYY/1grzyvilXO5qadgVcF6ClxPFuo2uvwLEUF49tnlBBfgor/PIWJt8HkEtWLl6iUD8Nt
	jPBG+Z5oUMyMc+Ig4eC6fkA8H1PF1l6HLwaDHaY7F3a7ixI4C601vwK9qnmptJnA36QQqq
	7b3bGI9rr+uzEPIEUGDkS8MqRCzPr2qvikS6l9vCvis4C5Tc5ts/rNxAELfRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712003950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p+ffdm98Zd/RYcRzCmqzEES9oVZO0M5ut9quXFU5cBk=;
	b=iarpA9tICnQgvPYjzujhMjBK8Hh3pOw5fDds4cjZehbwwNVFteI85Nxa2vC0Zu071aDPY5
	+iBI2sNr0uXu20qNQWhuYQs7UfWG7BXbg51O0cSlXHFPWZcsKYigKco909HWnozX8HNrpb
	QJW7GCo/6Lz644IHKwZKr2hIAfzE0Cb4oFbXOaJJYc1RLyVMLNafh325YiDp3lkxprkc7Y
	HMbKAXiF/P/nhZ74Pqt9XWybcP+anpAkgqtY7IkVZURGj/GtxtpXxzV5hU7I+O3Vcq3lrm
	RY5nPoCHQuQR5E50zS4cJfhTDoW5LfQaL64uGGlIG9MFUlCpNFczNRSGOFczKg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712003950; a=rsa-sha256;
	cv=none;
	b=n9ztCCpOCSzU/Of8qks1GoILp1dINDyIM8u7JY5zejGU0BQYd4bQJUNojft6Bvczn/3GUh
	w5b4D4mT3eVLf7934XCIxhJcX4zpZwKKfHz8ylJ64N45oX0cGfKlkteFEDQ08zqV4J54NE
	ZcHrSyiYE4X8AI4AE4NRyUBaEMBFHPZPv07a8k3eZ8TUvDkJMAHO00halS06HhkEaMdrOt
	vkWRgK1Lo5UxXiRGnifRoUXgvlt0IiS5XCPlhXWm7bOoMilSuuFhOFnCldEnlovCjKwUup
	jdudsmoaBqMSHrvg4NED3YjPxBy5Z63RVlyzkKTkScuXoUo6r+TrMBUe/RImeA==
Message-ID: <b77de7683ed8bebf1281c0f0f75115771d0634c8.camel@iki.fi>
Subject: Re: [PATCH v2 0/5] Bluetooth: add TX timestamping for ISO/SCO/L2CAP
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 01 Apr 2024 23:39:07 +0300
In-Reply-To: <CABBYNZ++1tDjXPGhBJND6qBqGR-07CFabW2to1G38RFsohxPmQ@mail.gmail.com>
References: <cover.1710440392.git.pav@iki.fi>
	 <171200163859.25745.12369452892917865813.git-patchwork-notify@kernel.org>
	 <CABBYNZ++1tDjXPGhBJND6qBqGR-07CFabW2to1G38RFsohxPmQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2024-04-01 kello 16:05 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Apr 1, 2024 at 4:00=E2=80=AFPM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
> >=20
> > Hello:
> >=20
> > This series was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >=20
> > On Thu, 14 Mar 2024 20:20:16 +0200 you wrote:
> > > Add support for TX timestamping in ISO/SCO/L2CAP sockets.
> > >=20
> > > These patches allow fixing / working around controller(?) issue where
> > > two ISO streams in same group get desynchronized. It also gives user
> > > applications the best latency information as available to kernel.
> > >=20
> > > Also add sockopt BT_NO_ERRQUEUE_POLL to optionally disable POLLERR
> > > wakeup on TX timestamp arrival, which is mainly a nuisance in the use
> > > case here.  The alternative to this seems be to deal with the POLLERR
> > > wakeups in BlueZ side, but this seems hard as it's always enabled in
> > > poll() flags so not clear if anything else than polling at regular
> > > intervals can be done there.
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> >   - [v2,1/5] Bluetooth: add support for skb TX timestamping
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/0368e609d090
> >   - [v2,2/5] Bluetooth: ISO: add TX timestamping
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/3067d73e114f
> >   - [v2,3/5] Bluetooth: L2CAP: add TX timestamping
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/e22f35ed23a7
> >   - [v2,4/5] Bluetooth: SCO: add TX timestamping
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/b7adccd0e8b6
> >   - [v2,5/5] Bluetooth: add BT_NO_ERRQUEUE_POLL socket option
> >     (no matching commit)
>=20
> Ive left 5/5 out on purpose, let's have it behind an experimental flag
> so we can later rework it if necessary, I know it is a little annoying
> to have to do extra setup in order to test it but we are not supposed
> to introduce something like this without some safeguards that we can
> later rework if necessary.

Thanks, I'll add the experimental flag to 5/5 and resend.

--=20
Pauli Virtanen
