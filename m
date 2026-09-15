Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6654B5123
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495673; cv=pass; b=MhlE2pGO96RkitbqJLh/qLsQ0ZH6UDCSQcauLjXner/WbXYpKAFnJvN61voKfuXjaZFzyYbGufzP/hC25wdP77PIFW/dgN95zojFvi67opq2WPIfvA7lUkQhT2wMdCRprFD7R/ws9Xr6OXVpybQ+FlbX1M9MIyd701e0riFp+Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495673; c=relaxed/simple;
	bh=WHuFY5lyfwFlgKIprd8NFUWzO+uzl3QfjnLSqIeo4fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTfk20ww0gswfbWSvqTxixzkBdpxujFcv2KcTNdGCj437fuXekPZ4w5Is2IhFaCeZt0wZj1wNdj4pSMmSknSLqfCc98ySGK+neKzYnVA1JYiFYBvgDyo29rxcoFyXm4Y/AxHmHha4bUweg+t5ywSqjBVwWlrrd2xHncXcG27Cxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfXjxwcZ; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfXjxwcZ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1fe3fso52238d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 11:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789495671; cv=none;
        d=google.com; s=arc-20260327;
        b=OmBfiVu0OiRv8ukI5Y2BVGzyVYS76OUOL7nxDukF/8HjesgJQNI+YMGBDwG5gWDFiA
         yk1gWmuobKPMvmdh2IZJ0La4PmlGDJCnCnSe37umCKbx6M1vktQaq/wqQskS+JmCZz0Z
         dBfLJmOX+SFo6vYGwqiyigbb26GLMfRTDA/Dxt9/dInqUw5cypjR57P0+rl/iJFm4GK2
         +fAa7wxl/fEAIdrRBtG/tXg96HLYM/l4IrUX4Q6MtnpF/Frcvbwn9pAoFRUQ2jNYGOJ8
         QdpJrJIOf0UgMHRpSPo8EH0GJdlapRgDUTspT74p2g1XPcj0bQAqrvVsUx9teCMpV63m
         bjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUHmVIDon46c2goJFaXs3z7P7UrNBaUEH1nRfyhH7tA=;
        fh=S6UG2DtihsaBHeASh4dJTCyMlP1nJDgRmzM9JUwjfvs=;
        b=VhCi7flQ2fLgPDHoy6rnR37y3uHM9P6yvrib9UtirMIN5pxTpUrvPFLraApTGkzpUz
         aqjv1pmenU1/22XViplSjJkPEP+hNgzAg4AIO/iYgUj5cQ5neK/+fShETpAqY1ukYu8k
         0mE+K6q2o9uLL2SoyeaZtO2MJmUZOx/o8dKbId6DU/0YN0kFnh9zSXt1Vmsz/60YDPAX
         3dLAnd0rmf82CzJRkHVEBN+8MgoAJxYbxu/Qa7ZVnL6EaBGuWxJ+DPo2xvYXt/01hHaB
         tjDohii6bREO4n+CxLm326eLhChCQy/VrwIT8uc+JyJZmmtHraHU8ylE60rtrYenvSya
         ttLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789495671; x=1790100471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HUHmVIDon46c2goJFaXs3z7P7UrNBaUEH1nRfyhH7tA=;
        b=RfXjxwcZRxCCYDSsBDE0zhZbrQ57mIU6ECgiZTiaXn28poqYKR29mQXhRX2NxMtfie
         Nv5LK4o8xTcSdFN6r84ZrgTDXvOw5LDmtV0rhYrs1FAuQRwDUXbx2rBGGVFKzlGc7HPI
         Kp7kmP8nd+Qg5GLYTK+IdhB2AI00E6xZr+daD/jNNc/IM55vg48VWVtTy7IA1ZhNF8c7
         QiVifVEr+TNfKRdu0MT0S9fItRS7f/C7zmDh9xo/iDhkv9hNBFNtGc6SLC3TunRGR9u/
         sYkVXFT320JEfq5cLtIRjkK1S4NSuWlRpYwmmImptno18aeAu5bQN+4mFhuYHBtpygdh
         S5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789495671; x=1790100471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUHmVIDon46c2goJFaXs3z7P7UrNBaUEH1nRfyhH7tA=;
        b=qR9nw7oBJjkuMKdcm0eMY59h+S2GvfOvwfRoD+BBm6/5FsOVBhjsSIjhtcaJSlT3zq
         MQZ3njZyTrlWRvpGmfmVKgVxCkeWKiefTfk19tXsy+/v4OZ7ch2/NlDJ6X7TUpVUdKEn
         VB6/8ojF+IJqGRKn5YE1QN9zRhgOY9d3BExsHy+Uz+Fpu3s7VCQDeaEURySXgMP8DV1F
         L1wtaUojxwxy5Yxt5AbIDkGzebn5NtQI5iT5IW/U90TND0/JngAX//MvBck6+9Rjcj67
         DlYWrxM7HaZLV6RnNAXWgo/OoR5AEN470iEnfbMMT5wsYI4Och24doqYfE0gfNp9Xtop
         25vQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkK+DrxFmTdT/Uer28aVnT/zZKxjBuasBi56drcCUBCHGJk3aV++B3A7DQdhXF0QoiU+JQ2stSc4FR/w1YOgU=@vger.kernel.org
