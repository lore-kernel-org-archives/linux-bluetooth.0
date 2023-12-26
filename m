Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021344E623
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeHlGC5S"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d44200b976so4972545ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 04:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703594343; x=1704199143; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PWtNUJtnPIuhT3eMeiS7QmVsvjNWvYaI7XcM0HhW5QY=;
        b=YeHlGC5Sn6uOkOdkmO6ZMeM/oBPJciG4EW6B48v7gRmdZxKcA8u8cGOSyQhU2aIad1
         qtdKTmSAAq8gBSfUMi1YpbPcu/9tqaOuNWV9ie2fnj5ATIPBi7adWssKvEJtIZ/F6v9D
         GemnZuvb6GazpfsR3w/9Q3hvG8Yw3X0WddZv+3+Bo5HtsNddF9yNBwP/UeBMQeQgtdn6
         UQvWa6I+zi2YWjrsIX2xL9xK9K420nZ6Jtfs8KWHuK1XIp+emlR5Lo7Ao8rsbB+xFUFJ
         hxQhpKJNkKdu8D++ruYDGeg9MXPqQ+PiKoHMThfHKasV+1ugSYEgRoG14H9ToiKRPPlc
         JW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703594343; x=1704199143;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWtNUJtnPIuhT3eMeiS7QmVsvjNWvYaI7XcM0HhW5QY=;
        b=mmz/0Qv8ZwDE+8QwDFQA8N/kxgiRdKt+kPiBrkJdFERsW5HJWDsOLl/dV3VyohvpgX
         uv/7S2M/fhKnRy+6ZpYfcZ+AvqxPe+HCU3Qux0gdzIblHpQUvKses1ywZSFjs+PHAv7z
         ExienxbPre8PGTicanbzsrllcIUfMherGR1ys1Ljub3eCwevZIdBSdrNbdlHhnEJ0og2
         ZbNuIC44Wf4zKMdsebJoAi4/V3r6pk+e0hEGMLPAwZdBIefpAFjzx9oSjKE6mS7nbTBo
         LGAXG92U7Cg2/aOjHwSMYpZLo2tBpLHfFZYS3zG68OyWy4AJ3ELcQaz+vtxxC/Wc7U9b
         1cFQ==
X-Gm-Message-State: AOJu0YxCKgmTKLGISqCUofWQPrOeqlwbHm59P5d/hM9EWAvZ5KqmdzkX
	32IiAW8G0ZUCFAdywOqvmidQSrg3rcg=
X-Google-Smtp-Source: AGHT+IEONMuImshMYMQnEkXytl7kmSAmCljfZPeM7h5fM89SMzjvhkpnFJj7MsDBEVPX3VmLHQP4Fw==
X-Received: by 2002:a17:902:ce92:b0:1d4:e0f:e4f3 with SMTP id f18-20020a170902ce9200b001d40e0fe4f3mr3456988plg.101.1703594342939;
        Tue, 26 Dec 2023 04:39:02 -0800 (PST)
Received: from [172.17.0.2] ([138.91.70.190])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001d4752f5403sm955074plw.206.2023.12.26.04.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 04:39:02 -0800 (PST)
Message-ID: <658ac966.170a0220.2135e.1614@mx.google.com>
Date: Tue, 26 Dec 2023 04:39:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6360375066605549883=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Add the support for RTL8852BT/RTL8852BE-VT
In-Reply-To: <20231226114518.5395-1-max.chou@realtek.com>
References: <20231226114518.5395-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6360375066605549883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812888

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.79 seconds
CheckAllWarning               PASS      30.53 seconds
CheckSparse                   PASS      35.69 seconds
CheckSmatch                   PASS      99.10 seconds
BuildKernel32                 PASS      26.90 seconds
TestRunnerSetup               PASS      433.16 seconds
TestRunner_l2cap-tester       PASS      22.92 seconds
TestRunner_iso-tester         PASS      44.56 seconds
TestRunner_bnep-tester        PASS      6.77 seconds
TestRunner_mgmt-tester        PASS      164.29 seconds
TestRunner_rfcomm-tester      PASS      10.70 seconds
TestRunner_sco-tester         PASS      14.26 seconds
TestRunner_ioctl-tester       PASS      11.73 seconds
TestRunner_mesh-tester        PASS      8.70 seconds
TestRunner_smp-tester         PASS      9.57 seconds
TestRunner_userchan-tester    PASS      7.26 seconds
IncrementalBuild              PASS      25.65 seconds



---
Regards,
Linux Bluetooth


--===============6360375066605549883==--
