Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B323CCFC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680279; cv=none; b=pXLoL4MxtnQSBHahIDuO+qAwW9wvMkvmFn0+Wov0KnmUo+MhTb2ck5AQnvlbMYDlmoW3QZ1CAcM3OXT+xOuzu+oIwKPmRWrKY7GjswP9rE23+2kGiRyR0zyhEJ5aP78dq8On8Q+Mdpdl0kuHrov6Lj/K9WEb9sGvXT3nnsP9AtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680279; c=relaxed/simple;
	bh=L9K5XuyuzxQ8p+6cvG5sDqjpEqsB5NMJBCZARi/tfeI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=koAiqCsFvqUbZR8zuCQiX/zuZT3jsb95qf7g98ojl16sYSDwwPmEShnrO6ZggI5ixH23b9C1Tttqe2VXTu5LYT1Z2PR4BHNvfBfgkCFfh3/xs4yTdgbWbKjHZi1GNI73ZTF+DaxuBBopL4hleJVZvI1RGBhOk8t+lonUNWMey5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHCybpzG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHCybpzG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e67555e24so36801485a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783680277; x=1784285077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L9K5XuyuzxQ8p+6cvG5sDqjpEqsB5NMJBCZARi/tfeI=;
        b=WHCybpzGBiFou1xKi6Cfix2rFydm+bbFXbeEY0uqsUDzUjNdvfa840kCj73EFzdVTC
         7XdsEvgcuXRY6Um/Yd73wGrXxuXYfkjlUWlArDO/rtsdXI/g7QRmG1Zx1F0QF6wLRhVh
         akfHPZIbLNCYKvWSXz1lNhy1+6pZCSDKxZLfITVhiDLxnOlYAThDeEmQh8Q8RFFw4+qs
         NPbYc1VR2iKLP42FreUyA94EnOXCFfvahnF6q0kXxOYdeTJsGW9KnV1v9WpGDi59yF0A
         E7XTkO6We1CkmWbEMYNVQDXXY+h3g2oSLlgVEGtJp6egplRJighQH+lcqwpAbUjUnTIU
         dN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680277; x=1784285077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L9K5XuyuzxQ8p+6cvG5sDqjpEqsB5NMJBCZARi/tfeI=;
        b=oieAeUc4Tr1ywIceVdJGs110tFFkV0sHmJ8/V0sRH0xGKhNWOw1SbfgZYhK4rSJCIW
         YPZ6lfZ82dh/N7bPXrrTYBij4q6cImHgIFbujBlRnq1q2mCGZHXhrkGvydKVSgQ5jF09
         bd1ERNkGzplQE3W12z/P2WEZnYZnI21qMkOJp+Qb4J9ATUgvuxO1ei20sdmdtMauj++q
         BNM67OdNMRfZLZv3P+pvKWoJukok6qs/NMAsEVVKp1xouRmvVjRdPW94Wm784fknpZj6
         NfCaVPyooDZvKzy6VBpYmnEj4bUg9OJBzYo25TllxdS60lSwtPd0jekcIV1U1mx/1Ty9
         cycQ==
X-Gm-Message-State: AOJu0Ywzoe1prKLUlochaDZRGPTESDVuMk1TUW2hy7kynJ3GeHiF6r+E
	VVrDQIMoeYcrBuRi+ZPE37uj1nRDVAG2lndERA5CQsPNHcfpsWOJnN/Z6lPBBg==
X-Gm-Gg: AfdE7cl6+FgTnBCrll/ueoytICNHyhl1rRVK4Wkm6hKaer942tJo0K4e0skj5PlAYKW
	cgRNdqEFCO+3cae0ohni1BHJAtW97/TakBiyWW+O4M1q2IgSGOYBSCfmLPmgzYS4YAZDv2P69FV
	Mat0T8xRt/8qTOKLEOBhRbJ0JojOZnWE22dPY7khUm01PegBf/o0YGj/OU9IEsUozz0oItUwUR/
	6kMH/bXL6DFiUu6tNlRfvMDTe8UZhMrL5PdlASWkgx1GWJ78jPA1Mg9btDT2qwi5ip74YJeniLw
	zHwVrwZkcedXampcs+a3Tr7xGbCA+K1AaS623URSZcQ+xZBb/kKpToq11VYfkkCdcF8DrKB4lNF
	h8z3yCrK7T3xEhaQJ4kpxApAOcxciNBxI4iXinPTrPBMPJXlZCK6bgA+F651oR956pJpRkzin6t
	zmW9J3p0Uhza5o4ie2MD6FpWMSzMbcFg==
X-Received: by 2002:a05:620a:4115:b0:92e:caf1:7705 with SMTP id af79cd13be357-92ecf68cf07mr1131899385a.49.1783680276896;
        Fri, 10 Jul 2026 03:44:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.36.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d2d68bsm162749385a.33.2026.07.10.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:44:36 -0700 (PDT)
Message-ID: <6a50cd14.e317185c.1e5b9f.bbb3@mx.google.com>
Date: Fri, 10 Jul 2026 03:44:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5885279681664665521=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: arm64: dts: monaco-arduino-monza: Add support for LGA WiFi/BT module
In-Reply-To: <20260710-monza-wireless-v3-1-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-1-46253587af64@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5885279681664665521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/core.c:991
error: drivers/power/sequencing/core.c: patch does not apply
error: patch failed: include/linux/pwrseq/consumer.h:25
error: include/linux/pwrseq/consumer.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5885279681664665521==--
