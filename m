Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58929236420
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852506; cv=none; b=FBRpKwfOjcSHsOBBbgFHJFYFT1qh0rxgT/x2QYlc/QmVHmBDSYhIG/NqynkEZJVNBL6+iMxJSy6WXcYnw5DuqR3un3VDHIcIFEAuDRvn9KWlQz5/PFlEamqKmOnZClWkceEYQXU7mGFhFRvpxTSrsIoOB+CL3jeILIqnxLaf3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852506; c=relaxed/simple;
	bh=ZNmh7YZuHearw8lDa4vjlAgpCc8b6WxJBj214J7baMo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oVxBSMzYHN/DpfNqlV5qU+nhHKvQ6QxHVtt0arii9WqU2yaPiofAYDXWX7wYRLMzbsF8V/1gLX2/Mjo/jS6Q9aUuGBi4y2fOBstDfkKQhf4PudCUZkgg/VsnvHWYEd6mJtyE2LtKmOQqQdgBMPnO3opR3O991KT6vmj5Ms9IR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcFGCBWP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcFGCBWP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467b086e0easo5318001cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 06:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738852504; x=1739457304; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jOWnP+hs+tCrbefp1Oba46A/JA3SeEvmam41cX9hsDI=;
        b=BcFGCBWP6LP+Bw1xr2GmXTgYzenAIBjHNDwRFieQR9M0YRqU0xc3ACKyvyptAB+rQQ
         40bPaA7DWF3w+vIGR6YKcDoLb8vwIvhw5yLFrwqnzh8D2n+YFLbVtmGFYBk5unMlpBOD
         uaeM8RylNHY0PW608O0wS+ynu9mcF+S4Y9Q8lFeiuFTQ8XqZkn5bN1rpqv7TiZvB0ftI
         e09PukrHnlgblTz0QirPC15FBNKB1JqiaxfyWUkVFqsvklW6NbcWQ0TY+MtU+dDvt6+1
         8Zpgs1mgkdg13TY9pnN7S7ljRstr5E41NYrwxjHIf1qX0U7jHQ7BKPqjxyHifFFe2Kkt
         TugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852504; x=1739457304;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOWnP+hs+tCrbefp1Oba46A/JA3SeEvmam41cX9hsDI=;
        b=RohGHtjat8PGkfWSFubOU54Q1amnRDbIWYdPXO9hzzGv+IbaybrK0FWYpYBjGlCnty
         ZuA7JrVT7fnqcUNcpWEBKI4AmQUIR0gdBxwFf98yEH0fTwd9aoGUzgTj4fla95RcPW1L
         NggTdxCsx6bY+YZHNm1MPkL31kaYVZEJBZEYlBCDldTFFnTwChbv6fscStAN7rTBcsgn
         TzSKORHByV9Hv8w504xksnYO+33Bhpru/viAMq0DaSRVgNgE9YVmCZIrLCTpELie5kQS
         7CCii0PiWmnKU5P9eZvnnyoyLOXmlHtT3O5Xzn+ouAbpdFvUfIv2715Ib2tcNoNtQkOl
         e7XA==
X-Gm-Message-State: AOJu0Ywa/qd+osNnEddL8o/D29aPwOI54p1v4L/qVZ3ZpkNXzBuTvCF+
	ymGx4U1zXnrROFpRba6ZGlC23Y3myM2G7QPOdfNIFHfg0dFgll0ofaqWnQ==
X-Gm-Gg: ASbGnctu5HWjggHQSIqX199HsOkUyAmSCeN5rb9veBhN5ZS65f7BYFPcX2y6O57VkDh
	BKQ3yfDfDcjZeReNjYW1HUaNf18o4AOB8Zd+IxSV2eHDcdYemuqBYcrD6Qw19PDOf5/Yc6OBqVB
	ejFtSO2kQet7NCtNKEbvUIDb6vIfrcpUg53cO2Lu/PDKfa8PEhJK1NfiPl4p59f011CsSlkIvCw
	S+TPgTiqIq2nQe+Kfxg1NIMIaRNELMq2xb3dWd/b0ZhJl1oMMGYvTiJnbUxa7WeSgoqBImaebaz
	ODfvxkL+dMgxJW4i9YsZ
X-Google-Smtp-Source: AGHT+IE37xT2Si08dcy2VgZMe+eGr5qOl+3oD9VzZk5kmgJ0E65UCCNLmfjpMsRHLqrPWC7Ne3sWVw==
X-Received: by 2002:a05:622a:1a99:b0:467:86a9:f7d4 with SMTP id d75a77b69052e-4702818750cmr94532931cf.16.1738852503854;
        Thu, 06 Feb 2025 06:35:03 -0800 (PST)
Received: from [172.17.0.2] ([20.25.204.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc75aesm5772491cf.64.2025.02.06.06.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:35:03 -0800 (PST)
Message-ID: <67a4c897.050a0220.2beca2.1e7a@mx.google.com>
Date: Thu, 06 Feb 2025 06:35:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2593745220501406224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sanchayan@asymptotic.io
Subject: RE: shared/asha: Add support for other side update
In-Reply-To: <20250206132548.363559-2-sanchayan@asymptotic.io>
References: <20250206132548.363559-2-sanchayan@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2593745220501406224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931214

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      1585.61 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      163.68 seconds
CheckValgrind                 PASS      221.51 seconds
CheckSmatch                   PASS      300.05 seconds
bluezmakeextell               PASS      100.56 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      906.62 seconds

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


--===============2593745220501406224==--
