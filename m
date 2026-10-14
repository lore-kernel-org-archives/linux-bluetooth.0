Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5A5013B4
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982539; cv=none; b=McZSNe1e1uo9PYSeTxkS3ZOTq+LOht7ntq5i6x1vI4pOX2FnLivJ1Zs+yqqq7O10+MSVn5pkGBI2ng7oygUZLsrOddIuNtxmhpqpkYPqvdSQOVdUw+6L5KTOgo0Jot4S7Hovqs9MSV7479LUhWF3cV0cXP3qdXdru1lKqxxNQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982539; c=relaxed/simple;
	bh=QVyVmaAiGFGIhsEF98vw555ejx19adnTpYt/8HICQrQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TZKvp3nnTlWKt50FF9ZQVh3b4BDWBA+CdMHNBC2Ne/4w0ECYwrHVTO7YzvNw7IfVykq7OlDMZDvyAFfgFtpmlKlzE2p4BBD98x66LqG6mk0mcmpu+Ve0aLmskJ8aOetTSLObtT+/6SfT6ycuueS9Jiv1dLyvqw3wNW7sHQtlS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfieqamZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfieqamZ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9178d514951so2759636d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982528; x=1792587328; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VJWSU0WG/J4Ps+Pm/c2vgbRUV4+OSX7CjZaXkWpw+2E=;
        b=KfieqamZFQ2f662t98e0rDwRtVVLIaqz8Lzo1ik3ucCIR5SDhALq6IAnjitD6leaxG
         gdWR4YkpveCLvLBHdHlV5JjKjOfcNwHAedPMwXmCw4W10l74DV6t+xIBz2y7iTX5PGiN
         pDSnV6LPFGsY6JqyNwajvZelg4Ky0v84GXKSx4P4xeqDCiOUsPv4GBnsg2ereTAjXrZR
         mBLFaIrDZv2nOs7UjQ9I5lQkjbjRJe4b0xk6Y0A+i8gRlleE6GXqwdg+8DYVaUvXz53Q
         BohXcxOhDbqqLwhN8MSBuU362qtFAKqYSah1souIKqsKmmJS1q1Jt20CDcmW3sWCwUBH
         Hv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982528; x=1792587328;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VJWSU0WG/J4Ps+Pm/c2vgbRUV4+OSX7CjZaXkWpw+2E=;
        b=qzK0w5BwV1U+rGF9LUaRBf3VMogDnit1MPbz/IIoZwawEcgICgxatfmxayIG8YyIWU
         lZkrWHkPuARyx1CI0OVal4k58yhXAn1+vxu59buaWpFgEaNPATCgi+9KiOptOY9+c3fC
         R7sWEX64c08gzvWYBZNfHCSBO7KDj3LhGxxIc3p0pDjwxwiTyDSRdMFmVyh3IEaJasku
         FmvNmt0fIPZw68WeVqbOlSHbWzn2eujSG7SwE5I5ki356SlKVL0K7m1jSGkwsVQHAQAh
         +p7EzbTdf3eg9IsjM0NCNAONKgDGJNK0ya0dLT+ZDpzaQnCttpC1b9QD4u0Mro60kocl
         v+eg==
X-Gm-Message-State: AFq9FYLlFKpu3r65sV3orejVCgYueYHarz21iEjcndFJP8bvmlZcYPj3
	Hkdbhy3kDf9/Kp67j5byuAAYxbE4opYYSBXul0iBXZD4DEdRZMhpGc8cZisDQA==
X-Gm-Gg: AYBFou0yFWRisT1QZLWgRD5Ojgrjcn2u4irsDyP+9i4mOPVLDTaCW4gnvetvSlYYfFi
	2+81SzxbB+gsWo166/A+soAWZuKFTfI+XlSimkc+jTJQWBPVHHF/rtOX26goP10j8WgIEbJCIpJ
	KdQylas0ZChKdzXs9AP6E046cnRIc6lnxBGlEextrYyVfbHnz/CKGVwcqsof3UwJe8Y4SFTdFJK
	OKjqzLYqCKkT6ARLdydVxNJjMDHG6S35WX9Td3nwIdjN9yY0qSOxq/x1XCMkAtvlLMsUZpx1HO1
	10AdQ/FLizKkpF+LWxsPeYTTkFQScSQHROf9dwrW4Lgm87LA6ZrtgNtvNOEJ9C1C/j/Wp46fPt1
	8HFh7isgKgNjKHq/3cBM8CGByPVKH1WpGq/cKylpMSKECjeUv+0brB4bQiC/UvTXn5CeYnGgWPp
	VKwS/1Ad7sYBuBMLmG7DXchvKnC3naK/tYTAFZR6U75j0V8s6KhweYlnPADcUdgNw3bFZiKou0k
	iCV
X-Received: by 2002:a05:6214:3d0a:b0:91b:83a8:2d6d with SMTP id 6a1803df08f44-91b83a8386cmr153678856d6.39.1791982528491;
        Wed, 14 Oct 2026 05:55:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.77.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b3bb33sm51895266d6.15.2026.10.14.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:55:27 -0700 (PDT)
Message-ID: <6acf7bbf.d84cfa41.1887c2.9216@mx.google.com>
Date: Wed, 14 Oct 2026 05:55:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7465303452160236690=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [1/2] Bluetooth: btintel: Add TOP silent reset hooks
In-Reply-To: <20261014114752.174669-1-chandrashekar.devegowda@intel.com>
References: <20261014114752.174669-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7465303452160236690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185516/

---Test result---

Test Summary:
CheckPatch                    PASS      2.53 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      30.63 seconds
CheckAllWarning               PASS      33.75 seconds
CheckSparse                   PASS      36.20 seconds
BuildKernel32                 PASS      29.28 seconds
CheckKernelLLVM               PASS      35.12 seconds
TestRunnerSetup               PASS      700.92 seconds
IncrementalBuild              PASS      29.79 seconds



https://github.com/bluez/bluetooth-next/pull/932

---
Regards,
Linux Bluetooth


--===============7465303452160236690==--
