Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E236728B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608556; cv=none; b=qTokivOYkJ0l50fhj9T7NNB4nAoplgxick0VAn/NvI+3GV7tCQzxrwoBVqgFDzGu3fSQ2F/qcCj8MN0Q+CsMM8cjA6bbA0UseATkYoSahX74aGwjunID1Ozjqpezbj8U1m7GsHzQ0WZ4wh16UyXz/HPIWLhIa1WUBYF7Wl00SJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608556; c=relaxed/simple;
	bh=eGtHFKfpvmWPTv+iIsNNZawdSvL0oPXB7KZgfZINEKM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KpdFfTQmMteuA5lukP+06LzaN7Ilahkums/KAMTnFmaQoz7fjzDfHMvQJmBNFl4ut1CvpR9k+wh69CtdXjUn2oDx015Zhg+izQDnjQOJNClXonPTzXpYoSkHzuH5OUTjTR//HnozojsdZF77qgANSc6x+eZ06hVg7AJKmTDuNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/+me2C5; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/+me2C5"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cedfaab6bso924145fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608554; x=1784213354; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+R4h/Q5We1kXJ1cXkVjOwMlTPRyH/+qW5pr+crbTie8=;
        b=N/+me2C55wfdr9VJoY2NTV4HioC7yiGFUlS80qO9N6ENeukLp37OwPA3+DqvL4xQS0
         +/HnheDAEjtR978tRgr2RWNyV/+cUFdJBhCYkgBpVlrWLS/DkOZno5/w1zOjMv4LH42Z
         vE3xr8llIso5XSe4EB4FraBdp4PdEw6znleFKtpogrvRlD1tMOAjy0eepbn8y+SA6ae/
         5S6zqE5rxGqHN0tFHUCL+SwK43VkoZ1VKJAL/5V0wEy5E2fcw63mp4qcbQkabdy8fJtJ
         ewIuBTMLA0dVbIbH8yivL0Pv0mIv05ZdJF8+xUJk8SHsEyFk2QYmoSPxhV7QBL0VNrAv
         qmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608554; x=1784213354;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+R4h/Q5We1kXJ1cXkVjOwMlTPRyH/+qW5pr+crbTie8=;
        b=H5rXdT4SGlQVeBJAwX+rQWpYZ7c9efy4j46WKo21taxdkReHVSH7D1j58wy6zSX/zl
         nKFSg2kBliVgHPjGTq119+1ueIa8JWoJTm18c3ai9oqQphQmNQkTOtODKPccLCY7V5RK
         3rGRlX7ATnlzEW4FdBGf3Hfhb5aPFrRn3AGG1tqkogLV97Q63sD6ENwN14hJ39vtc4UN
         1WmXCkVm4sSPE4cD9FQDGIfk6m6Z3IYzIL2yKx+BJz/OLkOXdNsmTlTHyjVWR8x1Lfqc
         L7r8gGETYklmK2TgkDcDwbYHsr3ODxY/7t+qUt6NsBu59thi1JT8gVZ9IELJQNOez/M9
         Z4SQ==
X-Gm-Message-State: AOJu0YxWDrHkAWTRVPdJUPiY93Sd6Q/A0iMN5mkSilt6Bqlaw1Iw/z4A
	k+ns29Ta9ZuP4fxbQepF1JjzrvfAGvfPbHpJ+9Zwn5DzfhAG31LFXjSHG06kBA==
X-Gm-Gg: AfdE7ckYRjkObJ/YA2iFNmcVAF3ny+9AUkhxedfqNyYdQT20TBWn8weCvkz8FDsJuBO
	RKb1WF+8ID9h7hE3GjMTZHVFsK9zMvOLs5KGUWzTEJgksJRB8Nzq2iw/Y8LQPQjH3ULQAL1vKAI
	75jnMaY7ZZyMQa+UdeTcXrkNkw9AtXybpl8m6nDQ3gs3RyjpMw4ECKi5z1ysoGbG7uKWrAT4PZ3
	hhOxukZRpAs9IW4sz4TrsjEgWFcdgWFU7SwGqe9TJppvIWa5u9d7DUusaDAl9kkX2jKfVyFqE/a
	SZ4NY/3ayh/PzDtTPloqKLaGpuASOX8eH7LvWbwdCFh3aeJu4zqUdyH2c63kFgxAzPtWaIG5Fuo
	PKKXWG1XGgX/h9ow4jFVoO7iDRK/cIRXhnMt1dQLiHBUFiEtgdpLt3103XLWzo8EpDjnnvYIlAU
	QTlEqhMJONj6jgvVeCdseo
X-Received: by 2002:a05:6871:3a1f:b0:447:3653:31ac with SMTP id 586e51a60fabf-45163c23056mr5388366fac.29.1783608554046;
        Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.182.160])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm2161801fac.9.2026.07.09.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:13 -0700 (PDT)
Message-ID: <6a4fb4e9.5be7a510.380daf.88b1@mx.google.com>
Date: Thu, 09 Jul 2026 07:49:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0461628020088328928=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: doc: Add Channel Sounding API and bluetoothctl documentation
In-Reply-To: <20260709125142.2655974-2-naga.akella@oss.qualcomm.com>
References: <20260709125142.2655974-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0461628020088328928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124699

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      0.79 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      502.67 seconds
MakeCheck                     PASS      18.92 seconds
MakeDistcheck                 PASS      152.17 seconds
CheckValgrind                 PASS      221.21 seconds
CheckSmatch                   PASS      291.30 seconds
bluezmakeextell               PASS      94.22 seconds
IncrementalBuild              PASS      515.72 seconds
ScanBuild                     PASS      862.24 seconds



https://github.com/bluez/bluez/pull/2284

---
Regards,
Linux Bluetooth


--===============0461628020088328928==--
