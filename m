Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A594CB4A
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVJt8rcF"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78117c8b6ccso380955985a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 00:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703579702; x=1704184502; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yon8A6EmLUkmP1rZ/b1T1WcE7c9AyGDvvV09lOYpaUM=;
        b=KVJt8rcFDAD3MmxcuR4zkPuMNDpReIW0exMYXVY3jUqLFa0QAAcMpwX7V3vm/2Pl4E
         CjfNG7iru0XDRXvpIRKPAlkySAXjiiDgw56864mUHJJoAEJoPXM4WQeLaxhRDtqzrQi8
         TtVN8bPctP/MFeqhOt52Tf3jCDSiQUYX+PyTiT50fzIhOvVD0lEwbFKgEEivnY0AaEtX
         62/bW9rseVhnE3DmNYmJb+bsimp0jPBL/iOhfSGnWzPRO59IdtXD4IvEhEX4lTN4BBCp
         HKsnND2936e1fbKcm/Svofm46TrMoMP3AlzwTrjMmRXoY/shRQQJ31sh9oMlxyrCB5qh
         eU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703579702; x=1704184502;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yon8A6EmLUkmP1rZ/b1T1WcE7c9AyGDvvV09lOYpaUM=;
        b=rXuWXB/m2M3uFXE8p3CEmyf5mq+Svny4KlC9Cz7fGu7NAzJvJ2+ThsxyYGBLTyM64+
         bqVX1XLomsRzPqJZwchH7XtZ7oG9KYAE1paSngIT7GgDGKeIcbm3OZ1M5ykVj0EcIxFi
         ZNlJ9VmeiydG3ed+9EYRgMUbJcuby1aCC9WAJccreAN4CqC4pw4jM5zd7NSku1/5SBSh
         1sE0WeRHRqCggzACwEC3Poxt4YkdOmV4c4xySPvOFEiHnEJZT5wDoBP8xwsnG9yLtCZS
         mHAWasovqu1o0bsPieW8qpH4bWDiXu+9uLa4suoITGPpm1Efj64KGvK9ui1LPpRq9BuE
         t8bA==
X-Gm-Message-State: AOJu0YxZ99GSrsxXi8i1do7lZVbipBeFL2t23ovjfWEyvsFF5xZ1HXr/
	npOf332kQ48SyVY1XjgDC3ZpLbUgKjj1NA==
X-Google-Smtp-Source: AGHT+IFAGe7ML2tMUfbutlWSwE859aI0//5Mi+CJFtWsE1jd7iVtNT4F5igh0zDiYlMy8JTaac30OQ==
X-Received: by 2002:a05:620a:388f:b0:781:45db:8121 with SMTP id qp15-20020a05620a388f00b0078145db8121mr4163595qkn.52.1703579702161;
        Tue, 26 Dec 2023 00:35:02 -0800 (PST)
Received: from [172.17.0.2] ([13.90.174.194])
        by smtp.gmail.com with ESMTPSA id e28-20020a05620a12dc00b0078130871568sm3059087qkl.31.2023.12.26.00.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 00:35:02 -0800 (PST)
Message-ID: <658a9036.050a0220.80074.782d@mx.google.com>
Date: Tue, 26 Dec 2023 00:35:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1013149875901730714=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 20373622@buaa.edu.cn
Subject: RE: Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
In-Reply-To: <20231226074355.328940-1-20373622@buaa.edu.cn>
References: <20231226074355.328940-1-20373622@buaa.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1013149875901730714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812867

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      30.69 seconds
CheckSparse                   PASS      36.00 seconds
CheckSmatch                   PASS      99.34 seconds
BuildKernel32                 PASS      27.17 seconds
TestRunnerSetup               PASS      432.08 seconds
TestRunner_l2cap-tester       PASS      22.88 seconds
TestRunner_iso-tester         PASS      47.44 seconds
TestRunner_bnep-tester        PASS      6.75 seconds
TestRunner_mgmt-tester        PASS      158.34 seconds
TestRunner_rfcomm-tester      PASS      10.73 seconds
TestRunner_sco-tester         PASS      14.20 seconds
TestRunner_ioctl-tester       PASS      11.96 seconds
TestRunner_mesh-tester        PASS      8.70 seconds
TestRunner_smp-tester         PASS      9.57 seconds
TestRunner_userchan-tester    PASS      7.16 seconds
IncrementalBuild              PASS      26.35 seconds



---
Regards,
Linux Bluetooth


--===============1013149875901730714==--
