Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C225DF54
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrv0raoc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78132affa95so186801185a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 18:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703558524; x=1704163324; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TNWLFyrd6RwibBSkvzllU0i/M4y2iMmoY5TModtQnyw=;
        b=Vrv0raoc8PXhZ5jtHhiBecUimQvqmW9zZwIOSQt2aSqAhci15hyp+smCj+h17qqnAM
         tLogpy+em9yVIuHk5qSYjBjZwMI/SALWPpzQOHRkGm9s0oLJYDk5Nrs+uPz/L9zfB3db
         Pk6g2iJwhzzoz6MzKpjtUi7/pYFwTx60xcfB+Uh+c79prTc6C9R3Iy8inKiLexg+AePD
         kGe6Q6LNryzK3CIh+IaDPpPP8nS0JjphLyKA8pO0B+/BG6o935cBvqcCsJoNmNK23QPI
         223khAnHtwuQm5h6YL2JxMfZrBoPrGj1j1UQAimsiXKR2OuEaBuRyu8poUGg4vvxELEu
         acew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703558524; x=1704163324;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNWLFyrd6RwibBSkvzllU0i/M4y2iMmoY5TModtQnyw=;
        b=QgolIDiFjVi0OHAMr4NPoogidFEfmMAi15R4PYXAImh3cE7IIbnjgs6pBsGnbNpHnM
         28WDHnpslJaGoyd2whR9zr6XfQV+NNOFGFjXcyuIqiLNTfntJj0vXtc2Y8HmkR8W2ZST
         IkSeWxG+LFTcX5bqjb698EKtLMxceK1DhUaiHwlFEoYL8w0k0N/QLFv0LhjlkD9Kn/0p
         SPpX+PXPRXuHAvR/pcan66f/D5yD81hRQ3yNPWrxWwu2pPcVnl+hc8XTDGNDljaS5Kyf
         LKl+yMJbywb5SnzNlQyNPhwDxW69bADpx+ysK/GoR+3pilYt17ov2gnSZPZJeTK5bDld
         t/eQ==
X-Gm-Message-State: AOJu0Ywd+SiAplFy6AUVHYZvAdJvbskkewUT0O10CXczmNwv/Ls7BW+m
	8j6U/FBULQ1qNMKwVB2cySSt0vjo52E=
X-Google-Smtp-Source: AGHT+IFTf0GWbFhy3m5uaBM4t3oh5hMFju1P0n4rCZyXVyfS/8oOI9vzxxH6lNw51AV2H8k43cdHjA==
X-Received: by 2002:a05:620a:a99:b0:781:17de:80d with SMTP id v25-20020a05620a0a9900b0078117de080dmr6726217qkg.80.1703558524278;
        Mon, 25 Dec 2023 18:42:04 -0800 (PST)
Received: from [172.17.0.2] ([74.249.6.16])
        by smtp.gmail.com with ESMTPSA id bl15-20020a05622a244f00b004255fd32eeasm4904655qtb.7.2023.12.25.18.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 18:42:04 -0800 (PST)
Message-ID: <658a3d7c.050a0220.ccba2.ee96@mx.google.com>
Date: Mon, 25 Dec 2023 18:42:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7071866373105472283=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Add the support for RTL8852BT/RTL8852BE-VT
In-Reply-To: <20231226015713.13673-1-max.chou@realtek.com>
References: <20231226015713.13673-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7071866373105472283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812846

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.43 seconds
CheckAllWarning               PASS      30.16 seconds
CheckSparse                   PASS      35.62 seconds
CheckSmatch                   PASS      98.11 seconds
BuildKernel32                 PASS      26.74 seconds
TestRunnerSetup               PASS      428.83 seconds
TestRunner_l2cap-tester       PASS      22.68 seconds
TestRunner_iso-tester         PASS      47.01 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        FAIL      162.68 seconds
TestRunner_rfcomm-tester      PASS      10.62 seconds
TestRunner_sco-tester         PASS      14.45 seconds
TestRunner_ioctl-tester       PASS      11.93 seconds
TestRunner_mesh-tester        PASS      8.58 seconds
TestRunner_smp-tester         PASS      9.56 seconds
TestRunner_userchan-tester    PASS      7.14 seconds
IncrementalBuild              PASS      25.84 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 1, Not Run: 1

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.284 seconds


---
Regards,
Linux Bluetooth


--===============7071866373105472283==--
