Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C431ED83
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864966; cv=none; b=K7g0GcQqdiSsj+c0gQuJS9J+zVYjxpiavnKwHc7lHD7276AJ5VrI8lotpjA6/speFXOpFWLqnnmJHv9TMowkA7afoljJCUAYHQvQNeBAJRYpSQEDGWiGyYsVo0Dkuo9PEOR1j0wCYId2zR2hS/PEIhIP+xxA3j1poyBixTA04pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864966; c=relaxed/simple;
	bh=ycUnYA01lF/vBDfDKjIffvJPmFNdlQ96n870eGPcaRA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cgKjmqD4bR69d/s+Y1sZavmO+XcNVOVwtRbvgaAp+A59cc2WkieD+GwxLyg2tXVrWVuYhiUSVFQvdCIlcnwHIhW1q0+BJwOuxbnSF1ErO4eZd/+Z7278BSWDAYwlfm94pRmEvdaB2oD5HdWZES7OyCAbnqnSno7gqC2fFTtIJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdjsQuVj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdjsQuVj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so2189230a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789864965; x=1790469765; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1np2XixV3tEV2pFZFnhZSjpb1VoIyia2RZa8prumhx4=;
        b=YdjsQuVj8nox+qrwYLeDVuMLUkW7RCyDf961EtdTc4TY42lrE54wrEGQwWaNq0x5gb
         6H8k5k2jSzEXvDPfXnbm+cup9qV6Qe6DBBkllYbaD8miIYeJm/ojbtRfZxD8xS/iT2NB
         SmJ4otY4ruZ23A2XRLmRKrsJSg1KtbDzS071pk3ED+EuuLCfjHkNyvymrOE+KiF2lArt
         /GzS6Unak54wAlfIKlpvJOEVsGPS3tNkxXUOD648XCsvBhXGVogEPpk8WXff3aeFyf2V
         rfxtUYvVXbo5wuN6IsX+lVE4nHJye5EkEHxH4lRvzPt5iZ4nnxsAKePd1xfipelHI4ZG
         vp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789864965; x=1790469765;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1np2XixV3tEV2pFZFnhZSjpb1VoIyia2RZa8prumhx4=;
        b=rSeLjGOcJnL/IrLIkM56YPlvdZesS1IBW9sxPcHHn8ujO2QKPJ5VTUUo6i/Bu4Gneg
         t+UnjpikKSAXm59r7STR6+a/rAPzmbFatXCb9+YQE7phJqug3+XpEE+POnulJQqEnGTE
         XgJkXuZyooQ+xH+H0TTHOjbasYJ3BKrO0ENnqdt8M445uz0ozatOEH76TVdr8z9yfi32
         5WBrC8s/PUvd/1Q6i/nvI7Iv8fXn5fZtohZNZ/eJz+SQ2yhaeWExyJy7y6PtdJl6jhEg
         vikjWb79Jjl7bP9Y1h3BXBlM+P722+qkywfx5vdVjgHy2AW3RVPnNOPvweiUn37sKCEA
         Y1oA==
X-Gm-Message-State: AFuF++m0PjDq++gkMUuEECEPTjXwpmmd5QwbkK72MRncsXzEysW9eMU/
	ro63hTOATzhICfoV4m8XWN6SvwtwK+bg9wegUOAdY/U+c6jIZVNyqXMTR8TTmg==
X-Gm-Gg: AYBFou0LzU/qy+5/eiKpHjnf78qUVgF2gdW1chp1Stl0n+8FEWfiZfiasF5AxRDhwXz
	D4+oXXEQxJ4KMtFgajoXJ5ISbO4pguV6vH8T74NFrTMI0WIt8JfYaVhS1tcgs2dyDnk8FMHCLIe
	N897NAralFax2NeIzqkzZccV361SDFWvbfFATg93RapljkgVH5d3JdiNQMdSWMNveeQ82xEvYqT
	IzrlIzQQJ6g4DKOTkaYjU8SFiy2OtnezXUNla9C4Zn6xUCa7cLQ1TxCOErQwGCSOcAH9UGYV7K/
	G42Z1IMfoXB/e4xTbgOZ0RFAv6p78g2kvixL55xli25DFtAR36K88F+peNdJwdJGcD/HtqgDn0U
	wjQLP8rSYhoeZ7vPB4imIME0k8R6NCq9W7ra9Cf1ZLtLg/AT6XmSlG0V4xtVPkXYmur0LguxZvM
	klVPCk9xrkYuZKsddTLaMUm5D6VPyhg9N20tHMp6K/hPpNBEI46/+N/rY+v3gBeuv6f5fXT21cZ
	++eUF7X
X-Received: by 2002:a17:90b:3952:b0:3a0:25f0:d89e with SMTP id 98e67ed59e1d1-3a025f0ddb8mr2641892a91.53.1789864964915;
        Sat, 19 Sep 2026 17:42:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.217.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331433besm13923661eec.16.2026.09.19.17.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 17:42:44 -0700 (PDT)
Message-ID: <6aaf2c04.c9c553e2.155e46.354c@mx.google.com>
Date: Sat, 19 Sep 2026 17:42:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4067191202715386439=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, proxy-alt@proxy-alt.dev
Subject: RE: [BlueZ,v3,1/2] shared/gatt-client: verify a synthesized CCC before writing
In-Reply-To: <20260904213642.68792-1-proxy-alt@proxy-alt.dev>
References: <20260904213642.68792-1-proxy-alt@proxy-alt.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4067191202715386439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v3,1/2] shared/gatt-client: verify a synthesized CCC before writing
   Pull Request: https://github.com/bluez/bluez/pull/2495
   Created:      2026-09-04 23:15:00+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4067191202715386439==--
