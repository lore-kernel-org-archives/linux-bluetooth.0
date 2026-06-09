Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF828980F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970376; cv=none; b=NlWJu7a3sfqyAiwy8jgNwv590IHR/8ziMpCxBCO8mDzqcLlXkbOytCEOnCDhVgkEZb7TGbe2AHCk+5+tBj2bqPcDfPU5ZxBRwUMzOg3x2tKMYp53G4Et+hwGp9NBBCRRhgJIy3MRYzMU39oWwix6z3manhOBgfT8Ihhbr8Uknm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970376; c=relaxed/simple;
	bh=oPzAI2IXNrJ0RWn8nJjtkjaDxqBRSjN7WG0PEtD6crw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WZlg6oWhSg7zrxRDH21tkd2kDb8+HygCcWYjknuV6yf9OVDVMCdULZAY05JjLkt0kgKurHNWFAJap+u/4ZtpnsBECLzoiu3qNFcvrjae+pMXFgsDHMAEZOXeW0oywyjFdxGPixgSOzsgiWPwqoNy1Cm8EgV0PTtRTwXXfd5S0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaMf2hON; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaMf2hON"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304cf518c9dso6121627eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 18:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780970374; x=1781575174; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lY8l6B6MugRU3FEuz2yBzESer2XCskiaszymSniTkRg=;
        b=HaMf2hONuM7qeaXfHzM0wjWWUouhURZyTqmB4pq+fP6plU+CtwLG8stlm2i7rqLFr3
         XRBS6DtjV4rwFw9+72VRUnC1uJB/DrEw+WQh6k/2ZjSLAStTMcTNj0p7t7qjg09k4euY
         ZKITkohRkRrbl3BN4p5PXFIUmaaI0m+eSRi9FqBPxNFBCH14EUoaYosXmkFqm516SIm7
         /O+1fj6f0vaTYAINUqGTVjj4nCwJ1E2JM7K7z02lywYfNS6kxd3/dLE+6Ad0Ymlgxp3u
         weey6iPxZzb+b5RcQdFdH6uukFEj2mBqdqJd9CEn9llCJBQX658x95Y2OWaPqHNhq5uZ
         hW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780970374; x=1781575174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY8l6B6MugRU3FEuz2yBzESer2XCskiaszymSniTkRg=;
        b=I2q4SEkignAKTdFn3EZkBVou/u9jnm3qSWzTlrERzCQQGJ+lrOU6jVvg2lLXK0InIV
         G4dlE9dLruh6I5cksNQQuzD83qPDauyMiJwXgv/J6HFweQM/0NQga7HiIYGNz8R/3Du7
         h3bZCQEMOkefNmpboqQ0syaH45/YZYesYjXHd9CB3JvPWme2ypDjufIOSNPqcH2TsAhy
         2c4u70WEhEK53e08enZaOEldhIXtcy9UQsTPRDoCiWJH1V8pp+zT/SHvyNu91pghVQ1A
         vPetkaP45/7DIMSq3fGdu8gcdBgX+xbV8Lwhafc8dkhKdWq9PWQUUP02mENEmVmQN1bo
         +vsA==
X-Gm-Message-State: AOJu0YzFeqg8kMvcBQ4Q8NiwdfYp+bNXQdYB2ykZLWjX0TIrM55+0CJK
	1Aw8rfeXL8l/xLVVFUWWX517ZIIhOdDKMFXQ4KICyNPWuoo0ok/aWKFQA+uk5w==
X-Gm-Gg: Acq92OHKCl2Y5ZAOjdDkVadJRsjeWZbdaz3uNcIsVf65SXuXJeJeLF6/ekAE3MFn74x
	t6YRXF7WQQ4F7SiJfnwF76lIwnnNXMVpfkghopMRAEd3TG8qXEQHok7lzclEVfShRus2ReR8a48
	2a900KyYB71MjWL/ySomjGQVKF1jI0SbcslW1q/DRwdp9gtaEbK6EpMcMh564S4cVYcbMvLCuPM
	B7Ty3bdN1IQ+gErpsp6CcNgPGIg4MgMEf3vY2FI5ZX4kzM5LBKjWYHZr6iI4wG6U1eLIPmC+di9
	08+PBEMhde7bf+UW0DKHk1qpkaK2NVv27/+aBrLql9DrLcvvRAc7WTZh1EAcy2xFGilt2anYrjE
	Ouka1FloXvDxvAkLvSkR5dS/ve59pdBEDxjpzm9uY4I//Khf+KvjgOeQL9C9xKDiLfm6gMc4ohl
	uU2g/feFw/iKWvdKNDgIfzNg2RxLIbhbTZMbOxKFCNIhk9W0Coubrj
X-Received: by 2002:a05:7301:22a3:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-3077b2615bamr10300220eec.27.1780970374057;
        Mon, 08 Jun 2026 18:59:34 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.162.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f9da69sm11404455eec.31.2026.06.08.18.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 18:59:33 -0700 (PDT)
Message-ID: <6a277385.e1c1f991.db356.66c2@mx.google.com>
Date: Mon, 08 Jun 2026 18:59:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4513657367446182939=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sam.moelius@trailofbits.com
Subject: RE: Bluetooth: L2CAP: validate connectionless PSM length
In-Reply-To: <20260608235705.1233510.fe2269cf0103.bluetooth-l2cap-connless-short-pdu-oob@trailofbits.com>
References: <20260608235705.1233510.fe2269cf0103.bluetooth-l2cap-connless-short-pdu-oob@trailofbits.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4513657367446182939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108158

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.18 seconds
CheckAllWarning               PASS      29.26 seconds
CheckSparse                   PASS      27.84 seconds
BuildKernel32                 PASS      26.17 seconds
TestRunnerSetup               PASS      578.06 seconds
TestRunner_l2cap-tester       PASS      60.04 seconds
IncrementalBuild              PASS      25.60 seconds



https://github.com/bluez/bluetooth-next/pull/294

---
Regards,
Linux Bluetooth


--===============4513657367446182939==--
