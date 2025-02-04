Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB01FAC5C
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704635; cv=none; b=UtdMr4jHVKTa2mGkAc6u4pl0xGVhw1edzRo8uDCqHaE5QraNX5gibmXvFAbHNTzorW6pwIC/sckyCFquUhsfq9cby6b4Cxv9Ewq/3fzsy39RDF6xLdUP7L/RoiAp8627uoYZB5K2cVScXcW4TBv5POh/2TmMV29Mrdz5hy1Qrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704635; c=relaxed/simple;
	bh=aMAS+JPhBrCOWYwlE+t7P43teUsPcYIRU2EL76xFoWE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rkTGWcz4aHspzIlKIkFzSL2jRUaEkXORkEQPm6ZDTAPWBbPKe4zTPWGes8mqJtiZfjXgjZ4n1kqm3dR/B2Sf0vxK5C9wRhXRd3ngeKp6O+FgZN9zNKLK3vbCGD+lwUCHJVYL0EoXiT9niOG961pgs7PSJ9v3hVQQWJQkJlezFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwc5C2oC; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwc5C2oC"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b8618be68bso583795285a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 13:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738704632; x=1739309432; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nmngEQb5DMg9TPyCWlPyNksD9QZ69ATy9+Bm/2F/SWc=;
        b=Lwc5C2oC38mtYmm3HIqkd8/I9ek47eD0DhSKxq95WJFQpO1DNv0eWP1f4eu19LJ1vR
         lqb3Ol69cxmYOQMU/5djsi0gyAVR7Pu71fVzEkD48DIdJDP6i9LUjaWrRL7oUkqpxLG/
         soU3zALFWu2H3+Spv0HGTe+hXAB/pzFpEbGeBZYpVx31MuG3vcXHeGNfkg1l10DgyM4t
         W2oPel3X/j0rKzl9vcOiWkHx31JUlPIjd6G19kscjuDfgP2nK8yKcYfYeNFSZpZIZWwc
         4/YdQ0oQL2m4SQ3S+WasQsgk1hAQll2tqfpj5boehLB1f3+gG7LezsQDONeiykAbrMGC
         dIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738704632; x=1739309432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmngEQb5DMg9TPyCWlPyNksD9QZ69ATy9+Bm/2F/SWc=;
        b=TaGd3HahNXdOE5EKNn/D6Zg/9zaiwJ4QzggsBlN4RUc+0Dc7meyYH12SBg0hGxZdfl
         1oePLax9xZ1o2uZCabQmRpVhyvTR3uGFO4r2V5ua4jUFreeuUhqEjBkQZkCd/YTQZy66
         ac7RqGYLSZ5MIPSK7WCV/H48HwynpQ5YNC4LWgwmZ3zuKhmxPB3FHN8aFm0ZKm38a6ua
         41ZF2RAH3YWo5a75KxinLzXYX78kuNfVOHUnKRnPs2zwqTNUpqo4sH/3EEjJ+cZWrx27
         /7+f/0tLuVekvbsZ28Fu9PcDdfRxySL5cAEHWT9LYrAgBq0e8m6SklJCffgomGS15ooQ
         mfSg==
X-Gm-Message-State: AOJu0Yyoo3uq9wrIyGazfOlytRZGr1VIKce1v0+QYQxmVHt4Fc5aZUYs
	CiSRtH9JTLC3CKugMgKwMBpyFnsoqJGmjnHnJbzyqiPd6XMv8P8BYBX8zw==
X-Gm-Gg: ASbGncs2vSCr5ag15yjRzRKoMdzc3siDsPV0lVOq7pdA39bRjGHjJySqZmMvcnx8KQT
	7q18Ti4zOHBivj4IT6JP3GyfRAlLREpO1OVtpXi7QV2SbIfj0wRdtzMKzZxfdcz2whkwMeevSuu
	h8i0/lZqHcTnUqZm+C/r8/S/F/mrcbp7XQkqm8i98OGV5LtQiBclwwr049Z3vHpI53lAWjDGSvZ
	7toeb1A9MagnuYkZF/hLafFTAKq7faHJwYwan01kuSyp3SMQ8yRPrnsllfJH/YlnA4vRZq55Np4
	YEyvUTDsDOBA7K+YL0R7SGQ=
X-Google-Smtp-Source: AGHT+IFd1Tbm6vi85RdqnY1nMRhpZEyEwt5G70ejPQw03668WOqt/kNg/dswnaVGQzK3j+xcWIjPuQ==
X-Received: by 2002:a05:620a:178b:b0:7b6:dd7a:9709 with SMTP id af79cd13be357-7c03a02f0f7mr69246385a.36.1738704632306;
        Tue, 04 Feb 2025 13:30:32 -0800 (PST)
Received: from [172.17.0.2] ([172.183.229.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bbac4sm679105585a.22.2025.02.04.13.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:30:31 -0800 (PST)
Message-ID: <67a286f7.050a0220.4740.8768@mx.google.com>
Date: Tue, 04 Feb 2025 13:30:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1819482032847895886=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] build: Enable -Wstringop-overflow and -D_FORTIFY_SOURCE=3
In-Reply-To: <20250204201948.2883452-1-luiz.dentz@gmail.com>
References: <20250204201948.2883452-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1819482032847895886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=930572

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.48 seconds
BluezMake                     PASS      1493.53 seconds
MakeCheck                     PASS      12.73 seconds
MakeDistcheck                 PASS      156.64 seconds
CheckValgrind                 PASS      212.23 seconds
CheckSmatch                   PASS      281.84 seconds
bluezmakeextell               PASS      97.57 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      847.66 seconds

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


--===============1819482032847895886==--
