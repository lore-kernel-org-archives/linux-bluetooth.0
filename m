Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6193366075
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736135; cv=none; b=eIJGt/mfNi8zFiL4+5YzlaCaT3klQpA3tlTziiRtG7sHmor8qC9f1JIYfbjTAD23LK2BY1dNXOJ9vBHL7N5HPsknDMdjag4zaBGYbr2IjPihjMYvHkJdji7oEDPCwZtGbaE3q/WnzLbao2o6yxu2KTrgR8EDgloLg/Eaaf7fWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736135; c=relaxed/simple;
	bh=dTJzx9Tq8lty6tKNBncawIMdhelJoDUSpz60GOnaxR8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HOQWS+7ZeKQMHDy+T+tqK5bQ8Y3dZLwbgznj+i9etAsF7qHnZDpjEJyiE235Zxk3xnuTFMYLYZFjKPeLY+cdrvO2145aVJgFH8/0nNOX7KGMLmEv48joT8+nJ8we2jK2QDSsqI5cVRKWBDQoguprTPKS+5VXLUd66frE2Z7unN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiO2UmTE; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiO2UmTE"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c66ba0b762so884818b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790736132; x=1791340932; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bh62S/+AZWpQAMP+Oof0i5P6J7aN4ZT5i28zDqRqxzo=;
        b=BiO2UmTEoWbVZb8pOo5en2cs+NN+Y3bK8kWjmyVEZrew8jhGbCXaMA/RbVbbx7RV1k
         1U8Y6Jy719XZK0ogN6tgbK9XxmlJbxmxxuydPzWpEaEUth/2vmQDbqBxb+d/qSNRjjCb
         zbWykuj2C9HDfK2nnWsfyuk/eMKkYFj3INA2ewOojxq3gaIiwFpkLyEIq1PCHiq+gf94
         jo1BxvSEZsN7E4FN+oRN79Erv5Mzoia8ipQV6eYIBg89eSnroBj2+iFWvfzi/Lq2E0T9
         3o+dmjSjhlCdZcqesXaTyxRovgRmXJ7PEQE1HSaDQEGYPiHVCyXYDvMn2Tjlp0z5TLKN
         FEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736132; x=1791340932;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bh62S/+AZWpQAMP+Oof0i5P6J7aN4ZT5i28zDqRqxzo=;
        b=j+AMXA4szbTxIjM8+76QnwAlXPAI6tVZnTc+XnQ/4yudWvat7nOfNHJ0FrbnPZ4DEj
         2BMF04ChYKa50q7igxDJQnk8LLwuyKw/eq6Hl5MueJNgNG6S1dzr/ISeoZysxms6pqN/
         Ua0U42nUirJMFooYv7CGieTsZXikgKYLGXyhGFWQUmB/u++6gucKy3u1L35r2DLNFVD0
         Rws176S4AIWQ2ZV70C3EXSh9ucGtrQP02WzEfj1hSqWL+SZtcKkOkSradVXJSlHAf0yU
         8Un+F3cVwc0dzCNKwXK/u7IvW+gTMw5qqtvhliqStD0zY1nkZEMLl4F6Z93TzWFSgX0/
         eveg==
X-Gm-Message-State: AFuF++kANDpinC4bFzzTSebLbGnvZUPN2KTIRDAg/2cnFP3v+3e2/L9j
	alTF8fvRqZ1WO9NivhMeMBsHVyiIdcRrZ8IFhm4CmLx9vpotf/wb7vNinKKZeA==
X-Gm-Gg: AYBFou0dd1XjhPqFKsZ3brLk57uN6Rwtud9ZXKbR1wGq3fU22FmH41pJlqasRd8/XVq
	4juuGNHGZwHLzPzhIm2ePka7mOSd2Ib/ASDRyOvRekp8q/yJPmsh0g0iBAHGGs8kcDw9/CPXBa4
	NQHOBBxo9UjS/zhgiNS8tpI+0zVath3Vv3oiTbDyQ11pmt7mgquAfJeN//Pf9MJ+2JxzmfTnQqU
	Pi0DUD+bg8mnRZ0P5eJBTO96ItnXrrmfQYGMj7FIRgPJw1KZk2Ie9IQOyqHFYyXzWTt0g+x2Fmm
	kENFidNIeOlCjucWdR3W4Y4AopCnEBKvS+t1gO1LVMZkOD4kRA1EGnhka6Aym2k5MMsFEpbtU3w
	DXOuA2HGEpq9FJeRfyjyBH97uCiNzxOFN0ylFBIoicGbMnfPbskwNxWpgj9SUL1IEMDhAsujyQg
	uixkoxyvmAsrnKnXLvlzPq+LfHbkWqX2UQsG0LUmMVVNw2sVVrYD4IEbs0MMAjoPSVNl3reWMIJ
	SF7VnbBCg==
X-Received: by 2002:a05:6808:448b:b0:4e6:970c:7267 with SMTP id 5614622812f47-4f06c2c816bmr1150589b6e.31.1790736132375;
        Tue, 29 Sep 2026 19:42:12 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.233])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f0ad348b9dsm1317349b6e.3.2026.09.29.19.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 19:42:11 -0700 (PDT)
Message-ID: <6abc7703.c41479e6.3a10d7.943b@mx.google.com>
Date: Tue, 29 Sep 2026 19:42:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8062845296155480468=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,vRFC] doc: Add functional-hfp documentation
In-Reply-To: <20260923203105.264648-1-luiz.dentz@gmail.com>
References: <20260923203105.264648-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8062845296155480468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1172556/

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      19.43 seconds
BluezMake                     PASS      351.62 seconds
MakeCheck                     PASS      14.20 seconds
MakeDistcheck                 PASS      139.77 seconds
CheckValgrind                 PASS      227.83 seconds
CheckSmatch                   PASS      277.62 seconds
bluezmakeextell               PASS      90.47 seconds
TestFunctional                PASS      1059.58 seconds
IncrementalBuild              PASS      358.83 seconds
ScanBuild                     PASS      1013.26 seconds



https://github.com/bluez/bluez/pull/2608

---
Regards,
Linux Bluetooth


--===============8062845296155480468==--
