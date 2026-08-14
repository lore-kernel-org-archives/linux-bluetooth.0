Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB413A0EB3
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696709; cv=none; b=P/ctE3YJ7S4/Pj2q88ABLtDlUrPw5EqYwav+0STkiSPFH5VfUMDXCn898mXqU83ZAQQ6knAMPVPiktLDDe49JrZSItUrdjT2EHjmfZnZdGhGxZsS8YSz0hy2CidZ7FGkKsdk/Z0gxx1QaaoD+nG5xBu2/YdrWT8YqUcpzy6PVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696709; c=relaxed/simple;
	bh=XoesoWk0KoHqp75VZzjiQ4AIHLDzWs6rT+zBc7o4v7Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FUZV8Ehx7tLwXGbQRepxhr+GBQQnKo2GY/tGPoKjUVYRSonmT3GUv8bqSctWjT1S/KHvwcGzNrocpdFbVqonSqXnOaw6S4qvAcngmTs2UU+tgaCo3Ik8FXCUAs77UL+HpN8bcM+7Xns88rpVEMxpyZxFY6W1T2kGUh3MR87NABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUx5h0e8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUx5h0e8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so603632b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786696704; x=1787301504; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BkNgWTE+4JW02M9oNdUX9waSHDiYUQLf/B40FAHhxi4=;
        b=SUx5h0e8smGri0IRnRwHaYdwtKhaCF48dowgYIAmIV72vjymXVAe3a/AMYQv4ElE1u
         2B6SuMv+uyR6ZS+EiBDftHkXUlS2YYJ/q6TdVwMf/qkX/R4M88tfODQC7RaBmcvnUNQr
         fVxjiZFBho05cmWrSKPSksjlora6SLxVfQ4PoWIOnHb8CTfJ51aa0coMchsDvt5yZn5G
         Lqh9fpBgEM6xBgFeB8d6zTBTyKZH5N4zaX4ok8R5GuFldTQOIF5FBpExZE9fxbmSFU9U
         rP6BkeNgVUSptPuvDXLKs/4S7pUxd4Rd1OYCxGS/SiReAoW+jLTgoJTnoJOK90AhcZm1
         vI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786696704; x=1787301504;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BkNgWTE+4JW02M9oNdUX9waSHDiYUQLf/B40FAHhxi4=;
        b=Rg0ExRZlVEJyQbA61ndgvxnUsKb9FnVRO1Dr4Ijyf57NEgQMFqwljhW51GsUlXIDE/
         XQLlXl4Gf47dRa4LOToR2+CzQk69itsEjrrSQhd9agMnSZpZAyjG4fvnX1BOwgjlnktk
         qTmyPQ7Ns+ATOETbcisBSO6Oc2KlUFBg9OzkL3G9SPWsxaFC5c6vXua4Z/ND//NW+FWV
         Jfukt7PW1SdBdoK7wS2HLf7UGJw8vvVo0v3nXtsrK5ywJNlev6FsRkpsZB4cXQmpp0W3
         IngH+63UGO1j0E+Samg04riJ/oEcEv30lxnNtfwdYbYiDJxqzY6Fvb0gEtt+0Us1TbO/
         TCbg==
X-Gm-Message-State: AOJu0YyTBdZrrBD2BIGkurLEIC1XKJiJ+fTW8rOUYICN/9YVvq87DrFr
	zhfoN8eEKEYqZVCbkHRnqxn10qhhwjwE4TGYRvOEFQ/DpofSNLd8MXo2J2NM+w==
X-Gm-Gg: AR+sD11uiRcbGIF8Kf6Sog1GufZrQ3hXXzwUCgXSGqaPuKSPuFLKTgGzw1Z890pf6al
	swT42m7kMiYo7Y2WHXCaTuxTwFfguo+BzqctQya34dO1tTbS52FfggpetRItF8GJ/URebSKI/kz
	SIwvIiEXNDK+m4WzXkS6lTR9dLGBsqBEpctt4FHSsoXHq7/pwn9w+/GNr9mwRR9jh6NlNXAhYL4
	WM/wWJKfbF0gxCOiAIHS7wY7Vi4GeBUU96tKCrkeZS0HYSgRdDPYmVTIlY5nJowxo1Jiuyu3XA8
	8RIdCCCfbMtOpPNGvVBh8sJIw1qpC8uF26xMjQ4ZyWd8A5YMWE6AN59RW5WQAENcr3kSV823WsB
	ZX/U3PpYcJ2iqWvdcTQshKfjKrlYjEFJKFWW+wmFMC8c1PdkDzKfJwq+P053TDmxUjp4yCh/prs
	r3utxVJr9jEjRCCWDi+dDdKV2zwPJ39z9ujc7bUZsGrO19YAqiSxCfvyta2mAItcV3dZg=
X-Received: by 2002:a05:6a20:d52f:b0:3c3:a20f:f720 with SMTP id adf61e73a8af0-3cc71dc0c94mr5051962637.36.1786696703480;
        Fri, 14 Aug 2026 01:38:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.201.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea90010bsm2079750eec.30.2026.08.14.01.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:38:23 -0700 (PDT)
Message-ID: <6a7ed3ff.6c8668f2.1a23c2.11ea@mx.google.com>
Date: Fri, 14 Aug 2026 01:38:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2401848642339916183=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: btintel: Bound exception info print to the received length
In-Reply-To: <20260814080123.902388-1-ali@iusegentoo.com>
References: <20260814080123.902388-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2401848642339916183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145926

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.95 seconds
CheckAllWarning               PASS      31.46 seconds
CheckSparse                   PASS      29.62 seconds
BuildKernel32                 PASS      26.95 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      519.10 seconds
IncrementalBuild              PASS      26.44 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/580

---
Regards,
Linux Bluetooth


--===============2401848642339916183==--
