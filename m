Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40D15AC7
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jan 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBdxol3b"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ef33e68dso62697645ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221923; x=1704826723; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8NGIghOuUMd77E3R9NCLRLhRuMIUkoSF6f1lvoeMJlE=;
        b=iBdxol3bgBm30ERtTIam60vXhTQrS3aenaFb2yo1IQVrDWhDw4b15dT+kBkbluWbGH
         LBVnftY2Z05iJacr0vZZfAdJtEJv0LTS7K3Bk3hTIxvG0BpHZ7sGXk8X9bpPDMO07eZM
         7RA7XCkoN309ullxrZ1v58IYKuU5dM8Qfkhh44RVU3bEOUMYsxVWjV6i2guU8rGvJ8i2
         W9qi6oe4rJzjYeu1pmXp7bSqim5MS8rZ+fy+NuRdBvyHu+ipKuvha87EWDNNcdxXI21W
         /ryEURBMGvmYZVQKR2B3uh+PueA2yvx45wcLcohhNABp0ED7EtpyCfEQ75y9zbMxIXnl
         rIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221923; x=1704826723;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NGIghOuUMd77E3R9NCLRLhRuMIUkoSF6f1lvoeMJlE=;
        b=nIj1JQSR0tQYirCKJ59n62sKPcR9dUEM9BX7SUrHHvxefc2WM5XOWP4E7BZXR1nhW9
         htaqdM/pFUMiETK365B8hBJhvk3hbXEU/YHJeLbkhXg8HzEXNCWsRGdGHMkLr+esuv2u
         DN2NvSknZoLL3NobUVSnEbBE04vUCYlp4CcqKYZDjI/T69R00fnnC6rFzV78y1tq5DL/
         oM047Uf3crMo4gsxgzas276FNjbuMp+XpD6NIGwLZZ8rR3FCJa8ZLyRSEx8t7zkiQlOs
         DsVrJfhNh+siCk45Ho1g89ffwqx33IxezN9A1o2uFsXo2ndd8Iy5i68j0bYPkkuvekiZ
         cjGw==
X-Gm-Message-State: AOJu0Yw/qVQqo0y9DVeO+MfwwAGiJU3UEs1QCRk1kKMDsik8QqcGrsUl
	v6M/sl72aHvYfzXgQ1f3fgKEYSoVYAE=
X-Google-Smtp-Source: AGHT+IH0YwjXX7/qV6bwgqsGQijX3rUSY8bkyE8MXM4r37KAvcevSf34heX8GHWNzJ+QwlFLQbsxSw==
X-Received: by 2002:a17:903:2312:b0:1d4:c139:782b with SMTP id d18-20020a170903231200b001d4c139782bmr2466422plh.1.1704221922759;
        Tue, 02 Jan 2024 10:58:42 -0800 (PST)
Received: from [172.17.0.2] ([13.86.227.246])
        by smtp.gmail.com with ESMTPSA id p19-20020a170903249300b001d4b685f82fsm4374429plw.165.2024.01.02.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:58:42 -0800 (PST)
Message-ID: <65945ce2.170a0220.4b425.7dea@mx.google.com>
Date: Tue, 02 Jan 2024 10:58:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1979067447757266441=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Power off HCI devices before rfkilling them
In-Reply-To: <20240102181946.57288-2-verdre@v0yd.nl>
References: <20240102181946.57288-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1979067447757266441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813896

---Test result---

Test Summary:
CheckPatch                    PASS      2.26 seconds
GitLint                       PASS      0.81 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.77 seconds
CheckAllWarning               PASS      30.72 seconds
CheckSparse                   PASS      36.61 seconds
CheckSmatch                   PASS      99.26 seconds
BuildKernel32                 PASS      27.03 seconds
TestRunnerSetup               PASS      435.16 seconds
TestRunner_l2cap-tester       PASS      23.04 seconds
TestRunner_iso-tester         PASS      45.75 seconds
TestRunner_bnep-tester        PASS      7.02 seconds
TestRunner_mgmt-tester        PASS      163.90 seconds
TestRunner_rfcomm-tester      PASS      10.87 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      12.20 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.76 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      60.77 seconds



---
Regards,
Linux Bluetooth


--===============1979067447757266441==--
