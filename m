Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLC4iAX1"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE08E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:03:33 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f3159d822so260787585a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702314212; x=1702919012; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1NAdkTY1wBGLLv3GA3+K61JIb3FG3uvaXO2cShHAGP8=;
        b=LLC4iAX1czbMzcb677ygw586NZFC8UqrmkKy5vwygZwKLPZW5cxaGs0kzVhbYr+Jt6
         OJxwiTkQsRRtLe+Vgu/Ho+6pinpfGUpUBxkxKDGuqOLkWSgYqdKROgSkLEgwLnZTH27A
         St5Kbo3lbINn61Z6ictCdeUhlOb8LMsGQ70xtY5ycIWRsaV5ptSYo5SrPglKztMKt2Mq
         33pvnKdS6tPEXAAAcQp3EjeM7HJtHo31ZsgMT4TkzUw+9wuZFp0uEUVETSxY7ZBJaiXC
         dr80bY8ZJTTdPrBmz1hf+gruDFaPzwrmmtlPclckLve+8O8nImRS27SM7wmcn5NO4U6M
         0h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702314212; x=1702919012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NAdkTY1wBGLLv3GA3+K61JIb3FG3uvaXO2cShHAGP8=;
        b=Vm+bQLwinHxGZlDQBMnEMcJmsdh2I67QxOfnX8P9HOGi4b7apGu7odRCgjW9AVOZdL
         Ye9v845/nWxvIQ+hMei07x/bf7KONXp04KiyaMuuZck0WYwuNG39MR3hWGCZsrJEJS2c
         Ck2hwwcfZDU0LLw6hXoQTu8a+R0Z2Ozq8M+2BILldX1rIVxs5H+Aom2IlX8mTQntTJBX
         2W6Ya9MbG/SNz8jYx+HFSZhExIE+gt5pSuqO0JXk53ej6mPxKvdVdaxf98EG5Pax66r0
         G8kZWoObGOl/N9uf0VEJkM/DXblApT75BmriWHRnNErnIlzK5Jr7c4ouVIwKepbkzCoE
         7RyA==
X-Gm-Message-State: AOJu0Yx7Sg5cFVmZe/y5vsytI+RqRD8Ij3HLpNSczWN5r5Hxykaa4BI3
	hfLaItGZ9BeGqvhjE1bUozFtV8B8s9Q=
X-Google-Smtp-Source: AGHT+IGFJi/Ns8jL+CILdp2CVx5/C4YLDHgtZvbg89DXrE28LkckUpEpfv/Zy5sFMyoXLY8ouxrXvA==
X-Received: by 2002:ac8:7dc6:0:b0:425:4043:1d93 with SMTP id c6-20020ac87dc6000000b0042540431d93mr7570767qte.102.1702314212542;
        Mon, 11 Dec 2023 09:03:32 -0800 (PST)
Received: from [172.17.0.2] ([20.55.118.241])
        by smtp.gmail.com with ESMTPSA id fj26-20020a05622a551a00b004181e5a724csm3161218qtb.88.2023.12.11.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:03:32 -0800 (PST)
Message-ID: <657740e4.050a0220.21090.c704@mx.google.com>
Date: Mon, 11 Dec 2023 09:03:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7710129492109795894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [v2] Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE
In-Reply-To: <20231211162718.1183182-1-xiaokeqinhealth@126.com>
References: <20231211162718.1183182-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7710129492109795894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808857

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.32 seconds
CheckAllWarning               PASS      30.46 seconds
CheckSparse                   PASS      35.55 seconds
CheckSmatch                   PASS      99.32 seconds
BuildKernel32                 PASS      27.28 seconds
TestRunnerSetup               PASS      425.70 seconds
TestRunner_l2cap-tester       PASS      21.55 seconds
TestRunner_iso-tester         PASS      46.09 seconds
TestRunner_bnep-tester        PASS      7.20 seconds
TestRunner_mgmt-tester        PASS      166.94 seconds
TestRunner_rfcomm-tester      PASS      11.28 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      12.73 seconds
TestRunner_mesh-tester        PASS      9.13 seconds
TestRunner_smp-tester         PASS      12.90 seconds
TestRunner_userchan-tester    PASS      7.51 seconds
IncrementalBuild              PASS      26.36 seconds



---
Regards,
Linux Bluetooth


--===============7710129492109795894==--
