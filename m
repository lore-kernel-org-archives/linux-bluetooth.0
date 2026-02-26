Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B0399013
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118875; cv=none; b=lGUntBRo4d5GBZzUmrZGBU9wSIWIfj3TjlxswKGVsu12oqH3hD3SDtgmlclZ8gQxZlkH9jdJQMyK/zWiyw3l5W46xzBRj1NUdrFp2rcAbfJ1qbJ/UYuclIQrm2YFO2fL40VYi28beBOyr2BF9OxB6KnyRt/7wW7M8FMOUXAJoag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118875; c=relaxed/simple;
	bh=NHKLqZJhJuRybziZj7UnggEQJcbS8Cr7dvLiRndDZoE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GO49AtvHjO3Ha+2uxxvvpe7u4Z9NeODW0ZZnzb6HTa9BFFC5J3i0y9nBXL1MNsJu7Nu+YAtLY4N/AIw1OO3BX9JZ3Gc01hwA52CBI+A586doEHOnfl6UxE+6BMasOg8M6HpN5PjlSARFa6u4VRqpMJkr2KkzIKpmEY5B5F5rm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBLZcB3m; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBLZcB3m"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1206210eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 07:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118873; x=1772723673; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NHKLqZJhJuRybziZj7UnggEQJcbS8Cr7dvLiRndDZoE=;
        b=iBLZcB3mHS+lHyAXKs84gVlqdQLT5cBSWok6LuH0fgrvU99WEJZycYauXQXy7Q4O/i
         /f8gk3LJQuK7dIhMAZQDin5Vx8wjg43wkN2l25TcKm5BoX/FEoAX836+V05I7x7/ZF/l
         ChGBk718Qj4KwXNUMvgoiQC9CYI38xfGvCVUp7uxetnj/GNibVPTWtnrZPWxDWAbCMpz
         9iUGkweJHZ0YtJCMOiSjherGzaVkTxvJxqV1UcS19V2EaoMxI2Vjy1izQKQ200Mskvqw
         JQdrudE8+uMok9RAypHW/RsYyBDJ/xglIm1oZV36u8wAJp0itDyeek0S7SK5La2A8KBk
         Y2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118873; x=1772723673;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHKLqZJhJuRybziZj7UnggEQJcbS8Cr7dvLiRndDZoE=;
        b=ZiYF07c8us7gj20WMj0/T9+vWoZ51wkOgWu6Zg0iHx5Xg1dsB80EOZ/uWW3CmO0OiV
         QKbTDkfAtWag00HyDsR3VP0hOalkxmS67ShYZHfmassP9Yji/JwzagsborOgJdjlVe/g
         M0JSPolITy47EvBlmVUHG6bMamnx9A3GM58rJ5NRW0k59An+YFTkk6UvDSpLg6nttsOo
         XFCJETwHLHYzmiUx3m31uoAaxU1oR+ZwKJ4wrMFbNvJjjLWG6Qk18MpF5Nb/Wn6+78IE
         e8cWz/mVJOm5eMKRHZOwIwssOl0iC2F92ybv55kbzZg3UyvxKyPIY1e062QEcVgnrbc5
         p6IA==
X-Gm-Message-State: AOJu0YybmMgWEOCPzRObdVdyMy4/redZW6TALN06Ki99KcooFe2wHPHQ
	/c1ipDoY4QYVxn9GenaVijxPWk16ku6TlxrMUi3z5HY4uYc4cwyMXmGMZ3VHH0OR
X-Gm-Gg: ATEYQzxNG2QSyDMijru6IH5iwE1oSgVzXMXxL33NDRDeEFt6t9QEmvDxonlRCCtXsOo
	Ea4HY2R5O9zrXbCWpBEA7VxrbEHUqm4NqOlzkW8AxLCMZHkPA9iCFGk6h21Rtb31OOMKaPsBZk/
	j8WhCl7hzeA77Xp9udA943IB9chjdFPiK3Lx1DYEeANqWKi6g8FJJFHApKJ8Bryn/yNLevdIw9/
	kP3DVIXXhoJUBny2TzmWdYxalOEptFlibjF8Csbpp0z4KVKIv9muL2hDeEcNWdNFFLJnBSrrqvk
	jliaZKHqMDqMsrbFQ0mSH5x0mtxkl+pbobB9S9lBcGY08CXMZTy8QOxKxwwz5mrfZk9n9JwsBxC
	HH8JRpcca/8FUMvsoC32/Y5fMhBf7TD937uaMcslPZUorra9I132TZfa/YcvZULd0XSPMgXsGMg
	O4HCUq6e4o5KsbwbnsJP33Q1npuDru6ADVEgXAJ/fb
X-Received: by 2002:a05:7301:578d:b0:2ba:9835:1113 with SMTP id 5a478bee46e88-2bdd304c962mr1071414eec.36.1772118872945;
        Thu, 26 Feb 2026 07:14:32 -0800 (PST)
Received: from [172.17.0.2] ([52.159.243.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f45e23sm1958904eec.24.2026.02.26.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:14:32 -0800 (PST)
Message-ID: <69a06358.050a0220.182ea2.a749@mx.google.com>
Date: Thu, 26 Feb 2026 07:14:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6553536741352201487=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dajidp.morel@gmail.com
Subject: RE: [v3] Bluetooth: Increase LE connection timeout for industrial sensors
In-Reply-To: <20260226141821.885997-1-dajid.morel@volvo.com>
References: <20260226141821.885997-1-dajid.morel@volvo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6553536741352201487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:1131
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6553536741352201487==--
