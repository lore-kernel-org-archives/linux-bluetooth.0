Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256361F4174
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007750; cv=none; b=Jz3OIocJiyTI1XSPqziV6eABzNqhdW0iKMMtxBNjHrmWhWUgQmvzz3lw8+my2T1nSj9/iyIB9dMRyu38yLNDh6ESxLrvh+g2hl7bYCes41asCsjQoLYeMpbeSTWIPAjYikUvnlWjzEaYHeuJ3Iqm7Ghg77BJSgp6SdSQDJvUVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007750; c=relaxed/simple;
	bh=EetTJ/q1GY9CHOzpsegQyBoKPFLUDk54JQQOkW6kn8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XR758qOT2gx6+wIrnKE25FrR2sTZxOQm1RklYmtYLUkZeeAG5OCXi6aAZVCfJXs2rPm2gorc4kVAwFSw2fuUFuIzHAt8NnMIbfza3V+2RJwzeRagoMSjFy5KvoUSCw3BAFrhSaWHUa4u90YDFQSn1sQEL3/8Fod8DtG0WN0qSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePmn0a9R; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePmn0a9R"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c560c55bc1so10436685a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743007748; x=1743612548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EetTJ/q1GY9CHOzpsegQyBoKPFLUDk54JQQOkW6kn8M=;
        b=ePmn0a9Rb3UcVFGqYKwD+yScV8TUBWYwbQxqiarT0x4Tet03gwJBeL/5NVsHAaWkEx
         adakrCNhDfHp8W+IWSseS7XtTrUHk2+joWXK24vE1ehBaQVsDNZbDM3DCLxHhrkVSDN2
         5lHn8GG3QhOt34eH+XI03jfZOcExPT5hI0c/e/dU6jGi+VN+E8Zz/GdKp22aPARLVOhf
         1Dh4ATJUyiem6GCGdQMtNvkNPdNKDrYDHEInnjbdX5DYKTZAdanueDd2DUoEOKGKkZRk
         iddjHaW+TgMjI7h1UFLc2ENqsF04qpwJ82tTyaYXb9kLsAEqdY7+PrOnTjDKp6o61/dB
         rUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007748; x=1743612548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EetTJ/q1GY9CHOzpsegQyBoKPFLUDk54JQQOkW6kn8M=;
        b=QDCOnrbVNQEYrfa5t9aR+akMHsyj/akBSNYeGSgBCS7Q0u/6flK0KNEQ9rslb4yn9f
         hX+s0BmUuVJXdp6gQTsdbCWlzFZCq2B9CeqeMmRrA96yE1gwXvoh70mKGvtV/I6pkzkS
         1SmCEIco3X1hiOHPDqh82YTux97RbI3FXBZ2ZVRKq7PCiPlDRTc/2UoTK6U04RAsMklC
         Ayk/9aK7wo1UZbEq7MLcDa9jh/95kCYXzVoKVdjOQZdfmVD0d+RrFcZD5n/fKaukwvE5
         WfKXPvYYRPDzUWXHJ3/9LzuG/wIr3aILTdkV8ec73JrWk1n6cVqPVjFG74oBZxOyHNt4
         yoMg==
X-Gm-Message-State: AOJu0Yzc65uJpd8at4GYt/IK8EJbf536PgdaVUVZ5QeQakg+W7NQsFps
	ug0r/yddiIhjxq0YTEe6BWj5AxoinTppvde7A5VFHDbvDOW5DSoy4/jNPg==
X-Gm-Gg: ASbGncudwzlc8geilAstJ31WctDTYq0QIOzfkABzvvsGCCaej8rCBsV7Rr/O6IKKLGV
	AwcGN2CC3lIMeXxlyurxtMot77M9iOQHWuQiF+i/an0Cabik0gpDoK/m0rYq/rR0cDuyVW0WFaJ
	H+swAHKMOHOhobGkp2ufRuo7M7G+zWJoWKFEcRINX0svB3G6n9arjuIAeaJSI1p3Qr70Kv2Wlrv
	AnD+LkF8PP6wLc/YSL2DhpCbkCqoHgNksRs1r7sW7l+EvruvCjTnGO25o52MtGgbKMExX70DnJI
	1SJMtQzyOEj949QUbOtDl3O4pQL6KPPoHcjQpDJFdSzx93+S+7A=
X-Google-Smtp-Source: AGHT+IHxSSoNKe5Wd94nNswtx1CEcyQxcBCzu4+Ww7qZEH366HA1I3x8oO/sx6IPZ154+rRLGlKDjg==
X-Received: by 2002:ad4:5f4a:0:b0:6d8:af66:6344 with SMTP id 6a1803df08f44-6ed2389144cmr2187336d6.2.1743007747486;
        Wed, 26 Mar 2025 09:49:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.77.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f5aasm69376866d6.40.2025.03.26.09.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:49:07 -0700 (PDT)
Message-ID: <67e43003.050a0220.31dbc7.fab9@mx.google.com>
Date: Wed, 26 Mar 2025 09:49:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3166283760992819539=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mhreh594@mtroyal.ca
Subject: RE: added support for PRIME B650M-A AX6 II motherboard network card
In-Reply-To: <CAF3zC4ytEK4Gj+Qi3xfxMuzUsyMg9ZQ8J+C-u+eDuLTwz7OMjQ@mail.gmail.com>
References: <CAF3zC4ytEK4Gj+Qi3xfxMuzUsyMg9ZQ8J+C-u+eDuLTwz7OMjQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3166283760992819539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3166283760992819539==--
