Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A73F7874
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179347; cv=none; b=UJgjrCq2wNtX+uW9BaJxkLBNSLoG8tV3bu91yZ0GiSIf3wLQvWRqngLBYggi1SJto28yAfak1qISXJOXLuhU59HzJSLJwDYJO9QkoeEjBQuAr/Ykd8d8dSCNP3FG5Wydi0f6uSnAFwaLaxya2I1DNZtGKOi1h/8dl5XtqWsS2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179347; c=relaxed/simple;
	bh=070gchgatEhxJ/9w+kaNSkDvm2urYe1wzbvBlK8G+6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G7UPCUPL15KA7fAXNGSmavczxGKvk0vZO2QW0B/dKQNYcnbPIraNFoMyAhhLyZokd9EyoEnha0STll4Nnlmu0XW+d7eB7ysxQaNx0JT/o0NcV9jfbeKPp0solEGAHm8dVD3raLx5VCN3a1dJfKhytePUX7ptfU0C8h7zu9rIvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBRM4Lrd; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBRM4Lrd"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f4e6b5bd30so3320817a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179345; x=1788784145; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vqSgZIEZ1DtDCyMLvN6Kq5z41/cBYxZ01NaGoENJ9kY=;
        b=dBRM4LrdkWLDGTx+BJiMydI9jfZnFFj3sXzzoJxb7oWiXRnJcaWAcX2eqE97tHqCUR
         FEOFlgEHsmEaHzqP2UNe+zri+VRRDFMw8rnnxqGfSsaqQLJ1DfdUR7SnD8s8pZLwrssH
         JfsBcgjevjwST6Bsa4PZ/53El6bqfqL/rL4xeUYAzcFj9J/CCml5fcCHLmoOL/TKZUB6
         KaSTjDbCM+UxXpQuw+1vxXF2jyonl+PnkalQ+MV+OUijvmdSwFe1589OTOu321XXzsls
         LsqLxxayXJwImksgdAjt+vQeC1imcf1blmvxaipxLPbtzFzQtuxELzhcSx2aIMZTNvWX
         AZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179345; x=1788784145;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vqSgZIEZ1DtDCyMLvN6Kq5z41/cBYxZ01NaGoENJ9kY=;
        b=V1sUh1UnNyAu32aBA0A9cMxFfg3sYpWqb6H2ii+GYFQux4o/hwUJxeUeCmFI/4Xyxh
         /CeCCuXcdVCmXPqRYJurNFjjzx0Il4Jb7EraMTRiKqJY/Awwz0gmx53hrAQ77LXKVjpe
         FuukTTr3eMu+3nlwbm4RcvdSy0LjZnSnxscmBH2y7zzop9TsajNIaoY3b88+VB4fF7ee
         1OKv1nJiop0XBEaCnc2z4DMFg/S1hSwCk+ce+t17YiK4rfN3DATHtX6KE4GJY92BAEWL
         HDW7u4pzXGcI8VDyJ1BO+k9QNX/oS/JlWpcyqM0GlABkoTpgOyUss9JRngcEuolAxYV9
         Dq/Q==
X-Gm-Message-State: AFuF++llPyxJFhQl0ucxAwyXPgXfaShLmsVLOod1HZbb/At03QyvxA3l
	aBVgctGvffFIoAiZKvZbeCKL9vhLxoOTrH3aeqEM6HrMPV6izpU8GiOAA6oBXQHT
X-Gm-Gg: AR+sD12kb4qILeiScqDfXawE/ahzKDPh2mzXA3n6nPSors7satvg0QS+7jgSKd3wNNH
	2pSLdttv6reqAGCvcKg0Ho4MTzuqQdDx4qYwpawdIATfLsAPZ+cHFNW2w8lFTDCtUkbELzpxVgZ
	ST3gKugu+1CI1zI0rZl8gNdT0hdwOz//6fwAJWTdTaSbHv6lCbgGTvR656yN59TGwcVDjTdsudX
	2FPYZjgl35J8Y+K9Vf8zQd8eaLJpuEMXL1KdE8R+X8JCVrlbgEUzdoRRbS80ppkd8p2jpsO6pbE
	VaWhhreAsrf5KuwpVwypSBb72vrYKdRheLjAH9a9Zm2Mcd37d//+t2xLaEf7hHUWEfgEK12FSzD
	gCd8tLPCSLfeBM6IQtHv0Jc429BT7WLys5zguyuDdP8MLndF32zS/9aacvvhgoiN16Q/rzjRWOV
	rozBR6VMb0cQCSDCJXhA6WOgLo6VPhRWSjA21kd4ki2q3ehCRfBitkZO9eNggiV5sCom6Mkj6IH
	tGNgA==
X-Received: by 2002:a4a:ee08:0:b0:6b3:50e6:76f0 with SMTP id 006d021491bc7-6b35e34bee4mr5628674eaf.12.1788179344932;
        Mon, 31 Aug 2026 05:29:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.13.233])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce290532sm9714979eaf.11.2026.08.31.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:29:04 -0700 (PDT)
Message-ID: <6a957390.0c0d0188.1899c7.27c6@mx.google.com>
Date: Mon, 31 Aug 2026 05:29:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6543830435146812529=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: btintel: harden version TLV parsing
In-Reply-To: <20260831095923.18830-2-acharyalaxman8848@gmail.com>
References: <20260831095923.18830-2-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6543830435146812529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154381

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      18.50 seconds
CheckAllWarning               PASS      21.85 seconds
CheckSparse                   PASS      20.30 seconds
BuildKernel32                 PASS      18.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      314.40 seconds
IncrementalBuild              PASS      22.21 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/673

---
Regards,
Linux Bluetooth


--===============6543830435146812529==--
