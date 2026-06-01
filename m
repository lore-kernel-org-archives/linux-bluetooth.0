Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24ED312825
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318160; cv=none; b=DWCy9pimgtSxelu7aYRNSgXZtz96tmyunQC+UUqSOorLVrQ8yW6IXZN4dg9wPukAD36UHWBlfhQ1FxGuXpRkJt89EUw0nNlWhAdxGcHbEdeOyVNh+Kcojv/HQaMPHPmO2lmPfqtJxQ6BSaRgPuRKYwluxcLbItMonKEzYMPjc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318160; c=relaxed/simple;
	bh=lceQyY6PWVK5+TTkoT1DCXq/3gSXQwg8bJxxP4TtBb4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mJKtBR1YA31Mx9QFGaRObAjQFog3tH4w9R3XifR536buw/D0iFAbrTllu0WZPNyWefURKOBNx5Y4o8vLKkrGAtBOY7f6D4/e/nBMJG7OSbFP/C0ImM75AtSVH732YxRu5maDFu9q3tm287I2z3DLOzB6miVoWDLybQF5wfhLI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvOfX3kM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvOfX3kM"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51749fe3475so11237201cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780318159; x=1780922959; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ugqtXONXm3gq0vx42Oi9ti15jRWi+ckqyMXP6D1MCoI=;
        b=SvOfX3kMh18TKYus+sD/+2o3FGbGLiD7PFjw78JYa13Q+gewYxxWmtAKVXsnKGc7q7
         vFLvguAFOE46CBibSIFA4S1qBAfnVar9ETX39jZ4H2ifDupm0YWZxnc6y2Q9lNYV06NY
         ElcakaTygTJFro8AyEEJ8rpt1Aj1APSAKUWFYT55+peChOtpQrQniJoyeiY7lMWDXHlW
         82KKq+Dho7CnfzOlyPkiRGF0qsD9h3RB2AxPo7cfdjbPWMO75h86z77McB+hTbSI8P08
         iniHBsl9ALBiCbeU7QV8Yk5OkkparVqp5al0DNLhoV6qLgdxxMQplqxjZvO81tQS8Z2L
         ih8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318159; x=1780922959;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugqtXONXm3gq0vx42Oi9ti15jRWi+ckqyMXP6D1MCoI=;
        b=ErFPbdv7a/mBVhiYWyIYrbmbJgnoVHSJfsIcmQwBB5W5LmE1g3gunr7VE1JRfdxaWK
         ZY/URT44qztPYF2wKKgmzgL0dyYlvUPRjiKj9CXScbvfkoBr8MH6d71h/KYtsPwPgD8G
         ReMWKmKqdx3cdbPn7c6UBW/3X3xsqXBp4uCIxJ3OdDbhcQVB+gycbxg1SqRPoABIBWXT
         672zChOqbsdt4FDPvw6T+k75Ql5VcLJDWZXs1mWSLKxeFTtctIp+YCj1iu4IEF/6dthh
         GkwIRWwPnSQnYJYxMm6QRWgvyv5gwS2sFj2vznoszs395ZZIPbLoaF3/+9rE30HR5voa
         QxoQ==
X-Gm-Message-State: AOJu0YyK9JcBVAk0koNCzlAmpm3Hv8Js+eHv98VyIyQ/6ep9ef4owFCG
	yUUqIwV7I/l9urRNqGGGGosLTMwH8yzwX1PJ25gViom+09NgnM8RokKCuPQOXg==
X-Gm-Gg: Acq92OHvV8t7Rk0Ssmc14//fvDh0KIDfD66FAzpGlsS6J8NevEvrwRfMQsCzQRQG6Ou
	5ljGwX4yayo98fZ4GIUwsRDA+PX1SEj14Cd/McKd56oCv8/gIqSmsqdFOxSM3co1rpVCjwt3dYs
	pVufWof974zDL0Z7Hj5zSlwNyWSKwF5sMZU5o9xI2V9bElQeU3oRQYMqhtKiwk9E8TiZ0SXznJB
	UdaZxvw03hlQTf4qfniGyE+jfpaZdyVWnC5tRNGrwRihYyjJahGdOLA73/1GSlX6uQmiO3DrRxG
	HzJA34j9NqjeXXmtVxYNiNB/N0BEZLtIgslgiw2YdNR+Ndj+UeDl0VUPOzbBgMETrKxy6QNq6KF
	JN90XFdwkCTqdEbMPA343J0RiHN02cZg9uYCnNsQ+w/ycAqe9GsZ+Qo5h4llytQWjfiBNlBABDC
	hWRKoUiUG0N/BZZuFigOIE9tIMRajrqS+09gCPdvZR/w==
X-Received: by 2002:a05:622a:5c1a:b0:516:d4b1:48cd with SMTP id d75a77b69052e-5173a5b21b1mr162767121cf.2.1780318158599;
        Mon, 01 Jun 2026 05:49:18 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.235.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b05915sm55249131cf.1.2026.06.01.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:49:18 -0700 (PDT)
Message-ID: <6a1d7fce.a9c3b6c1.259637.15c6@mx.google.com>
Date: Mon, 01 Jun 2026 05:49:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5883192150517128809=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suunj1331@gmail.com
Subject: RE: Bluetooth: Fix data-races in SCO/ISO connect paths
In-Reply-To: <20260601111908.232707-2-suunj1331@gmail.com>
References: <20260601111908.232707-2-suunj1331@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5883192150517128809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103971

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      25.56 seconds
CheckAllWarning               PASS      28.06 seconds
CheckSparse                   PASS      26.62 seconds
BuildKernel32                 PASS      24.57 seconds
TestRunnerSetup               PASS      524.16 seconds
TestRunner_iso-tester         PASS      79.34 seconds
TestRunner_sco-tester         PASS      32.06 seconds
IncrementalBuild              PASS      26.22 seconds



https://github.com/bluez/bluetooth-next/pull/265

---
Regards,
Linux Bluetooth


--===============5883192150517128809==--
