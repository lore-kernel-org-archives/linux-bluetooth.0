Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACE3BD62F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768378; cv=none; b=sMRGsu2vW/OdLN0J23TY2othS52qaXAYNI7HTfHVJo3GCtbkCtknwCY9kKABSL44LhVr+m2n/eMEbUTMvAvu60G/FUlV1XX46UrVqq0gLceUiTJnF95nqHg3yL6Oh+ingYn3g1F4o4rtIEDO8sgs7Ks0svPn8vIY1GIcnyb3Sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768378; c=relaxed/simple;
	bh=XdYmnW1ypo68Toku+pjd/F/A+2IIfr7kLLdFuYbLXlY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=miYwctbaVYejzl+4VVxwWX+IRVURIKIWgLZf0MFMpVFLKYopdxobsWX7PlpSC10jrnRt7rEFBM6Wychh6gldkbAAojjvG2ktiHbysfbB1qK8QEYqYR//W2UYiiKntrzR4cesuH49HOK+KKEsjp6JyBFYj7CBKtS5cOdSwtFSFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moxJ+HDT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moxJ+HDT"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-479e4835e26so694266b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776768375; x=1777373175; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XdYmnW1ypo68Toku+pjd/F/A+2IIfr7kLLdFuYbLXlY=;
        b=moxJ+HDTrALEtYgFIXxcrTHe3gnVdPcjgOwpXU8sZyZLchhIQG7G8XfWLH6rfMPlTt
         EyIV2glvSRutOYXaE0qLsd/zpZimcnzvhaPM4ZGGSB/ohdVI5ATFve+GkaRK+JyqRD0Y
         VETEcgm5P4ZhkS9A5xANyn0u/j3YtlVEyPZk+l7Q9xUabX1ebQw6xPE+ICrDSnkWNeSV
         ZtlkAYAVBerGr8Rj73VmhlITZWS4rU2ghdFRrcZi0jfwhAhCRbJhbWwNPazUBDci9rja
         DstS39qMaBvhoI2/Af9W3bv2J5vpw26r6Y1Q3Zkm/3A11F5L3/2Z8KKL3y+A4jFRSKfT
         V6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768375; x=1777373175;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdYmnW1ypo68Toku+pjd/F/A+2IIfr7kLLdFuYbLXlY=;
        b=kYj2JYYpAA8GOM+55Ub7W0FSRUov/n5wrUhah6gbtFTzB86m8L9IIbAPGnSnq9ZK/n
         NKgk3XV1DRUC/whrnu07jY+NzA7wqhlbZ/UBxqgrgEYFL37TukUd8jqbDxAonrPHgVoQ
         X5Q1Zmi1/SmsJh8ZMIsN4gUFkBndCo5IuMNE0XpkwrVBsSCPw9S+82+CNcQU8bX87WRe
         pic9Vu933GWLkn/w1ZwY4O8N7gfsyZs1jMWq9Pz2QEn0fZtSybm+83tmjd6G8thjDLhy
         2kuW/GNapYm93KW2ONzfKlkKn7KNO2A/hoMjuWllfc6mCKlTiusqFibBMi2WHDdYGMLS
         LWng==
X-Gm-Message-State: AOJu0Ywd/49rqaYrHm6dLwvybhNq91KyKLQogIZGxgjM3IOcqjNHv5tI
	8GPDRsnb3Y5tkwTYFT9V0YaIEulJM4iX9D/2rOjlcMdYcIHt2ogmh7IJmG0Ihg==
X-Gm-Gg: AeBDiet+mFfufs3ajbNYDC0TH9t/omUeJm/pRfBVcWg/u5jZFaEiQozQBkppHn9ysl6
	zic53HsWYP2vBbS6VMpgp2VqiBE5vfBv3KNpR7sn+hBafqNs3kIZ2TgYWmADKimgPFnZOauLTI2
	EKyEFiaPCoF4nnS4E9iqliWZfbhzRpk/fOOfG0EBGfELTAqBzpckRn6Kfv8ucsEwaqC6wvuQs7h
	MhbJJAy6g/+q8Fms8+A/MzvbxrffyED+hVPL1TezO0Z4y1rmk+1HwMHSa0ohUF4j0GrDNv6quci
	ItnExdCx8XEevm+6Mhy5ClE6/lax64oJ1D6XEfG4/qPtMkHmJiNhvgOks2zR0gfKgwNDcUAuNhC
	4AEDdaktXi/K+4vNZ6T3ST7NGubHEPkzWEyFDuCol2MSR6viLBKawLa7kmzfWscE2KDOzT7ed0+
	+UCrzPcsledqPUOLbe+8n+iE/xojU4mze49apn5J0v
X-Received: by 2002:a05:6808:8489:b0:479:e876:9882 with SMTP id 5614622812f47-479e876c84fmr1829068b6e.36.1776768375379;
        Tue, 21 Apr 2026 03:46:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.19.195])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9751920asm11091416a34.9.2026.04.21.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:46:14 -0700 (PDT)
Message-ID: <69e75576.050a0220.e8c8f.fad6@mx.google.com>
Date: Tue, 21 Apr 2026 03:46:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4777524681491255317=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: [v4] Bluetooth: btmtk: validate WMT event SKB length before struct access
In-Reply-To: <177676799168.2227510.2141901333230538239@gmail.com>
References: <177676799168.2227510.2141901333230538239@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4777524681491255317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 50
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4777524681491255317==--
