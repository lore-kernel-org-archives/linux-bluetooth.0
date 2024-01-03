Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF9171C4
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPrOzrjY"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7811db57cb4so6952185a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 19:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704254189; x=1704858989; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bHjOdd7+o9sSVlbCFJZu25EzEfHl8jywBXEsPklfM4c=;
        b=TPrOzrjY6rQAj8MciLvUM9E/ewVCVMiUBHFmze/NAletuvw3zhUE+RHKlWJZPzhfTe
         JIxVwGX2fiICXd355bQvIExMtJOKKs0e347LDPEO58NojOUA8EH66vjn2WPAMMzq16za
         q79n9mf49ls366Y6Bm4j9GVxuRkue1aeRdRx5nQpGSkBYeaIeGaGCVeMmtSQ5MpgfYUo
         PLIUGSR3lgr9j9LBHI75UBhcY/FiOiYhKE5X5YZWNDQbdYH7V2robpY1npynhw75MdnX
         7j+TAI0po9h6moeRFh4bJvSNVQr4TksDwDhY63Y+RMzttwjEb9Q5GrvgPGAAjjrPimzE
         tspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704254189; x=1704858989;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHjOdd7+o9sSVlbCFJZu25EzEfHl8jywBXEsPklfM4c=;
        b=cexdGnYA9qlOWcoc+BvKuZiqCZcg9DZzwyzdCK6+F5GOtwRiSClGAw8n/fExPX1Teo
         j+FwYSEbBWfp51vJqbDWbw1ADam4LP9bMwH0uKagB467JOCTkQAkd1YalmSIvXjXLZJ0
         e3new+frl1eHr+HiAlZrfttjJC9Vs+HKxtf4G8SMKMXyBpuGriw7G0iaYnkkwgUq10qK
         XU7CU+DqgRfLDSTnpzNfclRnr4hPcsVo/fSM/caRP7TcZ8pXBmNeEO9pupo2YfCyHvU4
         BsUlxaT63coS6DKfiLWU8mYEMPLgySEOXHVXSpsl71QzwMSvICWdHFTRrg+icEnW0Crl
         lQDg==
X-Gm-Message-State: AOJu0YxXSCQsZo7R5zEjSHRq/TFM2CXIZ2I3xQcpzKLIUKCGoxoz+Uqa
	79MgnbaXxufgBbY3/RnZMcAxiLgvZh0=
X-Google-Smtp-Source: AGHT+IGTPXYx9k2KHLFGMIbadh+zQLncqiHRoBR1kJlAQK3URo+vhQXsWzlNz3Y0p2LfEOII1q2unA==
X-Received: by 2002:a05:620a:31a6:b0:781:b188:c7ec with SMTP id bi38-20020a05620a31a600b00781b188c7ecmr836587qkb.74.1704254189181;
        Tue, 02 Jan 2024 19:56:29 -0800 (PST)
Received: from [172.17.0.2] ([20.109.39.177])
        by smtp.gmail.com with ESMTPSA id v2-20020ae9e302000000b00781d4c771c2sm1262701qkf.60.2024.01.02.19.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 19:56:29 -0800 (PST)
Message-ID: <6594daed.e90a0220.d653e.363c@mx.google.com>
Date: Tue, 02 Jan 2024 19:56:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7281901975595815956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 20373622@buaa.edu.cn
Subject: RE: [V2] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
In-Reply-To: <20240103031410.3262524-1-20373622@buaa.edu.cn>
References: <20240103031410.3262524-1-20373622@buaa.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7281901975595815956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813991

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.06 seconds
CheckAllWarning               PASS      30.63 seconds
CheckSparse                   PASS      36.02 seconds
CheckSmatch                   PASS      99.18 seconds
BuildKernel32                 PASS      27.78 seconds
TestRunnerSetup               PASS      435.47 seconds
TestRunner_l2cap-tester       PASS      22.88 seconds
TestRunner_iso-tester         PASS      47.18 seconds
TestRunner_bnep-tester        PASS      6.86 seconds
TestRunner_mgmt-tester        PASS      159.08 seconds
TestRunner_rfcomm-tester      PASS      10.80 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      12.05 seconds
TestRunner_mesh-tester        PASS      8.67 seconds
TestRunner_smp-tester         PASS      10.14 seconds
TestRunner_userchan-tester    PASS      7.25 seconds
IncrementalBuild              PASS      26.16 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[V2] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
30: B1 Line exceeds max length (81>80): "V1 -> V2: Removed the direct check for `conn` being null in rfcomm_check_security"


---
Regards,
Linux Bluetooth


--===============7281901975595815956==--
