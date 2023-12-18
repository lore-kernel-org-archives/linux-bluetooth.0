Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2A19451
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXO/t9xg"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso967957a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897228; x=1703502028; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1OIyCMp0uXwrKBajI0g5qWujcaZIaGiAZ2xRwcPJYGQ=;
        b=VXO/t9xgvP7J5A2OQnX4HTw2zmVq2Dk+a7aLfGwz/yLpT0eX0gPIhOpeQO/FXW2iFP
         tMDVVtH2sluf9q+4PGhDMlPjhAG9BPTbQ9W6mVd2JyZIQR22zkMmXJ6zshe/6ZLDFAhn
         y4tWNsSDEcHZErpw2aEveDH5B/QqB4uvh1yYFXR2qx7PeUGkAcWhsE4QVe9Onzcq3zj7
         xx1rgA6vZZUP2dX4ozr0n3+qKYfemFXuBgd14jhPaqOWuB/QEIbE+LuorPYjaBAmvO8u
         FfOWSBv/VDz6MiKcFKTYSZa+5Zffq50KxTJ2Tqnq+DOUfwUfKvTRDFB4TxNQ2SKsPDoL
         EdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897228; x=1703502028;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OIyCMp0uXwrKBajI0g5qWujcaZIaGiAZ2xRwcPJYGQ=;
        b=S4Co3+37wxpet2IaIVkCkjEMiAYdstNZcryYo7QY6uEGV5gRoybZtAWtrDvjZW3iJR
         sphzr/vy3HxIT7dd6ZjpsSBOeU2OPwAwfbqvMxJRvZsPLiJuOabPL19noL2c4X7cF4ZD
         hjZRR/CbFKigEzC1vokikRjYbb2tNK+6iZS2HWljj+Vi/R/QA3tsKIAxuudT0I4Y+eaa
         QA018EsoyQAEdmwj5EwmjDz7wfpAnOvgfRCyVA0xvPM8mDlezd1cUneNINdQJTs0Fpkh
         KBGrTH+OyzN37iAngSCdJJBliuTmNMfqWnt4GP7lv5gSN4V1BLd68R+VDedhWuwF6N47
         qDHg==
X-Gm-Message-State: AOJu0Ywk6OwVURCTsQn8EU+HSG2DNd/c9z3Ki7Tzz9eZqYRgc8h/cevp
	D1eDz6BOh/jPPX9oEFXAek2mC80UXzs=
X-Google-Smtp-Source: AGHT+IFG6TltxvmDfqqsk0/lS1Ztclun9RDLC5e8Hqj5S7g/wb/8I3JdrTAnwCQlTjHfndxLb3vWSg==
X-Received: by 2002:a17:90b:3882:b0:28b:6b92:6f1f with SMTP id mu2-20020a17090b388200b0028b6b926f1fmr415906pjb.98.1702897227320;
        Mon, 18 Dec 2023 03:00:27 -0800 (PST)
Received: from [172.17.0.2] ([20.172.7.0])
        by smtp.gmail.com with ESMTPSA id nb14-20020a17090b35ce00b0028ad536ea86sm7472181pjb.48.2023.12.18.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:00:27 -0800 (PST)
Message-ID: <6580264b.170a0220.27e61.44de@mx.google.com>
Date: Mon, 18 Dec 2023 03:00:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5574592256594383585=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 15013537245@163.com
Subject: RE: Bluetooth: hci_sync: fix BR/EDR wakeup bug
In-Reply-To: <20231218102417.474022-1-15013537245@163.com>
References: <20231218102417.474022-1-15013537245@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5574592256594383585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=810984

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.50 seconds
CheckAllWarning               PASS      30.48 seconds
CheckSparse                   PASS      35.67 seconds
CheckSmatch                   PASS      98.12 seconds
BuildKernel32                 PASS      26.65 seconds
TestRunnerSetup               PASS      422.81 seconds
TestRunner_l2cap-tester       PASS      22.82 seconds
TestRunner_iso-tester         PASS      44.30 seconds
TestRunner_bnep-tester        PASS      7.30 seconds
TestRunner_mgmt-tester        PASS      160.21 seconds
TestRunner_rfcomm-tester      PASS      10.54 seconds
TestRunner_sco-tester         PASS      15.86 seconds
TestRunner_ioctl-tester       PASS      11.74 seconds
TestRunner_mesh-tester        PASS      8.62 seconds
TestRunner_smp-tester         PASS      9.47 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      25.96 seconds



---
Regards,
Linux Bluetooth


--===============5574592256594383585==--
