Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1621D3F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049680; cv=none; b=ifYM9hUtzn8m0aRwmn7RyBL3iI18KhouWqH7EbQC2ml3R0ptse26/ajmfyuKGCXDXD+vpvzp6cTWLgfPZl6BYkRUdghpApyVahWPcmW/7YXWODhuOJOoJokn9x37pEM/nojOGHkL4294QTLWRvco6HUg+zmbcGxtayZ2Y7FQrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049680; c=relaxed/simple;
	bh=FPkplfjjI4PGyIv9M+2bJsrISeq8yKfFtNTLrwv6TWU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qrd9WoPYRyjtKHIy6X78OqvUM95ULS62WsaTJ5F5G/qIE3eKVPioDbuYqKC/m4bP+XTp75HQqz9eGz75pYvuSMzjZNRhwB49eXJ+pwHAy6L10KXLRFCYZ6nDKxuXQd/YD7kPPTHG4ObBexetDaMfdd7F4pQY7Su2Y21idCESn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1tbRfbn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1tbRfbn"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53397554beaso13504471cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792049677; x=1792654477; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0fOkDho4iWbsrt2JC8Zm7BB4nDdmxYxpgpxGxM9A+Oo=;
        b=d1tbRfbnT8WiWln0CeFgiQDcIdiRCSJhwbqyTypkGKeOgO07s5LDShT2yob12faSXb
         Ri4i3FOq/r9H+55NOqCM9iTEDMr6dchqIXMsdC1Z8jjiQtZ19f9b2gTVsAK34mBUAaff
         DP1BqdkwxAErV2rSXSsi/mlEq9f7McP11h+4IhUGJXWBKbu/TXg7/MrSpPOabU83pt96
         owjWImB9Y9PQOFYfjPu5Cvie9Evk81d3DV7RS0RAtBRRAIf7JCrVYSCfaulsbJDLJqW+
         CXihJstx54Qm0/8PpV/+sxhh+K0UkGsqhmdBU9cGPZzMNYZMw0qAyzY7YWEmCjQIAFIj
         9h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049677; x=1792654477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0fOkDho4iWbsrt2JC8Zm7BB4nDdmxYxpgpxGxM9A+Oo=;
        b=kffdTtatYhi1B3FAnGT5rM0xfjP1/+s0zVy4pOkFbrkMuSHGjeUduGgpzcXU4NzulH
         oFSsLp1rN7kmRec7yD1iQ5mWStiQkOJSY+NREHiTbkRqCqeI/3RpWw1GQ7+ztmyRuQd6
         Xf3zJKHdTlQAUloQUVQG0UO5hmPmOx6Oj+AamxbFqQyP6wogkij7ScoqyxMXWKB3Svht
         NCA1HSdyS1CVQU+VmR9zWLQ3k2YdeR8QZjtIVBJctKPIwv/ZyHwGKzHq+/4qIE7n0krf
         i7rHCeYRIewo2w4HaRdgSstUVMCZv+kDENepF0mrTN+dmsv1GAoWG6ta5kOcoArBo4dG
         CBzw==
X-Gm-Message-State: AFq9FYI1KVOhpvI/WV3bPnxX5ODuCA2PkViJcj6VFuEjbNmFNePEvZ9C
	eMLu5Ei53nrYUu3kEZ5Jw0egI6Q9rs/qflmFJRGc6Tae5Za6dsf8eg2S5yIlMQ==
X-Gm-Gg: AYBFou16jwV2X3kUyW7AlvjRU2q0OOA5Nn4FgtYidazXN8JMOtuKPlyzCRvW6Nq/+uY
	UHWZfPr4DEf8zKQNUYAHU6fCPTD3NBt61anNH5pjrHw9Ww3+uic0aCKcxDjkkwwnc4pUZ2Lgm4C
	Mh3t9QpsBwTr8wveTzguvu9R3T5D4lJhoeOCFEUQDCUWcZJp+4lu75BOa4TdsK3papssqJT+QdL
	slLnpPy8Xvbel9efG0+ftUr+Bhax+cpPpU7P3x13n8HNF+JW5racwQ27/FKaMCaAegZxcLeqpVs
	jpShd9riwNrqVhW8HPvi/FUh08itA8GD0nGwWfK/W0x7JKoGFpbc6N6cSEzHryd/DcUKg6NxvT0
	YYVq/HlEjfXMUYcIy7cA1wDeKvPyslmEQf+V2biE4O44dz0/QxFfDPAt6iYjLtYgRDKDsRXugS5
	6Wvjr9X1lelMDh/Scfck84cu3zGc9rxWTSExzDZ3HqXvBIc9+4k48M0hFcnAQjz2Izsc2qqXQUQ
	jwRXg==
X-Received: by 2002:a05:620a:1a20:b0:93a:10b0:aee7 with SMTP id af79cd13be357-93ebd20b8e5mr3021876885a.44.1792049677133;
        Thu, 15 Oct 2026 00:34:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.23.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b9783c33esm75251676d6.3.2026.10.15.00.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:34:36 -0700 (PDT)
Message-ID: <6ad0820c.6d5a5174.31303.f499@mx.google.com>
Date: Thu, 15 Oct 2026 00:34:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5294744372823608941=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] l2cap-tester: Check compatible interval preferences
In-Reply-To: <20261015044221.55631-1-cochcoder@proton.me>
References: <20261015044221.55631-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5294744372823608941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186110/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      294.86 seconds
CheckSmatch                   PASS      293.15 seconds
bluezmakeextell               PASS      93.05 seconds
TestFunctional                PASS      1099.68 seconds
IncrementalBuild              PASS      312.46 seconds
ScanBuild                     PASS      1135.48 seconds



https://github.com/bluez/bluez/pull/2682

---
Regards,
Linux Bluetooth


--===============5294744372823608941==--
