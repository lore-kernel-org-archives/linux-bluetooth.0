Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7760C33D51D
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841319; cv=none; b=cJ7YMyDa3yumHbjBAODSy+Gff3WK04LNz9SnJbPpj+wD4j18I61/6GXJ602PXdtjwZ7OL0Ft25DoN0582BmwjJBDzMv4YAma7pnbGYlAJTTx3lR9kA+N/01Tc5MQChI+DLYp1I1ZhGPrdkcqxPyqnQfNUXB/SmzJj8X/y0OlKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841319; c=relaxed/simple;
	bh=M1/xAuEnIORBcY8+3ZhXBOIxxHmEBRNGcID1epI4mJo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gCl27xEDWBxjoGU0Lny0heZ8UKdK78SGhIW55mJxOHNxugA3JUcYTV7c++StV8nGwWrinszr6wczC82jGmVlP6gYyMI+mP5YlQKlkElvsOVAEw/HfxRHqC6FAvP4l+/psb+kbucPQIbao2h4k08COz+CjInFiNof+GACiLSTPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhczvtE6; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhczvtE6"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c59bce68a1so284194185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768841317; x=1769446117; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6b2hqp+9G5UD/aFIMIJAvWQB6BCNesg0FnKAL55kTkY=;
        b=BhczvtE6hkBA2vsosUfVWM+NhzaEIDVLhVXChVH48Q/suR9eUHfYJ6ESzKEnxpQrQU
         o6zBDIgjFaMb7bopguuSECfZ27vQddlwkVjPlmg6HynJyW6G46CH5my6VfDpr2H7TR88
         qvfzqWw3q+Vi4CHN2rlnOL/7+h5nb60eOdSwu7KNM3wooOx2FwplFWk/lHa6Moy32iv6
         YAFzKqZOLS3llA+c6Ym0WqNfkn3rS4t1nj5oyujh9NQheEUfdeD4MXB4djowOk68a+Op
         5DQ3FxSmSp3ltsoed2ggn0B8CSpxkG13OLqPHBEzWl9tOvCx7i1n5F4dWne5NYBLMt0Z
         know==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841317; x=1769446117;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b2hqp+9G5UD/aFIMIJAvWQB6BCNesg0FnKAL55kTkY=;
        b=kypSRAOvR1cAOgfkp+0mPyXjTKoZQIgOmEAgX5CdR4DgeO1jZndBfM57WXSgGLFNva
         B9ghpuYSgbRzLH8EWkrY2PaxYoOi5SB5hM3HLfGAS6HyeJHvIPbc2kZ2+IVLmNW2M+ko
         fueAisVwvDmlFkkBf1sV1BvGZQUZwTdoRh6IBXGmdGZRhubm0Rfl3GVlSeAJFNbiodEV
         tUjwjNrAiVXx1qmBhikSfv6okeYiOCiq7s0mWP8GfUILokX5IiGNuUH9ZHrqgVdY8EYE
         YH3sL2aRyalZBe1KbIz69CShYzymUUIL+YppGTSURvab5nE+3aSfeXwobo3BqDQ1scBG
         G5Zw==
X-Gm-Message-State: AOJu0YzW30Vx7sjjfmpWfxDVkvInUBUmWIApAKsK3A66Vix/XCHkHWxM
	5nRIdHTg3mSvUGfLI4e/DtX4qrZqfmlzqlv6mrx1CeKGsw+mFjakZ9pFZFEiCSYs
X-Gm-Gg: AY/fxX6TGMAIjDfifyTqONCZ9GUgU8Cs7F44IzCQ02Ky30NIq05cra6fn3/KriV7wdp
	P+MXAh+U7jBVexV6z4KlZ0xwFi9Mf3wN3QH+8/it7g3pBzQiqGEyIqWH/Rt7bQtB40U234uR9bf
	YMpywMfmSiZZMZdQwyjcy86UZRRHNcv/NIBquS1Tc3iQHUzRsa982U1h3uam/gpiUCqEfZIWJGI
	FSFxRC9Hu8Dh00yB3I7yiUJQyeLxXmHr7KKSt/6HQ/58KZmjs56GpGMtXq7arBZfz1zGb1gW5OE
	0iRBrdZp9Pu0Y3/UYnSZTMlh46e0kTCOMfDhkX03BAgHSrI3qzIe3S7x7/L2BvK+ANlvrwQx+GU
	qwfN7Opsa/KqI8bcf1XbWaKituqNkTzbLOmoTrk+x+HBuMK+bjovpB80Xwf5uKuxyJQyHVCLNOD
	4xR+bf5YIKg83wQNSfEzzegq8FnxGUfA==
X-Received: by 2002:a05:620a:254a:b0:8b2:e179:febd with SMTP id af79cd13be357-8c6a66edc0amr1561281385a.10.1768841317089;
        Mon, 19 Jan 2026 08:48:37 -0800 (PST)
Received: from [172.17.0.2] ([172.183.157.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71d5b93sm817603485a.23.2026.01.19.08.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:48:36 -0800 (PST)
Message-ID: <696e6064.050a0220.14fa8e.e0f7@mx.google.com>
Date: Mon, 19 Jan 2026 08:48:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0276492162885070473=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the L2CAP qualification
In-Reply-To: <20260119155548.89569-1-frederic.danis@collabora.com>
References: <20260119155548.89569-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0276492162885070473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044232

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.35 seconds
BluezMake                     PASS      651.84 seconds
MakeCheck                     PASS      19.07 seconds
MakeDistcheck                 PASS      246.59 seconds
CheckValgrind                 PASS      296.95 seconds
CheckSmatch                   PASS      360.51 seconds
bluezmakeextell               PASS      188.78 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      1012.51 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0276492162885070473==--
