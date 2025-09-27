Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DEA2D73A2
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Sep 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987286; cv=none; b=shu6cgZDp488WXWUEvO+yOKRJHPnxg+OWvWWIkXDoLB5eavqb2FH5sLo9gejzctMLMB7HxhJ71FzjfyK+E2DhRAM05GN8QmqTicJONqex6Cez6d48tTndaBFMX8IDR9gzYYWAXy8DoOrDz1qqiTUui+v/dopeAdgT2xlMJ/x7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987286; c=relaxed/simple;
	bh=1NyzohdQmVFa2JZ1JpySWMhbjvJCfx19LHiQMzBXbeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsRRleSZnJYksn0VihHEE3WRodfwZBgy0gQ+q0hyPxYrx01/q0OS2yfwTr85RelhRuXy2A8mWjDN8M1oX6x1M7XbXMIGSeTApWH2s/y9E+Wi0Mf77GIYOwYrfD/rRc2bgHLq5XQ1q/UP/kBOjy3p8u59z3JP6WIgOfTngQr0BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZnKgDOm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZnKgDOm"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-370f3111dedso19017771fa.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Sep 2025 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758987283; x=1759592083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NyzohdQmVFa2JZ1JpySWMhbjvJCfx19LHiQMzBXbeE=;
        b=fZnKgDOmNO2+q7SF65F9Gc738TakS4nJA3T9Evx8SbZ4DhWVrMtKdhxRMqTn4ejzFf
         gXRI+n9NTRaKEG2WPjSyw4e3Q+fJcfj3ob4YGMgR6eZW+0IuI5CWqgqWhkOZmy/sqfuh
         o82ZaZ8146fFIvYWVUu58cntuMAMOdZ785G8NUMP6/kOOs+rGM7Wxz6iiVYBsLlVzea2
         CFdxnYmRPErVbT1dsn7xzMZs0pOZE6X5cQWyijmBjNsGWycEuvxPNMhIkd+59F7e0ZP3
         CEA79gCYvLr48wBG3TaOx2Zs3T4CM8gLJibVcA0UyZ8ijnNeGwM/FiRaE2md1yuGq0Q0
         4BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758987283; x=1759592083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NyzohdQmVFa2JZ1JpySWMhbjvJCfx19LHiQMzBXbeE=;
        b=bQSnBvV5dsLcYzkN7QtE8HIwK480qphEH30yYtqM6FJCptUneL/8NH/zlDZcQEO02/
         mwkc1TsQLdkaksoRR91t41taaIR2U7owYyGR5JL8TnPb4Jh0IqMOuRC2TOknbekZCbAB
         LKAFLEUteB2FwtjP6p9qAWd8NM/uZRuDZdgShKq77eDHIuuC+8vy+Xmwp3oTczaV3nZF
         xyEr8HMHgOTuMqo4Pona9AAxpjl46+LH9uyp3I1Ba5c2L93XDRja2mU9ZDfc1aNM9iLq
         pEN9+60YDf6V5r62YcLz+IbrVJQu4yQsh8sF0tRGtGvmVrHaX1OAINNDFVyDvM6ie1rv
         6fGA==
X-Forwarded-Encrypted: i=1; AJvYcCWHr/l5D7MAo1hU8eHaq9aCdz1m8IYenJCvEMGhs4cfXZh413JmgPdd/m/5dI9HuIWto0oKvYQnj9E5Zv13zmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBLhULDZigkRnpOJ7GDGiTppGy5nkSP8mVDLoR2LN1o90Kd9z
	mAqQDl8qy3y65sPnV6PMHGrFiL7grYmdl8M92/QPyiVGfy8wqFtTxRgkFxRKcKzBgwHc1Y8zhIf
	oOty3OpdLha6jKXMoZl8w9+NcmcyLv9TApg==
X-Gm-Gg: ASbGncu01upPF8Sjg737jJ+XPK4X09s1nnT0vdt3SeY+o5JZdJkC24p+bnMOnPtDlm0
	CU5WxTSO0LnzgI6r3lztoSYrtmmydIr1wQn+Z328IFiMb+puSgF1fl0mSDKipkhENQhF4tf3kQu
	iYIYSd/YW+c31bOd2OC1n7tSUHw0jftj05jCqds4PM/mtOBlpLbVEv+MPCZJ6XgjH5pvqSjVL63
	g2PlYSIGSoCKo5s
X-Google-Smtp-Source: AGHT+IFIV8oIu6Oj1Pp1lnbMHoF9GdCsUDzDv0uNr9W3DhIQe/zD2dAbhVOoRTo8GVxP6GDf0o+SLlO/CQEr38ubHyQ=
X-Received: by 2002:a2e:bcd0:0:b0:36b:9ecc:cb5a with SMTP id
 38308e7fff4ca-36fb24aa72fmr33790481fa.22.1758987282373; Sat, 27 Sep 2025
 08:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925145124.500357-1-luiz.dentz@gmail.com> <20250926144343.5b2624f6@kernel.org>
In-Reply-To: <20250926144343.5b2624f6@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 27 Sep 2025 11:34:30 -0400
X-Gm-Features: AS18NWB27mOMiB1EngWQFWE_xBLp4JBJePuK0Mn4tVah9yp5rIMATLFfal63ZDM
Message-ID: <CABBYNZJEJ2U_w8CN5h65nvRMvm2wWHHRng2J8x1Cpwd8YL4f-w@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2025-09-25
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, Sep 26, 2025 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Sep 2025 10:51:24 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth-next pull request for net-next:
>
> I'm getting a conflict when pulling this. Looks like it's based on
> the v1 of the recent net PR rather than the reworked version?
>
> Sorry for the delay

Should I rebase it again?


--=20
Luiz Augusto von Dentz
