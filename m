Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikInzQJx"
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D51D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 01:33:50 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db35caa1749so3537429276.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 01:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701077629; x=1701682429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1uLoaM4gxkkRhNl5ftGqg+VaTL7M+XWtSa9IaZjpCRc=;
        b=ikInzQJxmDCZmYLYHNX4GN6zajgm0LayMJq92/d8ARbE2w5W1h6O0LxFyRAuCkHsvP
         YlkkV0ec3/MIVIXMGTwDER0jEURUQR0gAo28f8GA21IvyWdMiVCXbMiepnQMBWxbt3hj
         YMZGXy3eLLnjUPhtO1aC9l1vZlyL0pW4DPcptXGlCDNSEpiMLn15pV+JPNGtIaRj0GZX
         qJUy3lTo0Ehd/O4390R05ZQQOhSX1oKvE54LsgOYvxde3BJVJRwGaJni6Mv1k4fBY3Jl
         owovFJfcov8/56fHra2Q6SPfB7Zx3iuLAnUtdRH80XWgfa2pBUBmaOj7Vc/PdKvwvcnz
         TucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701077629; x=1701682429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uLoaM4gxkkRhNl5ftGqg+VaTL7M+XWtSa9IaZjpCRc=;
        b=mjaRFFlLN1OEARX7RezxuTk7Ajh3CyNaWlEJlp1shH3RGmyEK7OgEpOdo+gWL19zvh
         FVHbRAuJ4Nyuae+Nfu4zGVeb+4Zhun07630GNxBOpOipMAC6qd82TGD8b5MATnE5zwmQ
         bW6DChAZdYnDowyeHheNXsvpSnuhi7PkdTI1NceiT7LiRsVMDsWV5A7i28gTFBq+ynfl
         36o/oXurpx2XxxzSsqG4qJzsuePE7fsnGhDQUQxJIciJGRlwON08GXnd5kDjlZMOp2Bt
         ilbgR7UtXi1iC12hp1+VFiVYSROL+svSFP4rjdwUP02ioaYMSr2IFlJ/MwjLEriobItw
         HVJA==
X-Gm-Message-State: AOJu0Yzk5+qz50d05xtKQkUPbVGE2tY3icppDgghHmHVL+GfU6DZDoEi
	6YCy1v9ZMAxvPlPPq6V+1Up1Gi7J3so=
X-Google-Smtp-Source: AGHT+IFBNRW80XvHBZTvurODMbIVOgmqvN7aP3/uCtUOV4kn4/GMBkHZAuC3X8LGSEexpAEhBtxW7Q==
X-Received: by 2002:a25:588b:0:b0:d9d:5e9:c65b with SMTP id m133-20020a25588b000000b00d9d05e9c65bmr9243882ybb.39.1701077629193;
        Mon, 27 Nov 2023 01:33:49 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.178])
        by smtp.gmail.com with ESMTPSA id e14-20020ad442ae000000b0067a4513c739sm841664qvr.63.2023.11.27.01.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:33:48 -0800 (PST)
Message-ID: <6564627c.d40a0220.28b2d.1d25@mx.google.com>
Date: Mon, 27 Nov 2023 01:33:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0220692781296537692=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 15013537245@163.com
Subject: RE: Bluetooth: hci_sync: fix BR/EDR wakeup bug
In-Reply-To: <20231127090545.117162-1-15013537245@163.com>
References: <20231127090545.117162-1-15013537245@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0220692781296537692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804428

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      29.36 seconds
CheckAllWarning               PASS      32.36 seconds
CheckSparse                   PASS      37.57 seconds
CheckSmatch                   PASS      102.41 seconds
BuildKernel32                 PASS      28.08 seconds
TestRunnerSetup               PASS      429.08 seconds
TestRunner_l2cap-tester       PASS      25.51 seconds
TestRunner_iso-tester         PASS      37.95 seconds
TestRunner_bnep-tester        PASS      7.16 seconds
TestRunner_mgmt-tester        PASS      163.31 seconds
TestRunner_rfcomm-tester      PASS      12.82 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      12.36 seconds
TestRunner_mesh-tester        PASS      9.24 seconds
TestRunner_smp-tester         PASS      10.01 seconds
TestRunner_userchan-tester    PASS      7.53 seconds
IncrementalBuild              PASS      26.32 seconds



---
Regards,
Linux Bluetooth


--===============0220692781296537692==--
