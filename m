Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky7v4qp8"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C1D50
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:58:00 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77bcbc14899so366677285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701248279; x=1701853079; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FI67D4lTgeBUHKh8O/0nLfggIYGqimRvnrVakd94+OY=;
        b=ky7v4qp8F/Emxad91jI3P15JDhe908rb5flmPQ2mPpRVMvv8lfGrBdGjmmxIGtGN13
         +IBwpgEyUa3Fx3dFm/yxZ6fS1a0kKBsJqdB7CLLLz1e1qwXWLWN/bqgewysr86ermP6O
         9eipLW803kQu33+ojubord28xQdKOCzACo5Tn8dEBV2KFZXRLg9FyC8737ErruCAJNFF
         LbfbVkW1R+mAgtdSGCcOMlIyeW413wdxDUko3qq+8/z271BWEVRP8zOOpYFSC8pWOrpc
         nNfAjWkH39Lq4oXZ81iGviESyZRqT/m7k4Nu37NYdu0IYi7O1E2EbIqg5z6IcwadzOke
         KwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248279; x=1701853079;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FI67D4lTgeBUHKh8O/0nLfggIYGqimRvnrVakd94+OY=;
        b=BueqXrCFD6GgbziXx03ba0qKcmT53u7M0snMv7V1EYkO+JO68XdkEb4MDgRaeIkov+
         zFJiImqpsavejtPo9kcfwZboP+d/CchLKq2FTN2J/UCSEEoXkHkHi3xKxuz59MEU+M0t
         wqWn3piJjS5XWKlSj6ymyUKuSyq71eaVDS50fNEyDISqe1gtyVzpVdZF8LZg8Mwz1zdw
         +RwrNlKifOb7dbjh5eaVbhgYznAWbvqk5GCzldZpS0GPsIgjDcxUNE0RDWSL/0BdDGgc
         3XRmf69iduHW2xLuvDVJKCUS6in32S+S62B0VaRFKqT7jZQC9gPHfQq67xnm0yxTqm+2
         cB0Q==
X-Gm-Message-State: AOJu0Yz/KvRDgq7l3SR1Tl5YMDcu2930uV5Ru/Hig/jlT8eSIS03xFuq
	haUuUB4lm7nj9UfWKH7lxMU/4gTqyl4=
X-Google-Smtp-Source: AGHT+IFLv5WariO0gtKnc1by3sH5RWqzhryZaVqb/3cZ/B0UhKdl3YJd6p0dKgBGzmBGP6D7cQUzDg==
X-Received: by 2002:ae9:f812:0:b0:77d:ce42:2d48 with SMTP id x18-20020ae9f812000000b0077dce422d48mr773503qkh.68.1701248279560;
        Wed, 29 Nov 2023 00:57:59 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.145])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0c8500b00775bb02893esm5222887qki.96.2023.11.29.00.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:57:59 -0800 (PST)
Message-ID: <6566fd17.050a0220.c7eb1.4fe6@mx.google.com>
Date: Wed, 29 Nov 2023 00:57:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0629497009295783716=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: Support SCO offload for QCA2066
In-Reply-To: <1701246570-3564-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1701246570-3564-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0629497009295783716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805152

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       FAIL      1.01 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      27.79 seconds
CheckAllWarning               PASS      30.51 seconds
CheckSparse                   PASS      35.74 seconds
CheckSmatch                   PASS      99.40 seconds
BuildKernel32                 PASS      26.99 seconds
TestRunnerSetup               PASS      420.48 seconds
TestRunner_l2cap-tester       PASS      23.13 seconds
TestRunner_iso-tester         PASS      47.68 seconds
TestRunner_bnep-tester        PASS      7.08 seconds
TestRunner_mgmt-tester        PASS      164.12 seconds
TestRunner_rfcomm-tester      PASS      11.06 seconds
TestRunner_sco-tester         PASS      14.38 seconds
TestRunner_ioctl-tester       PASS      12.09 seconds
TestRunner_mesh-tester        PASS      11.00 seconds
TestRunner_smp-tester         PASS      9.95 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      30.77 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v3,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()"


---
Regards,
Linux Bluetooth


--===============0629497009295783716==--
