Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A218E00
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El5aJ/xa"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77f552d4179so224623285a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 03:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897253; x=1703502053; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=73Ek6uCYCjM36z7FmqZmv5v7XAXqGIXAyHkwRzSv29Y=;
        b=El5aJ/xalEP/7n9909tyffeNAZ9W4dPnAzp3n2a34kucSAMT1cuBuFwvEsQvlzNJvF
         dGh1ne6mWKxSnM28Zuj05mRPG1JDnd6zi8CAElO9roT61bFsre8vhCWiaKFCIJpG/iCF
         3jbXNCZCvH8rzeHKEdPL3Wb7Mfe4xBnqOt2Yz5is1x399uKpMXTlSnusiTKoD53/QfhO
         JPdkimGJpRgSjNuM2+EwHMpAdIkAy6sCQ3SuYpZUBwnkPLp3qiAFYhYZDZLHibKJ8l+z
         uSxzsFS7Ctu5LHAC3hezDUZ34J6uhjE+c8E6q7zyI+M7Ih8Yuiwka2YFQ4XRXrHMmeae
         bsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897253; x=1703502053;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73Ek6uCYCjM36z7FmqZmv5v7XAXqGIXAyHkwRzSv29Y=;
        b=mK3RHOO966r4HDxUuP7jJ5U5v6w2gnmCV42UCfr4l6HJbIJy+VFUhEHUugJQiwvrK7
         7A2Wf4DwYL9hqax8zKgFneiAyM/qnV6gltcYM2iP4fzS7trAmbDvV8pVW00K5kQK8zGl
         YsZeOHa11596OUP5OOVWOf7SaiQK0I6niVpDJrniRNDh/bMd26hdFnn0X55f5gA6eVsU
         AJlKP7oapvZ8lUwdk23N08qjEPJjDTqJbNa/ASAokthbhf9r/ZgRtufZRmHVorLc0WQb
         RgRe50Ur0FirjqXO0ZsUUcm9jKAt+ypVliO8Hdexk1gTyEpgAoUrXyMzize6GuFevd4f
         WxSA==
X-Gm-Message-State: AOJu0Yyec6qvcJ/oXJwFHzmuPbDNyIv8+uNeNcDD8q4mmJAb5xxZzmFv
	2Wv8fBrCiVGZxfb7MbP2kVABhDXZPTM=
X-Google-Smtp-Source: AGHT+IGk2uCfLUU4y4Nay2NiE/0sUNY5TQhGvxMxqjvrNhBPh3pTS/jc8oQfZoFV+zc2p1CEwqXlsg==
X-Received: by 2002:a05:620a:84c5:b0:77f:32b0:eac5 with SMTP id pq5-20020a05620a84c500b0077f32b0eac5mr19240145qkn.78.1702897253663;
        Mon, 18 Dec 2023 03:00:53 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.222])
        by smtp.gmail.com with ESMTPSA id ud11-20020a05620a6a8b00b0077d90497738sm8217599qkn.102.2023.12.18.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:00:53 -0800 (PST)
Message-ID: <65802665.050a0220.239f2.a8ed@mx.google.com>
Date: Mon, 18 Dec 2023 03:00:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0138003963218561068=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
In-Reply-To: <20231218102720.3816166-1-neeraj.sanjaykale@nxp.com>
References: <20231218102720.3816166-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0138003963218561068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=810985

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.91 seconds
CheckAllWarning               PASS      30.83 seconds
CheckSparse                   PASS      36.35 seconds
CheckSmatch                   PASS      99.39 seconds
BuildKernel32                 PASS      27.18 seconds
TestRunnerSetup               PASS      430.21 seconds
TestRunner_l2cap-tester       PASS      23.55 seconds
TestRunner_iso-tester         PASS      44.31 seconds
TestRunner_bnep-tester        PASS      6.84 seconds
TestRunner_mgmt-tester        PASS      161.68 seconds
TestRunner_rfcomm-tester      PASS      10.83 seconds
TestRunner_sco-tester         PASS      14.42 seconds
TestRunner_ioctl-tester       PASS      12.24 seconds
TestRunner_mesh-tester        PASS      8.92 seconds
TestRunner_smp-tester         PASS      9.73 seconds
TestRunner_userchan-tester    PASS      7.15 seconds
IncrementalBuild              PASS      26.19 seconds



---
Regards,
Linux Bluetooth


--===============0138003963218561068==--
