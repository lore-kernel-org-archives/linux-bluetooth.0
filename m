Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB333D4E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417993; cv=none; b=OHtlLGd8/dnhd7O+aA4ZCJBYS+ocrFmJ+FdVIJHkGIhFibZ10jYYsBvIVMWxtRwBXyxecAUboyY8XkfC4yjU+I0C3lEDAq/N3iFpuqDXB9KnJcqmnOWMydMC8qo/3OpZLO2poRRzyPg4zzDLVlaLHsmvSaNbpV8MQW+v+5yT1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417993; c=relaxed/simple;
	bh=lrwsLQnlWY0FGgJAnlnUNrvEfysSFEiAZqbvoCrK/+Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LhO8YpWAQzXOgSkaAv2e0kZjsVS1aULH13A0zHcYmeE5P6AhnuHgRnMRYwg94oubXRdK9TztGmiXXygIJRCS93VS75avUdpJhHQVuy1y7PFX2hX1nQuQ7pL9tg2f0LBSOioqelbeDoTIEvLM52exHPjELkWvW4gNvhS1dJMNycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWi6nHho; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWi6nHho"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e6f0b4610so26564657b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785417991; x=1786022791; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TIQen9+DOFmCY9T6lOoPLR3cgFj3+SH+KQhkByRN2+c=;
        b=PWi6nHho19B2JJGMokHC3AP+jDi74i2eAhnVRoBTPuu8i3q/qyTN/jGIrLI1lz2TdO
         tSuGJaXofLzN/bvp8PlUUMQzMHBH2Y0y+lQKJTVpB0iUN17/MaABADcnXnHKO73aw9BM
         aQGsz2gs4MscGAuRfM6u9JnAJetfyg9fMtKxPM5z9ox+ra8OksX/DXxuTgGwZ6mjeJ+V
         +d6jqBClRLbmb9NUzYPIs1hAqO5Uefp0Us8efiCf12dlHV9OEVbNCKzlUqJom+LGiDnq
         gFWv3ldli2/ndvS9OKTVlnksAu8RzO7plASdEsMRqkq9iej6Ag2nHzSvSDseZEq6Cez6
         bNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785417991; x=1786022791;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TIQen9+DOFmCY9T6lOoPLR3cgFj3+SH+KQhkByRN2+c=;
        b=We2C9OhTNuL3fFzccaXrem+qhgyYp7QVsDjknLlGnyQj7OY8zepS6pNqoim7LLFZxI
         GfT/WtkjL2IqTRaNqfEFXBWlEYhtw5uwZhzzX/NFYjxs15XwGfyEIRljaORG3bqYv8aT
         D3iHqi/lsqMJfGCbgxoyJ8v8qM++JP8jlIMVTK2Y9tsqhL3ydn8H6GAlPbivZdXlxdUj
         rpqdpSZAXLN3uPHjFiwh6FUrwj1TlqrkiYqavdQ9VGpDRrJwqTy0Q/8NXmBy0DxTIj8v
         MUesTrHBs0+nxpPGvAjvEh7oB/9bSvk0SkPbLwVtnM+s8vLjP37T4MBATe2pa7OKMl1P
         U79g==
X-Gm-Message-State: AOJu0YwShV1MSZ/gP8QM4JvLq3aCIbnwFdT1kYsuZ7EHNwcqNvYBYlb9
	Of147FAMmW3R1ewVyehCyvKDc81o3ujz4O/ikdao96K4KNBZf/BIiduuSdkuyg==
X-Gm-Gg: AR+sD101cYLWGmSt04ggt9oLF5uLTY0tfbZExWXfs2T57/HV+N93zM7z+/Fhs2ucAWc
	z/mdTdzoq131441ymh0I8ERj0I30NH4k1fxmk1he2/nMxvUzv1QpampEu/iRfkVkBq4xyb/7G/s
	PA/wv3pJWXyDGR9ZwvdQePw6t5wQr8+HPSVmAeDjc9GmmG3SsHuePKOKvU27yV/tjEGaj8okB4i
	7QFt1ugrOlcNTHpYUx3KQnu88hUkIMbuUIYeYIpgKMDo/QHnhV7QxFlaFk3IBbCOfCVG50EZXjn
	+0Nf1mzciO+giZZ7Iqz+KO3C451Mudo4+BO7a1WdLp+emyiNAcwH4OVi9QWfgz63U1DGSb4dKqD
	3sW4d2m48U9EKzoMeb2EIIowE886MnZEL7JD8K9Sh+blpLNUejmVKr5b00hY/mnD4qEJS0//iYO
	JkiLK2OpyRaXlc/HfQfw/BOdCjdsZ84LfpOmzv1kIJO7BxeBog5NmSGNJAuOs/lGlvGTXi
X-Received: by 2002:a05:690c:67c5:b0:806:b6ab:a410 with SMTP id 00721157ae682-81fc1b53b0fmr2210467b3.0.1785417990558;
        Thu, 30 Jul 2026 06:26:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.66])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8acbaaasm9444897b3.37.2026.07.30.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:26:30 -0700 (PDT)
Message-ID: <6a6b5106.abd469d3.11abd0.9712@mx.google.com>
Date: Thu, 30 Jul 2026 06:26:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4581481814078457342=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, developerimalka@gmail.com
Subject: RE: Bluetooth: hcli_ldisc: Remove reduntant braces
In-Reply-To: <20260730112509.72623-1-developerimalka@gmail.com>
References: <20260730112509.72623-1-developerimalka@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4581481814078457342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137356

---Test result---

Test Summary:
CheckPatch                    FAIL      0.62 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      23.57 seconds
CheckAllWarning               PASS      26.37 seconds
CheckSparse                   PASS      25.28 seconds
BuildKernel32                 PASS      23.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      430.03 seconds
IncrementalBuild              PASS      22.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hcli_ldisc: Remove reduntant braces
WARNING: From:/Signed-off-by: email name mismatch: 'From: oshada imalka <developerimalka@gmail.com>' != 'Signed-off-by: Oshada Imalka <developerimalka@gmail.com>'

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14720666.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/516

---
Regards,
Linux Bluetooth


--===============4581481814078457342==--
