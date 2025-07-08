Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDC2288EA
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968664; cv=none; b=a5kpIQlHU0VMgDMwuId0/+ddkYyo1ENRgvw8KlFtpG3k3OQmBv2BeXeJbUkOCk5w64kdecnbYlhxuGGTJUpfr5UE874OGhstw74SoC7MAey44+bJCxMi4kUC6J7IqhQoQN5NCqrSI2Zb3U50ja+g6d81eF10kzmVveQ8nDpRO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968664; c=relaxed/simple;
	bh=g2/UP96H5nB/p6vC3QD7YHypIxsysZSi5gk6qk2S77w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=od2Noyj9Gpovi0IaJvtsGbgRBu/ZhRK5qf0F3Ik4VzfCtbin2Kyg/mxvALZSetqUxDJuG2hvideNtQp709YgKzGvotpD5x5Dozr0LQFYDT6U+6gcZDj0/HfsO0QTd27puId5CG2cSofRR+dDAZJkvlFYG44bcsj4AydoJRvsjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsQra0fO; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsQra0fO"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecf99dd567so58377016d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751968662; x=1752573462; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g/5WsXNI42nuH+Keu1rYwzdz9rae8rdyzvnZR9DKe0A=;
        b=IsQra0fOdPHe+OZVX0mQSmcI5OamAFMqGZuKaL3PR7dCWzds7PCqtEC4GeZs5rUGfx
         4s1b/n5an+Em2Un6Nh0k3PZ9OoWaz0YKZoIUge1tyiwH83cn/sMmkzxACvQZbEKXVp/U
         sIhACYu7+6TylAA/ki4S3RHElM5ra9uo8lwVDVJPP6ry4Uw4FZ6fTO9aRrhzRh5ojSxn
         tTXhCHEDsWROLOPwLah3BOMZp6FlOG4yaUViC1NDywMMto7Tc9Ct192QO1h8B+EdlD1F
         bndMtH++62ZeQHZAwCsZd5wGYXT2IUlAQUrzUlnOxgLhTOMo76xnGnFoej5wzQL6yco0
         8N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968662; x=1752573462;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/5WsXNI42nuH+Keu1rYwzdz9rae8rdyzvnZR9DKe0A=;
        b=A7eA6PMmzJF3ivKnr41eFVxGEPd+mFeJl/ELLeg47b+FIto1t5CLA+/aBFBdHtvcjX
         up4C1cR5fyQ3S7wIUvAKdCTn8rJAMlXnfjkuaVDcep7XUC/1m95OH4GzZYq5dM7pFcZr
         f3+XCOtE0UUGpQP68R/sU+D57Fh4+DkLUCI5Wvvb/NKXQ4B8irKH7G35GgyK3PJz0eto
         6J/07f36C67ZnD/6e5N5p5EQvpG1tCxZWfhj60nlZNX/z4eRXyOyjrH/xpJ+w00I8SC1
         CXSn9daxuxUH/f7Om3ScQmDitdOafRm6koCp41sO2Bs6vMyduMkzh9W/xeV+sfNYnysc
         LoKw==
X-Gm-Message-State: AOJu0Yx9BDJXOE2UbiqwZolxBs+Z1ECneR6IdZtZaASGnDYF/P9vHORH
	aom+d96hOIfSVbzcQ8oAZudRszxejbWCHYFLPIIhz0bae3VvmNjelD/5DAfck4P/
X-Gm-Gg: ASbGncsaHxH8qXosKJci4WEUhVhTKkRBU024HbyuWe2n/Dg8bCe8+LRpSM1JbmwkVYQ
	IeEwTnqS1LYWzOOgHgLQn+SCRUlaD6x9mgzAQbJZ4swpW0BbjegiHNNrH+lHFZ6OcXQ4/Cg8b75
	hn+5xMXsEN+veWxPZfZQwwGU1yphwfjOt3vOX0Sy7kP9vPyLQrvM3uzvQPHYUaS0rOMJRK6I+pO
	GACXi682cQNRfkVre4f01kqBgnfL523kUzLxURVz0QC82+OHDaLaAPI5TnrxDTZGGCRZfWKlBDY
	bmbtFmtjJ17kjHG5RTZgjN5RYnl95GztcyEAboIC4aMxFGP30JAs5w2B8lfrYLSpNTg=
X-Google-Smtp-Source: AGHT+IEHVb8IEhxmVoLaVxVidr5W+3715XA+2SA9i3LT7Gi5PJ4CDT6KrC2DPN9cXJ/m6kg8VD4OuQ==
X-Received: by 2002:a05:6214:5406:b0:6fa:d8bb:294c with SMTP id 6a1803df08f44-702c8b7e048mr288765396d6.14.1751968661902;
        Tue, 08 Jul 2025 02:57:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.59.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccc6easm73464786d6.26.2025.07.08.02.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:57:41 -0700 (PDT)
Message-ID: <686ceb95.0c0a0220.2c4c46.91aa@mx.google.com>
Date: Tue, 08 Jul 2025 02:57:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5933022427165343119=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/2] doc: Fix extra word in doc string
In-Reply-To: <20250708083948.1822604-1-hadess@hadess.net>
References: <20250708083948.1822604-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5933022427165343119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979955

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2621.96 seconds
MakeCheck                     PASS      20.15 seconds
MakeDistcheck                 PASS      185.35 seconds
CheckValgrind                 PASS      236.28 seconds
CheckSmatch                   PASS      306.59 seconds
bluezmakeextell               PASS      128.42 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      921.33 seconds

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


--===============5933022427165343119==--
