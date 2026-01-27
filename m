Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5145191484
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537496; cv=none; b=JAvXyTTt4QkLvTmbdh1YM9P+KEtVHc+wqTHyOtEhLkwSo0IIOhVU0qckJPN9dWlrrV67ai1BE6QdBxf87uoVk25lUISeVpgj0nhI+O08sb3SQEncjpBf2MGM2SuBeS2KdBoxfgcJM1UNWDv8YmE9hm9/KXLlJwQsGW/l+z1D9ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537496; c=relaxed/simple;
	bh=iJ7IpBNEbobtTG6/6uKi24C7OjC7RdXrfJnzddyF344=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sq43OJtHVUGKo4pEURrxt7X6T/qRV5RPoTqO6ki+1ADx9/vPfxQ33KwgNiOWI6DLkNThKRlBQ6QQZ2Jii6um7N+41O3jWBgHFKbmL2cCqTxBzCpGIy6+LVWukzNKdzycIpapzsTsA6ddguifpjt98JsbFTzWl+Xc/Y83djJX31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmITAz7/; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmITAz7/"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c0f13e4424so658924885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537494; x=1770142294; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nGJ7yqx7JSdWxQwPoMC44CDXTbV2FYNTwtH8FI2Jhbo=;
        b=MmITAz7/Vq/3giFn4vqadndmWe5CvMVzrYyQVJ+90vhyrWe0ClmQdKUFWJZbdu1WAr
         jUrJ7rSQT7oMmM8DD6VgwZSHQctSc8O/ptYP8YpJIxLUdisMxnwv7TAcl1hKGtDijpTB
         BEyLFUY2fm2U7+ajqtsOSHWKYyHdNPpILjO2nkLrtX4wIamJnNm5jtKz6op2oBLZggTL
         ZyyN0mTO6yyLicHDq16tXUAzEmtTQuaB2sBKpT0rZtAAYsHchAxz0gG1N1DMeNsPTUoX
         kGiGxTeTM/aNbptZWeOoO5SxAJ8lKXRXVD0/IPigz2Io/TCFsgNlMLQuQf1Uj3yVhJUc
         Jzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537494; x=1770142294;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGJ7yqx7JSdWxQwPoMC44CDXTbV2FYNTwtH8FI2Jhbo=;
        b=mz1KlJCvGydgu6Rkek+UAoqOclkGxgQo1ehLsPT1ODfWrZPxux4RMVU69yuy4fo6vk
         r8iDSgp7fn60EpbsezbNF8D7oSJFpGeYr1CvPtAg6C9zYJGZ3e7s3oa42NmYNCvvK1r1
         zKjSnJrhd6IyBD5/tDLiVD1/llEFCT4Uz9b4zguzsNy0oqSg2OlFwGCYCGOTarMH2oy0
         pcp2Hrh9BGDOyMIqEZZiB6FxFQ1UhPglTdSkwkMKTYdlpMqB74K335n1LaIiRqdfECmq
         G/ttmIuaSvW12mi2W/q61QdkNK3l9g9hXm2gKPYMEvefnNUzrpsK1SGLtTLxs8zNR97j
         wU6g==
X-Gm-Message-State: AOJu0YyQEBcBoS6CxhfxWw9xH0yvhsE+CM7Z0GRjthZuyDFCniX/URTc
	q2fQXfKQiKA1IEQZaYPf1/cLQWiqs/M23FzfQ28qGAT4zHDyCW5T6Z/3k9VvE/P6
X-Gm-Gg: AZuq6aL1pqzstU1vlDEw9rFe7Hmc8FYPqH99/Lff9x9W2NypyYJM9orR3qFPF2qnl7f
	umNDdRYNwu1Fk39AsxQrjz/CU3OFDZYnK8rB6oF2pX4yMH0G5n6XS9yaEAVyCVteFGMzSax2b+B
	kqLZWlP2B2a3m+UEckXd8aJJc898uB2C2oWR+3wZWVEVLs+KE0qJpKclBp+aoJFYKv1cYF13zY+
	7j3Z8oGr+IMjV7FroN21sD4XHAb/k8qVzggi/UoXqmhpy4g7HTOtLX0l87uImSVGbLQKPQUlL/1
	gXdp5GxKIX+Isx3SEHu+nUE11YVQnLLzAbO3lJaDQOVHMZKUkKlEr9whJ9uCcHu51UDUg/Yt3Mg
	KXSMcn0Z/HidE9ERRKP5STQJc0cn2JENu8/JST8+4xZFa/vBM/MMOqFYD7FiVfwoCsqw4UFY8Uw
	W7OtOtnb/nVN6alqOs
X-Received: by 2002:a05:620a:d81:b0:8b3:9e:3124 with SMTP id af79cd13be357-8c70b8f694emr334305485a.64.1769537493478;
        Tue, 27 Jan 2026 10:11:33 -0800 (PST)
Received: from [172.17.0.2] ([40.116.92.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d35d6763sm2261866d6.0.2026.01.27.10.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:11:32 -0800 (PST)
Message-ID: <6978ffd4.d40a0220.184204.2223@mx.google.com>
Date: Tue, 27 Jan 2026 10:11:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2051345899860520183=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the AVCTP qualification
In-Reply-To: <20260127170527.150218-1-frederic.danis@collabora.com>
References: <20260127170527.150218-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2051345899860520183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047686

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      18.18 seconds
BluezMake                     PASS      670.00 seconds
MakeCheck                     PASS      18.25 seconds
MakeDistcheck                 PASS      227.12 seconds
CheckValgrind                 PASS      284.35 seconds
CheckSmatch                   PASS      321.52 seconds
bluezmakeextell               PASS      170.73 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      977.90 seconds

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


--===============2051345899860520183==--
