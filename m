Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2C37C92D
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876019; cv=none; b=kLu+OZZLiT55/3uuvVEvyp+n+Dcd4SUW8+ty7BeZOPjLohFHNcGGjNVUxE8CwhDatHICSsluLXGpYyn451d+cdIIUIb5dYI/2cq1EN0MPJqgcP8KvGA1HRstGb9CRbGK7FzqvCMINIxUMEM83CU39EjWd6bONEOWeI1Y6F4Le50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876019; c=relaxed/simple;
	bh=+6jj99eiWA615L1WGCWUsVB7Xrq7kj/cWH5dO5b3iWA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IWneh158f+kYYVBXGNrLuztlRwsZgAslcquxMXa6JiXBZbh1qHJJhqyztsMmXnrOOEPe4qr8PLEKn7fUv75NQNbOujoTBJBcCYSFe9RWtjw+f9ZVrTpFBlL9t3Ao+3CJCTDGJzV2RG66DVToWUlQgujKJIysZQVWtM/0lS7iWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCdfi8YO; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCdfi8YO"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2dec803f9f0so3341118eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776876017; x=1777480817; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cDLNnV24eEb4NTOsjW2d1nwAObBMRO3j02a2ByqzYRM=;
        b=fCdfi8YOQS+zXmLB95iKjBvl0i2f867d55oFriDN09kI1P3t6XWsqKz4OgOc0AMnnm
         S4h8nEFcKwd5tARKI5pPwZSbZ4Hp6118b6pAIkCROl8x5mfHgv5I+CUkL6qcAQycN1Yp
         0SdNlKFzXVXF/ofva0/aEh2EXhq7VZa+MZ9LdUrjWM870OXFaMgdvQhedH6aUV3LC9z8
         P09pq35+oOLPe5rVR26j81zP3hOO93dGDUlWuGhbMewSdAABjIColgzYy8PKfvad3byV
         yrg2uSlhwedrXu2CcOitPetgzRPMt/1SkpcyvWAkH3UJlrEUKNjsn+T6lHJNTmXQC8KL
         YR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876017; x=1777480817;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDLNnV24eEb4NTOsjW2d1nwAObBMRO3j02a2ByqzYRM=;
        b=KPcVs28ZkOOqm/w1fe4rhMgGJIQjle/9wZpvQwVsjkebk30Z/+Rs6CdMEvc3yFe8PP
         TPgDv7LV8krZtSOAhL09iWIR20kVkdGHEnjI1hrEleAt4ux6eSGI4cpj9FzGCxxGREAe
         bLL1SEKIiH0NChZQfde1CV9OLg+XTmJ1blcQlfRSDtQHJLryuP9ZS3wHwQbGuq4GqyNG
         BxV36+Ds4s22sK+up7ZP2IVWOppb3KVpqRKT/LixfypnJ/jb5bI+19ug5dq4wmmls0Od
         lXESA4UyU4weIe3DfwLZ/ygO0JFlEhAoLSdsSdtdMugQwrqL6nz7IkoQp1ALquK9/KpR
         Q3PA==
X-Gm-Message-State: AOJu0Yzp3j4G8p8XlmItfX1SRSR0m8/lG5mVoQm97LvF2fXQ2sxHW7ep
	C1lTkRVcilTta45akvXvynblSH8b4ukKLXScrMIG64EJb83Ds623SXedXolh+A==
X-Gm-Gg: AeBDietVEeTVJBtrHbl/4deW5+/0R76nNMz3wHvANjkjnWz5x4mlnBk0nV6IHkLrMNp
	j/0cyKeEpg3kN1EuUYBzQpXpaQqxH4GkCe6+URlfanto/Lw2J7fz6caS1bpc8Yly/5Hbo2FVlbN
	+SYucC/MO3vDEguilcub9ikgACctG6auSbBG54LPouzwBYWediGcQxv6ExG9tm5VhXRAsu4SP0b
	+WCedryV18PZ1yDUhSTXvfZIQSvZ+LwksPoJay2L79eqttr7GLnNvysW1cnS/jqjG3JFg/jagb6
	TiSoJtUGzJVNN1OS3YrZNeDm+o6XZiV1NjPrPRYtXKAWWMn2SMZJJBcpvBBXqkC5HjEM52GdKPw
	OmhJwCW+JDCFZhTWvnQmi3+qSoA5AiESeVNYxNvVK9tshzyvH9FfK+nECur0zL2QoKAfITpVvtR
	b+LQKLymHX1tJmC8MyQD8iZvq49XUaX2Nkg25VK0oB+dw=
X-Received: by 2002:a05:7301:2e88:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-2e42e10a5b6mr8228995eec.12.1776876017252;
        Wed, 22 Apr 2026 09:40:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm23133800eec.2.2026.04.22.09.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:40:16 -0700 (PDT)
Message-ID: <69e8f9f0.050a0220.3a02df.1072@mx.google.com>
Date: Wed, 22 Apr 2026 09:40:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4908486201885899527=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] input: Fix checking LE bonding on HIDP
In-Reply-To: <20260422150328.2062359-1-luiz.dentz@gmail.com>
References: <20260422150328.2062359-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4908486201885899527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084336

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      644.74 seconds
MakeCheck                     PASS      0.92 seconds
MakeDistcheck                 PASS      246.53 seconds
CheckValgrind                 PASS      221.43 seconds
CheckSmatch                   PASS      350.33 seconds
bluezmakeextell               PASS      181.69 seconds
IncrementalBuild              PASS      646.76 seconds
ScanBuild                     PASS      1025.97 seconds



https://github.com/bluez/bluez/pull/2062

---
Regards,
Linux Bluetooth


--===============4908486201885899527==--
