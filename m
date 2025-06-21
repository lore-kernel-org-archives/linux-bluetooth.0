Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935618DB26
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750508209; cv=none; b=dF8UzoHWXs5FKYSLO8BlmuKijDA0lrGHrmKBVMNBxCY7cqXCRfxtWhmtBxhBqTSWkn39OYNZf9SwmIyPN02tpvyoOg6yaNa0lCrPu1jcYO3Tv+C0axmw54wiouevM5o+6Yy5AAiONTb6+tRTMksMf2duwSrFH3Yf3Mb0UqgOzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750508209; c=relaxed/simple;
	bh=kBluvRpR+4aP1gcu8Fb8Z5LjA91FRwpBWVaGvgr8rAM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jAa/2mBka8vO8Etp1rOV+Gcy0pxDymJCWMU+ti+K0pryHsU/YzcxIfyLQPuYenP5s3J21+Q5Xt7kjvyIdHGpZj5HKC31T+vY/nipXTYqHOtzx633hlt9JaTnrKf/p9arho00loG4zOPeqzp4Y5u2eWafIN4bz6FbcdsdQTw6mJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVT6If7h; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVT6If7h"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fa980d05a8so26544546d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750508206; x=1751113006; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7pVei9Ia/bMOJiSopPyHVHbDhIUQRQcTKIiY+dEE8z8=;
        b=YVT6If7hAdfHU8iXgv3fmAmCqpXumlYOGzsWjAfMNEvgE8T7tBu3rxNYE4pNRlWno+
         uqOcduxdpE7oLrKV1P3tRb6mjdVpPeyBgK3uadaw0jdE/G13HzS6u+vESxrDhKe6lK0v
         LRa8FIlpvrFyZ1ZPM+8OvqcKf8VSg755eYI2nYOxeoFr+Ri0iLB/is/dJOh+x8jc4cyv
         ENBti5bl/8kvvyyH4/mkJQurG57raLuNnaqxBAywaw3J+o4Q0YqDOhdvYWcKV4ueBS9v
         tf4aRyU8Dk2anpeNA467zPQu8Voda0+PT3+nspsfjATQFn+ES3wCP4+/gK1E2l1lc61F
         AsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750508206; x=1751113006;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pVei9Ia/bMOJiSopPyHVHbDhIUQRQcTKIiY+dEE8z8=;
        b=mu67ZqVxc/BIWzNcJsAAPYPeUbd+9MOQ8uRCXx5yO5Gg9EUdxJzhPio+e/jdy3/hO6
         nCx1O2meDWbr+4MZxmjBv9UzX+TK1PQZ0eeUAXjJbuj1YMUm7i+IYD9PsYvknX3ubkyl
         Q27oF2pUwXXPdj431gnmyrzaVrrz0Ew4pbzA93MshamomRz7RdRVYHtNwBtH0dWYa25o
         WOW6YPdHSkbQueCR4OXzRswbqpzDSHA46OKQiB8q38AtkirdisfUPvF9DKSqEVcPaCyp
         f+wdtqoRq5veD/50TxIxHNS8vGvUr/djqNOYOMWq+JJoGSCXkBmAPZ97QPaEEDO92Klk
         tXwA==
X-Gm-Message-State: AOJu0Ywkc8gOaDtpPJIvQLVFsqHm9aiNL/Wsgg3ZB8StPswpwFmulG7j
	jM9GxWWi4W+KELkWe9eh2Nyj6m4kQw5PbIFgfUOzTJoBwEGO4kLOUE0bpTXMAQ==
X-Gm-Gg: ASbGnctz+UhYdntJUxjwPQUgDTUyjg7O5v6ffDy0sK5uEOOSF2dMBfjpTj9hxabmkFi
	oxff8rkY2dZ9l9bl5tPiA3ttttiVti8Uozler6HHrQRpFN5kkrQvfwyD09KWTEcf+J856wJPUBQ
	d8DjbpKOrJvyZTBa3Kz31UB0TGCGgKeGZ2BTtsk1wAFqDxcXHuNthK21UKgfkCcUB20TWvNfgDG
	4K2suUdxUFZWQMQ6T1gMV+wG1ioal3lm627R952UZhPz4p9vCHTI7NRm3IuUvRf/WLh3ZAXWBTR
	YS1FIOTWy9iQ5R6WmL9JeKmkrghBu6HJkbmUGfxJY8wy8qul0uXx8L/mBtxp5WALJxA=
X-Google-Smtp-Source: AGHT+IHuOArH3k8GynMiWf5U0fZC2eamp9DgJacFEQR9soCHH/KVOl0iSzTNsFhbktLpeCgB0+ahMA==
X-Received: by 2002:a05:6214:501c:b0:6fa:fdb3:588b with SMTP id 6a1803df08f44-6fd0a59ac71mr101823836d6.39.1750508206583;
        Sat, 21 Jun 2025 05:16:46 -0700 (PDT)
Received: from [172.17.0.2] ([9.169.164.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09420e37sm23191416d6.26.2025.06.21.05.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 05:16:46 -0700 (PDT)
Message-ID: <6856a2ae.050a0220.11f4f8.8876@mx.google.com>
Date: Sat, 21 Jun 2025 05:16:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6288420465040023758=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mail@tk154.de
Subject: RE: [BlueZ] configure.ac: check for stdarg.h
In-Reply-To: <20250621104415.63416-1-mail@tk154.de>
References: <20250621104415.63416-1-mail@tk154.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6288420465040023758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974481

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.28 seconds
BluezMake                     PASS      2844.23 seconds
MakeCheck                     PASS      20.38 seconds
MakeDistcheck                 PASS      198.97 seconds
CheckValgrind                 PASS      278.16 seconds
CheckSmatch                   PASS      304.32 seconds
bluezmakeextell               PASS      127.90 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      914.31 seconds

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


--===============6288420465040023758==--
