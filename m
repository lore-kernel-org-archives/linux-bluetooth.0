Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F21FCCFF
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963106; cv=none; b=pgfRfcFMMJKzXAJ0oHSAilFHyVyyO/m2DURF3OlK61/FmUKneOhLJyV1jQIFuyc5JcvFSrxK04XR8Ci9kdlviFsHjdL/wOsAIiBGkvv0IJwoblmd/RJ232zzTtCxW5gZLls6hEQy5rjkBjfrHd/MA0atNQFp9aVwJuPU3+Ji2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963106; c=relaxed/simple;
	bh=OyFTCtMoISL1u5Cpc63G6/l1zR+n9ix8TGlZmiTEYsU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JWrBX97msz8EYgF25vD66LIkEZnem6MtfxOjUYpkioUXXsU7dfH4d0e2mnuETDd7i8z8ZTI2wItmmqnPhu8uURUF+B9C8wR3BI7GcXtLC8jDZzbFW4nanAq7TBrYbXf8OXgAx68K82GoLxjfqcm2B0X2/ptXq4MpHIIfmWax/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7JenS//; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7JenS//"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be8efa231aso419380385a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737963102; x=1738567902; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W8Rp4PylMXXqyj/1FF1FZKpmEvzy0YO43wAtWQHll+k=;
        b=O7JenS//YFJ8R96QI/EfE0bJ3+ygpP8YqWcp8VN7ccDB/0jr1hO+rfjImIKL/nv8qK
         PO+TO/vWOsmIO2NkPsaX1XhoPE6NYXqytVNciGd6sdlq7HWNvWNpPDShCjROTFwy7rQx
         tNAD5g9EoY/qbTKFyFz/lrcBiey+4N2fUBje2m2DJfxj8bXk1xKySWHJl/vi3DObKcqG
         l5z8QL5w3kYurpxwi84popXtQ4YlV3NRs80DXYRCm7bdckcKo9oJzpKGPFmUUPZynWml
         qMxiytVWDqTDljXFOP3A9OAMpLNFRtOKG3T6XhPl9wi/V6Y/J96IaDt5BzUMs/JNvQ4J
         1LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737963102; x=1738567902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8Rp4PylMXXqyj/1FF1FZKpmEvzy0YO43wAtWQHll+k=;
        b=l9IbP94GxQq5k0FENIE14xrBMq75qYfoV+r0nlt7Tai6jcML02A/WINlk8Cn9E7/Yn
         k3KNPsOnOxJkhARMSu8/IltLjcHrU+JySv12uwngpsMps4lGhCeCo65T5RuyNMiu2ibt
         h0bRxW5t/ttcTFH5eWUJKVLK001CRxY0Y2vAySsHcXJwr+WIj/AjBUW7iMazCov0bXEz
         4HUcE/r8GkZK84iJRY7UG9HT7xb49GB7RzqMNBHM0Ic6KDZYSI1Q/+nTn4w3PXFIlSpl
         ZfZX1o0R82OZ2FHR2Q+3FIfJymLTR/BbzhN5oAPY53XTWgTiDvhgzhQLvDbbt/PXQGHM
         0xFw==
X-Gm-Message-State: AOJu0YzinAO9CT4yzRPTntdAyvyELjEv3tMVOyLPzGK9g2LzjkSgM+u9
	jv5hQEdnOIsgKMQaNt0kdyvMfkxf8gunQcF9YsFjcyKbmLcythMKoGlO3Cil
X-Gm-Gg: ASbGncu/wMRjHpz7QDs77ueg2Bl5l55VXRzNbQgDCs6fAdKXs38pQkb4EEhJTxwr4Ym
	Mq+3752tN2Tg0tGwt8udcXDE+DW7ihSusHAuoZM+y5jT6htGocF+KNs65BdmvUE7oseQUw/gUw/
	MXUEeLtUTaDo7j5+r3guFQ3RLJ5RIc39bDNvlabXwfoCgir7FebG8fSZ6JDdab9GdUzZZHtam9T
	+Ld7uT6a5BBEeJQviL865OdYYEvRu1VAZl7drWgKc3SIHpPyiwNf8n35XmwaHpAJQu2r5Kktomy
	4LePXWuIXNA=
X-Google-Smtp-Source: AGHT+IEVwAEWUGrlQsS+KQBs6EEibq+h+qAd81/13hqBuqGaEch1z40YHvkkVH8dxSY0vmhn3h5yow==
X-Received: by 2002:a05:620a:4453:b0:7be:2a68:6d79 with SMTP id af79cd13be357-7be6321032cmr7513925885a.7.1737963102513;
        Sun, 26 Jan 2025 23:31:42 -0800 (PST)
Received: from [172.17.0.2] ([68.154.30.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af0d1fasm359697185a.98.2025.01.26.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 23:31:42 -0800 (PST)
Message-ID: <6797365e.050a0220.24d7c0.d084@mx.google.com>
Date: Sun, 26 Jan 2025 23:31:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7666059955233253312=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v4] Bluetooth: btintel_pcie: Support suspend-resume
In-Reply-To: <20250127124908.1510559-1-chandrashekar.devegowda@intel.com>
References: <20250127124908.1510559-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7666059955233253312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928464

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.45 seconds
CheckAllWarning               PASS      29.03 seconds
CheckSparse                   PASS      30.35 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      434.00 seconds
TestRunner_l2cap-tester       PASS      22.21 seconds
TestRunner_iso-tester         PASS      32.08 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        PASS      120.67 seconds
TestRunner_rfcomm-tester      PASS      7.72 seconds
TestRunner_sco-tester         PASS      9.47 seconds
TestRunner_ioctl-tester       PASS      8.19 seconds
TestRunner_mesh-tester        FAIL      6.25 seconds
TestRunner_smp-tester         PASS      7.13 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.101 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7666059955233253312==--
