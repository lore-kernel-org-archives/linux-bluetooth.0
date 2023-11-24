Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7FL/OWg"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DA110
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Nov 2023 05:11:06 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc2575dfc7so14381235ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Nov 2023 05:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700831466; x=1701436266; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r0GJ2XlPTCfW9VJ8EmwYQipojEkxIKtSJWkc+Unhm1c=;
        b=c7FL/OWgJde9gXaCLjLg8335B3gkBKGAvRU2e6V5xR09Vl6Tn24J2NgHLJeneVFyGL
         uh3tfGSO/2M8yjMI3xoHqJGHYvZ4r7zMlFBoX0GaNYMS1bkcK1WzsVavGBoO591nHWnz
         8LWLUZBW7daGtmN1Yzp4cCJ+DGip0Jm+/gcLKgLJF8Sl4f37hkvHlSgeTKahMDVRGfko
         7on6OLA/F4yKzdniRTg0blItD35CeiDrMLqPIeMH2JJurfrheHdfxU+CjX6lqf/tt5B+
         +rkYr9LTmD51QA/vKtqPCBUkFv+N8JXeGrLFLvA2qkKkOunx5MppfATCAXYF4t541PHM
         fbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831466; x=1701436266;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0GJ2XlPTCfW9VJ8EmwYQipojEkxIKtSJWkc+Unhm1c=;
        b=g+Eb7cBoxMdMl9TNiENdNaQ0RefSrjYW9zDULhDbk5+Ey/tsarTKNXOkhypr4XmTWT
         KeDztdOiLlOYbF2gVBG6Hb7PZb73UXrRTeOIajJNxYBc9TPG/AwwviR+EAA3ls8p6OQb
         /MRny3+7Y3NcBv4rKpW/pj5+gitxqYp6YBPBinRt9pMiNJo9n3fMj1Ac78GSjHqaF+kk
         /nJwi4cV5nPQ8cvB8OU/8Lwrqs0vPiFv8HjgMBKYLTdASMcjtwEjbDT/OK5VORfUh0cJ
         z8NQ+w4NhrGFG3a3ydDabVb9yCrGUVhG3c5tc5CoEMZVo89srI/LL2By034Af8hQT44+
         vqGQ==
X-Gm-Message-State: AOJu0YyM/hhGNVSwdp3k3GZE4Dj1BwRI0sDMqahQIrzSRe5aYu5jCkJu
	qrlK1kej3dCPirCP5iVhWXW3+SwRuLk=
X-Google-Smtp-Source: AGHT+IEXAilh4/53Ax9R9BkHWDfNasmlc7nsXNd8WTCpvEkH98M6HWgvZjtKEFw3aceOG8F3NANVFQ==
X-Received: by 2002:a17:902:c3c1:b0:1cc:4a23:c5fc with SMTP id j1-20020a170902c3c100b001cc4a23c5fcmr2535627plj.2.1700831466005;
        Fri, 24 Nov 2023 05:11:06 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.192])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1731135pll.118.2023.11.24.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:11:05 -0800 (PST)
Message-ID: <6560a0e9.170a0220.fb436.42a1@mx.google.com>
Date: Fri, 24 Nov 2023 05:11:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4248649556119886468=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, AKoskovich@pm.me
Subject: RE: [1/1] Bluetooth: btintel: Demote DSM support error to info
In-Reply-To: <20231124124248.7621-1-akoskovich@pm.me>
References: <20231124124248.7621-1-akoskovich@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4248649556119886468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804016

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.67 seconds
CheckAllWarning               PASS      30.17 seconds
CheckSparse                   PASS      35.59 seconds
CheckSmatch                   PASS      98.64 seconds
BuildKernel32                 PASS      26.65 seconds
TestRunnerSetup               PASS      417.78 seconds
TestRunner_l2cap-tester       PASS      23.32 seconds
TestRunner_iso-tester         PASS      41.33 seconds
TestRunner_bnep-tester        PASS      7.00 seconds
TestRunner_mgmt-tester        PASS      165.46 seconds
TestRunner_rfcomm-tester      PASS      11.12 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      12.39 seconds
TestRunner_mesh-tester        PASS      8.79 seconds
TestRunner_smp-tester         PASS      9.99 seconds
TestRunner_userchan-tester    PASS      7.41 seconds
IncrementalBuild              PASS      26.01 seconds



---
Regards,
Linux Bluetooth


--===============4248649556119886468==--
