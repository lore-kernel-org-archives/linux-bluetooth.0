Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1d+fnpP"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B910F1
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 10:35:21 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so1675466b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702060521; x=1702665321; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1tZ5fk9H19pu1F3O5k0RVjQpyVrbKu2IQIjQRSj/riI=;
        b=f1d+fnpP3sE0lPnj98jRumTfS8xLWSKjYygJC8DwNng8PXPO/BJR0NLy4/ofjukUxR
         /T3KtL7Pogkwna0mxRDZbp70TWvbNg1IdXE0sH4X1XBXID7ivRHaWTIl72m5v249Demz
         b9KaU5rc27K4MCxDFvJ9HlcsP8yZiMcoRaPMfkNJOcYOxRXi2RcqvPcGHZhYwJTPLQVO
         Gxosw6C2wrCPMjVJRAJwnmgGXZjogOemSRV/9yXid72yzNNVkMyEnyQdR7VwqX+1Vrua
         0ZUYW9LKgGb3OwLFBtNjaVdPMkaI0eKepLPQiZNC6nZBEL5IUvRDKgksGPWZTDVcIFIZ
         m8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060521; x=1702665321;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tZ5fk9H19pu1F3O5k0RVjQpyVrbKu2IQIjQRSj/riI=;
        b=Go4uJhaVodCr1oTVU0rNk252AldICpXbZvjuQ9btOueKBvkurZI6+/USJEflx/SD/K
         0qBrIKZiDDsZ1o8hGV1aP0W/VhqPScrbimYQwqMpTsPwyicYnalXzZYwn0ArAH9wSC1y
         +hojVLaHwnyukDWKM9S4o1e9AmrM8NgzouRd/pHJywGJrFN3DPSF7PYMUBklXJvq8wrY
         erKS8czhoVfQtqEkBAU/mVi0ZrVedLJ+j57asLV7Wf5HTiKtZO8+lt0Jqb8nWRPQBz3I
         4Yxj49ddKS7NwWr0e8c4hGrzI0OomloYugZcukePOuPumMWV2UDT4jizlqGf8Hns93A5
         11bw==
X-Gm-Message-State: AOJu0YxJlwvebjCjOvOEIa5kgUP32TWD7cUpjOjF0JgSLNipzKoHzceq
	/ynjuGxHW9LoN8Hc1Ax2Hywu8n2NXds=
X-Google-Smtp-Source: AGHT+IGoV2szNB7h0y3FCaCipWrphdSEZWrRXQNUvM0hcXp9/ZlobvWDDpOG+o/8DKCgEYWeLxfPKA==
X-Received: by 2002:a05:6a00:14c6:b0:6ce:57f2:45fa with SMTP id w6-20020a056a0014c600b006ce57f245famr475929pfu.49.1702060520924;
        Fri, 08 Dec 2023 10:35:20 -0800 (PST)
Received: from [172.17.0.2] ([52.225.76.18])
        by smtp.gmail.com with ESMTPSA id fi29-20020a056a00399d00b006cbe1bb5e3asm1870215pfb.138.2023.12.08.10.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:35:20 -0800 (PST)
Message-ID: <657361e8.050a0220.ba8af.6730@mx.google.com>
Date: Fri, 08 Dec 2023 10:35:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0493239457529575353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: L2CAP: Send reject on command corrupted request
In-Reply-To: <20231208174150.1313389-1-frederic.danis@collabora.com>
References: <20231208174150.1313389-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0493239457529575353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808342

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      6.39 seconds
SubjectPrefix                 PASS      0.71 seconds
BuildKernel                   PASS      28.55 seconds
CheckAllWarning               PASS      31.37 seconds
CheckSparse                   PASS      36.94 seconds
CheckSmatch                   PASS      101.06 seconds
BuildKernel32                 PASS      27.83 seconds
TestRunnerSetup               PASS      428.07 seconds
TestRunner_l2cap-tester       PASS      23.12 seconds
TestRunner_iso-tester         PASS      48.36 seconds
TestRunner_bnep-tester        PASS      6.85 seconds
TestRunner_mgmt-tester        PASS      165.73 seconds
TestRunner_rfcomm-tester      PASS      13.37 seconds
TestRunner_sco-tester         PASS      14.52 seconds
TestRunner_ioctl-tester       PASS      12.46 seconds
TestRunner_mesh-tester        PASS      8.97 seconds
TestRunner_smp-tester         PASS      9.92 seconds
TestRunner_userchan-tester    PASS      7.43 seconds
IncrementalBuild              PASS      26.37 seconds



---
Regards,
Linux Bluetooth


--===============0493239457529575353==--
