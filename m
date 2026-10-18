Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE643446C7
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344228; cv=none; b=qd3a8E9sAQ2sA50u08xyngWZ4SVOxMr31HINt/w0zQZ6fMARZzzOLGYtXxlntRkLBx/ecSZuhxgGt1eYDi8wHuHpeIv9uOY3iOVHGj4zO/7ndc60is8JMciUiy9ZTkh5Gbw2r0GzzpE7Wo5sIk827DHplAsVDePGtZmRngr16ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344228; c=relaxed/simple;
	bh=ky3mbr7KVgqQatuEWe4Aa3ak6ic89LHCQz7N122yMug=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oCNqw0clfq20CMX3r0YPAsMyxDw4/FqyCuSVAyxQLBGHVCZwWE5YL8xoKRoBz79oMdhi2uf3fiVzhsNq/IfuOVeorGDA+qaO93EsSQl8miNO31Kt2F+BDezs8Hel3c8OaQCLk8mUeGocDgCexex/jWapy4pxi4s5rJ2pY271dh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSHOqNkh; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSHOqNkh"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35c76e9614aso2599418eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792344226; x=1792949026; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ux4fG7hmERgapfKycQKd2/ruF2GnbQHTspo+7v6NBCw=;
        b=HSHOqNkhzcUGt5b9/yT/xB+WyrOfnDCsqZ5wdPV+/AZ1jKHHlDMrYg8fqRwam3UuuF
         VpKULOEX8MkQOWhYcjYXZDjysDAoHCSh/+qK3EdM6qaj74rIuPNHYARWFd4m/NBXRUtu
         4j2RKrEjUCsiB+YIHx/jgt7GsCf5dOPLuJVlhdmO0lDVTeF86g3a8LVdbSOeo9F2y3lG
         l0L/CQjBsNvPX43P//niOZ9HOt8oizYk+8CCGvPTk6TRGbp6K+0mT1RTbIdxYa3RrWzC
         ks84rB6y6b/IIxzkAAnNID9QYjFPWPbiIlMYOvfzgnerC654WanZ3NspLIORubGbkXqS
         JdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344226; x=1792949026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ux4fG7hmERgapfKycQKd2/ruF2GnbQHTspo+7v6NBCw=;
        b=LioC/Cn9il1MRBj7wzzmbiVCHhGS/uGbMkAAdSVoDAWcV/yOoKBnsTM6aIoxBwQW2x
         WGt2+u2MED54u/Tkc4tSQ2kygNY/o3Uz3F2JRSetM25/E/FYiPu2DC3Q8V9CLnqMplue
         yodJ0udymvzbjN+Ib9RlB2LC46JTaAWytmyAHdqVpjpqdeO/6RyQ01Oev4z8o0Ips6d4
         M2VeQpvixpvyXjgr2rOTcnTyrEO0V5X8pWGxXdRKAKBZWNkdMxDhpWdwq+1y78APJnnF
         bQle5oaM1biIEP26DFiodrbRF99FT9B4tHDNnkGF7oCKrOPmh/Khxbxcn5nPqrfqbDME
         tbRg==
X-Gm-Message-State: AFq9FYKEm0Cx3q2JVzye6sTJDEiU8C1gJDKsdk8cad6Kd6xwxK6Y3uFJ
	n5Q2QLGJ9wktIIhbWsC912+iys1Nd7rZDLsnbJhY/YKBbRIrpDXKf5M8QpCBVQ==
X-Gm-Gg: AYBFou3hojS0HrQh7CROklukwkEw1mMj3HU+gaUSvUu2D+1rHmEA2gmZBEuVYa+O1JS
	XWfQ9RTTJS/1kzvlyxP2QcXiaTywa6e4JxLQr/ycbiyWCC6+PFGsnuij5Y8tBoVpwpx1f5vwO/9
	bNeX6r0Lzrocf5RGtCQU+l0XL+w2figOIAkEMnmwDmeVayNXkOde5l55clO4JYRuTCtvsplnBrK
	4m4I4/jT47UikxRpPyHPS2Zmv+yre0dR6nfOKRPu0xsm6cceq/n/9k+4cGOirDkC4rOw/Cxy3ZV
	Rnu4HOFTEJnoOyeQpZJEE1rFKXVkcBhZQiFhL6r2/rcMPXwGXIqhk3QfnkszIFXd0a/xJvBKt1X
	U3lyBAwAIFy2bvkWp9x/nSxDj3mdsDIkQxMp1H/aUuGnnrAyabfQ5igH/lLacgzYcSAHXnPjc1q
	RxdEKfyCKHsxiwOWjoG5+cgzzeNQkNAvZr2Jm1KdnRuIcWemUAoZ8JqGrjiCsDg8DwW5bqgFzf9
	Ykr4yQM2Is6kA==
X-Received: by 2002:a05:701b:4590:20b0:141:4951:f150 with SMTP id a92af1059eb24-18512a49e38mr8001144c88.18.1792344226151;
        Sun, 18 Oct 2026 10:23:46 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.197.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ca95700sm22021142c88.23.2026.10.18.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:23:45 -0700 (PDT)
Message-ID: <6ad500a1.e8a50b02.358f0f.7e20@mx.google.com>
Date: Sun, 18 Oct 2026 10:23:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1137783205092919912=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sbs22ms076@iiserkol.ac.in
Subject: RE: [RFC] Bluetooth: btrtl: Add support for the RTL8852BD
In-Reply-To: <20261018164017.35330-1-sbs22ms076@iiserkol.ac.in>
References: <20261018164017.35330-1-sbs22ms076@iiserkol.ac.in>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1137783205092919912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188374/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.46 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      18.08 seconds
CheckAllWarning               PASS      20.02 seconds
CheckSparse                   PASS      21.53 seconds
BuildKernel32                 PASS      17.25 seconds
CheckKernelLLVM               PASS      18.60 seconds
TestRunnerSetup               PASS      397.61 seconds
IncrementalBuild              PASS      16.91 seconds



https://github.com/bluez/bluetooth-next/pull/962

---
Regards,
Linux Bluetooth


--===============1137783205092919912==--
