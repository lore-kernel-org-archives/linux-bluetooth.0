Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4230E836
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772189; cv=none; b=K45HKPS8LISIJS7nzNv6lzMiwhiwhqxiNP6UOtuRXwojZ6EDUoEljFWIzJOmFHokk2nlSCzePJc80XKCUiiXIbNSugTqaOPsmSY7IG+kRGpxPwuvN7WVpFsF3PR59O5xSkAnatPfCQO/vqydr+w0UkKSTnwK+uKqJ5HJziefnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772189; c=relaxed/simple;
	bh=ihmWPC6pic+qsaOzlJozebnpygbC2KR0MmAVqpGv1EA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=neDFJTfWv/ijTb2jD2FDaLW28oihp7+iVq5z1WIMT5+waP4i3IJQcn8A035KfL06nmXqmvZXF0zoffuWKS4CtVFORI3m4fCuHeQo6zVKPOIiaSWjHXXV5KrWSARLNz7cF1Qeg7A3L5oIefE6JisM81KEL/nxRj8it11d+ffc+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo2ma6A7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo2ma6A7"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a0323830beso27312216d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776772187; x=1777376987; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ihmWPC6pic+qsaOzlJozebnpygbC2KR0MmAVqpGv1EA=;
        b=Xo2ma6A70PffgKGT6RZycQOViIklsczgIsAqDlCEn0pAcDqTJWuqIjVRh23bvqzQQY
         u/NrcV8HjY9X5NhyebpFBQb+K1mcYcjA031VCnuVP/3xKEgtJszGUvBfoZWxE3mMGkYQ
         OhJApiRQoJZYIGp0V6uuF2BjqDVW/10GNdNxWnJridCoRfVo/HY0zHdBmtzwzvaC7TZm
         t/kiJWZsHCA7OqMFvHl5AHRVYP3wO82faQfVbF+fPF3KMZwrWv3BmFop0m+Ptcxk+MHn
         QTXYGR+ehileClDpUC2xzu+DrsKk0GYwEXYhNtOCMrY8/w5kbZ6YKeZinWBF2CDp5QR3
         spQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776772187; x=1777376987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihmWPC6pic+qsaOzlJozebnpygbC2KR0MmAVqpGv1EA=;
        b=dOklIq8rSGAUxkoYSaoAA7+b9NgHT1qctaobR8WU6gcabQkP5Gex++l86Tf622cFnX
         sEN5M9N23tc5we6LaoDsFr+YUA5MUw6Ob95JYvJurGUrJ6bySB/Ik5jrvnsvuOZW/YOk
         eaoG/YMdE0L7I3BIc9RBCaLrBiIfFolFTz4t9oQ5kUw/Nk58V93ullveJI2QvXG1mF9a
         jfG/PRAXYuZqqwmwP1eTtePDoN14e+iRn+RhtqDRKV+FXpZNJkMHuDgf9UJ2fqbDg0jc
         DnPPwXEYnLRRQHN/qKEQkCCHt24+WLQEp/Rg69nbFqrANFPvDi4JVxLUP9hOuZjvyQtJ
         TxTw==
X-Gm-Message-State: AOJu0YycWHPso0az1bg2r3zsSSvVfAFMONfXHDnvYs99dWf2ATDtFCdm
	VF36XXAzgItZpQ3AI6gb9JMrPnXPoPDOJ3Js9kvwQT0K1M9O+fCOu2U7bcvZtQ==
X-Gm-Gg: AeBDieta0tfl+DSmHyYE4mjt/wSAgEjJSsNw8ZV6cJuijcK9M5YWg3SSDagqvSOWqv+
	6Vyt2x0H7CRNSsq3OrauSvS3XMba128ZDfrsYuzP1n3EUVLjgEAsn3PBRlW/AO1mKiQai+K512W
	fGQTIr4m9Cl5l6y/m5moKG1q+iHpWzi2PeIRUJeempSRgTb9Z3lUiTRxq/O71GvWGkjt6cq+mrL
	dFF3542+vuS1U/xqpLLrqv1kbzESFxpBrtU5NrvZHoWJqKCCZRDT4cqfHs52aQT8RND7Dr/59zq
	SkD64OoTVkVsUBDN/4oJzySSeYrsxYCNhue4JMFLi0auCn3fzn0Me9Jdtgkt4mH2KZze8lrL6Fe
	U8dLvFJdmloXZazPmHx5UcFie27uPFS3z1H5QI5I5M5skHEXpjPDWCe14XjjRdjwO63kHsHtgVR
	7uCZM7Lyl+4lLk8tM39WvHAexikREoDiBJSwtLapDa
X-Received: by 2002:a05:6214:2466:b0:8ac:82ec:9ace with SMTP id 6a1803df08f44-8b02818e9fcmr285715156d6.26.1776772187202;
        Tue, 21 Apr 2026 04:49:47 -0700 (PDT)
Received: from [172.17.0.2] ([48.211.213.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac78513sm101840056d6.19.2026.04.21.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:49:46 -0700 (PDT)
Message-ID: <69e7645a.050a0220.8858b.9dbb@mx.google.com>
Date: Tue, 21 Apr 2026 04:49:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4354199153501858225=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: [v4] Bluetooth: btmtk: validate WMT event SKB length before struct access
In-Reply-To: <20260421104822.2498025-1-tristmd@gmail.com>
References: <20260421104822.2498025-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4354199153501858225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 33
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4354199153501858225==--
