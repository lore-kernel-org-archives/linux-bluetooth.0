Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF209281530
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789812427; cv=none; b=Uma2sjGy5rIBra90AZRXqNOKctNUOEF/6rqjGcgUK5zKX7HOoZfOlHXPOGsz9mPCIGebJmOk6FyvofHU7PZv7ZXYZgIh8Q3idnzTEcdhO5iePEa3Qb1QZk1WozwcBZhM5OSv2V4BczmVuvw4eVe/Bj36Vmmr7Ye+ADmQXOWcV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789812427; c=relaxed/simple;
	bh=elqOL6SOduchc6fNzEwyeHOTm/LbyRxNpbFTpQaPiD4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDM2Qq76A/EOCNgdrdFfDLYzZPiyAVdYykNU0zJiugUxs+p8n/AUeyzY9K4iVEmcoOU/t4WP8gbnIxUexzC76X/IlNE1tCcqcgANXi+/PllJ+oF5HE7/2E32QZg/kL7yNkv7AL3pmBraxxgMOWLPkIfBK0PIHmyFenGKFS7y4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kkWuhE0l; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kkWuhE0l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789812420; x=1790071620;
	bh=elqOL6SOduchc6fNzEwyeHOTm/LbyRxNpbFTpQaPiD4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kkWuhE0lc5ebpFlcMKYeRI2LWa4MofpOuAUAwqjAv5PILTzEkx/zobqmSEK4bGpK0
	 xelUlfxX8UqpsNo4gURI1u7CXAQKAtmyUBKgLwGGPurszUfMqbZg35nG5MpbTX1fqg
	 cWLDmBsFgnVgGf/wMep2I7x/vAy5pOtFs1/JaKOM1MgM7Qgx9BFGNYtZftF9eo+DL8
	 exTXCZbOweqUPzXvP6kd2dODuGCz0YdYUSmVhPW1r5yjzMEGLq3t1/EybaYJSDf/G6
	 dTS2BOeRWyKFxHFMd6IskAetJ3DRrGHqH2DGZzup91jRvF+dmm8/9iRx0ytB6lq190
	 nWM40OwW9G/Tg==
Date: Sat, 19 Sep 2026 10:06:56 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 3/3] test: Cover BAP transport release and reacquire
Message-ID: <11nf7-aOUmEZfPJBokiWAsKwmmf53Zaknwv4rq6dYD-tSfU-yOp8Xu5zVo2WU5H49KTNTfQszWrAc2z3ErthHPbOiN5hgMmyjstPc-_Ozus=@proton.me>
In-Reply-To: <CABBYNZ+MCKEz_v2Uz+hDU0sn0COYj=guj9P8Fxu-qzp93XEufQ@mail.gmail.com>
References: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me> <bJzWf-DKkZ2NJt0LruBxuNgW3xnTzD5zu2ll54ZFD3hN89Bul7SbBAeOcvTK_S8vnaM-F5QpmQ0wZuDs9_M_G0fAbPTS8NMxFxctkbXnr2I=@proton.me> <CABBYNZ+MCKEz_v2Uz+hDU0sn0COYj=guj9P8Fxu-qzp93XEufQ@mail.gmail.com>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 758ea425a8cc1945b69edc3cc4cb548eef7f1d0b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The test waits for both Acquire replies before Release, and both Release re=
plies before reacquiring (done.wait() in operation()). Only requests for th=
e two distinct CIS paths run concurrently, matching the existing acquisitio=
n test.

Did you mean Releases on different CIS paths should also be serialized?

All three new resume variants passed CI. The failures were in the existing =
coordinated-set setup/teardown cases; I am tracking those separately.

