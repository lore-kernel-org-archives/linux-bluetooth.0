Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0B3E024B
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581179; cv=none; b=OHRHpR3bLQ+6+GUl2u/4zfedSyJJOFecMl/LrgaLRIekpZol/571UZwEwDKVX164tta1pWdGLjLICu1NPU69L8mZFXrpQjT6Z7TFVARG6kpO+tQT+Q7U9jvsMKaVcqAYX45ELdXxbsZCdSdCXRJ1CfAxwN5+sW1m0L7AG1LfW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581179; c=relaxed/simple;
	bh=xcGJW2VPVaHa6Wfwmb7/Tfk9B04y8KDASh82R/aA0PQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oMrHIe5m5n5kd1CmHJXTrtjirhSATDK7K+FNFP0hYOkcphNYnHISbebD2H/KjADI5ck03trTbjO9afWsFlc2fT2dbFYojHntKz3DisOfo5tjlSoEmDcokYC35+0T1FygHppJ+pkdWhlh8ODpwjE4lhNP5zAd6iUb5aXYbwAoYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/ShltLe; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/ShltLe"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7ac5b4011a4so1684599137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581177; x=1791185977; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sGDtWZ/l1c3239zQSo+i1mJQESLMDa9brbapmGbU8L8=;
        b=e/ShltLeRwAeW2WRVvAqibp9b41v6Y+9sVei6PMfeDMdSIP/NxXxqPfofAv+T1Jjq+
         Nh5dAlawK+vmwloJy7UHRXeXRRi2BnRkMiBrlAH+QQ6KJ892yr5zTTJY4fUwbRz9Fff+
         3dKkPgrYtVmQ63myRjqz4mR7goj7q447F+iW9hcIRM8GEG677lznisaTpa6Q76ISdguc
         R5/wBCcXgJyMZVMtwkkZKEXFZa8iNg3a/WCifkFnXUOGSybJvjB1xw3HwGN/BZeexwqp
         do8Wl7u7CMYC1egBuStNyrU9ICXclmZmdEkdrF2hQ3JdwqAe4tY6G7UyPa60n7lNT5sm
         ZKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581177; x=1791185977;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sGDtWZ/l1c3239zQSo+i1mJQESLMDa9brbapmGbU8L8=;
        b=GmPADnVB8mtKuRa+KRe7pBOA16ga1oE6AQuv9XRQK0iQQQEE3uwJ8oesvNhFWEFt8T
         FFJsQJ+xz6HbQmDgup/wZjoITuZpKyl4v8vFpEKgcllbYHd4BFkBpNwegzwo5nJBxRQx
         BSeHQRPv22UXbeCL5XEZQF6HNNCEhmPyk3my6/eCyvEf3/LyhF6zQNqFZV594wMppphS
         xCAtHTPFtqf/DvtZ7yA/sbveW2jxnSYg722YG7xAitPAKypGiaaKpKqpFP/mJUVx4ehF
         AIh/WwA3rCD/eNKMfnBlkxfMuN597UILmTVl8j4oR3471gL6KLcYxiSUJ3cWW7OoXRpx
         77XQ==
X-Gm-Message-State: AFq9FYI6H2GUqfDFyjUnQF2semyRn0K3VLGVdMuV0F13cjQSMYQFakB+
	OA58sp03ZuKHtF0DL/GBLRiW0ijGvjXOYcoSXYUKp/3VgeB79qcITbYM0wa5ZQ==
X-Gm-Gg: AYBFou156tiFgnt9RHtS2RGwdKWQ3w4ACYVUptqK4mwXEDOYN2tKEmJPnNKMxdxCmpd
	M8CPZww9jMRKvCQIp1JJ9y7Me+wqbKIaB17XOAq2ot7Jw7uQYBLd1eTEstOHnM6fr8XAdmY+AMX
	K9Zd00AdmBWK8yjvbAkU7DtjskMm45OXwP0mogayzk3k6CXX/hyZB7dlAYD+VPxDCcDOk292YX5
	BnxIHu/UNJslGXD5HO1jdQGt4r8JHBd9g5GpE2DHm8pX5xueFYCKqlq9trWbw8iYvpYmW1pI+Tv
	sb6VaWXTpaCQ3hPWEbG3d751opdujzFXOORSFvnbdBU3YsUuocqhbmUUTjkWziUO7psIaFKAl+w
	J8NoV5PhU4/hHqjP/Wx0SuCLDMBxuo/PnnqUYFQQ49qTy6eqXndrea2jN5WBwX8T3cN9sEjsaDS
	MkiWMVbaNjv4Yjc9P4AuUbwe8jwXph9qv3jnedFFOTbkexiktw9VmMlusqOTmTRLtFku/GDSoMM
	A==
X-Received: by 2002:a05:6102:6887:b0:7b4:ab28:785d with SMTP id ada2fe7eead31-7b4ab2879abmr951777137.16.1790581177007;
        Mon, 28 Sep 2026 00:39:37 -0700 (PDT)
Received: from [172.17.0.2] ([4.229.37.8])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39bcb1f14sm8211307137.10.2026.09.28.00.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:39:36 -0700 (PDT)
Message-ID: <6aba19b8.28a8dc8b.2130b.78f4@mx.google.com>
Date: Mon, 28 Sep 2026 00:39:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2429222864685740160=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: Bluetooth: btintel_pcie: fix TX descriptor bounds check
In-Reply-To: <20260928054646.2897679-1-ravindra@intel.com>
References: <20260928054646.2897679-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2429222864685740160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174948/

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      30.14 seconds
CheckAllWarning               PASS      33.86 seconds
CheckSparse                   PASS      36.14 seconds
BuildKernel32                 PASS      29.54 seconds
CheckKernelLLVM               PASS      41.81 seconds
TestRunnerSetup               PASS      815.90 seconds
IncrementalBuild              PASS      29.95 seconds



https://github.com/bluez/bluetooth-next/pull/832

---
Regards,
Linux Bluetooth


--===============2429222864685740160==--
