Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525615383
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257768; cv=none; b=sJXCIS25IAOQZLOvZ5YdZ3WNxokfEw2ef+Dv1L/IkEmIS4xOuslaRoRSyH2MYYq3LNNtXPqgP+lc2G1zsj67R7xx/UMARIaxKaLct5xC3gzPkvSCZv/RWPBWYWvT1t+bF0gQiU652+BXwPBYS9U4bGULcpxP7ONr8CVJHkCMwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257768; c=relaxed/simple;
	bh=J+2of9A8/47rsHtqs+JxGvRNTKHNo5zUYuMebOevNZw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rm4O4XNJWG1zvLhQ6iTewOfAFrQWc/0DGtcSrR6+E3mh38wU27Fo0IedrKUBlCgDAFnv5HagpZlyEVpNMI9QpatBO1SfaO4oXmYDWv8bGXl7VluaPmFwqNh/FPoFVl0zorwotRu4EUMoTzBTeL39oR8qOyh1nWy6oZptzxEIps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jay5wzs1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jay5wzs1"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fad79433bbso23992986d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752257766; x=1752862566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3QVTn/RKs4dKtEyfp514Je1qGqweD4CeSlLs3z7nOeU=;
        b=jay5wzs1BDAwjYhopl6MN9yeURIy069A5LuZ9oMGk1in6CccChWkln8w8+NEkRLEKD
         QJ2H7LPRwBtEemER51fzQyKJtV480NDf649mpIq28KNky4YgUiijKE6m9QNOITmdHv+K
         M7k0JeNi7ZK9HFBXHofDIeyseOrWNvjYKGmabtg2FJgOFR1WiNlXmORfzLRRTSb1iIeA
         HZ1Xgxynt7bKVMFOVj9GFZCoSJ7hB8OcB0jPtCMxJ0scjcq2lX7ljchoDGGLAszm8KKv
         jCEZQsR9qcqvZWq7dKmUfolJPEJWgUWGAKgtBdYQqgGPS2MKct/ZPG7f13oSZxg7fQKV
         EN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257766; x=1752862566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QVTn/RKs4dKtEyfp514Je1qGqweD4CeSlLs3z7nOeU=;
        b=bfXE9oLY+PCK+JCN5Prift5h1yIM3Wa6MirCnxJk3uWTOiv3pE0EokFZwSMxlXHMzM
         qRfZgGy3TnF/WGFDfSE/CG+DsYGPCG62JapMIuDu2k8UKygGcX10BUU4BO9317jmZxw+
         VrsobGYB/tUGqY+YtPbtBLJSjGwMWLOmMkmK3tTPMmXqlFF1EvQsOciou6ep5gk00sbR
         yzHR/u2pkH7wxX0Ju5OXPsk0learHAvvXeVPgX01tkDu0Erv1FA1lDhyJJlCBiP9ce/m
         VDo0kEB/lHtoVs5ilhDDsKw/7hWEo7LvY2MkNg/zupc+rop4s9ZqPxMPDfowLktzjtny
         uNlg==
X-Gm-Message-State: AOJu0YzAcGvMXyibXVIZHHDaBT1ovlSq31kw1AslaE83xSwGqcjUhIzk
	D+WY6JFiImHsHnIpsSJcU+wGq8JPP3nxh6Lgc2WA3oqFm7caxAJRxdaOJd9wHw==
X-Gm-Gg: ASbGncu/KCmQ8XEEImucdQKJmsNigmPPZPAKqsSKvhYVIC7frpQNZ5p+iNuv0eniPM7
	fTQipaSYKSo5+rNZIGR1kXC6HjSSN1LFJxlE0IaqcFPhMvt5SAml2ewljN3fbZ1uE81YETDETCj
	NUfebB1YfbCTs9F6XYTekUqtmYlLeuz++oACVUkiad1ElblriEQauEBRLkrcJ+hBItLNJBBlsU2
	8s1QGJ5h/XpG0sr9QtvjkogQK5c5BCyl1rSAZiwRxRwqRzuv+Glv2xR3Sft/EReTQNG1r/4Cpym
	Y0pyF6ZfroUV+uVT/PTv2FDk0EQ+M0l83+fMHJmjUPwddaw2lDpNidLqUi17uUYv53TtXkGGY9c
	9sw+Z4anW8cryrAIG/ClreEUkIWCu
X-Google-Smtp-Source: AGHT+IHaGugPCzAzdpwbDWEZsu2h8XhJoHVKHGgmxTqzD2YGyxO21nH6hIrE1PsthIacmGpC6Ruqcg==
X-Received: by 2002:a05:6214:1d2a:b0:6ff:16da:af20 with SMTP id 6a1803df08f44-704a40f3d12mr63795886d6.14.1752257765689;
        Fri, 11 Jul 2025 11:16:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.241.22.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b49b3sm22320796d6.30.2025.07.11.11.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 11:16:05 -0700 (PDT)
Message-ID: <687154e5.050a0220.132d0.a713@mx.google.com>
Date: Fri, 11 Jul 2025 11:16:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7289859524322000220=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: Initial support for GATT Proxy Service
In-Reply-To: <20250711175842.28860-2-ceggers@arri.de>
References: <20250711175842.28860-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7289859524322000220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

.git/rebase-apply/patch:395: trailing whitespace.
								
.git/rebase-apply/patch:395: new blank line at EOF.
+
error: patch failed: mesh/net.c:192
error: mesh/net.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7289859524322000220==--
