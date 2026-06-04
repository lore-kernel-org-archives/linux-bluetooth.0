Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59E4611C5
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576554; cv=none; b=PmGntWGHKkBoqsg2w39JZTYQVMjy0zt3b/eaO97ueZMnjmYXjdC8jNJpuvK9Pc5DrgFPxkrMh0/lil3urpDDOnuQU9b0BMUQ9pVYKjKLNlVbQhhjFPXDHQRcN4PwR61D37UQrNDna7YEOZ67kCcuLf7RjAWGXuYjphmVPM5kcuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576554; c=relaxed/simple;
	bh=j7admM6jkXpSveHZwKRQzz2sRfntZuNnTu/EBEuuV/k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tPuJvmZCMl2kcEXaEnWmlYYqsDurqTiWxVuiN/lLw9qP8yYDHyUdwGuVmJ54d8ipDxa+HsQPenqZfukGCxEk10hgOKeJ51OeYZeK47dNGc5ITieZpkGT0RlMC0NrUuRn9aGbHTEwwI8yYnAMVhkzDLmSywlhNZpB8z5fGl7FZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLxRa4a4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLxRa4a4"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso5594946d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780576552; x=1781181352; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dPr0UFOWDPeLIRZNYrveoNUKnDz5cQYDnOii90wbZ60=;
        b=RLxRa4a4a9VgN0ET6M5pmCwlw3ksQpJhzrdxVr4tLcUcJhI/b7EPHQgtxNbePPAZ46
         2zn3FjAt9aX6Tm/rD8BQB77RizBHTYHLhURXxcCSt8DwWDypmZBKiwPdzjeHyrqQOk4v
         s5tepz31o5URBTiK9LYn9K9EZXbcV8sGcjqeqmQPkojalFVznvAbZUO0DNd7fzM8/bEO
         6GvFdaXzSPDBG3pSDbSalPQBHtwOujN9psk+2RrqIVKLLu9E/qN82G/QZmtk2FpE6HBD
         h1Y+cosivCXQQDh1DnbuH35h3ZSRlmRTU/JnM+JpUExdjWKX9w0bjGgqWeZQmw+TQpda
         C1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576552; x=1781181352;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPr0UFOWDPeLIRZNYrveoNUKnDz5cQYDnOii90wbZ60=;
        b=NgacuGD5JtIRktD028Shz2KIv7sIpfzau5OLr7Gu1XhNSoE5q1jhvdN+EfXMb0mhm1
         YflTWKvz63PGL9Q+M/ZKH1VKDPn4jy+v347ewgRAGNx64tCLroKuaeFe63NJLm6m4vbn
         d4SpXEQ4Mshe7um4ZnSgP3xFV2ZHU5sPgXskSG4L+AbzAoBmAAsEL0xCuV3kdYF8pW1x
         PcyimtnZI17shT77oQJatZDbDPUjuRZjNMa80f9VfrDwXGBPpUkzkg1Yo8cm8qTLyObd
         XN/zTut2UCMMWhs+XukZY67+1/C5eYnIJopcucDoz4mY/RwSyDsl64lwRrU2+8gb8tpy
         gGZQ==
X-Gm-Message-State: AOJu0YyQzG6v+1SfigntWlfYGqZvxqNc7rnFnbwS99Gs+I8IRzS2vQPd
	oMPwA8N9MinDQdqnY5pgJs+GeIwFH03/nMW2YVGN+nX9V96RODZMUFsjeDMr51CP
X-Gm-Gg: Acq92OFtudEfyglEhZx2O3aUXeZZ9xuLuwLn0440ykOcFBb1CA4p3E5/ull8k/KkxsP
	hq4uUOkyQz4WG+/1xtnsaA9AlhV0USabng5SfYY11sc3UNC9JUHGa7inDCX/Q2asaYlYLB2Ce7m
	R9vhFFgYg2HWSDCDBeOkz5vRHB7EELzI0Bv2VhtVCCuhi5ZZV6+sbGQB66NMLARsm+2b/iVcRIe
	6rahK1d1hlsxBFX1X3xeS/ONxsZicJS56ItPft2/D8mRurwjJyaVBQSjj59GJuTLM3aDf055WmC
	iadGXEcC0L8R8O4evc4+RmcoRAUMAq0KfA3yJS9RGn+wM8sh6joz/hizRPpVkudagMaPta1+/mS
	i69Fu6SaL+qCk2K7Vs6JBO5VnKO3KiECTyA23EeoVQZpTaohlTieTOnSpEBRecrSi3sN9HW4Gnd
	5MljEoSu2DQ52gtmhVbJpGARVXxehrdK1zw9io/Rh0Pg==
X-Received: by 2002:a05:6214:124a:b0:899:f1bc:c6ab with SMTP id 6a1803df08f44-8cecdcd9f8emr121810026d6.42.1780576552480;
        Thu, 04 Jun 2026 05:35:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.102.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06d600sm51625586d6.35.2026.06.04.05.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:35:52 -0700 (PDT)
Message-ID: <6a217128.47d32e62.332ea1.6cff@mx.google.com>
Date: Thu, 04 Jun 2026 05:35:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3218507294864968014=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
In-Reply-To: <tencent_DDA5BDF30EAC58E68647B4C37D20A3C7A505@qq.com>
References: <tencent_DDA5BDF30EAC58E68647B4C37D20A3C7A505@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3218507294864968014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105907

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.20 seconds
CheckAllWarning               PASS      27.98 seconds
CheckSparse                   PASS      26.29 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      527.05 seconds
IncrementalBuild              PASS      24.45 seconds



https://github.com/bluez/bluetooth-next/pull/287

---
Regards,
Linux Bluetooth


--===============3218507294864968014==--
