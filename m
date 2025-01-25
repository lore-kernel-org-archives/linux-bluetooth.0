Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37093800
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737830031; cv=none; b=TSxFTLYoPFg33lnDBHWYQPRBS2SDG/hs8q7+QHP7ifRNQl7uxOufgENT9cht3/KDE8i11JvDqwyFqoxK6OxDbNTYcZRNa0TusFiVDZJCqSb3WF8IZoaOlR8sOP5C0Goux04szzhb3D7rzAmlL2xvNFAgUxxP47xYSYwfMbl0Hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737830031; c=relaxed/simple;
	bh=62t2mIlk4G1Ud0Mm4spnT6w65L2Ombcu5Sb/C4TaGoI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tmNzIhuMbkYmRw6+dXbZvXbyA0rU4wKXIKtzsIx9AxkFnZ7ioZtRyB8KXxNr4IH+ImIyfSL/tFRQp6lsgGtjyZHLV4MVahnndxRlGbKQVx9SUlMBNEZm7GzvEHSV6TzYof+goseG41ZnOBjIvt0SOTfBc3s6RE8SfKtcZt0C7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf0MWDKu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf0MWDKu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b662090so61068625ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2025 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737830029; x=1738434829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo2Vov1bFoA+NGIjYcjdMVEOLmcb6g+V1nK3YCBZEz4=;
        b=kf0MWDKux05IzsukwGF3QJq8HRARFhTdJ7NNMBXFL80yo4fqZweIEs2Qb2O6K7r8yT
         tN2hTR1adtGcTAXoOY5Jlsq5nJRgT+2syeDM90RvWfkapcFF8AuqMQzeR/ONY94BsWf9
         4eorFOobPO8I/Kq5oBDeJAweD/w/xh4wVoejtGJlGa4BOMUUOilwL2g77Q5SXt4FqxfI
         UuOfaGdSI8KO/RZeRgAMwsQi9YpTxtp5nj9SM+BiFke0WunSonWGUZm4gB6DH9rL6b9b
         VCf6J+CCQ54Dls9/yJtzJ8Z0Z0lDySsZsE1YlCGy2VaRU0TZ1mUrahXaAKDEur+aA8UY
         MfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737830029; x=1738434829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo2Vov1bFoA+NGIjYcjdMVEOLmcb6g+V1nK3YCBZEz4=;
        b=cnNxTZlAsdmpKd6lXj9y7XIw1S55i8ogMqCF0IjYslsOeIoCkY6RdauLjqB/EM/K15
         SwIIfkuhrcDJvvBFsD6ptC7p409IBGe2NdUV0xBdRb30ePGHRHTQ/AZFJpankRFer7F7
         LEcqbtmtR9AFdHnf5kMBYptVIhy5hk2sTVuSEHToos9xzosvdd4wIj9dJDR6WlxcAHl0
         7zWA8fRekm6rz5rV05duF9iqWVGKk5MRGQ1ffVlddF9wMuDBVm1K9ODFCtzC0CApX4Z0
         llzoWwODnSiW2Yu8jws0ZLZZueGUcNMJX1KOSbXNBN7p+3URbKf2/V6ek0U5VynbRhc+
         EtOg==
X-Gm-Message-State: AOJu0YyT9gM4OPeSy1ECylhbq1kA770lOnr4ynx+MHXrTjVw4zVf7+f7
	uzyetbufOEjD/xSe7BCtqRy9pbIF0pD3TfNkGbJigxf+0JSaiH7vqwaRhA==
X-Gm-Gg: ASbGncu2TiU2Ws0NR5EXAyQkO0aclgLI2Cbw7ZD3Fb1Wi6WdwH1czzG1mOPp31YgFbd
	UDC5gAn9AXpE5AIlkpwkhDhIV0Nz7RgAFQTNW9iN5Eh3DihQZ5qoc3Z2WyZiRBjzYxCSiDfVLsg
	kv0u4J73G1y/6bEl1KJngEMLMxhMrp1bZ48ebYLXIpk3pI42Bl6whmP4eO1Ox+VwZlBMmWrUoJX
	04y7FoykeiANoia+0MXRectJA4sWtPJz0gBvm4296whrQmct4pL+fqnLK8TE/1QEEJIhclCaOEM
	JlGbDxntjmPb
X-Google-Smtp-Source: AGHT+IF7UnZPXg/Rlel0yxe1Kie0mqnfUVGpPwG5BQGBwRte17zKFl3KzwZfGFZ4hfeQT9ZQCl2xWA==
X-Received: by 2002:a17:902:e48d:b0:216:4c88:d939 with SMTP id d9443c01a7336-21c355deb66mr426447055ad.38.1737830029100;
        Sat, 25 Jan 2025 10:33:49 -0800 (PST)
Received: from [172.17.0.2] ([52.160.165.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da41413absm34936695ad.123.2025.01.25.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 10:33:48 -0800 (PST)
Message-ID: <67952e8c.170a0220.3c6150.27a9@mx.google.com>
Date: Sat, 25 Jan 2025 10:33:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4639808011184794201=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: Bluetooth: Unnecessary braces around single line statment.
In-Reply-To: <20250125165804.11486-1-deaner92@yahoo.com>
References: <20250125165804.11486-1-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4639808011184794201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928341

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.18 seconds
CheckAllWarning               PASS      27.35 seconds
CheckSparse                   PASS      29.96 seconds
BuildKernel32                 PASS      23.86 seconds
TestRunnerSetup               PASS      428.25 seconds
TestRunner_l2cap-tester       PASS      24.14 seconds
TestRunner_iso-tester         PASS      29.51 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        PASS      119.15 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      9.27 seconds
TestRunner_ioctl-tester       PASS      7.89 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PENDING   1.12 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4639808011184794201==--
