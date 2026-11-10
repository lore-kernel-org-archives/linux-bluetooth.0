Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335791;
	b=jbtp9/cTXO4+Xc4f9TL4mSw3xs2KL22+PFaw4bpl6cKPJymwbRDMXucfG980PA5JPgJp
	 o0P8UAO9JuV87bD6F7zJUOsOTbCcygn4ebpcXAtiV++iFLjvzFv/vgqiNq7BCtW+F8Gl3
	 cQ+D7mTayG2Pz4k6fmRchKVQlnrVAR4YZphkyuMD6CwXfNwlPm1K2OLX5K5tyeqV+h7yn
	 KYBderzGOipXYv2wGGDacERczBFs7eDzTLmHnwdhEN3BgzG7ib6WpzG0iVS1J4z9CYV0g
	 7kNkMYQyewxO6Bt/GXwGMoYzm7Q9MrbR3Yw2Mb1F0oFDhoKQm8H01mpG36e3X6JSa0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Ou4jNGWuFZmwkjtdmIumJGCXqgh1SdfiKkd1sof2u/o=;
	b=WGdhvrL5clPs2DuoCwMvonu4yemiwVZN56kIE0j9yvqgg79fS1bOzKG3EKcG/9zXvsuA
	 WybpCqoKXab0ThJQ1VdBb9P5xBsRZWG0a8gr9TbjvxlinLIxo/SejU64o6E1IDFQ51fN4
	 e3IOJZtVDuXVTEyJg4PydN7W6LuU1RwOw5ZihbKw7XghOKjNOAPJv7gQZoBSERAX2w4jo
	 BrgK2dqM9x7TNG5YxY2bdEaVWiTAIBApwnnq8LzWDsRnQVrwjINjV/tCX5F/dFkruTPjt
	 Uh02b7MHZ+nca8FgdLd2z2Jw4LzypCP6lpxnZuMZbjMfGv5V0ukba6R/I5A1h5seD/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdPLSnaJ;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF78606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AF78606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdPLSnaJ
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eb5559b34so17942016d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 10:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335790; x=1794940590; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ou4jNGWuFZmwkjtdmIumJGCXqgh1SdfiKkd1sof2u/o=;
        b=WdPLSnaJ/1CTSWtclKd1a4SjaTfQAmJUV+9D0ciUDVBtFuZJAPKI4sy189qSbpxD2d
         5dl+O8nyiIwbnDbz2gyfsLWUNqcycOaZFV+JtUwDAuliokNMy6tVZmw69OD8GE5XGSlX
         XbmKsIykAg/hcfX/cEEgrO5u0YThOFCZ8nhzrh+sfD4mRRBsbBqTv3ewJa7kBGwSnZdZ
         r5YJarSpXHZun9COc3JGUrXp1Ob5E4pQn2n2JmUGf3/D20GOgKqjDc7oeB1eqHFy9gPx
         YRHJFm4Ni/JLJi0jKOYmckKcpUR2VYMiZhEp2OsVpTtPegUPM03YgocaXOBJZrxwpuBN
         xGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335790; x=1794940590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ou4jNGWuFZmwkjtdmIumJGCXqgh1SdfiKkd1sof2u/o=;
        b=PdKA5Mu0yuwfrDueYefRIMam+98Ef6RChYDupqnsIosB28Fb720Be2CdP9I4ac74oV
         PSQAkJlOEktaTjWz6EsHU2TccIxJvqSHYXnlhUdbsd9ktc0JKb8A50bxiXdMD8aftPLH
         9PXgwV6i6VQ52m4FlOV+XvUA0XZlCZpw8hg1oeZdrd3YZvvzN1IGZu93A4qFCDQriHF/
         76OUpRV5dwEeXeuTfGIgq9Oy5UrKkugXzXOnU1OKomfNBIOMn5w2iLG5iDAwmKGrlU30
         pqiXwIMOkIUuFRmP9XoqllqpJ/2nUF787RwGqUCk/b4oj1pjZWzgR1Kxli4c4Ws/AQl2
         5h/w==
X-Gm-Message-State: APuU4Z+ia8Rb5arwx9PD6oUZHww8ReDifESBM/giSrFkRP3Qmokav4m2
	29ncb1RBZpUxKFgPtf1IIH4MXBniqJVm8hPUa+DCbTvXL1HR50/YyF1bba4yXQ==
X-Gm-Gg: AYBFou2Kky8QB1HKIbaw8eyfMjbmN89qtDUzE3dTSOnAONrv60HCZkLh1ZsBNuZdFjL
	A4s3T6Tx+qB605Dm3j+Qkzpz18iOzkRLnB1h/djRqFp9CUaD/FMydbfD9onO255vgmIy/svNqOE
	hO48uD3stuliO7mM9HFwcFU/4m8zLJxJ73vaOOTYsNwisbhZkak95DMEXjrhPm0gpwMX4QsZ/7p
	EtxKAk21WRu2kEN/fk18B4/yUhwY5QdR/lmozZxspLMwnLYN+w2P1J8THyLyoX0xdBIA/oKRKJw
	IVSLxsgwzSxi+/sVW/Gjf09tV1kfitNCRFUhygEHDzthZxuym5Jc/FQ3S0r3x5v49rP91VH9AL7
	0IFZnDx6go3T/3OsnmTGP6vFMEGbggDxb0L06lGCkvfSaAhC5LTCTCvEomKeWN6E0uyqkgbgMRj
	88+egulOOBWy+IUx7/CnzjKDKxfDAmANPRy1fWd8uET4RSk858x+JBXdbhc1JruxdLMDPIrc17K
	wo0syjGSuuKPps+e03+xmdg+oy9IRSHsGB7zK2QeHods3J/1pE+yGBofTwGJhla
X-Received: by 2002:ad4:5fca:0:b0:914:cdbf:b68 with SMTP id 6a1803df08f44-91f0402b201mr2483146d6.20.1794335789851;
        Tue, 10 Nov 2026 10:36:29 -0800 (PST)
Received: from [172.17.0.2] ([68.220.171.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f0199c41bsm5079936d6.34.2026.11.10.10.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:36:28 -0800 (PST)
Message-ID: <6af3642c.40ce7c98.1cebca.b4bd@mx.google.com>
Date: Tue, 10 Nov 2026 10:36:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1112232234647364128=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: obexd/pbap: Report NewMissedCalls for mch
In-Reply-To: <20261026131504.1016687-2-jinwang.li@oss.qualcomm.com>
References: <20261026131504.1016687-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1112232234647364128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       obexd/pbap: Report NewMissedCalls for mch
   Pull Request: https://github.com/bluez/bluez/pull/2713
   Created:      2026-10-26 14:06:58+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1112232234647364128==--
