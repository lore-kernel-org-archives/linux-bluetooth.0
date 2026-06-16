Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D85313E07
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637956; cv=none; b=jWrO0MoaSnyX/Opg7G+xU9bIHwNwB117SJy0N3EkwJPSgykSmGAdqPmB7hi2yTjAXbJ0LtHfj51YOySbVWWFUy1WuqM7XDLL91eDj9toluyXh8JWvff5Io/Mj2qlAXNnJrQnOvhJYQuqBu+MbR+cGqDfRzuFnAN5SMNoZ9K/7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637956; c=relaxed/simple;
	bh=ceJKf6ciziF7Uo/X4XGWlg7CLmxKg182eJad8bzrzIQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WW5n567w3HJ81c8AhAQW26HYqLPqoNktZ+UdkWdgffjCPXlfObmZPppkPsB+HTA8US2dHZoSsDQUMdrPww1f5YmnQuCttilrK6YdVJv0FBzCpR9UntXM0GIKYZXO/RrqCXbI/lyPqzPYONbGkPAkYlGg49zjSo/zLU6Ac1aVXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgepKu2k; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgepKu2k"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-307263ad0cbso7847230eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637954; x=1782242754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mveRIjRZ6/xrCO3KbO+F8WH0Bu815vVP0MxPA23K+Kg=;
        b=MgepKu2keIK3bMwkP3/634g7Gspk51W5gOH69u91GqClyPWDEqk6IXBZdHeTKEPEeU
         xOyoVMTy9K1UvP8zhMTqFvGbb3rSi0SpngLhPmS0CULdXmQ2bdmFEPyRyot4/vNPGw8o
         u+NtHiqDZXGpK1T7hCKZNxQeSFaTHR+/qsCj9YqnOmIG7Hw7XZsKug2+5FEavKcURWaD
         j6Rt/7X6Y3DERo0uO4KvaFfPvMK1iGu6fgRaZn/KHDWy4snVJv++CAkjShhDg0X/l8Kz
         GS+Ug9zDE8jHbDPrjGkGU13SgSC3wYoe4Up90ubWZVhj1kXDqiByR63TmkhCcgtGwRmF
         osKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637954; x=1782242754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mveRIjRZ6/xrCO3KbO+F8WH0Bu815vVP0MxPA23K+Kg=;
        b=EkWFLXP+oOAduKbvX1YLYyCVTs/irCPQ0wQgqfEQab5W1wa+PtrIo90R4jWxTv68//
         gi8UOA4b/Zm2u4VlcWD9C0G3myI+FCxIlaugYTGlSJ8gpbCxBBc+CXlX0HlfGd53ySl8
         rCJR7Vv6EqeL1VQ/fhIlbs3DW/8qOEE+2P6EVieKHdXf0+aMb8tMqy3deXKbICj8Ta9b
         eHpZ3Aa36PU0IQhYfjUxJKZwQ31z01eWuZHNdDcMCeOgT6IiHOQ4uVuSiswia5LHe92A
         D7/yn7T6cRgoHaDo2m1qa3fWyLpMs1JYVIs+/CVNMF/Aq9H66RZJl/ZIO8B+WBGiTxgI
         vKIg==
X-Gm-Message-State: AOJu0Yxm/gQO3YW9djLixotfpB9Y9tKIgBZp43UgOBKqeijWTXht2aiH
	/A5rn6U9XLz4oKXo6NejKlP+Pzjyj5GKQeJu+exfPDcILl8uXWcifTpIEtFZyg==
X-Gm-Gg: Acq92OFjZmhKXD0+3noJ22MjdMGkHhdr9+XrrKNZsUDBrjuL8DaP0gq3mqSdFrWy/IR
	boe0wvMB+5VRNNqeP0i691UPAt02nugCzAyZVZIvNDPzSA/WrjR8yTNKPCFz/XSSiHjgmGskRUY
	sSuOh75hZIEoIxgv17swcuJgiufrLX2CuXstfxbdxwYQdGph2TWjMYLN7czKOZLgiGFuv3/ANTH
	H73EZAaIZehFSCUlxhxD5L0jwDJgX3wV6ndAlRE5brUpvIRGp0+4iKgkARLRc1deyJ4mdv8fEKo
	FScVgAoh9glPjwbNNZ2xZl1usFj3UzYQP8tMJgOEx0UgY1zqBH4uKmmXfOU0mNLWM8ZjClvecGY
	M84my01DsYW9WAse/y3gF1kBegaP7LkPSYXL4AZnnIElodCRDhOsiGDPYMDqevndHbGt1IxIYo8
	MVrrLa1mnIoJe/V/2PnN68mnPZa3QkPw==
X-Received: by 2002:a05:7300:d516:b0:305:179:4dde with SMTP id 5a478bee46e88-30bca0afc18mr435149eec.35.1781637953752;
        Tue, 16 Jun 2026 12:25:53 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.13.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5cea89sm21745464eec.8.2026.06.16.12.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:25:53 -0700 (PDT)
Message-ID: <6a31a341.9fe3c139.35270a.155c@mx.google.com>
Date: Tue, 16 Jun 2026 12:25:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7107842190884371144=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maoyixie.tju@gmail.com
Subject: RE: Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()
In-Reply-To: <178162441367.2434858.9590661629618538235@maoyixie.com>
References: <178162441367.2434858.9590661629618538235@maoyixie.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7107842190884371144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112441

---Test result---

Test Summary:
CheckPatch                    FAIL      0.44 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      16.91 seconds
CheckAllWarning               PASS      20.08 seconds
CheckSparse                   PASS      18.00 seconds
BuildKernel32                 PASS      16.75 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      329.06 seconds
IncrementalBuild              PASS      16.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#108: 
Nothing checks that fw_dnld_v3_offset + len stays within nxpdev->fw->size, so a

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14631861.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()

7: B3 Line contains hard tab characters (\t): "	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;"
8: B3 Line contains hard tab characters (\t): "	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +"
9: B3 Line contains hard tab characters (\t): "				nxpdev->fw_dnld_v3_offset, len);"
26: B1 Line exceeds max length (81>80): "confirmed the bug and asked me to send it. The Suggested-by is for his suggestion"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/321

---
Regards,
Linux Bluetooth


--===============7107842190884371144==--
