Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A641756A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083351; cv=none; b=iAxUM3e+wn33aFn2GtgWLv9wxKfWzkNJ3riQbqmdjAnpe8rOv/G8oR5zJQSYpV80xFnXG9XWd1g9ApSKNXVBZvLtKN+jxv2uyKvPY4bQ8PMDAQwkyZMSp3GtImnpFZrMn2JMM232f/B8+xDAY2QQAVwB8O23shts9Wvi8eFaBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083351; c=relaxed/simple;
	bh=KtbjppMpGLRbRB4YbCo01QzaD+ikinAsIHbZuiJ8WnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IANULDz6QlGUVLfnmw5SRlsBSHMMctNM0BJcrnXY0ND3FfYaUhV3h4SXCc9vmHmETV59Wh9TPFiOPxcV6uV3soz1HNOpC8oML/fBKQnBP1yibyym72BEBeo6dXASxeFRbfUknT9t7P1HQ1Wo737rLzCJWq3ENBKVUlV/hG0xZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdIE1ymG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdIE1ymG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ead4093f85so5198520b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712083349; x=1712688149; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SDwY0aAFrqbcLXdPdv5Ry7eTcx7dIx78MvbiM7+NoDo=;
        b=ZdIE1ymGj4lhDaknwI810vtFlMfeYIUr/nMwYExWLwi4/vJaWDyM8YKWgcYO2xJVi8
         a1itwvpPGCZhyS9+QWWiamInHU72LMk9JM0QH+QNP40eLgisB9jH10u5eYMPY6Jp7AZ+
         Ijanuye0HnS19L5RX42Z8r6LoO8BuHLkX96lFRas5BY64biKCqlsqJ/ApIGT3Sbu8k1a
         /mUgG5sz9qpHi9e4BNjZJZBJ8OZXddHc1trNhtfz8OBYxwC4muwCVRvOO6WX/zzNyPSq
         1dGRFdp4IawF9hwVxNLlz3U/5rOHrgyNSNTXsDd0CX4nkUAUGihX7OA/bnuY2/1gerrr
         KJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083349; x=1712688149;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDwY0aAFrqbcLXdPdv5Ry7eTcx7dIx78MvbiM7+NoDo=;
        b=crGiO17YEjC4ART5CnsYmgF0mRXK3E1sO+R8ivvxQ9VPusdObeV41QGrzw8YyL2YSg
         bka6/QBKK27INernKHsMdKmfPDHeNGJnKHaNLQfTDFJMoYBa3eA+EkmvvUWKckYP6TmV
         6HdRnHqbKHJcF53Wnp4oxC+R1+dKn6PO1U6uVgDO3Dsw1ef6g1LLsyp2ltfrBjxHV0Jc
         orjZdvIQW2feE4TlpRnUD6WyOiTESkenaX5iTtJf+u17RV+FIiOvGd4ivIqrVwVsZJXG
         HndKgzcAKHCOJtfbZH99ccGnJt2Z2m0KoCYfKa1YodLdYHYGCPfJTeHz7dx1Ijhh93pQ
         YObA==
X-Gm-Message-State: AOJu0YyfWQvm1YIqYAeW8Xui8E8kgc59bvxmyf5ninM2AGcoerTj0Pzq
	JSUhBgNnQPorCMl4zooKwj3TICfUb+E757QAebqx+CsBnlNe3HapQuyDmvzo
X-Google-Smtp-Source: AGHT+IF+u2dDUtR9ADGR0eZnaRcUK8hdTmvR4K47y1PAud62MvfQLmQj0f16zYEzt21cVB9u5kfFSg==
X-Received: by 2002:a05:6a00:1992:b0:6e7:47e2:d8ed with SMTP id d18-20020a056a00199200b006e747e2d8edmr12189091pfl.26.1712083348749;
        Tue, 02 Apr 2024 11:42:28 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.69.169])
        by smtp.gmail.com with ESMTPSA id ff15-20020a056a002f4f00b006e77ed385c4sm10189532pfb.184.2024.04.02.11.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 11:42:28 -0700 (PDT)
Message-ID: <660c5194.050a0220.c2e05.b484@mx.google.com>
Date: Tue, 02 Apr 2024 11:42:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1777813028357374829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] adapter: add support for setting NO_ERRQUEUE_POLL experimental feature
In-Reply-To: <abbf81af1d80d8a2863f1b441b5c39bad8e89fa2.1712076220.git.pav@iki.fi>
References: <abbf81af1d80d8a2863f1b441b5c39bad8e89fa2.1712076220.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1777813028357374829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840719

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.60 seconds
BluezMake                     PASS      1717.15 seconds
MakeCheck                     PASS      13.41 seconds
MakeDistcheck                 PASS      176.85 seconds
CheckValgrind                 PASS      249.19 seconds
CheckSmatch                   PASS      357.01 seconds
bluezmakeextell               PASS      121.03 seconds
IncrementalBuild              PASS      1588.00 seconds
ScanBuild                     PASS      993.03 seconds



---
Regards,
Linux Bluetooth


--===============1777813028357374829==--
