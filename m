Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F981922C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355591; cv=none; b=mNU0Qmd5rJ0yxYxpVhqyzHBa2sMi0yJzYphCrp5qtiWoSwCnFXwcEJfLb79AUsUDoIz4+rGXw6nbb2EebNnNwBzFz6FIFjmfUgTdX2Ss9AMFNjMJOuDFYtL5PKJBsxhF+6LlKFLbrnG0/D+zv/mIfB2nb6GN+0vT/fmE2a+xhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355591; c=relaxed/simple;
	bh=0psmBsRqEpgVI0il5lywZkxg7bfBkSuDY8auz+nidMk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LCyiqFIk2ymtlgpR+QdnMCZWLVWaPDVmjJwGqTTynxWR1GnL9wiPjNnC8KbdhXrlLmvDBcqjQQDY4FFZ8JIjIOZAS6CKrIYXRwS/FT2osqmT9jv1Nt6FgFtQFHLt2VVfkG877LulS2iMX5wEew4xmQkMGqi/TEflDAmWplUX7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW9UFwlA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW9UFwlA"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80ba70d19ddso578751241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718355589; x=1718960389; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+25I59+K1iTnlhrY+GDlHUOOn95XR1AOVLKJQswQxUI=;
        b=dW9UFwlA3WS6Iv341NbTJmGckKTwKmxdkDFf2lABb6mO9N5+2m8+f/pis+l2QjSUQr
         0ezOTFdYvdxg0ecaDGwBTr2JWCiIk/4CqbzjhraD86zk3+Rgz7p8kiP9YYcoJVjxb3G8
         awQWr3u6aUC8M5T9IADeVdLr78tTTh9MVal6Mx/mnIXP81q4O+1/9SKtVfRDSnieMhDl
         Wf5+jIuNe39UTXRu1/PMltTLDRIRseWPVU6OgOfOTvnAgfCzIQVP7NTdMdeLaEwtBMcT
         OATzgvAwuhVzY5yiBEIkWLbwzyr+IE6Lj8zOE3ZTtbdxPuzfZumtf8ohwcy68rB+KfcZ
         /K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718355589; x=1718960389;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+25I59+K1iTnlhrY+GDlHUOOn95XR1AOVLKJQswQxUI=;
        b=ffX1xCWcT2rlN/Yv+co9SkEWhD9YtjqoUWpDJXbGnoD4CZy9Ll5wm1+GlmQODA88sH
         JeY6sxm3XJJWfVYjPsN9cTr14hTlZrbUIr4YRJryVVkCNhfN8lAn9fAWmlfiKnaM1Kgf
         +sDlKNps+qCDYtMz6k/aecKv7X1Ast8jXQtdY4xKERTCMEptI91ksYKexYmCdljqPXs0
         2XOlmn9xvVWtpz7ltSJOFQfWsW1YYEWI1NN+Hy2oGVjpjYguq65DpYNWIapBnmTKP3as
         tM2kRFuhnSTKVkiTLlxD3moghn6byDmOz+agw8aAYln7gWB8p9nrmCANB1vQGehlAVlY
         IQMw==
X-Gm-Message-State: AOJu0YxFSkVhgx1d7+yoYaQk3k5UzJOUml7BGlwGOFS86SoXy88dN5jw
	v5aJB3pjEdqaZOcHfQhm4G/N8n9a7ufVDDCT2+5EpT9gqaEbh7kywvJ3Cw==
X-Google-Smtp-Source: AGHT+IE/psFw+0/gaXuoFhxUQdpaYm/gXzK8sZ1isZEAbu5rf0mkj4rk+V1Iv8YgVtE1WaAF8pe+vg==
X-Received: by 2002:a05:6102:24a7:b0:48d:89e2:8ff6 with SMTP id ada2fe7eead31-48dae3b40b9mr1929738137.23.1718355588926;
        Fri, 14 Jun 2024 01:59:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.36.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc03812sm126689185a.93.2024.06.14.01.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:59:48 -0700 (PDT)
Message-ID: <666c0684.050a0220.2ef71.4d2e@mx.google.com>
Date: Fri, 14 Jun 2024 01:59:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8888619027895229138=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
In-Reply-To: <20240614082338.6530-1-neeraj.sanjaykale@nxp.com>
References: <20240614082338.6530-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8888619027895229138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861976

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      1.37 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      30.56 seconds
CheckAllWarning               PASS      32.60 seconds
CheckSparse                   PASS      40.97 seconds
CheckSmatch                   PASS      106.04 seconds
BuildKernel32                 PASS      29.33 seconds
TestRunnerSetup               PASS      536.95 seconds
TestRunner_l2cap-tester       PASS      18.54 seconds
TestRunner_iso-tester         PASS      30.92 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      108.98 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      7.98 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      7.30 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PASS      28.28 seconds



---
Regards,
Linux Bluetooth


--===============8888619027895229138==--
