Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFD757EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839615; cv=none; b=svy66kWawUVWJio45fyaT3/4W4uTzn2g72sivZShblClFYYlPezni8NzwxMpkQPciDhIYLiiFsg30Wzqm0Y2KuQkhR02mFe9QH1H/0lbebp/gUcS0SYpRTrQPqh+Z2R660XQaErZ/LqPEXvIU14Ze3xqLYgDWwFmJF9kLAdyntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839615; c=relaxed/simple;
	bh=0FWQnxA0RRta0qKV3xLSRNO7F0tDHPeLImbWgbRt8rY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JxCGrxJ2iWr+wsmdeCmnPPd/vAvv+5ewWnYHCGxrawJ8RsYPbRkMHBJRnJQm+WKjzHnxb2sXd6t+h7gu7muL7A/f7WLQrQ3YBECZ2ayJvEKTVK16RFZ5eyZXJS0hN2erp+C6W/ThlTVy2WzLmFnD73Ju2ifyC0v8cAOgjFOuOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzl+wSHv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzl+wSHv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2349f096605so31639415ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749839613; x=1750444413; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yJbrXKl1gxIMXIeieVv7Jdihw7wTlVIBRRXjydMZG7A=;
        b=Mzl+wSHvpcMWB4ryl04PDYvUFPxfSKnr8q0YI0+4zFGH42WBF4A3ZkgBgChEE9dMlm
         Z3sSTxsF/sx0bxEtyDhT2tYQesvRfw9reQUZVKWkyxjqMSqSt86XhhzzkCVh9yrM20SG
         eZik3V5HhwwfIliKmG2gdAkoToZwbkt99sq6hQNc8VThyii4+dvcbkdKWqsnaTlN6xeK
         baZF/GPvmmo1ZbUZFPGb4EIvWNDiiSs92J8vs+CvERX/dBLlqUg80szlUgkNLW8U0Ds0
         yV3TOfvKzIhgs9N12/HUD1VO0Q1Wdy7mzn3CmXLeeIN/4zNKzIjHYU0VnZZlRCxOBOSe
         IKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749839613; x=1750444413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJbrXKl1gxIMXIeieVv7Jdihw7wTlVIBRRXjydMZG7A=;
        b=V2RaPytXgOiLprDeVCHqsKQegOIiyf0Ej7Rb0aMy88FfuAIuwRUe1HQn2YQx9SkU6f
         76BkN8JV/Ho5avdIiCNWgA5jBUjaddy1SiF8BBv+qmcnzQYaMM2AHX0T1JUjxvxNdbb0
         aH1Jp2nXRnInjUfbOoYJA8gMIyoS4p2LonK7gbu48GChnlvhr3O83S8dAsK6tY5tbxq0
         N+C0jG4WQOhpSXNf/ypbdL830qHgNK0N6faOLviuHpUVtYGCItO0emjf58MR4mP/YjtP
         ksefWbcH2WQlpAYKHSgggdigFWDzql5dqa2Ek6tHqMHm7BOAa6bNlhQupdjK4Gcn3r/e
         wVxw==
X-Gm-Message-State: AOJu0YxoKd5S4/rol7Oqdi7YRsZ+vCj5456+M/mcMYDdMsZLaIlbfh9X
	zEVRSf+Osz5cocp1WcGNiABb63btmYLjhRzWKSLxllb0keQUP6S/jeB5FMTWrw==
X-Gm-Gg: ASbGnctow0amFDS7+P1KZqEWy3JRroYO/QItMcElVlksmG1tXpUVZimf5NOOueTFw/0
	S5KVI4stR5KZ+R/CG6McXqqriSJ1g+53iiB2pauPCEMRjiO7ZLWWk/x/D4RHWCJfsr0zlb3Attq
	9RhLUrEyN7OmuQIiCJ5uTo0cuqSEeu6VZQXiqS7i9RNR73xhknw3nJbGp+8Mo4EGb4SgE2Nipz4
	UwEOoAns4UaaXlZK2B9JCv3vyTo9tDjOokMoWghZoxuMHLVjd+q8SNxzzZbnMhSfEZIv3DGGPQN
	sI/ENQCzDckyfQQuq50CsGNAdqAdAX+lzPtU/54Pt5OPS83Ekv/rH8qT/RozNsNtfg==
X-Google-Smtp-Source: AGHT+IHeriMp858MW16tX22tAfGY804Su5RO+LgQKt8Ckk8w7OeebLxhUKK9Zn324alNj58ZW6t7IQ==
X-Received: by 2002:a17:902:cecb:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-2366b3c38e6mr6627725ad.37.1749839613342;
        Fri, 13 Jun 2025 11:33:33 -0700 (PDT)
Received: from [172.17.0.2] ([40.78.81.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm17784505ad.163.2025.06.13.11.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 11:33:32 -0700 (PDT)
Message-ID: <684c6efc.170a0220.3616ef.fab6@mx.google.com>
Date: Fri, 13 Jun 2025 11:33:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7012479693125953939=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client: Add prompt to enter metadata for custom presets
In-Reply-To: <20250613171209.2108815-1-luiz.dentz@gmail.com>
References: <20250613171209.2108815-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7012479693125953939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=971929

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.08 seconds
BluezMake                     PASS      2768.24 seconds
MakeCheck                     PASS      20.72 seconds
MakeDistcheck                 PASS      200.48 seconds
CheckValgrind                 PASS      276.56 seconds
CheckSmatch                   PASS      304.65 seconds
bluezmakeextell               PASS      128.88 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      915.79 seconds

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


--===============7012479693125953939==--
