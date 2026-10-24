Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792855486;
	b=Ov0/Vx+s6pXo+ybhMz+WiWzs20ghvaeYqPfpLf0sO8wu7yi0IOqhWXGl8AMW1r9e+PWu
	 Sr065sjavpwlL+UMIns3/GlQlVarmzYKhQbq1LEHart1HL7CSYxhj0/bKekBUl5eUuVSd
	 6zWtb1loU5bAdBMvPt/ChQKUvPkrTyh6kWPk2HAjFuqTZwfgqSKZML+1Vxs1pyP1YXBtK
	 +zUfCyQnSyhZ/E9VI0SaU0maEwr+ckdxwXE0aodCWKvhsMW3fXqIrM7w+mMNzo89hCxXm
	 nmnLL2JA6d/4fMJ/1Hx6y6UTHvXo33Yj7qquw9mRspGVZ18q3e5/0kGoXO5yL03krCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bOEPhMnT3qw6l1DHtxEGI04VEwZVz2VL0yInLDvd2FQ=;
	b=0ud0/HvZr0+EPrf34Q070BVTEkoG5PjPUQyTcqw4q6Y2m6Pv51P3tF8ktIVub0mtWfTP
	 C9VZA5q5hnONl3guafyhL5p0/ETtH4H0HcmQjgnFew1yagHVkxawCY02xsPabf7oYpfWH
	 OcYaVHY0271YQUW6VUT+Cs4VGSK6RdxeyfYcmhI+QJjJMwQMOVvWPQCJURY4ttQX4uN8z
	 mLURdPkV5v+bWmyDu95otpkdpxOqwX/yNe4nS5eLXzbg+rso97ETGc6d4KAf9caCGSZdE
	 rtAbUnHpykNN92SD3AXkS2iizxV6+qApJQJzC6Rm7h3eEtjIxJr3xRxDGIC/DdZ7p9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LCqtjpob;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE038606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 15:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE038606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LCqtjpob
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48ed0b68895so954571fac.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855485; x=1793460285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bOEPhMnT3qw6l1DHtxEGI04VEwZVz2VL0yInLDvd2FQ=;
        b=LCqtjpobhTkriQUJ97ThnN+tA8Qf9bX3kFbk24Ks7hbqQTiD5hBQQQO6qJanajX7+o
         B5hjlyliyIT8EbSfgMB1eJtY80x6Nuqo73aAx4vixjhe9yApik5NMtnAfvp8ztyPp4Qr
         /8JQJwsyhaO0YIcjsIhniuXy+A3EitQ6auPZhnCWqy6jvLQ28v4F8Dyw0UZXbr8Bfu8g
         LixR1UsstQIe4U5okySzM9ItIqMseXo7NVdfFYLNXsQ7SePByoOGbZcee8mkGSVNUSXA
         fKHVrYw4v3Wrk4aAXxn4rn+WD7js4kuisrdnOB4f2Jy9qJFT9qraq+qR8QiloWRRRPHe
         eYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855485; x=1793460285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bOEPhMnT3qw6l1DHtxEGI04VEwZVz2VL0yInLDvd2FQ=;
        b=TiqusLJVxyRS3rRXhtLueXh1bqWjq9N3DcCGyfKUqRA7u20S+UUzfF+4sH8AwPUwIH
         7KEynwQkzVkZcAkat5RoPjLpNAtA9ZUyky/jsWMuSs7zwcMLfIm+JYCr8akjfT7EBveg
         SAQHSx8hT7s7H/MfOyaSP4enYq5Wr3dyVBGYAGutwkt9pG/Xxin/avjj/CE8yHYLg0rA
         QA36zMJG+FXIHw4zC3waiw4zqDjIxkgPo32hkCdcp7fWUjX7p/krpalO7wre7xrv+irS
         y3NcsU7ECAgnDsBnugPW+i9Pieg7hSpkdnMxCssdp6pFSaq4007ysUCRQX2VkyBL3sa7
         i6dw==
X-Gm-Message-State: AFq9FYKC7XryqfH6IEdhttyfN+8oqfjq3zQWizKsIuSuyOL41T7+HG9t
	86rTBSt53Yhcn3TIRbpL8SFgM5JBTFJ6RRgQLffwuEJiFVy5+A4XuLFq8+xeNg==
X-Gm-Gg: AYBFou2vzGiQFXtao8LJ90XhUafU7L8OW4+fuBOPCgX5gjI9KWzq5IAUC4uMnR4wmH1
	Y1+WvCCRLOaYcvCso1DwXXf6uCPzlh2NOFLy66UujJfXIoQ/j/pxx7/m+RuxXICnKgChM74NGy7
	LwblMsmTeBNk6/i1mTvtjg1JjrFZ4QXxvGyk9pL8BWhB61HuNPbcnMyO/57cVRNSQJ1QwozT/vq
	xLJ++8A1+CSZvT7s3fTh7qq/ry66iDvNtl6UWeTxwLzcv+r5o4nBDceD1NTkOkmsIKOZdeRLT0O
	pDW5Gz+zuy8B86OylSmjbb1zZtVrOdGxVPcrCuglV2JH//mBTqSPi6U/89VlSShqqvw5s7EWwvA
	uZEtCpVfUGVoAw7QO+Y7JhShL1A77+I0XmRi2MuaUHRv1UTlRXaUfzkjqXbkYG+lKm/bHRrGFHM
	w8KiDUX9H0xbnPLtweTN1ir97vvtdqXhmIcC1z7/BZ9LuBjZbK1rBNclmYFvX1pMwY9Lvw+Ujcr
	ymSwSzmrmJCfqTmLIUsbDvLQBZFK/LESevql5Pitm4nvyr34gqpUx+P8sUpNXo=
X-Received: by 2002:a05:6871:b2b:b0:47b:cd37:f931 with SMTP id 586e51a60fabf-4a83f51c20dmr1390114fac.13.1792855484661;
        Sat, 24 Oct 2026 08:24:44 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.193.27])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843231095sm1254305fac.17.2026.10.24.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:24:44 -0700 (PDT)
Message-ID: <6adccdbc.3d33c982.147a4c.2509@mx.google.com>
Date: Sat, 24 Oct 2026 08:24:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3384204127545100600=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2122295973@qq.com
Subject: RE: [v2] Bluetooth: RFCOMM: hold the listener across child teardown
In-Reply-To: <tencent_D6C2C07E8FD8FC290CA9F9AB237DAE4CE505@qq.com>
References: <tencent_D6C2C07E8FD8FC290CA9F9AB237DAE4CE505@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3384204127545100600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192660/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.54 seconds
CheckAllWarning               PASS      33.79 seconds
CheckSparse                   PASS      36.67 seconds
BuildKernel32                 PASS      29.62 seconds
CheckKernelLLVM               PASS      35.45 seconds
TestRunnerSetup               PASS      698.11 seconds
TestRunner_rfcomm-tester      PASS      6.17 seconds
IncrementalBuild              PASS      27.42 seconds



https://github.com/bluez/bluetooth-next/pull/996

---
Regards,
Linux Bluetooth


--===============3384204127545100600==--
