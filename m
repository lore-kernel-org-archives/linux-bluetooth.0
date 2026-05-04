Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2523090C6
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925678; cv=none; b=CZxo7PsoRj1gSdn85Grm4fsNdFm+y77o3yGHm11ommRS68Sv0O7U3rhQKcpAfQcdBWM27VGm6ZZtHfzEJrwgIifLwqDWeBRFjDVHzCdmKnwjlBFgpWtCkwv5XSsYfs+00Dy78zJ6/4nGbg1PtY9UQAu24QV7JHGtQGsnhW5x27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925678; c=relaxed/simple;
	bh=+rRR7cwNrEdMcANF37mHW8Svn7ld97Gjds2LjisBt30=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E/gdF/OLOFYM1vjoQEX7TP8w4vHZhRFHPv6CT2nS5I1RKEqvjC13d1dn7TImYuEER1sfb7L/1DdMeyKOyDzoZSdsfpyNAFlhy/ngFdmhEiHq+qRJuKhp+1dL5hx2e7naWvFgLYJnTLi7Xjb7vku1hrQgLWwsfmiqYlX5jPlEsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdJxLmsK; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdJxLmsK"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c8ccc7755so6433903c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777925675; x=1778530475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SlJyThPvB9165j5+wl2VGFNIjwcTI6pmeZQVPKF14+c=;
        b=rdJxLmsK6yyYJkuOw2jdXNo5wRJPDy27r3RrWzUHvHWXEVBdH5rHAqGBrE3HSEzi3A
         wiiRdXS9SaxGcMfIA19CR8ycofyzZXQCtP5V++N71BeeqqvnYE5/pP9OK3wfkHzb1/JY
         5jX5WgDLJl0iBucYcx8gX0ZBQmvStExeFFEF1Gf2NW49nCfAxhR8bwQv5Vho9GJrBceA
         3ccQNkfL2H72JT2JG8I4en6VNFuqAngP0GxT8TFXfRVSjT/S5/97b+wz2Wxbg3Nmeck1
         RiNs1bHR9cw2oIfYgzM+OJIu6T/STy3RlE798EkDJDLmBC9AJtOcANGxgNR+gXYfHQNp
         1now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925675; x=1778530475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlJyThPvB9165j5+wl2VGFNIjwcTI6pmeZQVPKF14+c=;
        b=eF5vKfsw7TFARs1TvnMyiJaDVLDmXxAIYgaVfGeVdNXNN4IQe6N49DSyz2o5gumXLH
         F9YwewsSfOLPNXjgbDaRkXo/iPg6GFfwNlz3LJN906AteAls/LMt0Yx1JbmDmSiI1dJe
         546AFl2eCOyqLEjYMcRfgqSCk8PaW9h58T/5cG8AFx12QCjGdDPfdKKlbnrs9VItRkv/
         ZF1vppVR4O48Rv7GDhuxiA/lx/6F8FK6D9yPstdfq5R3IaQMU57Lk9dnnHxKKf1JCb8/
         8x8wSyvB0dFl1QGDrw10s5fxnXPAdDQmsJ4VPwmk6fYBwSDXTljsA75Ce2Rxq8trj7YP
         t0hA==
X-Gm-Message-State: AOJu0Yw/zggdIK1jyBiJQIoAUjZAlC5L+OZYZjIM6BqK6QPfb1XucAv9
	loEAR5E18UNUufBPa7iTW9gtf4e81f/SzlOzwhl+QYdBtuHPxaCbkQBPzuB3+Q==
X-Gm-Gg: AeBDieuH8Mm6a1vCdQvpP+KI+8oSJAwbw3VrsWz8c/irYXTIwoW99pZnjOa/milWlFe
	GLTkPLNiMb9pBCjai7RjfVS4kXZDVg6dcNuW0SdbdcQXzNdWYY+ixArIimAMXrsl9Obwx2asbcm
	ods/u+qm+i93BS/E9PuJVxLE6F75+R9xSIgEhGLNxqLqaNsnCT2sbpiHa+l3EyvAWOX8plAM3i5
	b6oDxS6z1VUFubsStNfWgBUdYLVvBg9JSGq9fqmWlqewocc6k+IwJq06kNSc3coxv8XSqgLlDHv
	dRU2hmCD9CG+0nAJtb8xE23k9SjZJcYbK0LLqAYuJ5NPVJb+uuf5ARuizTYi/6ZQP5UMqEqVNP2
	EPLV3hOztBn3hWkydzmlIjIq306VI30iKZa7NOMGXKOQ9GtQLKQ16C0euXBOV7paCD+jqAMmAqy
	gGkte1Wirp8yAfUDhQbpj/vOLLeKfGCLD155dlHgFt
X-Received: by 2002:a05:7022:68a1:b0:128:d23d:81a2 with SMTP id a92af1059eb24-12dfd8315edmr6027138c88.29.1777925674502;
        Mon, 04 May 2026 13:14:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.51.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df845e220sm19129832c88.15.2026.05.04.13.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:14:33 -0700 (PDT)
Message-ID: <69f8fe29.050a0220.18b31f.7d1c@mx.google.com>
Date: Mon, 04 May 2026 13:14:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4190530160794335515=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, admin@fluentlogic.org
Subject: RE: [v3] sdp: fix overflow in sdp_extract_seqtype()
In-Reply-To: <6vsGD_2xyWDIrUZkN1idLdLKf9ChYJJOMyOm2FglmFna_5KyDCgLG6PIsHrMSN5YJv0hAN0APdkK0kZq_5k_qKP_wqILFVxMpmkhb58GyVU=@fluentlogic.org>
References: <6vsGD_2xyWDIrUZkN1idLdLKf9ChYJJOMyOm2FglmFna_5KyDCgLG6PIsHrMSN5YJv0hAN0APdkK0kZq_5k_qKP_wqILFVxMpmkhb58GyVU=@fluentlogic.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4190530160794335515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089467

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      20.65 seconds
BluezMake                     PASS      677.29 seconds
MakeCheck                     PASS      0.92 seconds
MakeDistcheck                 PASS      250.32 seconds
CheckValgrind                 PASS      224.55 seconds
CheckSmatch                   PASS      355.79 seconds
bluezmakeextell               PASS      184.80 seconds
IncrementalBuild              PASS      669.95 seconds
ScanBuild                     PASS      1033.40 seconds



https://github.com/bluez/bluez/pull/2094

---
Regards,
Linux Bluetooth


--===============4190530160794335515==--
