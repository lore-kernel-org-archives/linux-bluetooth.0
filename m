Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40092FC26
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag8iM1WR"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78154d86758so24230285a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 22:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703572547; x=1704177347; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qkzZ1pNAKUVKphPsK2yv/veT3o42SjpFYjJ9irUG54k=;
        b=Ag8iM1WRulqZPjIcf2MooBcfVKwvyXAOIJ3osTAyBZnkIzCbyqEWfS4tUCbym74wNt
         fbclu81Wfn8rSRvIiXf68y2NX1gItuMzYUbranmtec0nPG7JHpdaqAovyQw547okPJMG
         X7gIr5YQhzGBo4d1G3LXKfFFbssPoe/qaNj69aCDkEDsCj+TDQy1v0UUYleHBfj2kaGh
         5xyq7eO5sEVl3fChgP60QKmhgEj3PzpwLXlULfPQBg8w8wfM9HDF1+zQZZXISYt3eV9R
         jcoIKWFxExVIlvBtSrk6e0K70K0gEg4gQybgoVBrGHm7MlFTBa+owzUCW55WQ9FjDN5H
         8E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703572547; x=1704177347;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkzZ1pNAKUVKphPsK2yv/veT3o42SjpFYjJ9irUG54k=;
        b=gL4PSt+tOlYzPZf7il2VJ02jPw/dVV+zCGkOMcWFvSPN119gEV6TNad7MBwimiJ1vI
         cgK8fg1NpaSpKijGmGNff0qv7N+MjG2sr0OwMzzNVx2WERgNczEhG/412psSNmRwnDQ2
         COCfYUj37RzGZ7/cFWbnBidTaAGcQ/Y66u7bpxBxjxazGneG2rgIMCC2bkshBjmtuL35
         cpkPIIE3thzPPu+sRPOUnutfism/xvz3W1g88FFZ6JRipLNC7c4PuU0jjUn8VRg0NvaN
         u1ILMNp1Y9u1GPSb+jYiELcpvvPsD3u3act6vKCkaQkK1JP1MwOTf6j0rLrBoi3Pser6
         i7HQ==
X-Gm-Message-State: AOJu0YzFETLJ1pEdn8CF5Gyrp00lN8y7UahjHjUV2CVEj7snWODJA7aH
	I90X0QaIjx7XXXxvYdRg+13Lzx1Ab/U=
X-Google-Smtp-Source: AGHT+IFS+dfwm2ITX7qNhOZXDTnEro1IbO5XrRQ/F2bepivCWvJuZNsEcNY+b8jEeQjG4HX61S5pIg==
X-Received: by 2002:a05:620a:12c1:b0:77e:fba3:4eff with SMTP id e1-20020a05620a12c100b0077efba34effmr8035533qkl.85.1703572547302;
        Mon, 25 Dec 2023 22:35:47 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.244])
        by smtp.gmail.com with ESMTPSA id i20-20020a05620a145400b0077fb8c08291sm4131265qkl.49.2023.12.25.22.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 22:35:47 -0800 (PST)
Message-ID: <658a7443.050a0220.dfc89.db9d@mx.google.com>
Date: Mon, 25 Dec 2023 22:35:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6268636305370541299=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: hci_sync: fix hogp device suspend bug
In-Reply-To: <20231226060818.2446327-1-clancy_shang@163.com>
References: <20231226060818.2446327-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6268636305370541299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812856

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.89 seconds
CheckAllWarning               PASS      30.38 seconds
CheckSparse                   PASS      35.87 seconds
CheckSmatch                   PASS      99.92 seconds
BuildKernel32                 PASS      27.69 seconds
TestRunnerSetup               PASS      431.83 seconds
TestRunner_l2cap-tester       PASS      24.93 seconds
TestRunner_iso-tester         PASS      47.13 seconds
TestRunner_bnep-tester        PASS      6.90 seconds
TestRunner_mgmt-tester        PASS      159.28 seconds
TestRunner_rfcomm-tester      PASS      10.89 seconds
TestRunner_sco-tester         PASS      14.29 seconds
TestRunner_ioctl-tester       PASS      11.97 seconds
TestRunner_mesh-tester        PASS      8.68 seconds
TestRunner_smp-tester         PASS      9.60 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      25.94 seconds



---
Regards,
Linux Bluetooth


--===============6268636305370541299==--
