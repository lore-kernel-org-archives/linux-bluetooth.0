Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A77145FE0
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775263177; cv=none; b=LIjj0ahEG8AG38oTSd9hGL+T+0sTVGadUbNHHMtp9kklsRW7ZIsK2sDP8RyEjhqSFzE60KQ7F7QDvhGpgp2U01hoC47sjg5nVGFahKABrqFmu7y7iLb62qI4GSUk9O6WHiszNWyeMZumSILb9hH4aIAoj70HHbhR4w59Erm0U10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775263177; c=relaxed/simple;
	bh=S+RspoFDT0rDLG3sUekFWjK0jOVrMlAF4JS1DHEk3sY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YsaCvtKYY7BZCBAqQf7bMNmGB9+QlxgcMMTWBHMrBVkhFEQliU9HLK7DaemXgGSDJBIgGbbNsQdTAmPmVcg3xxNA8q6eoku/2mX1jVDOoMrFKjWvf64YBWPEdr3xlCTNP8N8fJiDhB8LxcSZMK/Z5KUGhYfP1ucdWFvS9bc4TDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4yGf41T; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4yGf41T"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso2923874c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775263175; x=1775867975; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zfqby8kO8y2Ga0aSXsGAiVOdxtL5JkDb3Ml+Oqrd/I=;
        b=A4yGf41TbxyXFfHnhR7C0/+okhiuD/ULcB/QBPYueZwHDTigLrHUfLB4Y9z84+b6B8
         nGcfGb2GAdtqyebZL3trD0OSp3kRAvFsPwbqlzyKOEQ0QYS87RQSSnnd8dVH2lzsRKfl
         tnDtEPtkK3ALWx9FY+KJGMiK1t1N6M9PUQM4xQ88xJKXV9EfiX+RbDCrpGyJcYqi7wgr
         cXZebofraarmmR1aAXazAdmGtJYaPqqBj8Xx4mMFZutcfhnrsqS3hJn0fN66tdkZKujM
         hEr9TVBRe46EiJ+lDNFGxKxD8iyQhUydihlM+cA1lR6zh82RQD8P5lBWWIbtWdKCFSif
         aiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775263175; x=1775867975;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zfqby8kO8y2Ga0aSXsGAiVOdxtL5JkDb3Ml+Oqrd/I=;
        b=M372n0QSjcc0f10fkBvU2hiFSc7y9gGPlZnZmJxCki2qRbw3q0RZVrtpjBh9omgPIq
         IscmGWGz81EnC88Zl5wDHC2EbXaGUSoveht5jZnvK3Qb8CIpMxo7Y/aCPNygnep1wH8R
         q9VCYe+NG/CjGO5D/VzcJ0THZQNGAW+SpSZN7EIwyUaEzFbQS417MLgvzhXhwSKYrcA0
         /zpzccXL5CNZeJobPQ2zNXeCppWlr8xzzeGL8THw1Lm+zzcQeag6AJnfN2Y23z1Pq/Rd
         CkxXigNgBrJhkBWQUbBl3z1rU311+r+EfsWzWtND/8bKLNStPgtqLKYwbSHgvT8k4QNW
         v/Yg==
X-Gm-Message-State: AOJu0Yy1mshlI++WKKrpOD3BB7rozCwebC9ZXIRfO6oAdFFkfZi4C9lB
	8DeR9ncCvzvFq+l7uWx00hbb6OaARovtLWC8TTcTDQio6W0TLW5DElmz2hLUNQ==
X-Gm-Gg: AeBDiesxX611XZL8p1UWlIuc60OQMXvsIyRQuPxJ/hm5EhgKsffKKOS2lBbfqWLqTlQ
	q7oORa5hN5QJ9aMjzsVkHZmY9A30Gkb+ru5mb5JrlbWd6Gpf6cpCpvBLc+Mct+M+qQMw4idCMj/
	ozH0bTE+iX3uSaAhPZEL6iVkQVAfzmYSq6453DT+YjftLaWFacYo9gcZzomcb/Lp4why+B/cc8J
	FmKv4MGnPwoeOAW1UYrYxAnPhSlLK2ONd46PuzYU5h8GX4uGVObhN6hwNanmS0cJ8Kh9FQipBwW
	i8DNKKcDQHANT5/J+fQV4bGvb9RcMA+aZLdv/6YyUYioji94MJlnbssdoFN2LkMiTK8FWxElGQW
	g2u8WD3g3K+noDXGVL20V7c1dmnmioXtveL3lGa34bOzk+glI49ZluDpDPTNQ1rDIN18v58JzmA
	1k2pYUC7CAB5Mgsiiaf3p4fc7lRRpkoYYf
X-Received: by 2002:a05:7022:6b85:b0:12b:f899:717f with SMTP id a92af1059eb24-12bfb6fb68bmr2355957c88.9.1775263175146;
        Fri, 03 Apr 2026 17:39:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.195.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bf90973b6sm5154336c88.9.2026.04.03.17.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:39:34 -0700 (PDT)
Message-ID: <69d05dc6.050a0220.321466.1d18@mx.google.com>
Date: Fri, 03 Apr 2026 17:39:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0978986744473462161=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, harshsahuxlr9@gmail.com
Subject: RE: [BlueZ] device: warn on BR/EDR connection key mismatch
In-Reply-To: <20260403234246.31501-1-harshsahuxlr9@gmail.com>
References: <20260403234246.31501-1-harshsahuxlr9@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0978986744473462161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077174

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      647.07 seconds
MakeCheck                     PASS      18.75 seconds
MakeDistcheck                 PASS      247.14 seconds
CheckValgrind                 PASS      294.87 seconds
CheckSmatch                   PASS      351.06 seconds
bluezmakeextell               PASS      183.74 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1017.39 seconds

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



https://github.com/bluez/bluez/pull/2013/checks

---
Regards,
Linux Bluetooth


--===============0978986744473462161==--
