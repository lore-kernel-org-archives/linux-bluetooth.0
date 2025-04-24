Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDB1A255C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514267; cv=none; b=uRwuWXZdhzmympKt7VVCqJVILOc6hACqCmHP0QAS2tyn4lZQmrOUa5QLLDrfJiOnx/BdicK5R4/SngiNOVlPKAc6ERr+ABB/LhhdgzwuV0NDPsctzwt46ScG5b6AEmw/9PsNcbgZ15nmAwlXMXhZcxOaTTnZ378i6kquwW/YSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514267; c=relaxed/simple;
	bh=6GYe7aVZfYJq5jO/4w5JWshX7Zq18ZVCUr+IuIWEmPw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EubimUFX9D+cwQYakFSQsvZWdepgTvV/7CGaQ4jbDtHqGVOJORCLeZHlSqbORfzxuRIpdsdmnxEMOePtKXfJFi8MUjVU+Ey/gu5iCuV695uJ0L/kFTKKmBr1qxusS4TZrSdR3jsaS2Bt7+r19FZsFFaUAQpCrIWNFfjHSvp9cXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAMTq3wr; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAMTq3wr"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so28293376d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514264; x=1746119064; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfs8Gzqi4mePvtfC5J+JBIIbtoekMvWRSJ4h3QbxYI0=;
        b=DAMTq3wrH+eEpe+tdVXdpyjyroqhjwgnAZhEQXJTL/7joE2dcP64HwGpEKNPcNEtis
         hjJWQnHf2frX3o/r42o+e7Gfcai09BGMfMC0jJOAF8xNSBv4Bmh/EprVoebV79ewF5q+
         ySteRzijGBvP1BZvYKXkjneUCIENrG5o4OYiE203lCx/IPI2LMdRJo+DV4FOENXLnGSR
         slo1Yy6svtndkT90op7eVaRU2Y351BPx7bG21xfrbzVPM+ZiMIAuOo8GDhgmHpUSiRoF
         jC95O1jkwV9RYN6/Fxg4gzxQNO86Ll2mHbd9HDxQP8v3p6Uey9H7hQBHdlg5Jf0eSMpi
         Pg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514264; x=1746119064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pfs8Gzqi4mePvtfC5J+JBIIbtoekMvWRSJ4h3QbxYI0=;
        b=ay9WXzayJiWwhVP/SjDKxD5doB5mGOLfsc0jhaE2ft5YRzwqIlftnnSwW/8F4x9rni
         w0BIVWzqVCYQHsj3i93gZuiRXn5M1naXwcQtdYnX+zFWt/ks1sHmsoOp80bgVK6PPr96
         YcQfUqrwRugRF3dk7rct8pMP4N8XxBS7qiPTB5Gh2n852RaS+3TG5ut+tn8thl9wjYoj
         RF+SAa/E6Yq3aE8pLBLmZPYPTx7f7vrf2TJArMAMAdB9JZtq2vpbblFLyCzBsklVNLKY
         vk+iXaskszHFaldPkQq2V5trxZUsyGy/TW7SmiuPv1LPmNlkiLe5TlPYxjx9BTalfZBk
         h4ew==
X-Gm-Message-State: AOJu0Ywc6H+4dJaDlZ8HUG+ZOad8tkP+OiAKXrlgh1SHw+obD7+yivVr
	hKcw43580bxivaKi+M/JkpAIaDCBOPkTs7P+tSjmUtB92y2klErII1iqEFhJ
X-Gm-Gg: ASbGncvS0Z/eicc/qW6QjiGekUyibB+JPkM4qw5ar0yBAYF+Ad1C5qrXeFkajwjkH2n
	HoCEtSNU08f0VM87RBlk/irtsb1SmgcXn1W+l9Zr4Nrv7tZLLGucVNLS5pQ35XmeiB+f9EnV90G
	eiSP2BqUUBgWU/11EncQu+7JRZf7nxE6ScLBM7Jm9T5jrmkqtkx5FeA7NOrAa6Yi/g2Hp/iU6Rk
	Xe3Xomyb5xEXyylZNyFZjsBv3XY4Jtg3gTYQPv7QR3m1iY+1f36qEwzXPZGSl5IvNjKFNWSk9zj
	HDWkdpz8ijoyicuUX4IvCk7QeE47MBzkBy4x5FAP9XbSwPE=
X-Google-Smtp-Source: AGHT+IHhseDZfZi1QzMVDu1KuyDp+7eqhoDlrUys0qnFCrG1Lg80lIOgcs1jkHC/XMBFoEOErbbLdg==
X-Received: by 2002:a05:6214:2b05:b0:6f2:b9f4:3843 with SMTP id 6a1803df08f44-6f4c125c392mr50911036d6.22.1745514264074;
        Thu, 24 Apr 2025 10:04:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.17.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0a7429asm11334966d6.69.2025.04.24.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:04:23 -0700 (PDT)
Message-ID: <680a6f17.050a0220.233ddf.5f81@mx.google.com>
Date: Thu, 24 Apr 2025 10:04:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0850714341124602396=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ovlevin@salutedevices.com
Subject: RE: device: Fix rare ERR_BREDR_CONN_BUSY during connect
In-Reply-To: <20250414115017.116579-2-ovlevin@salutedevices.com>
References: <20250414115017.116579-2-ovlevin@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0850714341124602396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953043

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.85 seconds
BluezMake                     PASS      2833.99 seconds
MakeCheck                     PASS      20.23 seconds
MakeDistcheck                 PASS      202.74 seconds
CheckValgrind                 PASS      280.88 seconds
CheckSmatch                   PASS      308.50 seconds
bluezmakeextell               PASS      130.29 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      920.66 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0850714341124602396==--
