Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C142E41B
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455970; cv=none; b=Mkk6O3K8vIo9hCdAknGFCwL1ixdsaeM8dTF2dcFbEwFqGH7uVZPtb+YoK4byX40L4A9TwGzFQjwh7NAmXSWqPns3oWUPNN7IhCbHqTJBJci0rlPoyqawUBd39dTAXsAliPk+Hv3/SNbXPw6AgtAV0RE0Okjo9Of5P4yt39g/K/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455970; c=relaxed/simple;
	bh=vEZmDeNHKKydVmMfmBmcS9e85POr4LLOLYFKriUQV9g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cBXWPUVi7cTVRZElREy0C6I9giH2ziy9olThUHeX5K2hlSNlJb/yqJI/Po9WkiWWB/yqe9M+VgnR4CX1XBEC2Qyx5X7Prs6NZuNt1ZGwtUuXbyjiYKwRpWQW0MZdsJDGDvYBGMx5nLuUVZr3qkR97cYWbkLO+wQW9vDBXcmRRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd+PROch; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd+PROch"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53381e53b80so31073061cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791455968; x=1792060768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NeTJ0ce0yN/ujurX7jOiV3/w8V2U8WaiCmQt6+KfKAs=;
        b=Yd+PROchNdqlGDi3m1e6ObDhNw62BWSkerj0YfcWwYeFBrOepf91kkf6eDPw7RAyVX
         GSTRtU+f0PYXILL8JN5rirZOMKLj9ZC+HBCtA83a0RBZCTLwaEgX26nZV/BW52aQKz2S
         hjLmUde+jty8EbZDEeTC9jiLguZ1a0R34axbre1yqkZpwSfF8kmcj1OeoSYq8vqDq7Hl
         L0SYQXEhgDCkqDTu7QFrwqzRY1UoJB9MpkXZ3hrOqz+QjQbkbwgNU/WS4Cz77+sH8n8S
         E9boBhheQ21UmMXJWXjkzKTEXd9F81uwK9NpOuEcZaQ4k2RU9gnaOy/ZlC9Mq8xQ9g/b
         QqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455968; x=1792060768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NeTJ0ce0yN/ujurX7jOiV3/w8V2U8WaiCmQt6+KfKAs=;
        b=XGKGOkcCUDgPM59yDPCaeWAUqVQ6o/BMI3+cXP0LRrxELG6O7V5AoCsLNoaSPv6itz
         fgHJP1e7nKMzfuoSRecbzWeef0s+GTbvE9ZKWelV9CZYDnVYpefRQEmYEzjKqtQ9TyZy
         rlNilKDOpm3wXMyzu9JZw/47lyyTawvKQ2+zCOZ7hImNzwNj6Sxc1foMcdmeYzvHcZQp
         pY97FUlQGd8Pcu5STMSmAO2HNt3oHuLLmgw8aOiI6DvlCsHGfVqM2IhUeeu2Oq3ZR1uV
         DbsDLTi+Gz+k4phO6gE2VZNKjmvIw/FsW7wia0P5v998huqzed4bDK4cnvdI61s8zWW+
         eqvw==
X-Gm-Message-State: AFuF++n0AlJgHhVxglw7+FTVf5cgP7nP4tpGyF6TgQi1wgVzePoC4Iir
	85sSish+MgOLtYrv2HmvAZ1BxcpqruRz/snzxTrB/cGZ8n/C64GZpgQY43PxFA==
X-Gm-Gg: AYBFou1tuyu4oU45cbWlbsh+re1sdA1QvAyel4WYzN9rc8vLHxxyMknzFFGF+bEGgQe
	Yv9GWEP8dE3j8LGHS9a8eJXsGHkxNUFx8C1gUhf5YM2PagNGGgfBYlIbKda7YXVOIm7S0GoJh1y
	vnjGfrAncpBCGvfJO8TDI/ozbi9m0QG2dcTmPxOhuQ3yxnUU/oqt0w7dSy4pA/xJ+ESPB3gYKdM
	uaVSHVmCta8Q+PS3KHdQ3MzBunLRPp16BX6OTGdKGpFBRgNtQ2euP6N196ouEa7zqoZZ45Z/seP
	xKwhNvMuymEwW9xKB8QwWRTSa8LKkADqUqb6IksMapcHFHbYPn+Mw98NdHd6n5aqNpAD0Uw8sN3
	ALZQrppUj8V7Gr76YTOL8+cla+XJDw6o70W5iHG4Uv+jBLucyrhdQ3seBNUwAM5s/kGgnwy+C9n
	ywY+MpCUkdrD2wdK47RUgy6ADBc2dpapA5eWI5Luz8nbPSp2zJA+DKbKrx4/c9kt1tQuZrrwIdP
	QKoLYcvvIrc2WZK2fc=
X-Received: by 2002:a05:622a:5793:b0:535:70b5:2382 with SMTP id d75a77b69052e-5357569cdb3mr88348101cf.66.1791455968109;
        Thu, 08 Oct 2026 03:39:28 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.217.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535721c031fsm40614731cf.27.2026.10.08.03.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:39:27 -0700 (PDT)
Message-ID: <6ac772df.8bdded90.3bdaba.38b2@mx.google.com>
Date: Thu, 08 Oct 2026 03:39:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1991120711068467996=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: [v2] sdp: Prevent integer underflow in string attribute length calculation
In-Reply-To: <20261008042720.3134391-1-benquike@gmail.com>
References: <20261008042720.3134391-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1991120711068467996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181248/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      19.72 seconds
BluezMake                     PASS      393.94 seconds
MakeCheck                     PASS      0.90 seconds
MakeDistcheck                 PASS      143.49 seconds
CheckValgrind                 PASS      146.23 seconds
CheckSmatch                   PASS      291.36 seconds
bluezmakeextell               PASS      96.12 seconds
TestFunctional                PASS      1156.46 seconds
IncrementalBuild              PASS      392.60 seconds
ScanBuild                     PASS      1150.89 seconds



https://github.com/bluez/bluez/pull/2635

---
Regards,
Linux Bluetooth


--===============1991120711068467996==--
