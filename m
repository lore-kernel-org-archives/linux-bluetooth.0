Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE425B099
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185738; cv=none; b=WOVkQlN9xEb1ogbQ1ZDwt7dyHpLpdETkyI7HOYQHyxLvEUwHC+UQZTfmJLD14MgVAoeIW6pdqD/2Pip2LrJN2KL5Rpdh7ZecfKoqo8HI0n4mqfT6ukjz8aqUD92cO0bDkGrMArzlGYE3gtFCVyx+uyG6Tl7aOaI4r6PC4l9kZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185738; c=relaxed/simple;
	bh=86YerqUUnM8rkZ67QZYLllz5AaVdE07gVEybqZjqnHA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cHjH2UxiKnZvgLWWKoWmC7/0vrFz3KGEuQhi9dPFuufjYKMugtM0tk7IcEm883ItRUes5TYGxb5malec4LDdYznMOcnamnr4p/QxHnnd+Byt8XzE+mO15358UdPd4JLwyrp+g2TLSD9xywPvCQfYxRp0BmeGRkfl73FrXCgOZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXQq3xhg; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXQq3xhg"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c88cc025f54so1013415a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jul 2026 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783185736; x=1783790536; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86YerqUUnM8rkZ67QZYLllz5AaVdE07gVEybqZjqnHA=;
        b=LXQq3xhgNwoG2k4+P6f0aDD31DyjDMmMlgT1XuouUzclBPJ7lv1NA4+U35dggYZBQU
         Gpll0vIqesyLu71Eb6eWChrTls6eWASxzuTMM5By1M2OUlX8/9YL7HISakad2WNnUQPD
         qeYTzK3arraeq9nVKCB/v4NVyRabxVb+lTH6ZwSbMOMTfNybSjINO/PNkzcpD6v2JlTV
         ycL9ej+ui6ZCQ/jEdbDG+LsuRRxUl/k3Khb/lDbuzuJ7JRlS8aZF6AJ1PpFAK+QNcSVN
         EAbcCTGlbhl3/gjDcYRZ79nfL+YrJNNBeFYd9DTpDjeiDWgIpoFOe2oFv+wEbn3hjVsI
         cXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783185736; x=1783790536;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86YerqUUnM8rkZ67QZYLllz5AaVdE07gVEybqZjqnHA=;
        b=PSiZDoRWSY2a2AQGs0XMBWFXEJknsTAsAKnZgV4ihszqMT4vAkEAuW9BxctaJ6pKZO
         zd5v0fo/dLqnHjFieY1khK/xxvRWlgYyAtV1mhInDWKjggdE0mF0Ys+M1fFLEDvFDvMy
         ydcI0AT2JBXcz08z09VLTbIQcOYeLfKjc0JGZOdubyhfyKr1CsrJ24DSnB2TqXo9VIBK
         uSBaZzc6Ns/frrIK0R/ZkulCx2lnbXh1yYqyWtQu0TPt0tBzEst8sP24jY3XVpLiLddH
         gvykvZG98uUCdwVuSwP1IH0P4xC6hDNhoN+R7N87Twbt4mtU7iBnUzNl4YpoEameBt+m
         6n6Q==
X-Gm-Message-State: AOJu0YzTtIiTHxaFNGKsP0ZvEf00L0DiE2D0jMgSvWKAoTG4/4o8uS16
	1Mf/4Q9lerzYpHVJN/6Eeeh8ytXDoyrH4gv2GnZ7vAJv79J3YhvwionjEVta9g==
X-Gm-Gg: AfdE7ckFtsqqooftGu9vIOmYQJreLITpeFlYDH9M+mooXM7Iu2/xtEFmBaIzyddX86v
	D7zb/+7mPvUyuI+LWO789lGbr+7+mREyzWJenfEowYRIQfWO5Irjo+SXpSviqGgc0T5EecPcfct
	c7XaZr0yILLPzpp8GwDAoHjs2taJGvWivxFQAQNpvzPlnXTdf3sqFy5WlOb50FXwuZQNXTMr+Sc
	20ms3J0b/J/MsF8YKYqB+VQ6sWfamtPrrS59SxvZAwKQ6yQbBiIgYBJE6Exh2WnoDPS0Ak7PVlZ
	nTufbVwLWoKMV5IX1faHqinhHRtOWFwJPJP44xZLbB5r5y2yG4+IKhimlj6kE71XZjwMKSA9AHW
	p2SA7FZH5tD8PRK7jON1vjEYj8JLk2gTAdGUer2V0SQWvhNm4N8R56x73577SzexGwf6y9YG9ep
	k+ERDW+qh7nIyenVzxyGE1xKZ/Tse3UqHc
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:fb9d with SMTP id adf61e73a8af0-3c03e51e3a9mr4158000637.49.1783185736458;
        Sat, 04 Jul 2026 10:22:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd221bsm35103687eec.22.2026.07.04.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 10:22:15 -0700 (PDT)
Message-ID: <6a494147.cbc3f03a.3be201.610f@mx.google.com>
Date: Sat, 04 Jul 2026 10:22:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1649421903414614795=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,221722] New: Blanket HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for all MediaTek chips breaks HFP mSBC microphone on MT7925 (0489:e111)
In-Reply-To: <bug-221722-62941@https.bugzilla.kernel.org/>
References: <bug-221722-62941@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1649421903414614795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 4
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1649421903414614795==--
