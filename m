Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC1271450
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065247; cv=none; b=a7WzrQEVps4/bUe+VefzgNm/GNVUR0xNvwgtIxuhEotYvB3xi8FfEUee+ik88VhcALg5a/EEuVDm1wTbj3JlDxk1WzvyNCAD3mOhcsMyrzlWNM1L8F0OMXohrrWP+wPysDy4OUv+GmyEkvmIGWV7xkhV3aneUYZKWoyNIm8kBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065247; c=relaxed/simple;
	bh=XUgFP1oNR08r4cICfGHlYKVwh5BWMRO1eWqnYtbldA4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rt8tQLqteEb2U786IIFGZKfozvtBd7/P9wSWg7oR8W+QD7BcnkV7ePlqlmW/XhDE2d792EF3pIMqAHdyA7phZmrFMM4lLJaIAiyZi1tYo46Zsg6rs0CYPQevAcdgYjSgO6i9GBZ9HK9aJ+MoMLM4K2oUs7JyQAqaCK6qELIGD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0cudhY+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0cudhY+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e65e18969so130656185a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786065243; x=1786670043; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IfSmFyF2G01qZ/gy5gxaP4dZoTCEkyDccg+w7oQUjIo=;
        b=p0cudhY+Z1vV73+xulPoT116Zo+S0g5ajCDNmGEy2ANbd2eg8mvvH1JxzO0igiu7aE
         dFFGh9Ga+sUlDNT9huZ+LAsLI18g9OcKWwzyuv53i/n5HWKZO3NOguxrIAbcUgCJ8Ua5
         7cCsYpXSdFr0hHRhG6entheYSYK6xoX0o9GdHNlNYd3dx1JPY4fr9Lw7MhEuH6arWvKI
         iA26mQDfRGw8/ajZIRyRsJN7BBJtghesk+6C6p04vZH3DAX8AZbU7tNxJnPpr1n9KlGw
         bciTOF+LbqFQ/y3eb+PGrKDXSAzBLYf6abwnh1z4OiPj5nNyJ1BRCLiV1teevQ1NGMkn
         kaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786065243; x=1786670043;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IfSmFyF2G01qZ/gy5gxaP4dZoTCEkyDccg+w7oQUjIo=;
        b=Blghp9ddO7EHAs7m+IwV+ISnhm3BBZ+kFZUstT+xGpiVFcuqbBwVPb/DhpP0XpnrfU
         P6mEc7a7R1TujSSjgpzxKlAJPUt8jfqB9ZmQv0qDnao4SyvQEkpzl1/OLig1qgmCB3gm
         Xz7EXt1mq90Dl9EKm/Ou9aRQDkdHkfF0GGsXOeDGLZ/J7f3+6NsWKab6iS6oEIhKL8BT
         +2rWkp1AAH47DjwkKV3zI+e16FxHDV32qZLYUbz6CDz8RN3UKs5l7F7pu8O8KS8y5uJi
         S6rbVJNClQ2t55oeeL+3jxgv2u460DVHR2WoTB635xjy3Nkvexs3wZXEzmDWjX+rbsil
         lV/g==
X-Gm-Message-State: AOJu0YxoysLcD1OiOC5psgdIn+JO4ik/idm2LmhcN5uWxfXMtnzERJYY
	M4s9RzTBN8bxM7HBGhx37c+sg8pDmimxYq35Dmch9ufoNvJvR2aZSnLShqf9xw==
X-Gm-Gg: AR+sD12dAerSJItnvv8fHEcRPFdTiyA+7vGQfXRCycRzF78wdthdjI46GRSphE8w2Le
	Sk3bUi4qp179yx4DxDzIKqiTQAKg8qGF+tzKziYg9Qte6JTEYrJpQvpE+WBrWhRCWVANcLqv2kH
	Q1Ta2IVBx1gwg7V5glhtllymmSGCU3gqMzOkXj7/i9987BQye57Rcv/9K4PDvQyi0+Z+3MnISFV
	jvPhm12am3reP9L1B3wEwG71Jn86ohKnwlt4vk5zsk59dQzAMlTxmxqxxdiExkk3LVg5F4SAo49
	+JP+x+xKpRAFDZRrku9RsjaMGwEonJYFNkx3idFkM3gmCCUv5JyVRx5T5dl44dGxKIA8U2csjwG
	dty/KbrUY3jCjILOmB2CMuLIcqD3lj3LOTZyxIIb43USkNIfi/bRALurJbOCLvzHQ11/HNCyV51
	AjXXRdmdHThpbU9eGRwjEbLz6mO7RjG9v8WJ8VbvLsbdzN+5UtK6dEv2dDnINjsy6NR9M2hg==
X-Received: by 2002:a05:620a:691a:b0:934:a131:953e with SMTP id af79cd13be357-9365959e1a1mr1233098685a.15.1786065242865;
        Thu, 06 Aug 2026 18:14:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.157.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e290054sm38688085a.40.2026.08.06.18.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:14:02 -0700 (PDT)
Message-ID: <6a75315a.0ea1c686.2fbcd6.6cc8@mx.google.com>
Date: Thu, 06 Aug 2026 18:14:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0437054031423987477=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: ISO: zero the sockaddr before returning it in getname
In-Reply-To: <20260806230621.10105-1-ali@iusegentoo.com>
References: <20260806230621.10105-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0437054031423987477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141806

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.70 seconds
CheckAllWarning               PASS      30.30 seconds
CheckSparse                   PASS      29.18 seconds
BuildKernel32                 PASS      27.01 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      506.95 seconds
TestRunner_iso-tester         PASS      84.12 seconds
IncrementalBuild              PASS      26.25 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/543

---
Regards,
Linux Bluetooth


--===============0437054031423987477==--
