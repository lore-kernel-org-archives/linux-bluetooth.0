Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75414D598E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351695; cv=none; b=OCPgl9CTFFicgBR8eGSbiahfDs3IH+BY3lS0qj8DRkw56F+EtzNErXXNCQbNTafOaGgyN3HrSKsgS7AMK48X1kE3j+KPdmeFPHK0cr4rmHItJ7GsCS0ZTmdMGrHuIs6S2NIAT8aPZPFq6g0BIlN5f6zkF+cTU/GFK3y9AnPt6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351695; c=relaxed/simple;
	bh=onZnLVcwJ6GVQLiwv9af+u/rtEOhcOy/fhzaDAfQi28=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QNV5JNEbZmr/QYaWLUCp/ej4gfGDnzNszsEuXMB/G7PY1FV3+DcyjiuzXGP5zQY9NtxFjI66ZfT5DBUBcbwfPQRJKJ2/ceRqmNtcRU2cL5GVwWdNzzjrfRUFFGwu18tKGMqbeyDa9BteGAXjxEEqZMcyl75TA67GsmD80mUukwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ7yZfDx; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ7yZfDx"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe60d5fso3872216d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790351692; x=1790956492; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bi0bRzBBqGTarmwJnkwx3gjZ0JcTLagD8Uh9yAli9ig=;
        b=XZ7yZfDxGSKaj/REgEkXhxfSvUBPhPaL8K7Wp/vemKzmLDFKKDtp+tIW18GxTU+gYG
         0NBgZUfxwNtYYVSQtIVnSmmWyNwah2QfFBrqCjLMUCP0Iqj7gVbEOOlmqPSFrLpjAY65
         P75vvh+7zoF0QXw/dJGvyI8+H1ie0T0SxOq3eR2z82QHu9uRjEeQC1vifRX8tw4JazbM
         k3kMqv9QXHe5snMK+xfOW0Rfcz90rQZJhwiCenvL+aVkmAoOL20ivrVmTKmYqiyenS8M
         PCJCiDqOxxcA1exhiJ10TZXCmOJnTJrNAjZ83C8vagErlGVONBh2KNMxH0WaocKezSKQ
         6Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351692; x=1790956492;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bi0bRzBBqGTarmwJnkwx3gjZ0JcTLagD8Uh9yAli9ig=;
        b=n+rK53ua0i5cQMZR3/ZWwoK2sgKKsAVN7jyVdMA0WWOgWozjBxKcfxRpbBs9ZXIc4a
         MG0SrjZke+GpAR0gb4htB8uwMCa5VIZluzGoG9F8xqMOkycM8OQPUuFKm/CQXTGCIEKZ
         Za1wAhr/Xv1fVne0duJPnh2d4vqi6GGYMOLyKlpI7zaEiNzQMhWDLH8iz8lLqWq3fHc6
         UTC4T1TV+l6zWCbMuwBo5nAGbgT5L/D9SLn3qWJmJ8KcNZeZc0ubQhn9in3eKMHLpVxs
         QAGmIUWuNF47iAplp+0PZlRZ2tlTJh4AW5mPL6WcMfBk1bsbm8MUEUCAaDn9A7ZNjGtD
         0E3g==
X-Gm-Message-State: AFuF++ljFZdkFPNlCefVyiqdxOdTTnrFiryksZWaDBf8xU+AJcOvYEdC
	wKFkLJYreBtEyKib+LoKWPuKENQ84iY3QG63qHabs7mHZS9N/YSAQln72lJidBYv
X-Gm-Gg: AYBFou2UON00y11N2gMr+Wgl0GLW7cxR9QUPzIldUgy+qVflBhZt9U6OwNjo5whLGFv
	tud1sUrgbimbpM0TFxiDBeluHd2E0velsFrq2tRn5U6sF2AK7FFzRN+R6lhuQlt11jj7KgOVf3+
	LCdmKSs5vKyZLQj8k/aefH6dqzJHLbcmp+Fg9cXPCrH5w7rHGVlt6qD84w74Z0t3SUuV2x1tmNX
	0ffKtdfI6Lp6kE/+PGyXL9+CbhTSGgNeGbAm7Gky6W3pYYnSvUT6E4vjH8398jCeW0PvS68Amiy
	9GCNXJAsTxAJQyAmE0bOw8YGfxrjXucWPj6FQ/rzeHftZqV6Umdkf9vS/+xSH/5OLWu50048D2I
	3NbGa+0CDJVFe0QNuwtU0q0/h9tB5Cpecc+L/XL9RZjiGq57H68KYa5tqOmGpXu7tP5OrByDxVI
	f5QziHg7Yz1duwDifDUIllKG+1QbYoO9297xm7aGOCNYqNLLZ6Ijat+4jZnvPFCEkOYfTMRQgMw
	ZOP
X-Received: by 2002:a05:6214:19ca:b0:912:db2:8b1b with SMTP id 6a1803df08f44-9142f640517mr54105146d6.9.1790351691999;
        Fri, 25 Sep 2026 08:54:51 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.167.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9143d0a64b9sm7886326d6.35.2026.09.25.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:54:50 -0700 (PDT)
Message-ID: <6ab6994a.6e630a3d.1361b5.083d@mx.google.com>
Date: Fri, 25 Sep 2026 08:54:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5650750305674443885=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] doc/qualification: Add CSIP PICS file
In-Reply-To: <20260925124155.3344025-1-frederic.danis@collabora.com>
References: <20260925124155.3344025-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5650750305674443885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173742/

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.72 seconds
BuildEll                      PASS      19.90 seconds
BluezMake                     PASS      386.44 seconds
MakeCheck                     PASS      14.10 seconds
MakeDistcheck                 PASS      139.38 seconds
CheckValgrind                 PASS      232.87 seconds
CheckSmatch                   PASS      289.47 seconds
bluezmakeextell               PASS      93.44 seconds
TestFunctional                PASS      1118.08 seconds
IncrementalBuild              PASS      386.54 seconds
ScanBuild                     PASS      1127.04 seconds



https://github.com/bluez/bluez/pull/2584

---
Regards,
Linux Bluetooth


--===============5650750305674443885==--
