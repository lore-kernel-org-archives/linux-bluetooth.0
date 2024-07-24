Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953284A3B
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826292; cv=none; b=rQy41u/DhjtymUV4aj+bRcHxKKRDAoxT5qr+NO4RwXAamThbWk1621ISzPQWJIIto3ZxFQ/xFsyDmc6tqDTlFuUQ9aDYTWwhVThvLUpTsJDX2KKxjznKyzSVjgxzlL2CcuIEGHrz7oxOljlqE6wnbhXM5SR1+qsCvWBJsKyYh+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826292; c=relaxed/simple;
	bh=idrPpnHngaV4p//Dqx6pQMt6JCpmGJFY9V6ONv0t3Go=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=csTb/Lj5jGuuOWxFX6Djfb+KEo0bpJyCaOBhCKhMm1R2OTnYqywNcmG8JgFU8fbpPpOIXUrmhCwfGgJHEbWMfAWNsyXzCsd75zYfpkPKLTG7JcxiteVL4L+ulRSR40wq0g9Rc1cloEMNSP96VbPmqdPULcLBOcy7PjhYVb68W7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8R+o6zt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8R+o6zt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc4fcbb131so14713075ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721826290; x=1722431090; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WhSZT4B4nLNIKCqD9Jb6NRA00xY7weS1MQhhCxzeLJI=;
        b=F8R+o6ztlEE17ajDdXvEg5kj/+PIEGztvqRiLrTGPHy8LYgumCG0ecB/AdrBIm9tOO
         mGIzZcDMpEjop9fvos5s6H8hvlquDN/iZVg2y6piWdWTGanC5J5/jqMZG/X78933qrCE
         L0W2Nj/aKcFPAOKV2aRutajC9m/MVeZXYM8MtPv0aiEXkoaybxxq2S0taoFVK7DL0b/C
         LXfDMV1zsrt3fD8/ovdPqnf3EyUXtoAw9nwBdAGFZqKr2xDl+2Nec7S2gWtjb808SRmS
         RXI8wXJhUNx0frKyaQcjkPoDEH4z8SnYFCp8mtSO7n8zkG2Cu0TPPz674blfgtOjPvoX
         9VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721826290; x=1722431090;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhSZT4B4nLNIKCqD9Jb6NRA00xY7weS1MQhhCxzeLJI=;
        b=HI9onhXQg0EXeeTdHDB4y3MWVUgPdXNQjwjvfm/52O+N5HYrgMyYz4F6G39bk2Lji9
         0eVDpyeaMSRUN4c8me2YLG9Rl+RpJqg+jYBd3+4P0MNr9FGNeUiE8Ci5ZqtO8cszEVhg
         J+7DDtArhCuxAQKS3CLgImrREylklDLmSWlgWG+NUsVjKDE9SYIvHd5lFAuobUiz4rww
         o2nrp0oqxaYbNO/IUARngKRSL+fKvnpVgBzvh9GPQv2rH99PopaWyviA6wxsdXeIItEX
         0R7J/4NwpSGbfWRr4+4ol2NtQ8kBIrpQ6uRzXikzwvUgapmbUhBXFlpNe7XOK5xeNOK3
         F2JA==
X-Gm-Message-State: AOJu0Yxy6Iu1dEMiDDNABAuV8Wwpt/tOHlKWaDY2yuIYV7U3SSY3QU3M
	lTOa9K8Vz5dJXeCD+RmynsETEIoTOQq0jH3yt7whV4zH3aU73fmAFlJkIw==
X-Google-Smtp-Source: AGHT+IF/RLQGoXZobcJdCpIewk/pe8mTGjmjpW8kWJH+jhueNS+FQ63hNkdxGuxCMdHR0I/6yHVEaw==
X-Received: by 2002:a17:902:d2c1:b0:1fa:ab25:f625 with SMTP id d9443c01a7336-1fdd216fafbmr31724035ad.38.1721826289656;
        Wed, 24 Jul 2024 06:04:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.17.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31c91dsm93455685ad.142.2024.07.24.06.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:04:49 -0700 (PDT)
Message-ID: <66a0fbf1.170a0220.622ad.7b72@mx.google.com>
Date: Wed, 24 Jul 2024 06:04:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2301731755292728678=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_nakella@quicinc.com
Subject: RE: [BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.
In-Reply-To: <20240724111747.5952-1-quic_nakella@quicinc.com>
References: <20240724111747.5952-1-quic_nakella@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2301731755292728678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873515

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       FAIL      0.47 seconds
BuildEll                      PASS      24.98 seconds
BluezMake                     PASS      1736.79 seconds
MakeCheck                     PASS      12.84 seconds
MakeDistcheck                 PASS      180.57 seconds
CheckValgrind                 PASS      256.98 seconds
CheckSmatch                   PASS      359.78 seconds
bluezmakeextell               PASS      121.86 seconds
IncrementalBuild              PASS      1513.53 seconds
ScanBuild                     WARNING   1035.52 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (95>80): "[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request."
1: T3 Title has trailing punctuation (.): "[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request."
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/hcitool.c:3404:13: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        handle = strtoul(optarg, NULL, base);
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3407:10: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        min = strtoul(optarg, NULL, base);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3410:10: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        max = strtoul(optarg, NULL, base);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3413:14: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        latency = strtoul(optarg, NULL, base);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3416:14: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        timeout = strtoul(optarg, NULL, base);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
5 warnings generated.



---
Regards,
Linux Bluetooth


--===============2301731755292728678==--
