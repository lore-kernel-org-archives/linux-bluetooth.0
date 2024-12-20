Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954DE1A83E1;
	Fri, 20 Dec 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684945; cv=none; b=HQ8sJLfhxn/7W0pgcfG+zcrBhgLIhcuMUQxHN5oRWcH2tjv9gNzLy1FDJMJGM2yBS1dmQixYRJuU6f9IB9CjQsLR1RbvgFEslWTcYULnB5+bUq4PVyVzDn7+79iE2Hj7LmbWDn60tiZKVQxt0r4LCcMKeVr1ZNwCoqETZL0wDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684945; c=relaxed/simple;
	bh=To2tjm4bTsuKzl5rIRBek2Urfo6PMpfmF+YP90MsSqg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bWIIfdsKKRdBAdU9RSJXLgzaJJWKPFibWamxf31naWxA5Qa6sySMHYlPWUPJ2/pAKP465yzswS5mbO66H9/jpI3GALqHvv4t3SCswGsLQB4ZdAXFVqn4JRa957l8S1WbjrwJlGJSOyor2S7gcwXAZu7GGQoizOQK7ZtcXdxTJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CE0H2IC+; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CE0H2IC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734684935; x=1735289735; i=markus.elfring@web.de;
	bh=uY0QnZ+2e3wdfJBlg12kzz5oZRddUD/Z3Fn1810BULE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CE0H2IC+kY/6C4fjsSIsBncTVBaGXQWdQORySdO3eEO7pnsjKzbS6NsS5hj3++WF
	 Ew3+Dyig5PjABZ/sxYvsrZV5+r7chyC5S1NpszroekeDf1FyU8N/rOWKrLZ6+40NJ
	 A5TS2H2v+tDTMzBDSafp8+QyTKEWeXrThowpN4svxoDmqS4Ds4PlXv3iyXu+nTj3F
	 0y8yAk/NTV1taR62iy4m7LrtHzwd1PdGkVSQAfptVgMdsJxGMjBj8KBlWBoDJYCFO
	 nJO/Zn4PcYnuCrz5Mc46eB5kD5V+zceu8VhzPaOGlgg07cX9scICPDl3fzGk6d4AZ
	 vStmTxQ2Y6YRbnziDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtsj-1tHdlX1ppB-00EzWN; Fri, 20
 Dec 2024 09:50:22 +0100
Message-ID: <07a97bad-42a6-488e-80ff-b6adec397ed8@web.de>
Date: Fri, 20 Dec 2024 09:50:12 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: En-Wei Wu <en-wei.wu@canonical.com>, linux-bluetooth@vger.kernel.org,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241220082225.1064236-1-en-wei.wu@canonical.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add NULL check for data in
 btusb_suspend()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241220082225.1064236-1-en-wei.wu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WcLSpMtOClRVvVXqbIrBbaPhAwGbqlaxGqYDolMbBcthz/1QJNO
 0nnpOKLD5FKV0xMEkyRBai10LtQFeklnVG2VpP7VjxAvXVU/h6WGdhVAKBzphx36i+7l9Wm
 3gQIRTjYAaDwPv9K/t2pD7XRXkAMRl8MjGynQ474JPXMQ5we5FgMs1dMkhH+RK7Gc8IGUT7
 tPnQgdXjPIjbiE7c1Mjrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NEGoKFxYuuI=;a9o5fzO+/Y493e5PRiI5Eymgsx7
 M9SW/l+l/nOW0ekkPyEdc+KPACbsJOb3U2Slkkx61NuBePuEc5IcCC/MwaLoHf9YBQL0LU5xZ
 teioJ6NTRbJTUseEcljWeI9ohmOwi6IE5fcM1Ae/U1jq5I13XZoLUOH4MayhNENsXFSwsasPR
 v83jEYhBd9RRzkm8xhgHHz7eygrC9YpLbXseKOoVqxzZImsabsF73Irrd1guQh3f0SWyuBa1V
 bANhGFmXWVeSTnXEywwvDnNwrqwZyGhtv6bM34xSyTMXdwV+VUVAD2eP4cDlPKONx3dXcjLKa
 N3ujns4K037HAH8VBwHP8nB1/pSCFgg6lE62ULJizksCABk9FLocMKeHkZ4fCI4lSg6sUKvQG
 +016TOL8bfxySaSJBWx9nWxX2S9tAthsdm3gIvE0gHqZzxqc+/wD6vEeGXsdQw+EZpajWaDNT
 L+EJEobQjYesiegwUcEOfseIMWSbq98Lm8SQmyf32GkBloteWX1TvVvXkroUv/T+lz50uq7tx
 g9/QyUxCMgBeST375gy2tX417ThNMlJtXbMUa4GV6a8tUVNbnM1uMOanu3VyrYHuEBogs2q5B
 jmnkS5Fl54C5idjSWvQ8UbzBPaLvgs2eR1r3lBI5tPBSyJKHX1WE8BJxQPGVYH1di5YsVr1u7
 XJgzdEn/y6LxY3n75nOsMVQVHz8TUVvGhgHGXu7oHxYkWxtwq9XRieg42eRzDdk/8wRWsgMMg
 QCn5uziJTmdHlJhOZR6WB9Q2MGiQK43lZu+QdB0g3YMOF4NcXfHrpeRQOwtBO4NpCCPIKViDn
 RgRXo2hvaLpSGVyuF7x7tJB9YFiCK11AzS6b449OCQwfmiqMmQqDPnLSA9Ch95PONwUmDuNZE
 c3jyCzaYerP31FNW6WXr2EhdhCuu5GT7dWg/bj6eV9yifz0v1B+obRvWLBXpsr9ioJGJjpPj2
 VCSWXY8hmREADh16s4obk7RzjGn5bbdKAIbA+TjLDWq+rRzstvlIzJJfwH5uI5UZjR38WpZU4
 2vEa3iFnlKB0tMLTWU3w5U8KwGrMCiPrpHrMCwSvp0Pxoc1TLnDs3yHmBVJpaYewzwPSh/MbL
 aP00IePvE=

> When performing warm boot tests with an MT7920 device,
> we encounter NULL pointer dereference with failure rate 5/30.
=E2=80=A6

                            dereferences?


You may occasionally put more than 61 characters into text lines
of such a change description.

Regards,
Markus