X-Gm-Message-State: AFuF++nLcb8slX7ZcEc7MsNIF96PQuH3AGcWTqCHNwH8StqCDw9DtC1U
	sHq+vV6AZYROWytk2UltJpf57xoe/yhbWNsmLPuSSuYK3bc/wIVmwcpZaYGOHchC1RNCi/4Bq99
	pkbfgPX/4KE4gncKHj7lCsu2/4k81yZg=
X-Gm-Gg: AYBFou2lpdENOQ/9BZVP6Qv4OggF1zIeEKdQUhKRP5TROTznWFEhFbBEQrCTxH0KH8a
	y1BKY14UHiI73pTVsaEwd6DksMw/TqaZ5aV91nzUUqhM9I+apnCd4I95uy4oMkyabg+rOy3RZAw
	gGIc5OhPKc5AkTen8CG3IKhy9xLz9ewoAsahH/0iSSwX+GVc5pl133MOxErSnaKmxIWXb5zzi6u
	F6URwNRStjriP+Qeo1kv/CIFp4mkWm9OFLCgOE7PI3KO925mqPvk1eHuE91/VEzLDhm+zojOUTL
	BaSX9NNXXxELCRHlc0VjuGLE15eFjLtJgjWP3LptlFtjfbYX9um7N3UeftdqaIS04SN6pJCKmzB
	9HijTWaWsKtlCS3I4JtLmKJohs+X+fwL5vZlLF8aUvtTe2qBe2g==
X-Received: by 2002:a53:ac95:0:b0:671:2999:3a26 with SMTP id
 956f58d0204a3-6714e060b8dmr2603442d50.60.1789495670704; Tue, 15 Sep 2026
 11:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
In-Reply-To: <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 14:07:39 -0400
X-Gm-Features: AcwNN1XJaDhKcxN6rFKX5saItsoN-QDKLpK8Kc3XBBzF3GPkM-xZVPUCaj4dQaY
Message-ID: <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 1:46=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 08, 2026 at 01:57:08PM -0700, Jakub Kicinski wrote:
>
> > You're missing a bunch of your own sign-off tags.
>
> FWIW I do keep reporting signoff issues to them:
>
>    https://lore.kernel.org/r/aqQARvWlSUQEHMtw@sirena.org.uk
>    https://lore.kernel.org/r/ap6Ze-_ckuTFyCMH@sirena.org.uk
>    https://lore.kernel.org/r/04d6aba2-bf5c-4e73-8ba2-1fe57218fbd9@sirena.=
org.uk

These have been fixed though:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D8d463624a249b6023e1bac6a5ebb0853a9c96d26
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dbe1cc4fae4cb7d506ad01fa7746db363c41dcb6e
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D9ec9d1ade8ae7a3bd3cc061534d767fe305bedb6

--=20
Luiz Augusto von Dentz
