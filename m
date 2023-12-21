Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9ED156E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma0rcnZK"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7810917125bso30082985a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703145423; x=1703750223; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wtEKxIo8hPjxILMUyEPg6LpJ1i89fHe6Ugnxp8RAufY=;
        b=ma0rcnZKKZzo8QO1mUaMe3aSUsLSW/T7bv+NXJkGWS1ZvqJK2HozfNDFN2HD0033Q3
         GyR2tYWwF00kBcQ4TXcvmcgVVQnYrVn7yU0lbFA12LanAPVkGkwHN9QSU1Jf83Mhs3IG
         0cp4msK+xm69govVwqxgcCwMe37cuaxSNs5oZoyRrn+RPfRnBcBdMVuUoIqo3Mg5y3f0
         N2ZJ+9dMQAsS2n93n2smVJM80K3MmrId+lol3qMoYjzJcYxmOl7ATqBGwtoOzs8kgfL9
         ML+nKk6pk+NxArzvIYZqwKkDQVfwPNnQs2lBA5roJxnkiU0YCZIWbH5XN9gIHcT7G6QC
         PIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703145423; x=1703750223;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtEKxIo8hPjxILMUyEPg6LpJ1i89fHe6Ugnxp8RAufY=;
        b=IrXGJHHwZuD/Re5AXGq7KTnWB+5lRjxysmuZzZu4RvSFY+acfWxVYgu1hCeFWYZaNr
         P6EqqF5ckelCHiXpCbsM0yK5DfjhPwZgp5JqJmolVv/wkzszEoTky890qoMWVuJyE9l/
         iryq7tnxQXxnFtV/t5q1xUU6GDwWRVPQSye9baaoWV5WwcBP21inwnZPaGDfLbSUeGM3
         rh9Kr3nd5ytSmT3OLCDhalcnf7wgE4KZASjtCIhQoymydADxBcc8T6hGhFsF55IZrhWx
         m+0xboOF2x6K3yUFNfPY5CUKn3v7f2kMkYzz0QphzAi2D3treO6P187QM23Otd9liw5K
         G0xg==
X-Gm-Message-State: AOJu0YxTPUhx8bLwvicLkSEnwNtOrvkbpR3dm3vua6kg/715x+O6JYSI
	Jp9nI3Lt6shSkTW1pMH/M9379dYPSNY=
X-Google-Smtp-Source: AGHT+IHAYTgHn1iA7EVdFt/vxX0aztHVQuHSjYZUMokNqY8qSQALNzQCbHcrZWDKqiYA/6qC5jqWXQ==
X-Received: by 2002:a05:620a:640e:b0:77e:fba3:4f0d with SMTP id pz14-20020a05620a640e00b0077efba34f0dmr23086511qkn.99.1703145423506;
        Wed, 20 Dec 2023 23:57:03 -0800 (PST)
Received: from [172.17.0.2] ([20.55.15.33])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a081500b00781211b97f0sm130034qks.24.2023.12.20.23.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 23:57:03 -0800 (PST)
Message-ID: <6583efcf.050a0220.38ae4.043e@mx.google.com>
Date: Wed, 20 Dec 2023 23:57:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5714325775717098747=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 15013537245@163.com
Subject: RE: Bluetooth: hci_sync: fix hogp device suspend bug
In-Reply-To: <20231221071621.1154462-1-15013537245@163.com>
References: <20231221071621.1154462-1-15013537245@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5714325775717098747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812044

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.78 seconds
CheckAllWarning               PASS      31.72 seconds
CheckSparse                   PASS      36.19 seconds
CheckSmatch                   PASS      99.56 seconds
BuildKernel32                 PASS      26.97 seconds
TestRunnerSetup               PASS      434.45 seconds
TestRunner_l2cap-tester       PASS      23.27 seconds
TestRunner_iso-tester         PASS      49.50 seconds
TestRunner_bnep-tester        PASS      7.21 seconds
TestRunner_mgmt-tester        PASS      163.68 seconds
TestRunner_rfcomm-tester      PASS      11.03 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      12.25 seconds
TestRunner_mesh-tester        PASS      8.94 seconds
TestRunner_smp-tester         PASS      9.87 seconds
TestRunner_userchan-tester    PASS      7.44 seconds
IncrementalBuild              PASS      26.14 seconds



---
Regards,
Linux Bluetooth


--===============5714325775717098747==--
