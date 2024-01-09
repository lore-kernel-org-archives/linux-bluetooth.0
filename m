Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91D3A8E8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCukeG47"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd2a584fbcso1495577b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822963; x=1705427763; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ET8nVy0kgNEXNoxWIo8OUlGqngM2BqZljgqWfSyT/g=;
        b=JCukeG479BLbD58bU4qD2hnzQqtxyvqZLaLBCCcMtlnSmi94HRPUhzVlFNy/I4VqPA
         xtOYUlYAJxBsZciTJaE/0Wgu08hUuGuZaDuMcftJ8wWN/oWlH0X4psj34mkcEQ8Tj1Ae
         7O5EKlC86R99e1BHb01PD63f5Ig4aWlVE72JIC4pzHv6uJ5s2XxB1QFPGG22RP/8bDh8
         Mtd9me0pOzyZ2m827NRrnFj9jOHGJxOvW+trprRk2CkoGsGH7T0eYzRYzSyBJ91NN3np
         mh+aDx0eVkJuS9O//9x6YSMOh4+lJ4tVK4paeC2TE/E5uYQseP2B3vf6H7GqiNxQ9UlF
         whCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822963; x=1705427763;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ET8nVy0kgNEXNoxWIo8OUlGqngM2BqZljgqWfSyT/g=;
        b=Lp9k/U0fAM3TegMKOlm1ak/Kf4/GW51uUjG2Uzcia7ayhC9BCLMdevTmfZcQ8dlCo6
         Vc60ILCWx41QzCPvcmzOZVXOCtPR1m2tPlfAhv+MUwqNvv4/8EreFxRkhYmen3dHSjbl
         AXVRnovSIeQpI6fcdrQ1pQNzCYlJmXcyH0kjyN4KCMtTWGapN84fZho0fVBuU997d0Jr
         baNz+233Yl1rgofhvjBYIW5yp4M0Rdr9s0jTiRJzmxSw0S2LDkfcUGlZ1p66yIpLu1ZD
         mLwmgXMlOantEaJmtbsbIZiNgH3Y8NKu6PPFdADd2E/PgT267OiLoW3wU3bxNrFRd0gW
         ksJg==
X-Gm-Message-State: AOJu0YwUN8MG/sVLwDllUb/AiOBT6pW+sGgfvK3dl5Lk08ioi1dFy5k2
	8slSXd7sqtg3GOsriQSrwnvz2jNYKeA=
X-Google-Smtp-Source: AGHT+IHLYe00kI547YEydFKTILLAeEnqVsJhG1tfXgNXDweyj06O+bhuHxzJud2q8GGymmS8gsO/0g==
X-Received: by 2002:a05:6808:1442:b0:3bb:dfe9:d6f2 with SMTP id x2-20020a056808144200b003bbdfe9d6f2mr3683716oiv.69.1704822963258;
        Tue, 09 Jan 2024 09:56:03 -0800 (PST)
Received: from [172.17.0.2] ([20.42.106.73])
        by smtp.gmail.com with ESMTPSA id lg10-20020a056214548a00b0067f75dbf08fsm1068168qvb.11.2024.01.09.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:56:03 -0800 (PST)
Message-ID: <659d88b3.050a0220.f54f0.5f94@mx.google.com>
Date: Tue, 09 Jan 2024 09:56:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1788589110860458286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: hci_event: Rework hci_store_wake_reason
In-Reply-To: <20240109165552.430359-1-luiz.dentz@gmail.com>
References: <20240109165552.430359-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1788589110860458286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815468

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.93 seconds
CheckAllWarning               PASS      30.32 seconds
CheckSparse                   WARNING   35.68 seconds
CheckSmatch                   WARNING   98.86 seconds
BuildKernel32                 PASS      26.84 seconds
TestRunnerSetup               PASS      432.72 seconds
TestRunner_l2cap-tester       PASS      22.95 seconds
TestRunner_iso-tester         PASS      46.74 seconds
TestRunner_bnep-tester        PASS      6.84 seconds
TestRunner_mgmt-tester        PASS      167.11 seconds
TestRunner_rfcomm-tester      PASS      10.85 seconds
TestRunner_sco-tester         PASS      14.38 seconds
TestRunner_ioctl-tester       PASS      12.56 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.68 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      26.41 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============1788589110860458286==--
