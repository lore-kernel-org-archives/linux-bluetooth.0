Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E71B78F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279626; cv=none; b=Julj8RGIY3j4Voq9J381+mpqRMgY+xtbcP6PD9UWcKcEIaq2FnaRDkmSBktwWOSpD5ojayUIagGs5wvSbNyoHmdDsjdt4XSyfIE7qEVnLdkJjegZ7VNcz3nBG+VhUJbO3nFeUsOrxFovO9JJ3IjhJ8wWPdMnUobH5+6ppxddRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279626; c=relaxed/simple;
	bh=yg3nj0P3tVOQjSgBNl5BwFfrSQNbgHbNOndORjCeSZg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ObxF14Sy/eo8NJQ8GnL1TirTBmlokrQzOMwDiUXli8zHjqfixoUTDZZgywnawHix1g5XGdORBdGhPIj6/bGniZTpb8Uo+1YLR5Ubg+/uy+5T7V+p1DPVK8+m2mJFKq1iec9fklc6a7OAsaThKcoY0PYX3sJfUz/uKe7Y+zBhGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xrj5rqW+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xrj5rqW+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d09f11657cso11315385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750279624; x=1750884424; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JlamqmmAOGswW6YgKStxvdD0dDU3rPOE/EaaOBe0kkY=;
        b=Xrj5rqW+RgSs0P5XUHugzenrfzc5JTpWP0KFjk71Jxuye+xBrLPjdSKhpUrkPbIU6d
         XxDz1nBDOR7aQ/FiLX7oZvUzqMtC2UgCT1XyaiuK4IZ7w12krTN9t4CgB1Ckfpzsh4fP
         hNl9dgi0719zlqIFleOXkLoWOY2qzBi1vgDBpbx2A1rQR0W1csxEiXpSHIuBdZLO8QgK
         scrDfxKCHA4A2ryDIqq1mKiqfq67cbN62dsNL7renXDhZrUo+UbtkIzHm6utLaPzlJMj
         v680FpHnITDbniZAAbj+Nz7DFzyTZjB497ynNLhNL3ESjvcrCJcpWBgeGHPkvrZ1snga
         M1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279624; x=1750884424;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlamqmmAOGswW6YgKStxvdD0dDU3rPOE/EaaOBe0kkY=;
        b=fbrvdO84PtTcMT3l9MPt9BA5Vfy8WOSezLRTFGbf+VnCkFPws7peEfCuukbT3R2Y+1
         1b8hfjhn2Cu1rcrCQ8xCDbkHn0tmeUbcT3ssUCAMcyGJZDKP6nWQrxKkITBQR1vWPOGE
         pave94aoYRhl6hgZCYIWAZU47yMEa6hK+RTSXVO/rBMbZFC8bbjoiYjtmZMF/NQFeK1T
         XZ1KLPsIMf4tOHR7QtwLjNdgRzJwNXD95Vf/f0z4TgKKQKXLoyKs1+gDHlRr0upqWKON
         8+VnR//PiyksFIu3Hb35ZeSZ8rtO0kzh5rWAvB6//dT2tmWLW2e2lRKS96VCAcSnV0hL
         QoLw==
X-Gm-Message-State: AOJu0YxvTpNGDw+cfPPUW464qZe2FB5FaVsjduu+ITed8SqDR6exgA/h
	TQbRDz5HGj7wE5b+dgBd8gZczeO3hfd55InuaLlpTbvwrIrxtDp6zbRlAaXOtQ==
X-Gm-Gg: ASbGncs6odA22mNj2+tm2nb5MHxKNkohXy6gsEPmTDKWxrdm63Xa6eoyzfqWFtacdWb
	jquhCEAWeESFR1BwsUZetaDTyM6VUQVUeqjr0Ssm5mKsWVbjY2m5GB5HYRZuiLnYXTMPD23vZlD
	ZE+TW/QB9pyTi5elk+rtW+geD4Utya0UL8m8YotE88Z8ipUuo5ULroACoCYQVYH38Z2YsBuv4Oz
	Z5CwZoVBss2rh6KvkmPA7mRHlXbuvLnEgz5bc6ULxLSBK6PG4mPcXmy7eF+iWzHkNwhysa8sIoq
	jfh8uo2uSB6cxmWzJ7nMq6dvS2l213mJVLlGMrgz3EHKiwRyPwlumN7V4PXUT+Y1exQ=
X-Google-Smtp-Source: AGHT+IF4N6OXQjTdwiva7lYfwdqONVBKA23F8DQ61mYAFIKHm426axTWjO7s8bNdvPeomjBWBfDXRw==
X-Received: by 2002:a05:620a:8086:b0:7ce:e010:88bb with SMTP id af79cd13be357-7d3c6c1ab89mr3168226885a.22.1750279623856;
        Wed, 18 Jun 2025 13:47:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.168.33.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eac196sm808268285a.70.2025.06.18.13.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:47:03 -0700 (PDT)
Message-ID: <685325c7.050a0220.5d1e2.31b6@mx.google.com>
Date: Wed, 18 Jun 2025 13:47:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5584424628851883861=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] test-runner: Add -U/--usb option
In-Reply-To: <20250618191125.3123951-1-luiz.dentz@gmail.com>
References: <20250618191125.3123951-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5584424628851883861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973550

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      2980.79 seconds
MakeCheck                     PASS      20.14 seconds
MakeDistcheck                 PASS      201.55 seconds
CheckValgrind                 PASS      278.48 seconds
CheckSmatch                   PASS      306.49 seconds
bluezmakeextell               PASS      128.88 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      919.54 seconds

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


--===============5584424628851883861==--
