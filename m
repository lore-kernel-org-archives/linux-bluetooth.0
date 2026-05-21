Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F82E7F38
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350973; cv=none; b=YUDt7Q8fuXCNfsMuVbq8mfy1eniYwC8jMVEGczBnMRRl2fTEr2hkg1JeunA5xSNYKjG2Zj71x5QKjNAN9b/yfRL3R/t51xQbsoANuLxzdKZFl93xIT+4i23TkUy+HUYtGorapM/0+YXyYLt4gem1IeSLhphUSDCskVDdhN3hfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350973; c=relaxed/simple;
	bh=+tzLslo8MQxYd0ByWRGD9ZY4yoVFxFoEG6RUZfn9djA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gEW2QaPLunWKuBnfWZiXYxf2rSXsb3jbJbrgexPIHcRuKMDxWT7D2493R4vpyCJ2vM9uHUobo/IRXfUc9/bGetxvvUym3v+ek8na1KjgaGm8o7dJhzsNpWPFMhv8KewesSWnVchGU6MC+LiMO4Spediuehfe2+D8L07bmuu/wnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxr0Rt9n; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxr0Rt9n"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-911dfc86903so686586385a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350968; x=1779955768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1UOehAoJKGtkjaXuQU2uQHllv2mNi2YjZefEwDE8lE=;
        b=cxr0Rt9nq9OxRrxxWdnCKOb4iHyE681KpWBTl3nEpdgn6Ebv69O8UGvZaDHtKXbniw
         vp0b5PcjwQ1+8CFh79Y44IAfXOq9+FsVDGLBAG+l4aaR+g9+ko59XYDW3460VIk6g6V+
         w/8fNLKhHNqQ744rnFvwtGEyeINzRwYszcmPM9XbP4DTf72eWI+frDKLwco4VMJyP5V3
         ig3wOFf+KBOs65D0f4CIqUTTbv0JRXPaEnjP8XuofcizzGPqfsn+QfspV7kNy8pQTiyk
         yePNy7kYcbPy5kyxNFU6iENi4lVI6EB4GUIe6Df+TLO3duBAFkQdkYntZRomWjdtA1O+
         N8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350968; x=1779955768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1UOehAoJKGtkjaXuQU2uQHllv2mNi2YjZefEwDE8lE=;
        b=RyoFqUWDtvwBiQB/ZbUWJCERfISZpm+YZ+R+7D98nbD3A7DCgHiCJqEAUFzBdyZNHs
         xTMaoShStN3FTsnFU/CvbHgunJU+HXW2JeUoh8W33uvpDFdcjC1KvyFuPw+PCWAggVgI
         qRynOoiQs5XNXZitY7S7oT//63wekgcmfHc0yO1lVGGmkHAbY5O1M6LYjMhSGyE36fJm
         eZQO7jtoPwseMIbc8a1nJM0kezjg0ThdM2cxqrfbpb1o0yes0gNvHN/XmepBlVcDwPg1
         vkSEUU6YFh7g+ne+VbB3Th5xBRyMm68jmEiDNsJhKGKa3ra7OzxwqSWWDAAQD75iYjC+
         SZ6Q==
X-Gm-Message-State: AOJu0YzjjDgUJfeUYIJEzOmdUb4Ih8Kj7seuMSZ6isjdOmu0MY4YvDzo
	MTuIARn3MYV+pkvGHakatzBzlc0URNP/RZwOSDoiT2J27dF7jqhijzG0/oL5Cw==
X-Gm-Gg: Acq92OE8rNk0F9kIpi2JX5SWHldbS2eQ8qBmdcEpZN3gmZNLZtD9CKga1LFdW0VdfL3
	mg0BAf2MndvIlZQn3uvhY8cvIbMa5sulWy/Wpz+ulT4OptC7l60BNQVhMinD7oLM9pPrvENNanh
	G1xp4QkUYVpHQVYNuJgh9GDaERH885xxU/6VqHmjCsb+LGj/pvsCRutzK4++j1Nea8HAJ8wGgVy
	PdW3R9swwvLHewvS9Y2U7bTvNTBexx9nrbQZZ4JiD8Y0PnIzPCpb1tWgDUzUePFBbRvR8Y+VGYf
	jUjJokP2DY4bXdvhCN6g//EsNL9Wozxjt7QW44uK39wq+5Y+yPCMWoA7i8st+eOKnzDrryW+nt2
	NGWTfNTSU9yTSLMiM3fSeg59a/T5yIVyGSOdAJ3n258D1SjFkgUe3SF2EeiyxyFiiSNYhwlOgu5
	qFvuY/iRM9NQbpT3ShZAMhGGtqqaqOf1hp4N5MsEc=
X-Received: by 2002:a05:620a:4453:b0:910:b13f:ac81 with SMTP id af79cd13be357-914a2d19ad9mr231018685a.52.1779350968265;
        Thu, 21 May 2026 01:09:28 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.239.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abcc8884sm26725985a.45.2026.05.21.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:09:27 -0700 (PDT)
Message-ID: <6a0ebdb7.79e210f8.2a19cd.f49f@mx.google.com>
Date: Thu, 21 May 2026 01:09:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8212510702821052330=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuaz@qti.qualcomm.com
Subject: RE: [v3] Bluetooth: btusb: Allow firmware re-download when version matches
In-Reply-To: <20260521052547.2862803-1-shuaz@qti.qualcomm.com>
References: <20260521052547.2862803-1-shuaz@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8212510702821052330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098452

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.12 seconds
CheckAllWarning               PASS      28.54 seconds
CheckSparse                   PASS      27.57 seconds
BuildKernel32                 PASS      25.98 seconds
TestRunnerSetup               PASS      565.39 seconds
IncrementalBuild              PASS      24.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btusb: Allow firmware re-download when version matches

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
34: B1 Line exceeds max length (84>80): "  https://lore.kernel.org/all/20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com/"
40: B1 Line exceeds max length (84>80): "  https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com/"


https://github.com/bluez/bluetooth-next/pull/227

---
Regards,
Linux Bluetooth


--===============8212510702821052330==--
