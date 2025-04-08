Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE020E32F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151508; cv=none; b=b2ZJeIDFVkqU0IsCi1ZCpE99nkVrDa8zuH5+LSsRvCVDPAO68GMjfKGrRTX0kmdQdjow2YhUzeqkw5DBx1GKhS1M6l+zOdnojYZN9XcMySxAKk8bsRBUTui/Cofd3lM4rPc2YgJ1N2Vzt2HYLPQFehw4r6vd3vg9rMY1s4Y948Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151508; c=relaxed/simple;
	bh=Ba6xP+p0vFZjVuSbcGdJp0CyiqObRIakyc2JL8gPjeU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YHkgyz0DetsN+9gzmwb6FfpFdl9iN9LXYvWWajuNcpwJ5NLjzfRF4ttkwA1Zqb/Ra0klwzEtYxWaN6q8J3BwVFt32FX76Ukftvpfy9IWCKwWijnTx8CkWgksapMF8gyekshRfTNaOZnaYtoq3WiTo2d/axcQTxOlmZw2SMCUMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr72/Bdl; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr72/Bdl"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c58974ed57so625455585a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744151505; x=1744756305; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3NgEy7hVx7eVBIyzf5MxYgVUB3Dv+UkGVFLZ8rsGNWE=;
        b=Fr72/Bdlr44DRZvmvgj+wZIcdX8gzETUCzBZHrb8Dlisro17UMEFazbZqci5NicIUW
         KaULBMYQyw1K8ZCH4OBk/hgWgzLKojIeguTTAhWKDSqxOAQ4rHxeulIFu56kYVxik80m
         OuSqGB3JT/fDpqB+TYOLNjdjoYSAS0o8DS6yjVr7nqW3BKwFY2c+7jsXdQYs34olP0s0
         rY3Ye6jatyqMtJ+M2pdno9Vo2PBTA5JiHTELR6P9RgYtC8uirAdCoh/+c1/fXVoPHLbW
         NMKGSw2b8R68n5w5b4nfcB4dvjFeC3R5UH9LN8fu231cjj9QQY8FhdigIX1Ik/oL0Hsk
         xiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744151505; x=1744756305;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NgEy7hVx7eVBIyzf5MxYgVUB3Dv+UkGVFLZ8rsGNWE=;
        b=VGA9R8q5Ohi3C6L8lzh6LHCSxERmK88VZBAD2X5qEiLKRfRH8kGXHsnpB6cKtBCKEa
         R3QbxT/35EHOY02opsd+mlNSi00CK6xX1h/rhRRL8M22itWpNi0A4PtO4MPOND3wBU7l
         1fPZgn5JpHrc1rklxakUDV/k3DCd/P+Vxt/ooXdfuQfSOMoA3a3phK2XlariSL0+OJHG
         hZQDm9zDMo4XWrnWhR1aJFq3nCWMx5zYfryEcHaqIkJUQODRzEqlRAmoi549LS0/yp2R
         niFXpSSYgd4hblhQUcjujS/VFuwJg1Kk40BpRVbejnyAKB36xzwLkUNT0vNRTh+sLUK8
         6jPw==
X-Gm-Message-State: AOJu0YxUtc2vVJsavV+PxRthMd/jo6SloKjxNPAXAra42mZZ9O6D53/V
	JG2zA3V9T5UwD/5n9oWhuSa7CkS1G/1vlawTZg3jL2SXjKMcb9lyv8vblQ==
X-Gm-Gg: ASbGncshuHaLsKvBjcPt6wZZeRHxzhm3EFXGRji66lWviI0I/XEOPkGH6xMnxX9kYYl
	RK4jR/AG37xkfyfxRe2aVBhmxQAn/r1gQTHngVJ8rnna8Jy0TPPCYDZ99PiBDI29uAPHoigZQVu
	DcF19+bsbGL+asOMTu4emVVjzRGe5TVZPPjzMZ2b6QUiMTssif6AZQYEkVD3vqdwL7FmsnGv6lw
	LJynheEduq/7MVI4Czs0Rk+EhTAXaCZghnIAV1ynYu64rHUaVWIPFmdSTGgqGSsFRboLPbHO4g/
	8bzZscttyiwOz+M0/+MvGF1sTMv8QtZiQuxl+VXw/JSVslPbXwWUOJrbq0/u
X-Google-Smtp-Source: AGHT+IEV9sXJRhEywxLPsPChChRF1h0cdS0v2KspghXpx3x/Yv8nQtXPJFSNuLaCs8Nfn2JsMsp7Eg==
X-Received: by 2002:a05:620a:2548:b0:7c5:5909:18f3 with SMTP id af79cd13be357-7c79cc3561bmr125041485a.37.1744151505363;
        Tue, 08 Apr 2025 15:31:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.63])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea5a897sm824073685a.74.2025.04.08.15.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 15:31:44 -0700 (PDT)
Message-ID: <67f5a3d0.050a0220.4e234.a1f8@mx.google.com>
Date: Tue, 08 Apr 2025 15:31:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6949487550034546375=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/3] shared/io: add watcher to be used with TX timestamping
In-Reply-To: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
References: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6949487550034546375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951281

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      21.00 seconds
BluezMake                     PASS      2613.93 seconds
MakeCheck                     PASS      19.83 seconds
MakeDistcheck                 PASS      198.31 seconds
CheckValgrind                 PASS      274.35 seconds
CheckSmatch                   WARNING   302.66 seconds
bluezmakeextell               PASS      128.49 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      897.96 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6949487550034546375==--
