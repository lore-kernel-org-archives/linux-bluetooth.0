Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C932B99B
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843342; cv=none; b=SfGbagDitgSPsDYF2xcQn/m+VlyQE98XSdwvh2Z1ZuUPGJQ5WoAyRSig04vK8YeWRtyf0r/vSBvzZiIfPGsLV7bIuR0lCCtQnZlI9aNYydib6uJNB+FfA1ONvqS016wvfPSYCFZ9Tt8tKbNXgyBhMc4xlEUkKPeifKQG7h+tiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843342; c=relaxed/simple;
	bh=Vu9UidKu1HC8oIeO3l06dnOQydY0k0NN2cQJWu2N9tA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RCi/kY1nULDSJv9/pkXCTsKIzaCwEvcpf/ZoeirASQOnXUrNokjaxlTnJLGfh34b631F7I/tHBLdi7ORNCKkDckqUwxNW14dTKU2svcq6WaHaTZ6IsEn//poLqIbixplmERaACj9hv9jlKD4n0w3B+waItD3UvSod3qYKhtChVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0nBVSbq; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0nBVSbq"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5028fb9d03bso36490931cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 09:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768843339; x=1769448139; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu9UidKu1HC8oIeO3l06dnOQydY0k0NN2cQJWu2N9tA=;
        b=C0nBVSbqwVWe0Uze/ZxbzMnHBaCkFxFQmTI6RPOGTvBg7RuIZ1OcqsEx8RTPQreB+U
         qiuHyIcoEusQjodxeub5WsqbFtjOpRNNuniEj8tAYzMok8pQT71SngAzWdgaqhHVEO9i
         NSNjfPHx+Ex52hbdPBRoMF9HvfzNFbefXozRH38JT6q/ZbVQq1vHPBqrBjIzhQs3DbjY
         SZNeuR5ui0urtsmSENQl2Cdr7pU3NR4fiyZZ/Lzum34aU2Gp9UxZODu+D5gwkbdnqprE
         6ZcCm34ZG2v+MnJl4AlS8utkO94HNcYSeodRh9UgbGwnHUqO8Oaqn7w2eDFkVSUBAeas
         ejNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768843339; x=1769448139;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu9UidKu1HC8oIeO3l06dnOQydY0k0NN2cQJWu2N9tA=;
        b=fCG12kSIL1La8qwVLaLACwjbFhsOZSIiH1Ut9TAeV4c2YlhMc0Ltifb9bibHhy3CXV
         PhryX94G5rynvlwHNBxokipqd4VwQ4/hA1BV2GcWsrxm8hKj4D+Jw9KSOGHqcgHziOJJ
         7b9MRzXFObEGjvzO5kBWxSXi1q8PBS0tj/qozxQXdYsOVy73oqMD18+EJLcix7ptXPe+
         r2EuQVwiNMM/hD4Pgr9cHqsz1qrUtILGfseBJ2ON38AsxYYE52JI8fU4uKQoEb2ACqwa
         E5RJOfJNwjMGT45cuTdqb4/8rVzuWrJfNaEy3k7pFXoS9viMJ0bGskYSWt42AApZGfLQ
         TC1w==
X-Gm-Message-State: AOJu0YzN34ZNM90m84i3iyACVxBGlXc+yAjBELXbGDYRjoNDgICEAhzb
	5c4YukTjdr9XFxqOt1qC3fqVJHC8NxYmMr2GOSIxrnL4+ym8DsgJbU6d09Y6dmCt
X-Gm-Gg: AY/fxX6tV2ShWufrxSdHOWou8sfjuwHniUSnuPTnL/maOR1FtNWlGohBHCgnDycm8VV
	FGnwFHRZJRj8SyS3BFMVb1MWgaf481HDDolp+qo7WlROOCmfyqPerhbEVYFqI9HhbSQpT4Ce9NX
	AR+73LbzcquLuVsJ7ERGJOgLL0yNNMLnxhlMwihmsOWhiSji1ZRSGqdHgz3sJaP5KOidqg74x1r
	vHJ9xxgjX7ujQtdP9VbQqt11JwuFkBFcficuLVwgmwnM+ZEYeyK92nXzTH2I+cXA+NTKzX1MrnB
	33wDSjv44E/rKB8SqWzQ0jA1rvywDw/ulUr80lnlh7oZyK98B7xOrRai1tYRu1LnwlxOBmfMcXE
	83o+PeKxHxSyqmpi1jgY9IYW0L+1A3fxCi1RexsKUGfupZRNCaJ8LCDU33AIFMREqK2BMcJTtb6
	KzrnjHUiLDtc4ypZ0=
X-Received: by 2002:ac8:5a03:0:b0:4ff:c14d:65cc with SMTP id d75a77b69052e-502a1758662mr171794131cf.51.1768843339329;
        Mon, 19 Jan 2026 09:22:19 -0800 (PST)
Received: from [172.17.0.2] ([9.234.151.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1ed3155sm73298761cf.19.2026.01.19.09.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:22:18 -0800 (PST)
Message-ID: <696e684a.050a0220.385661.57be@mx.google.com>
Date: Mon, 19 Jan 2026 09:22:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7335240667697987749=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: Bluetooth, wifi, arm64: extend WCN driver to support WCN399x device
In-Reply-To: <20260119-wcn3990-pwrctl-v3-1-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-1-948df19f5ec2@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7335240667697987749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/qrb2210-rb1.dts:235
error: arch/arm64/boot/dts/qcom/qrb2210-rb1.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7335240667697987749==--
