Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1A4A68B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095426; cv=none; b=gQ7dSpPtEUB+xI3ruORJK7s8/wli1GBx9eGMqn359KNfJzwPOxm6nDw405ZcCQglze0nes4eFtCOYQidmvwTHqSHTtgiwG2ktvDMKrGAVQIHyKA6U566FdsJypV73bX2euRB8ga3nSjqRXtS0nL4b1yMYtxaewu71IIfd2CTpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095426; c=relaxed/simple;
	bh=Nm5rhbIebsE6VU3/X6JOHUneK1ozV0IUfxokho4bUjA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BpuQfb2YFUVLvjZJcntK227DSjCFBxCcHOjQiKsUPCoH9JF/92CrYF9gRgtPDU7UMXIiaXKNf7RL2kkGh/edz+v5onzJ08Fk5d/MjW3olr2c6LKIMetQDFZdP/+bpsMoorfM0wWPWQZW2AuYzww40Km3u8U6ofZz09hFcFXxWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5K/b7KS; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5K/b7KS"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5350c1b9e0dso21881511cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095424; x=1792700224; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wLQZBwE/pE86B92dCaJq6zzUryaQHrTgos9fG94kBGk=;
        b=i5K/b7KS7ild9PqPg0iMEbZxgHTJ6hVvkPc3pX3mDXDynGWAwu8wzu1KiXqJF2SDrX
         b0emEtyzpf6GMC5GGIwQb3+pb+wvroWF6saUQfiB0zSLBS/xygDs3AR4/jJypdtOhEfm
         ucyk7nlw5BYIPQONfwilO9GhwBwzoorTxqpJLy6aIf5zYDmEjEd/xTZlgqF00nrUW0IP
         72lN0XR/ud/8m+jzd3os3eAXqApyDV66b8YyGFnM/+KUu/OL9oDc3g7DWPT/X2/XCs70
         dEKWtTNcJVwH9DtM2VJH3/RjkpK5SpdHF708s4YUOqqyWMLRdqC4AjtSjuW2HNLoGnll
         ZCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095424; x=1792700224;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wLQZBwE/pE86B92dCaJq6zzUryaQHrTgos9fG94kBGk=;
        b=TfCuMSShZP4+nOltvq+iXHTcD0F42EIPwxgDNlg07t6PQPLPpYOwPyaFRO2lYVaDy6
         gLvcZy2YlAB3b73Vo5qsmf19zUvv5csS0dWxVZ65EuKJf4V1FI1Fq1uF2hEIv8+aWQQp
         aVTkHmgZdBwEdg4w1z1HS2rYCv5yXEBGTVlU+P5rafmep6qTrFBCUmuUjIwTFRXbFtDr
         RmmsnIZnDJhK4p0MhB5OGbUcKEH0Ccr59D7S/q+Kza7P08LyMuVHCWW7SGi8a/SR/3F7
         G9Sflsz6O15SWtfcVtYVq5D7CU5DedUpKOei5bBUeBoJk44O597E2+vPoKtWh4S3jS1M
         CL0Q==
X-Gm-Message-State: AFq9FYJ4hPkR+i/qeXOLqu9+eIFhvf/Kr8TwJA0w7hUsNHX2WE4rUhUi
	e6JuUSbfp/JsPIJuxYXV36WsKN1oJvX0tlsNbHZ6rLPXdqYd+66gxZHXsIYarg==
X-Gm-Gg: AYBFou1dRfmZ04ujsKVMXqKqeb/Q3Iuf3Nnz6u8M72dQnYnDvvvl+qL6hfrJt5ROqjt
	T+J5FlyLWtzX1N9THNafu0ZZLRD4RHy33nyq2r0FTy8WFuFQKZVGnB28322yglvQcVpIP5sBNGF
	6eYHnvdaKjci3QLlgfEr50ixzfJ+bhC16fSQuohtnWnUhIfKOgo2JA+/GBnGZZ13OD3Xuwb7Ns2
	WKLUeT3r0X+/SmK7QXMvHUe9AxoI5tmRjre0bE1Eiu+zXTKywOL/FFKi2uBCe7u0ZBatPHCyTqY
	h62oOmhZ9LgFJn4fFTvBqEsuztq0PxUd956lcKv5/Cg8jnBXj9I28YiSl7DfK4uQFAs5awFD6mC
	XYI80ccgmTKY4iohUP7kxMjUs81AIbdlE78h+xKb6+tL8FATXENNqNLwItYdJy4ppXUwWrrkjau
	W/JUg+kKjyrw72CoiLcnifHwrKK2lr1CYTifBAvMslQooUjAB0EXj38f6p88MWCUUlQnO/e8DX2
	WywlI8=
X-Received: by 2002:ac8:6904:0:b0:530:f8f6:4ded with SMTP id d75a77b69052e-5359fba82e8mr322542371cf.56.1792095424214;
        Thu, 15 Oct 2026 13:17:04 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.102.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a75472esm2743621cf.4.2026.10.15.13.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:17:03 -0700 (PDT)
Message-ID: <6ad134bf.3c73b1f2.2d62aa.adbe@mx.google.com>
Date: Thu, 15 Oct 2026 13:17:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2810740971046116901=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v3,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
In-Reply-To: <20261015181624.48318-1-cochcoder@proton.me>
References: <20261015181624.48318-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2810740971046116901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186712/

---Test result---

Test Summary:
CheckPatch                    PASS      1.74 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      31.51 seconds
CheckAllWarning               PASS      33.73 seconds
CheckSparse                   PASS      36.47 seconds
BuildKernel32                 PASS      29.38 seconds
CheckKernelLLVM               PASS      35.28 seconds
TestRunnerSetup               PASS      702.28 seconds
TestRunner_l2cap-tester       PASS      12.79 seconds
IncrementalBuild              PASS      31.19 seconds



https://github.com/bluez/bluetooth-next/pull/952

---
Regards,
Linux Bluetooth


--===============2810740971046116901==--
