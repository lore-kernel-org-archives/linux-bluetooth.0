Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5722FF5E
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591580; cv=none; b=HLr1zRO26ChSMJ+ECUH2AROwqrTo5Pu5e8xhT/QHBq3EbSZ1hGEcQ3hdsQPvEfrLd0+zG72at7qIZHqZCZYcuFpv3fQyGnA95/p9SSv3kMCQC605q1wA00G8fJfmlflaf38JsfMXs2GYq0mZWAQv/8IwgIWKE4zVv3UZEYy4K04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591580; c=relaxed/simple;
	bh=lL69AlYldpF92Ce9oLwzf57AfRg2GjHYax3ZtY2jZKQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=haGU1ZQ5HWG7NyC5uXTKCXa2QLyO2qiorttuMdsS58PTLCI9Z2oX0H6rlAS1TTb5odQkAnSu8YW7CO4MCUhZ7n0qHhxkR0SQvx2ECFu0JJOI5jPx/AvPPAQdJFOdEsR3OlJD8YWxSXdkaDdZOmHQK0ltQagI8xWjL1kNwlgl9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1NifvPK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1NifvPK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so50257435ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 14:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742591578; x=1743196378; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4heAp8593hWvJaHtRmv7kUOJrr66xP/IvNqfkpSBaAU=;
        b=a1NifvPK1Y7juISZWauBBADv6CJD3IXkN9PS/w9jAPQT4DvmzIbAqfki9SniZVAQU5
         LZ2POAYFPhhZlBuvHwD09EaiCx//YH4c0BbNmvK0pNKV3JI2Phjf/WyEUtdbUVcwlvwk
         Dh8R2Zj9xlN2P6+WcyDk7UV+Gkdt9x/lr0WVVJXwvWG2P19m3JA/tOjo+1XaFXmh1yQP
         mXpJgtlrcL/eX3uxJJmUT360PGTplxZOA5NWZ3U7zGxcI5V5taJKCqTtOzzOHHl7C+JJ
         ttZlE/cEQyYIPuBbBndQmLy31K/F/UmXJsrwer3BbcR3gAYMce7BGO7agxb87ZllE7TD
         CDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591578; x=1743196378;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4heAp8593hWvJaHtRmv7kUOJrr66xP/IvNqfkpSBaAU=;
        b=QFNw000JDPxjYv55ZE60ZMFhfWLVnaLO6WF3Jk7S31V+LWi8+D0XICu1yllZ+IJJKK
         0bvaP49Cm3XMb24i5Jxp6Um+XWOME6ASeh/eoTHHm24cpU0OTnoaa3rr3VWe0N8fVnOb
         CCvVXmCf3Es2+KSjTLtivqm7AH0jHU1DrOs6GiARgus1kiEaqWnI7jZV+GavwbhAhcd/
         3jjCMLziztU/ITGUvY70B3IU0l03RpZzfmIwoqSR46OAqhG21DdC5iw/Qntmi8onAc+h
         tXK6NpP16hHAn02QlG1u6BRRSCm2vYFCB//GGtHIklSZBKlDA25cWENSVEfLjD1d5BUb
         OyLQ==
X-Gm-Message-State: AOJu0YzSNPEUW7Kg24aRXh0JtVhsFkby2Vf8GT+jI9VFsUkJaPf5bemQ
	zC9KpmPo7Fz4ztWXYz1zVfxkSXzAcXRcuRXbGLPHsRQ0so5zAX9CnemsHw==
X-Gm-Gg: ASbGncu/jDWxlH2gM7pl+EJ4xNg0vvwBD9vcsgVngi4gpKsewAxOtSZvEem/VuKD2O4
	DeVIzD8kKSneCjWKfU7BtOXxgIrZfDFaRJHETso1ptl4+zBAbFfLiN+sw0i5/hEObd05XbG8Emk
	g7BvAiTKccORKQym/dhc873pwSzcWCpXO7d6atbem9ciCP0FtTKApQPtBv0lWXiB+5L8qUZOlNb
	2D1CcLL+cAcYlm9grcgbncIPdw+llwb/Ng0vx924B+j7FUp3owK40GlBgBo2M2Lof5UIVnGJHw4
	s2qQHI8xCohB+y7qdWE2ujeEneC7abJIJnzTLBoMaUuQqerX1aU=
X-Google-Smtp-Source: AGHT+IH3qdwx6GFxGC2gOsKCtp5kXruRCvBMxZu/6ioZJ1cJWhNQCLK6Zp0zexBCZcVqoRtzMwpf1w==
X-Received: by 2002:a17:903:40cb:b0:215:b75f:a1cb with SMTP id d9443c01a7336-22780c5570dmr73600905ad.9.1742591577761;
        Fri, 21 Mar 2025 14:12:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f44bbsm22202875ad.232.2025.03.21.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:12:57 -0700 (PDT)
Message-ID: <67ddd659.170a0220.19e339.8fb6@mx.google.com>
Date: Fri, 21 Mar 2025 14:12:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2794737303694302838=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] device: Attempt to elevate security on Pair while connected
In-Reply-To: <20250321200527.1733821-1-luiz.dentz@gmail.com>
References: <20250321200527.1733821-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2794737303694302838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946413

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.44 seconds
BluezMake                     PASS      1558.49 seconds
MakeCheck                     PASS      13.42 seconds
MakeDistcheck                 PASS      159.45 seconds
CheckValgrind                 PASS      215.37 seconds
CheckSmatch                   PASS      284.29 seconds
bluezmakeextell               PASS      98.23 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      868.20 seconds

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


--===============2794737303694302838==--
