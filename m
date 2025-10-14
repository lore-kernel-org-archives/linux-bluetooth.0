Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D22E8E11
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480039; cv=none; b=ZKLvxQrOjPIfjnQsVXL2oW0QD43asxQXS/qyTnnK0Tirw3eiFnOUTzMoPQpzGSLQeUgnpUFJht1oalaP9FMXqK0kbTlKolGEak2F/dBKDiN078eUlK0emScT5sYsyaS7P7mABn7+VGXjzhGC9pMsM2Avls7m0VcWbO6OXuuPXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480039; c=relaxed/simple;
	bh=lmHtRN8L8lncmU+YRrv41snFltspx3jwQiX0ThAdC7M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LuzONUhbv1dE96I2I6jZd4vOOMQGQuf3IrbATSF9QzI4ANRAp4oSKxFp2cfToqVNC4buVgnTP/ZZVcYytSboc3/g9ym+wFIopkc471mT+mievcFlatP4Z/bjGmvz+grpteAeR456i3OwYDaZCl2nUrVtkDH7Lq9PVSuq+xOhwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKAcKZ2+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKAcKZ2+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso5152150a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 15:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760480037; x=1761084837; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=roIFLvzu+EVZAoyph4qzdazTEx56zTE7BX9y6faVfYc=;
        b=fKAcKZ2+1xvmqn5xn/1VzemBu7BF8P+3p5WD9+c1/6yRHzeYahQiZH+je8CXkPNr2v
         DaWJ+Ha6JcOhbmWa4FzGaR6cnfZ8WzX1alHLhXtVP2RtiqnNG1UJKXXrGPjIY9SuPSl9
         9w871p7vy162ce/bO4BdOeozEnXpe6IlwfUXr7mLuBFaq3bfGromyQ2+rZlYD1HF7ijg
         2h2/KU6LcjsRy7uhR6HS5o3ViT23PqAj4l9i82tGQT5IKTMDh0s4dYnuSMj2dO+BY5CK
         FNyVCiaAEoYRV+F3tY2kkgJbq3FUl2uo7VB7jWU0xmZQAZ8edM7xcbWh1t7mmyHO7hRG
         N4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480037; x=1761084837;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roIFLvzu+EVZAoyph4qzdazTEx56zTE7BX9y6faVfYc=;
        b=S5XYN2jaQIyQx0dS2czxI6pMT3CqzFftMX3nRtTY/cC+aFARq17pOewP9EcqgURd1w
         RQBdhuG9B3kjsVtkfI294ckCHE4V7TZgGbMgudZ48uJ1bqduZ4zmdkKDnGm0TW4ecgaG
         hThjyiPDVt8DJ/h/ja3WcWLgTuUKaL/0eL4Ruto6RAjmj0l7rKduF8RVW9uSO/VKkdCo
         ITz8m3xvyZ41Nw7MEMoa2J0LDS+2eje7qUGkKCEZBvLlj0feGNx+6sGF/38wAnIycWMS
         yz4PoAbLbff2YLGSxdY2rfiCfC11Ph9jE1vtehQRsfdGKmouDqWwlqk/7ZCoB0dvxRcP
         eCRA==
X-Gm-Message-State: AOJu0YywkjlKRkd4o/ZY8El7eQrkfWuBzR4xcUdh6GNUNJGXSnLntwvz
	u+EyY14Ijr5hGLjMNBhnPystMaiLjKprA+vgCHCOqCxE0Se5/DdqWMmNnjCpiA==
X-Gm-Gg: ASbGnctSkEZG9Gkd3Kpe/RlCZmcTid+pMfTOs0s6cJ2BHb8BI1vtKK0UY0LO6NfVXIB
	8cKTqtPO5ZvHzotlA7vZqI7NrRcwcpD8fFwK+GqVJcIVXiYayUvS6gtPdeOC2q+e67GoyZCoF9f
	hSPqFdD9j/YXtLqVJSb69HB2I+zAtXKc8zIPu/6YZKJI7ijfy0FCg8g3UDMAO5KTCBrmKV1TX0e
	L9e16ShwlqvU6bM793LSX9c4+T8dr2diLENUQqljdArEgzY/VraCrh0Yet+zFkGCMkS1hwU2keP
	U44UftcW9fjstu6LWKUbKG01R2unfv8JsVpGehKguknnsBrYwdEnHbOaeexT743X4+C7rJdhDRh
	FvVSXUZiYZDKRLIxPJDnvIRm9P2YslzX33929egAOGFh6O+BG
X-Google-Smtp-Source: AGHT+IGHBzdAI9dUE6ysz/8r6anScswCmoy1g2c4olQEXl5W/iwlZfbP6FnFwlrjC1SdSCMcjHcK1Q==
X-Received: by 2002:a17:90b:3ecb:b0:335:228c:6f24 with SMTP id 98e67ed59e1d1-33b5139a113mr33603607a91.25.1760480036520;
        Tue, 14 Oct 2025 15:13:56 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626e8f80sm16994538a91.22.2025.10.14.15.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:13:56 -0700 (PDT)
Message-ID: <68eecb24.170a0220.2b598c.89c3@mx.google.com>
Date: Tue, 14 Oct 2025 15:13:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3582553380068297212=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/6] monitor: Use PAST to refer to Periodic Advertising Sync Transfer
In-Reply-To: <20251014203400.453454-1-luiz.dentz@gmail.com>
References: <20251014203400.453454-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3582553380068297212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011519

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      19.82 seconds
BluezMake                     PASS      2686.46 seconds
MakeCheck                     PASS      20.51 seconds
MakeDistcheck                 PASS      183.32 seconds
CheckValgrind                 PASS      234.30 seconds
CheckSmatch                   WARNING   306.32 seconds
bluezmakeextell               PASS      127.19 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      908.52 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3837:52: warning: array of flexible structuresemulator/btdev.c:459:29: warning: Variable length array is used.emulator/bthost.c:699:28: warning: Variable length array is used.emulator/bthost.c:700:32: warning: Variable length array is used.emulator/bthost.c:917:28: warning: Variable length array is used.emulator/bthost.c:951:28: warning: Variable length array is used.emulator/bthost.c:952:32: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3837:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3582553380068297212==--
