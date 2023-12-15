Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591910A27
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuKS8+/w"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f11ccd8e7so3242586d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 23:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702625560; x=1703230360; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih50dbo6w3HeFusU6Ct//RKDJY0qMQCzLCjO5//AIeI=;
        b=FuKS8+/wSfQcPMutf5YQBmLFondKc9fd3Bn7vFYokPxnNfcTyZJWkRW/Y1K1qIj50k
         am4Dn36RN25ikIShgruMWpDL7wRptz10YBZ5T84KA5TIXYKyXvoTZc9afGldp5gC1ZKO
         EYpWlSeNETl5Xc8G5nE0/vZ1F+ef9Klj4wpR4d7cbGPvOARc5GXfF1rGv9Vmkc9K/YzG
         hewpvyMK2rL1w/y5bOxgWCxaFlnUjIUdM3PWoeq1i/OH6mzxkz2T0qP/DLdKh8iqSaQb
         /ebPQM91BuCFjIf5KWD+6W33PpVAUSULDLhYqHK3cu4iLf0Ts10EBm/GB1iMkoH/iFXj
         WYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625560; x=1703230360;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ih50dbo6w3HeFusU6Ct//RKDJY0qMQCzLCjO5//AIeI=;
        b=MlfJpi6zZheg5I1HYLbk/MrgQepW5uF8/8UUmgdnOBmMQvQhHxjaG5fELG9XldgSyE
         408g/RBMvPk1Y+hv0u504oi8nkYFZyx9xTDH8Nuu3uFe5vqG+V4KPiApnADDGxxQ+92S
         xiMyYt4C6Q/rSe0CfgCpgO54dmOS3Udll2gxuIqFRIRIKSnNKHTZtLxK8DCyT9fOohAI
         s5hRIJNdSVH4/0bMJoRLsjS02evxD0unxBPY5htpe6VL4palGPfMw//ROgvXxgUXwiM3
         U93Qh/pDgf3hpdOblzk9KIck09qUmkmCVqXlrRY7zX9i3eS+OK+OfP1pZc7yYr58g5R5
         Zjvw==
X-Gm-Message-State: AOJu0Yx/OCUgKQz3Xn97eJHHLiW31mOfe0Sp47uGvHa/+wjRYrJlLc3U
	uHRMNmbJAfQLGoAq7J0CYLYQLJcLjPs=
X-Google-Smtp-Source: AGHT+IGaOmEdbwV056eg/HAkP64gtJzFl5OzmIFmTtrJqWnKHuXYda1gYq0fIlRCbBSWHkhPtgp8/A==
X-Received: by 2002:a0c:e74f:0:b0:67a:a24d:e58a with SMTP id g15-20020a0ce74f000000b0067aa24de58amr9878071qvn.7.1702625560362;
        Thu, 14 Dec 2023 23:32:40 -0800 (PST)
Received: from [172.17.0.2] ([40.76.106.50])
        by smtp.gmail.com with ESMTPSA id w12-20020a0cc24c000000b0067f056e121csm1453548qvh.97.2023.12.14.23.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 23:32:40 -0800 (PST)
Message-ID: <657c0118.0c0a0220.35d81.a98f@mx.google.com>
Date: Thu, 14 Dec 2023 23:32:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5437881207541240385=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hao.qin@mediatek.com
Subject: RE: [1/1] Bluetooth: btusb: mediatek: add a recovery method for MT7922
In-Reply-To: <20231215063714.7684-1-hao.qin@mediatek.com>
References: <20231215063714.7684-1-hao.qin@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5437881207541240385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=810339

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.89 seconds
CheckAllWarning               PASS      30.45 seconds
CheckSparse                   PASS      35.75 seconds
CheckSmatch                   PASS      99.39 seconds
BuildKernel32                 PASS      27.14 seconds
TestRunnerSetup               PASS      424.70 seconds
TestRunner_l2cap-tester       PASS      23.16 seconds
TestRunner_iso-tester         PASS      51.26 seconds
TestRunner_bnep-tester        PASS      6.98 seconds
TestRunner_mgmt-tester        FAIL      164.58 seconds
TestRunner_rfcomm-tester      PASS      10.89 seconds
TestRunner_sco-tester         PASS      14.40 seconds
TestRunner_ioctl-tester       PASS      11.99 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      9.79 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      25.50 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 1, Not Run: 1

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.189 seconds


---
Regards,
Linux Bluetooth


--===============5437881207541240385==--
