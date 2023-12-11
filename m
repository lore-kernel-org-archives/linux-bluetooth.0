Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv0bi9y5"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206CB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 01:57:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d2f1cecf89so9269305ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 01:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702288659; x=1702893459; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=emXI2KDweDg9j3Mgj5x1qK3w92IkrLMbL8lJWTGhimE=;
        b=cv0bi9y5Q/YGNzEgrIDxRg97gwpEwx40hi9LftP6OBZPDC8zb0dIXLG9ApgEyjgn10
         uA+eQaSD/hPhh242KTZP83g8DFTNGLAz8gzPENVFiONZLLaFfdQeUU2lq40x6+4/PtEJ
         QKI1+EeNcziZwMX38auX2gjxR+Ij6vCA+G21KOOyFVF9rPBu7IHWgzLC1DRV58AEuLP6
         AjgsdTHbwAbhYgi4RXbgiX81REcKbIeh+3SqJQ5+AcLh3HqW2jNn9r9OORIWrmGr8Qaf
         N/TqQjhn9nTImTbAnIawEAgmZihX7jReTYZFfczH3fe+AjOxB5PWrNSIrHmZVr+eUUzK
         UaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288659; x=1702893459;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emXI2KDweDg9j3Mgj5x1qK3w92IkrLMbL8lJWTGhimE=;
        b=hvFt+x76r/kAtZzZQ4qQGHEnn0dQBPLa/8m/c3rbJkBeJqSyPftgJyKrLItAFtXMq1
         oUCmkjQrtowo0xDsuZox2WMN9he2MbvbYti1KM7CCgKs7bOIwerbm/IBfIfMnK+U9eRW
         nb4wKCv14uJHqBsDu7dZ5MZam/qKQNUUEAzZz4zNnBg35b18vJiS/m3tOwnaxSF8Lzlx
         4H85YHKc8eAheoLzvhXGQV01UwgEzn+/G/28YfLRbMoeostNgbBqJA08ZyFuip6J/4VP
         eEWZ5ED7Tyd7hUcZNFusp5U90wtTAhKL922sE5O3OqGL/BewRH+k94o6K8qMK4XaXtff
         e3EQ==
X-Gm-Message-State: AOJu0YzDWzjAVhTghn4qaWS6Q70hpKY0Abz1g2kr0196eThl2R3CK/8K
	/IpPspITnRr7uuYULq0SUgzibBc863tRcA==
X-Google-Smtp-Source: AGHT+IHuih7xrEZwZtnjCTdSVy/veSuTS28DGPOxJJYnLJ84LGhTdmxBVzqc6AlU/TxfKVi77EEPpQ==
X-Received: by 2002:a05:6a20:1381:b0:18b:9041:58b6 with SMTP id hn1-20020a056a20138100b0018b904158b6mr960367pzc.7.1702288658725;
        Mon, 11 Dec 2023 01:57:38 -0800 (PST)
Received: from [172.17.0.2] ([52.159.137.225])
        by smtp.gmail.com with ESMTPSA id ms5-20020a17090b234500b0028672722301sm7786565pjb.40.2023.12.11.01.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:57:38 -0800 (PST)
Message-ID: <6576dd12.170a0220.262f6.400c@mx.google.com>
Date: Mon, 11 Dec 2023 01:57:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8525402378467453935=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alex_lu@realsil.com.cn
Subject: RE: [v2] Bluetooth: Add more enc key size check
In-Reply-To: <ZXbWcZPq_2zIbqEO@alexlu>
References: <ZXbWcZPq_2zIbqEO@alexlu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8525402378467453935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808718

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      30.74 seconds
CheckSparse                   PASS      36.91 seconds
CheckSmatch                   PASS      99.35 seconds
BuildKernel32                 PASS      27.19 seconds
TestRunnerSetup               PASS      430.58 seconds
TestRunner_l2cap-tester       PASS      24.23 seconds
TestRunner_iso-tester         PASS      45.04 seconds
TestRunner_bnep-tester        PASS      7.09 seconds
TestRunner_mgmt-tester        PASS      160.98 seconds
TestRunner_rfcomm-tester      PASS      11.03 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      12.19 seconds
TestRunner_mesh-tester        PASS      8.72 seconds
TestRunner_smp-tester         PASS      9.77 seconds
TestRunner_userchan-tester    PASS      7.32 seconds
IncrementalBuild              PASS      25.72 seconds



---
Regards,
Linux Bluetooth


--===============8525402378467453935==--
