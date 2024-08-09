Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256F624
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230051; cv=none; b=F3+KS7hSttIbztRrECxN+U1KahcHJSXqYSjEryiD0M3IBl5FCUxJRLQroy2xsCF7SdpshCEUm8w/6Wt8mzkln8dJO095N8yah1rf5nKT+ip/PMKEiG59o02yXPTTF7ih5ngLYMwtHtXhUMzz9AI+Lt5aBitPNFXxLPf8CeITEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230051; c=relaxed/simple;
	bh=QQP+s0eeJnwzT7gf7jVIu5IUSv0D7w3YaBxZhmn0U98=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cuuQ9ewfy65TTYL4h2jVp3RCQldGSKVWjl/lpWhn+t0JlsRempOou6NW78xanvsyZfPvgJdjUv3WMb7IQV0rzc19buPKoK+/OQ8/IQ+FB0KCQMg2k/HpigMbSDx2qpNykls5qCXql9rINJPeqlKNiYZfGGDiFEbfJkdFtXG1mlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNQNVBKN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNQNVBKN"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b79fc76d03so13538016d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Aug 2024 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723230049; x=1723834849; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WP2KUPxenalc4FkzPdQ1/dkDP84hvaYlN7/biI+3T0M=;
        b=UNQNVBKNQP0bamqZxi1WOrFASLY3OX9FsWYGBvWrfP9uRuOv00CGho2B8FFF4XF3Mo
         bHso0mlswwG3ZfDG3LarFwXm1+mcEQDHuDcozp8U11aUFrpEcvXX6gKAjTXOAI4FUr1k
         enFfRZZNrtBn3+Otd0dapAVs7ykaPv15Ew9f9Hi02V/lBnvu8RJJHP64F8JNk6ZLRlev
         Hm4Vu5AWHo3MOyb4XcQbEM9ZLur4cwTj6FKMrialTnghoZzaykAo7YlCdvRq0KSIJNJk
         n4Oixg9ZPUGdTVvoG++Uf33ibcQqHtqL5YExtw3tBerE0aKGPlh0rPcQzm78oujGEu2G
         Drng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230049; x=1723834849;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WP2KUPxenalc4FkzPdQ1/dkDP84hvaYlN7/biI+3T0M=;
        b=LIm1dKRHVZ2Qs0rpzOxDEpyg4xk9g720G3u+0eamB9hqvj34Bv5x+T5KSaA2GN7w9f
         hexaUjH1pIJJGajNHLgOuty59ccM347t+XqKyVam1jAGgpa7dNWVRk0cb3ao/o2PbvZn
         3HiVEUhMHTcsY1dsWpKqEbU1MKzgyQeOAbXZgp4xb+3dHCiSsZC5J25FmkY+6GnKeyZ0
         P4SYs+Psr2ducti4txaCc2VG0OtIH0X0MGGyNDMQ9+c8NZ6Zu5ekkyi7ecmRYZKs1RHs
         YUcYo/Tj/IGx4IDv18SI0orM39wYxinrAmB+q9hr0BYDbZ9IVCXggdhSVBcRkeU5tOny
         WEjw==
X-Gm-Message-State: AOJu0YxDVozwrbOOcdzmxl2dcs8FGpHbvbpQJ/4hfYFyFqd7tI35ILJZ
	Yto4grReSA5HSNSxP6SCjinzRY58FmniuvstRKxBFRoj55eFyKDB9oEXfA==
X-Google-Smtp-Source: AGHT+IEwUP1Fc6E9doAmQ4OOK7zASQ2RE5KuMEENJJwWQxurRf6mKtDaGeoOEZ1P61nlBZXm+02BnQ==
X-Received: by 2002:a05:6214:5b0e:b0:6b7:9bdd:c5ac with SMTP id 6a1803df08f44-6bd78f4692cmr26981346d6.54.1723230049146;
        Fri, 09 Aug 2024 12:00:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.254.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c5ef1bsm778656d6.26.2024.08.09.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:00:48 -0700 (PDT)
Message-ID: <66b66760.0c0a0220.327305.0661@mx.google.com>
Date: Fri, 09 Aug 2024 12:00:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6626208663654493694=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: fix errors found by SVACE static analyzer #4
In-Reply-To: <20240809162252.50098-2-r.smirnov@omp.ru>
References: <20240809162252.50098-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6626208663654493694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=878285

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      0.97 seconds
BuildEll                      PASS      24.54 seconds
BluezMake                     PASS      1717.48 seconds
MakeCheck                     PASS      13.68 seconds
MakeDistcheck                 PASS      176.56 seconds
CheckValgrind                 PASS      250.57 seconds
CheckSmatch                   WARNING   353.99 seconds
bluezmakeextell               PASS      121.69 seconds
IncrementalBuild              PASS      4675.93 seconds
ScanBuild                     PASS      991.93 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/rctest.c:627:33: warning: non-ANSI function declaration of function 'automated_send_recv'android/avctp.c:505:34: warning: Variable length array is used.android/avctp.c:556:34: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============6626208663654493694==--
