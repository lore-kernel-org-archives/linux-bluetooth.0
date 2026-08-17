Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2A3B47FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964059; cv=none; b=WdI4NVRFOea/dCBt99UlZ9S7wJCCjooHNdO4nEUcihPDuDNgjNSs9LRPPeWxGFd2Tt0yEB0ajc3G54SGB6YyvAffVKC6iS16a6ZAyQP+ao0cd0hVuJ9yYMPR9ouAKuczemjiwfkf+cK82vdzMVSVgc+OLNH0UqqCBwEFzDiO8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964059; c=relaxed/simple;
	bh=9LwfgxqYBw/1ur8vVlw4BkPuk6bqsMJy3rRApEu2Klk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bTIndJwjgg58yIkGga8Oa/skTc7JHhGpHNgpnRs/06I0+6AVzuacDdrZUiCIi6OIKhCrh07jjRjVmbvGcyvPCiX3jO1OMJa12KT/B1w3lx/3+vZLTLKIltyIgl4xhv9Ite8w/ne1hCO2q3Ssx5gzymV/WrUEZWu+g+3qVCFSuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFMkcRDq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFMkcRDq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so2159287a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786964053; x=1787568853; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OENRjIgDvbsCi5MYlp8YMmFgMN/RoU3INDZSdngQ19o=;
        b=VFMkcRDqfYhuME0HvWgDKo7rvzh4huEqiQqZ0oKEH97DTNU1PlvWo5rTwQd0br5RV2
         GFQySCDms6LBeJSEXAkuX5/SrVs85wUjW7AEqSeGcF+r4z+OhfoKUVtX2HqNjWcXUgxb
         9gEHxQ4Rbm892YRWbP2KPMS6qFWQFqTG1mFLrNCZmKyLjoOXAD20Mzi9Lk6GvW9DkEZO
         o/HgZZfrF+tf0mHUF/ZPzPj68GtuQ71CaC49BiDj5U6Fc1RLIJwaAOQxh+NdJoMK4si+
         SLZfqNaYDpCgy8bz9xSnLG0ELersQJoLPPMbnPG5Ln9NJnFnqqJMvx1GjvQmGe+qF5ul
         zAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964053; x=1787568853;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OENRjIgDvbsCi5MYlp8YMmFgMN/RoU3INDZSdngQ19o=;
        b=rctgteLDrgTjPX/qSwEpBDX6fjUDLh/9cLwE5Vd8Xz6da5jZpRhSNrpiArhD9S2NNP
         7y9GPhZYPtZ9nbrwXHG9ViclRdzRAUUWe6uvZw0EnJKOiCoVzGpRWFCWi47xGbcD01SJ
         lCo/KHUkvLaFPwiP4nxpR8auYeVAYadkmcysUgdgUP0pMfEdV+qlLWxRsLquJKWWATRp
         68j7X3XOLeAqp6vU/9+8L07zboYgL1PscW8UhAvjsOyFJDeLr7pCk8zVkMuD58kaMBry
         C7KqjYrhUfentE3SJ4AN6vQ3SyuHR68rEw9d31gWh7H0qZqsqeu3u/IVLN1gVgqgjSzY
         Pq2A==
X-Gm-Message-State: AOJu0YzKQB0f640v2SDKPIa2MTJU9RhkivVq6rVTXCCP6C4e+qeyCVT6
	V9ayZZacacdOEdZhRF8YRk2lLu8vDxoALLMuz9zPVQ3FWDUFytYknciC9gGE7A==
X-Gm-Gg: AR+sD12/A0jKlnDEgwrWrLP4XT+JXgXpe8IzKLETHwaeW/OYXa6YoOKqx/8kLu3qaoZ
	FBCD4qgcCtPeHYx+lFIq30kmAdMRPb2erwNO/fRD9U7sMlLnPb+0EeO73oxuyLwp6sxNZSMC3v6
	xylSMZ2YY2laTiT81tNtlTYYXykgG2JDH1CHUqqDu2eZV/td1g1H+z7kPzzT55tMdAwTmRQrt7O
	4juHUeiPTJBSmwzKCesi8jTPSN5kndPGhTWPrFJXgtL6wxfMwEPnAzmwQRp+G7YXgNqw/VrlRKC
	pq1jqp9uaTIW2VaowFdS/oehwGemBWBm2ZnG4/rvgPr67GN/lr+EyiPqdPsoNifQT38TOZNeeP0
	xPr5XxTYzi5E11ba34lbef7B39NqvyyiZPNOe0nhTwQqvBuEN2PJobHbcfecDf5SWmfshXOt+lF
	WV2lkf6W3jzwm4KzFCh7YnKlwSRU2AuI6AsfdzUks+HTfsFcamj+zUZ9FpTaASCwGHNk8=
X-Received: by 2002:a17:90b:4b01:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-3933b714d4dmr22043638a91.2.1786964053184;
        Mon, 17 Aug 2026 03:54:13 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14153044411sm5042973c88.1.2026.08.17.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:54:12 -0700 (PDT)
Message-ID: <6a82e854.c5504292.7202b.44d5@mx.google.com>
Date: Mon, 17 Aug 2026 03:54:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4618087948046009948=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] avrcp: Fix media/folder name not being set
In-Reply-To: <20260817082315.4090729-1-hadess@hadess.net>
References: <20260817082315.4090729-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4618087948046009948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147094

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      20.41 seconds
BluezMake                     PASS      609.28 seconds
MakeCheck                     PASS      3.23 seconds
MakeDistcheck                 PASS      162.52 seconds
CheckValgrind                 PASS      162.28 seconds
CheckSmatch                   PASS      314.03 seconds
bluezmakeextell               PASS      104.43 seconds
IncrementalBuild              PASS      621.28 seconds
ScanBuild                     PASS      988.08 seconds



https://github.com/bluez/bluez/pull/2408

---
Regards,
Linux Bluetooth


--===============4618087948046009948==--
