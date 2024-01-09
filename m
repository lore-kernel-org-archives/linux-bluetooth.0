Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D23D553
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiylZwLQ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ec7a5a4b34so34862247b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 12:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704830948; x=1705435748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jseom0tHGDoR0y0iCwlI91YE/rjyF4hnnBSRPEBX6No=;
        b=LiylZwLQhHPMiqx30641yyTGU8IFSjdYUPUaHCNnhALNb47cSaFtLrDUDImGqVtxR2
         AXR+qFPwLEKmCn2Hkn9XsO89tAGfq8ChnU8yG1W6aCjcs3ZaOKnqhJKKdumg1G9mnv+m
         R7IHGwtTqnTZOkH1GVW4zmao1aDzd88YCmEvxj4XgTX3h2coIudt4kUycJjzmVVSuqhc
         eEbVSl3tjDsLysKbbnV4E3a23Cyt6E2cMxqhNhmFnSV4pF/KuFHf5bJyJ9b0FcH3LOVP
         CpVxYvfj34stuSMggRlWYqtZ5s2l1o8VPEG3jrzrIzbZWN2mIVOTX+Q2tf/qukjcd2CA
         vtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830948; x=1705435748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jseom0tHGDoR0y0iCwlI91YE/rjyF4hnnBSRPEBX6No=;
        b=fQA0vX/3vtDeWFMrPkQsYSQQEEMNwo0iktyNYwMemkLyYWGlJ3yF1g183CznJg5vZb
         AFcmlVeejFUa0Hhx3IKRwka32XVfBZ1VzxKe8uH1U2HUMde9/tUn4txRNTdFsPfJTAOj
         WLru4945c1jcd3pIkXtvzSlaI1ITvrrLicEm+oNbxBWyYqy+Cpw5AoJchg/EkCk0W7UL
         ITU7hCPY+3WUEMWt4JsNL/9pNo6osbdaGkDsdJ6Bnm24vyKxsx/Pa/+KTySTmAPMeG7g
         DNCbvV85c+WspVMhJdFUXa4mjet+vgiBXaysx321Cot4hSp1SMe0psRDhxx0w5zKgSa2
         A/fw==
X-Gm-Message-State: AOJu0YygfVo/h4VbWka47h7ngDbfStsT+ymoHRS5GfpoEY8c78qw2kbD
	FWLAluZB0D9kBpxG8/7Pade05Jsw7Cc=
X-Google-Smtp-Source: AGHT+IFYC2iiipH5nvjPGzQM7xVR5PM4Dm1Au3PVV8eYC8N5EvVh+sL6KrFo4YiGLVDEIdIbW5WIxg==
X-Received: by 2002:a25:800f:0:b0:da0:7d1e:6e0 with SMTP id m15-20020a25800f000000b00da07d1e06e0mr3434054ybk.20.1704830947940;
        Tue, 09 Jan 2024 12:09:07 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.179])
        by smtp.gmail.com with ESMTPSA id s22-20020ac85ed6000000b004298c9d0ba8sm1167344qtx.22.2024.01.09.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:09:07 -0800 (PST)
Message-ID: <659da7e3.c80a0220.5734b.62df@mx.google.com>
Date: Tue, 09 Jan 2024 12:09:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6206559479259755507=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Complete request if command timeout
In-Reply-To: <20240109190905.546266-1-luiz.dentz@gmail.com>
References: <20240109190905.546266-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6206559479259755507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815513

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      30.95 seconds
CheckSparse                   PASS      36.68 seconds
CheckSmatch                   PASS      99.46 seconds
BuildKernel32                 PASS      27.37 seconds
TestRunnerSetup               PASS      435.66 seconds
TestRunner_l2cap-tester       PASS      23.00 seconds
TestRunner_iso-tester         PASS      45.38 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        PASS      158.89 seconds
TestRunner_rfcomm-tester      PASS      11.31 seconds
TestRunner_sco-tester         PASS      14.51 seconds
TestRunner_ioctl-tester       PASS      11.97 seconds
TestRunner_mesh-tester        PASS      8.69 seconds
TestRunner_smp-tester         PASS      9.79 seconds
TestRunner_userchan-tester    PASS      7.22 seconds
IncrementalBuild              PASS      26.62 seconds



---
Regards,
Linux Bluetooth


--===============6206559479259755507==--
