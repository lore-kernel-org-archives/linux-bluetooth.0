Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDA31A81C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371379; cv=none; b=RyKef9PE3Xc8i5r8TC6pThHH/4rq5BEBPAvb0GMvRHIWvzZj3GprQjsGiuhQbIt+J3gwyD+c+p/0GpOPbiYNuYTNXpGjaVEf51Cce8RK73IBj9ScM+CiT5rsXa76D0OoOuuKSY5M3Z0In4292v2X1vSBlh69RNMmTDCV+ui6Qt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371379; c=relaxed/simple;
	bh=itTfzAbhNvUr00zxtXqAMKcztcwl5/n+03ckilUh5dI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OgLAAg6oPTkQCTYV52fPrN3IAzxfzPWnz/oVY5sTNIDoNA1SBim0eTR2UtUT0E2SSsFBamzlC7HrBwLJZPEEuVjtVm6RMrBkkMGGStMFhe9ovGd2ibO+vaPJ9OS5G73IIe1rwZjMMAqh46MtK7Vov+OALX+ToPuMVYIV1brYX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJYDXRKG; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJYDXRKG"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dc51aa8926so2417879a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776371377; x=1776976177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zy3v9lxzB1/U7fOPwvSkR4Z4tdjtTakDW3AVA7vNeYc=;
        b=aJYDXRKGA21duu7jchU+aHBPANrOmaqsZ+qy7vqmwZ9vxR9rWN7BPoO++zipTXPqLf
         QiwmA62aONo/djiyzqW2OF5uJhjPIBXZgDo9lOogb6RyWLKMLSVdMgOVom89mDaPdsLn
         uvsblO+EOIpL3nzbP7lMg+GF68SIhD/2JM6bySK9nG0jZ/t0oI3qtOEzHJY6JWzxHjhi
         wPqijedw9k6Lk0lZ87QgxQHzA/GLLb2u34uyMc6hmXTvtTRrUUtnkSg3/6fHxWI82wkD
         X5l6VYqSPs7k9tbafqPX1K2c7GLxo5pDaTdp83kj6+iLg1O0DyOeJjFTwWpcny21BBUo
         wkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776371377; x=1776976177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy3v9lxzB1/U7fOPwvSkR4Z4tdjtTakDW3AVA7vNeYc=;
        b=EI0rmAy0l5nTlQ7kdMxJRBrXhps6XVe4Djwl2dodYqCEeuNRgCYP7WFhNYoxTC20p2
         Po1tVgoqxe00+BYvZnfMYU86vEqx7lHXNk8E3O2z+qhGYvzbsUtPbZ1WUt25U8syxARf
         wSGnrm+W2fMZLdF8mPLPdFqMdX//p7lDXZXCtoEcFqpjEQYIG66Yf4ZcXh1GnRZnLDRW
         h2w1hlWoXnFxzzpkrPB8WgrEvTYtQ+RKyi5FrmNUszvoRVo3DqwvMNkpBNbfzw52PpJA
         7WzSJ/9ROQSXdD7vy9Pvpm1k4HMtSx4Fyu2YC/KWsVwkQ7ef+0t70NPThGOsQiRc06tM
         +C8Q==
X-Gm-Message-State: AOJu0Ywe4AOHTPfjYMWshq7f+LzgIOGyPt08L1IlDHaTRpGaTb2cwO9s
	B3c7u8jHVHf8ClhreI1S0oC26SO1tGKRaG5Iqs86miZJVIQm0sfNeHfoIUtVFA==
X-Gm-Gg: AeBDievvyxUk0Cb89kmJABNSYwZ8OGNCu5DhrpfUkzoJ0zKqyNggAyA8rnVcSfOlykZ
	8M3CmUAbzYk1dqmGzZD0cKN7gEdEbtxjunwq7nL07XN4CgIW9tYc7enxnglwagAqBdaR7sqfKP/
	q7H60L17aswzfwko8ZE7CZ2noRs65OIRixJUtDz2DtcBwwyQaFuHbECTYElqJQirT4ldHYQ35Le
	YTdAx1MlNsT1cyg2jLKml7tTKweUEtHw77MyUrgAGGqtMlBd9Os4uifhvk51dUXbp+e+Gb6D6LL
	xjRf775fXXtyuW4oKrf8Y0TgzFMjtcrP6DnFasGXgu9QrQrt4wn3e8l7fkg3D/vMVj640KUwsXe
	YzUfGQipSx1ic4dR2fBa52MBe82AlXXU5v3H66sn3gkEKZ74G7TWkmw5pvkfScQMonpxwigQhaX
	kS8AJ+Em7QvbbvpSSFaDordL9g2E/F3SIQCu/e06Y=
X-Received: by 2002:a05:6830:f8d:b0:7d7:e6cb:836f with SMTP id 46e09a7af769-7dc95256c1amr18282a34.19.1776371376934;
        Thu, 16 Apr 2026 13:29:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.58.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc90c4731fsm681686a34.19.2026.04.16.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:29:36 -0700 (PDT)
Message-ID: <69e146b0.050a0220.31b5c2.9d5f@mx.google.com>
Date: Thu, 16 Apr 2026 13:29:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0208930400026097059=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] client/btpclient: Add BTP_OP_BAP_DISCOVER support
In-Reply-To: <20260416184914.145135-1-frederic.danis@collabora.com>
References: <20260416184914.145135-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0208930400026097059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082169

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      19.95 seconds
BluezMake                     PASS      590.39 seconds
MakeCheck                     PASS      18.31 seconds
MakeDistcheck                 PASS      231.93 seconds
CheckValgrind                 PASS      269.97 seconds
CheckSmatch                   PASS      316.65 seconds
bluezmakeextell               PASS      163.07 seconds
IncrementalBuild              PASS      599.28 seconds
ScanBuild                     PASS      902.88 seconds



https://github.com/bluez/bluez/pull/2049

---
Regards,
Linux Bluetooth


--===============0208930400026097059==--
