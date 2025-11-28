Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7E2D5920
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764363529; cv=none; b=joMIAAQOgjdLtyk7IwvGswJyq+Hfd/OCRa1jx0ysEMQHtZOELeGm86xU9b+E/y9FiCXLrfgAPOMdbVLwEMV88aN3OgJgqskpdOjcHuVvcHz0hui92v4QwRaurND9/U0BlhAHnk4/L8FAe7tY2GE8+4rwrvp0Yr6QBE2pNYqw5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764363529; c=relaxed/simple;
	bh=0YgFaNY6F6OsSg1bmkdDMFD4mqyqt5P6FVQt8ru3tNM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zlk4d9ppZ8FWyxK8mPvCqH4BH12Mwj4XdZ8FUgrxibabTjKPknhY7sdzN3gVBUZYmoKxicXO1MXPSqBsXZkooxuYQViPAO8MDj2kqdZSvxmpwk8mnL5ahdmlstX0PAsVh3lyVYeFohhTw8/A1TWE+CpxELnUw0QyUlYq3lhu6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHsqIMWu; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHsqIMWu"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-435a16798feso15521765ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 12:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764363526; x=1764968326; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OLrbV4zb226r1jppsafA88DmqG5oslRDcSULM7rkhZc=;
        b=kHsqIMWuYqO3QntAXAhlxSj4hMP8o+NGwzC9U5WbNZdTe//Em4dwgFhavYrCatkA6D
         bXXbPu3WNAshebmhib+il2QcG0JDaqzAZuTQoC+Vglj1uLNrdw/fLxrCdu1iNBcpQlPR
         dYqDuPUJuzgZVPFQ9CR06/L3S5etPzHauDiMZu8hsAc5q2tdMy6ZJITU2jQCDwT+EqGK
         eHiQzNhYCioVnai9iwBum5xxXucghlFHmCmmh58AdPpfdDzguE4GR1NhKftMxtGry7xq
         hISBlGQhDEim3Qb/iY3xdbPRV0prTM19h8ZrGC3AmcJzvPf4G8/wkTCHTg0kYVcntNW+
         /k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764363526; x=1764968326;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLrbV4zb226r1jppsafA88DmqG5oslRDcSULM7rkhZc=;
        b=ZKTrO0f0dF8xNsdHXeXf1ziU5dz01MIczEjxl8S1CQf86DVbG/vwqS76H1Jo+f+pmR
         Jlzh0gpS5xWd9oP/WEvNJ7BwFC8s6tPwt/gn6oKeXiWw7s/ZPN0K/xpuY/umIMuDHiHB
         Xvks3gYgI6j44VLhTlZ6Q8DzfwNIKyKVGw4XNhY1TzsGFwXlQm94VNE+KQ5v5phGp4hm
         sG/3z7AlWRN1IXQjkcbRa0yWKwCU4ybfVopH8w6Zlx581eDrdrf+IzkzGynCvslhNkHp
         AMlO1nrVEUPy94m4xc+dGdm/GLIduXlvoE3U3YuQlDQzpi04up0ZDvPoAiNo9pME9QGK
         /egw==
X-Gm-Message-State: AOJu0Yxy8+kJ6CKi9tNLxg4DRX3DUndqZu6ro6OZJ1GWp98vGCdDvGhE
	i0oqQArb98acU8DUEHBE+wVQiPKVzi7GDL9zaybc01R/MKVYgFTDPiQCHSRNqw==
X-Gm-Gg: ASbGncsmwMM4WvKTmnEUDOc+zrFChFX6Tnb0FmTrgH6GMUaKG3Z7GwpaMLnOSUSLLrB
	AHe1NTSSi3GAu5+NCk+3kv0/X+bDDIuPnZvrKLLkw0ndY+PXyZ0UAQg+bE5N6DxtfpnLkbrGe7J
	7aU7nHPKKlByD/lKPKsMG0YuG9AoLHgA0JnxSId9aA+vdYL2pWetdpXGwOKkJNUEZajbM8Co6cM
	g4PH3kaIIywWq4NOuQse+AFL30YrZ5PUcqUuqFh3yGjv3wd+92dW3HEyma/W1YIAFLgMg+usYpK
	0sGw+ABh3fsPM27WHVnp5sibkpYRBQUHPE44tdeE+FfZ/983eTlO+xaH8c6InhMHnhWPR8ZB8DX
	mzeHVbPOeHi7bnc3YyN24Sh9WyEUNfggfCmINERS8vWkcB3x8XaYz799qmpnMk8aVFzMNiFkNY5
	+n0qpzBzxZwuwseOg4
X-Google-Smtp-Source: AGHT+IE0r7FJwst+9c7pb/2NVbOIiRYpZXhfIZB4UpmrFsfq9fMph6fEM/+uGK6AeyHygB9sRBBqFA==
X-Received: by 2002:a05:6e02:240f:b0:433:6f49:2ae8 with SMTP id e9e14a558f8ab-435aa8d17b7mr249325735ab.13.1764363525752;
        Fri, 28 Nov 2025 12:58:45 -0800 (PST)
Received: from [172.17.0.2] ([52.173.163.36])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436a52ff1fasm29099415ab.9.2025.11.28.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 12:58:45 -0800 (PST)
Message-ID: <692a0d05.920a0220.f9084.3d6b@mx.google.com>
Date: Fri, 28 Nov 2025 12:58:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7463732503368242815=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Add TMAP & GMAP information services
In-Reply-To: <e96fe0ead1afec4ce017a2416132b58548f1850b.1764360140.git.pav@iki.fi>
References: <e96fe0ead1afec4ce017a2416132b58548f1850b.1764360140.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7463732503368242815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1028785

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      637.42 seconds
MakeCheck                     PASS      21.70 seconds
MakeDistcheck                 PASS      239.12 seconds
CheckValgrind                 PASS      297.87 seconds
CheckSmatch                   PASS      344.65 seconds
bluezmakeextell               PASS      180.66 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      976.58 seconds

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


--===============7463732503368242815==--
