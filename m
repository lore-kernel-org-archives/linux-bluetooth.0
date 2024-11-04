Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433C1C2309
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718368; cv=none; b=FUAsroHrACGAbkDBm/mz19jQb42QfuKr7WzWibzRwMhSsPXp0X8PyDer3joZao1AYZyrQZu5H6LJ8w3o5IsVJr6jo/GUz5b8YF5DJ3nRDapVvYynGzuTBMj6kqkMYBRZg3OpxepqytFK5WaNkJ74xBLXVMVmdv+7a7IcRwcCqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718368; c=relaxed/simple;
	bh=JMwhVQx9XInRXjfa2rD3Ylv695nmXR6cFgYxvy4/UxA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PDMJ/YDSq4z382wHuk06WvnoYteLUmcudPiAHRsI8vUHTb7ux19y7ywoM8MsPjont8kd6HHsQ5OUZTaZJ3bpA3m5Cm1nJZL+pexkvkKwTZshnudFtJ4kDLM87NXTgQa9s/m0Z/nefApyxRgfr7MppUbKlzSWHE3iU9YMQFwHTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEdUCSlD; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEdUCSlD"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e612437c09so2347690b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 03:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730718366; x=1731323166; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cCpZQIXuCyiV+Jywy/ew61kupTs8ZAo3bGLkynb8XLw=;
        b=IEdUCSlDNLV3Ex7YxrZlJ/IPAlSBji8jSlwjVB9yLF5ZpyPo6avoIc9kJV/dsi2FLb
         RBbcLFsU4Sqa0yw9m/xfl1sTx/TCoBTUFlegalGNX6OG2GRMC6PNI9Ds6vgdZTIFc99H
         3eZ7cvkDao7oYnJ79/5UbDGd4yhUPo+HBjBZCbgFGOsNZDJRxSjgJVIJcsAMJXFyFV2E
         m1QdrK1JuP690p3WXiG/HoJfrMyyqNmH+a7DdAV1qfWG+DVzqhA/bwAY/Y5BGwxGaJgI
         lykzRkbJt3LMhu4uJqjehTgaURpBRf3xpWSRscajKeem2QJN3naAoJkB7K2m/oCmxRE8
         cuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718366; x=1731323166;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCpZQIXuCyiV+Jywy/ew61kupTs8ZAo3bGLkynb8XLw=;
        b=vYh2ZVyE+OIb7a/RVNRgfdU7Dp1kcrs/qAH46N4YGxgkPhRd3K6dp1EhmbpYfUbpmB
         gA/AtYtzKwKMdY/5hhX4apqknRRBpqaZ3oh1f56x80zOutcIsA5FDdfQMi7SksGqzdjO
         usPtYbylm73kHmMc02KrXNlePHOiyk043GNjaR4b1C1OPkj3LEkheS/7/3xZ4U/qysve
         fS9putwoBszTcPGGL3HeIJt9qNqIU4PL/ewuNkO1aISuX+y3EI+O6diJjyf0rbSKA76H
         9V9RtH/Moltaa+nCTPhJpV0qDuej9lfRpC1KNvfa1Y+1hDFnyiVhaKvvizPVURA4PZvJ
         JAxA==
X-Gm-Message-State: AOJu0YxCd6cyQLHidxyUqME9JADXp0brA8f56/jH9Q/yHEI6hoSoHMaU
	omfjLOGsWcQJNChyUYYSFZYs9OiUrbstnyyLZZXkUVXqhLe0Rm8MVPwxRA==
X-Google-Smtp-Source: AGHT+IFE2Lq2LiEnyRPb4QedZes6q15CLPpj4Oh1K8z5fdaycRbB5Dh4/+qf5ajUDEvsijjhU6xunQ==
X-Received: by 2002:a05:6808:3847:b0:3e6:18b6:4bc3 with SMTP id 5614622812f47-3e65837ad68mr19105070b6e.24.1730718366082;
        Mon, 04 Nov 2024 03:06:06 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39ec671sm411067985a.27.2024.11.04.03.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:06:05 -0800 (PST)
Message-ID: <6728aa9d.050a0220.2a4b5b.c6a8@mx.google.com>
Date: Mon, 04 Nov 2024 03:06:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2927726391975194680=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v5] obex: Fix PBAP GET request in PTS testing
In-Reply-To: <20241104091944.411353-1-quic_amisjain@quicinc.com>
References: <20241104091944.411353-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2927726391975194680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=905963

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      25.49 seconds
BluezMake                     PASS      1670.41 seconds
MakeCheck                     PASS      13.44 seconds
MakeDistcheck                 PASS      183.22 seconds
CheckValgrind                 PASS      256.54 seconds
CheckSmatch                   PASS      363.63 seconds
bluezmakeextell               PASS      123.18 seconds
IncrementalBuild              PASS      1442.80 seconds
ScanBuild                     PASS      1047.46 seconds



---
Regards,
Linux Bluetooth


--===============2927726391975194680==--
