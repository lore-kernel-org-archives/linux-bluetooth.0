Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149A3CF1E1
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446848; cv=none; b=hKPI+wRRQnkIv6M6eASe7XmEcoL9+KSqeMicmbmMMU6qN4/bo2AvT8PIVzPuxqCvgCVAQ8t/+QK7N2P01sN9sGo6sFjhR9rzF+YUm8Y7wrg/Tfcg7czlWwDHDM2FkhLFuGgjek2jTK4C9ZBGdqGwWrx1TpMmsBhHqTJS1FusW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446848; c=relaxed/simple;
	bh=A4a2F9THSW2cIRwts1Ah6tJRTMg0uNMLq8c1zm/GQco=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Om9T+YKCG78N8jhEOo5MOQCjmavRYEf6sw0madHdYS59SaaZPPCwK5Sg9sa/GJ6mhvkVb2BoZaFVOjyjo0o1owsec7RDBVzFkwB/pwwa1Fel0F1B2c8VF4MTHdAjNkAXznd01lAsJNFmaKcUh3qRaHnRly/4w2S1mmiAQ/F/JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLqOxSJX; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLqOxSJX"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-150f88d22aeso2092433c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446846; x=1792051646; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dVa68Yh96KeAt0Vlqyu+7QGy7YsfjRqh4MZ40WANWoY=;
        b=rLqOxSJXXil9rLGGV2RIqEMv915msngOOHqXq8+y5TyF8xETe6tQB9W9SmnrVefYfR
         8GJXz1xzFx+uzieRIE1kazryBWjWhrBVGHR57SrR8DLcW1ADVPJ5HQbeShJiGiVITZa6
         pRAQJJv4Qy8wgfXghDoxiTKw0EnwbbbO8YPIy1xSLCG7tWtKW4w6NNTtFZ+0bTpPIGSW
         6yNvF0WBMKZwCuaoBw9KZ0VAIm+PZN9VN8LUq/00LxxPNrKY7Qio4CTL1/fEaV7Wyu0f
         yDHw5Ug9N2k3ReoZ43kostdlpT6iYev6JB24p+Tcshwrda47NhtHKBZU2w1w0tZFmEIl
         e0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446846; x=1792051646;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dVa68Yh96KeAt0Vlqyu+7QGy7YsfjRqh4MZ40WANWoY=;
        b=mnNjICzDu+ktcQMyUnrqSR9FSUNxZGnAdi9QxYJoER0nLyg1UOXjI1hvc4f+2zsAuK
         WqFJYL3YYcBAQoGrIAnRO7wkNgwLcGPIuHIheQI2ct34xb0C4B0jHxbBHKJfJoyHFpJ1
         jr2WvN3vGzGGulmuYwr3ifGellL7/j0e8CqAW71PyUtamMyjhuvomwkQC5+3SYdnQD6y
         dYCIzRaO4l4tfkh9sY/cs78TclJLEF1kRdooEPESt2D/AsMmvkm/TeHBExLAsmpOL8fY
         O8SddQ53OTCsCYRv+44fL5IAYT5oJ+laWnNrkJI8bVHN61ajup1owclFCb5kqiVV9biq
         5z2A==
X-Gm-Message-State: AFuF++nInIkFt35KL2qaA9WXXDx21Wwuo8Tl0QllBsRmvriAgkmU7ohM
	31Te1zXK6NFh9l9MyVDWffnziddJN/UiBrawpl4DICuRr/itvTv4ri85hIylew==
X-Gm-Gg: AYBFou2pozzb9VPCRgQZ9/7SQAzLxoF9dvCrb1xJle4K3+ShX3QLGUb/f/7NXy57gOy
	OJ2B88cljNW9SK9BvkMi5Z4fSZQWEqCmVSxKsP/AlrkUe6l26jzx69TyHncV8k0THSTVtYOujzC
	OoN3dodF/oANccay0N/xUyR+ZqGXILsxojs8HCRXvHg38N+swwQ2RICfu0hUOyLjYrkclWQMY/5
	kCDJbSL7jPMbtb+YWmtV+iXf+opRNLbT6VYzppdF6KihY3u4oq+vPWcEVuTsXawTaHVJIozpAjU
	dnHzWnDclqg88KuCoxmDJuUaWK7Hh+GkArUzzgaEan2aohOLIylXpZywDfJAqw4eVIta+C4PvmF
	Zm92hrpzq72Y8p+HCv/PDjGYze4JAcAzoOG6Km0X19iJYxRSFRppr+q1H0FeLMns2uFX7RksLXR
	89CRSa260gOlD1TI6onOUAOs2vOu7Yw+Hb0QTiqycTjIii/seM/hnHCHn0w7OYh2l6N7C/k3Rpm
	7DiaLpeeScHIKzI
X-Received: by 2002:a05:701b:4354:b0:160:8d8e:7e3b with SMTP id a92af1059eb24-162047a18efmr6266940c88.10.1791446845859;
        Thu, 08 Oct 2026 01:07:25 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.240.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-162263643aasm14894867c88.17.2026.10.08.01.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:07:25 -0700 (PDT)
Message-ID: <6ac74f3d.14693a91.3a05bd.f808@mx.google.com>
Date: Thu, 08 Oct 2026 01:07:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4550417229868249987=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: 6LoWPAN: Serialize multicast sends with peer removal
In-Reply-To: <pm-bluetooth-objects-candidate-0001-v6-7494fb26092a1231b75b@gmail.com>
References: <pm-bluetooth-objects-candidate-0001-v6-7494fb26092a1231b75b@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4550417229868249987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181249/

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.96 seconds
CheckAllWarning               PASS      32.92 seconds
CheckSparse                   PASS      35.69 seconds
BuildKernel32                 PASS      28.86 seconds
CheckKernelLLVM               PASS      32.44 seconds
TestRunnerSetup               PASS      774.46 seconds
TestRunner_6lowpan-tester     PASS      5.51 seconds
IncrementalBuild              PASS      27.25 seconds



https://github.com/bluez/bluetooth-next/pull/881

---
Regards,
Linux Bluetooth


--===============4550417229868249987==--
