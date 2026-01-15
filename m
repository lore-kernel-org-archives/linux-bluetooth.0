Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658C1531C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768448552; cv=none; b=MZUOOCQxD6ndpUgSsJ7UEv7OZAJb2G7SaY6Zm5YYDTCKg+2rkX2AEyf2n/MexKN+nAJdC3Pe2JdLVFThtl9l7wOIiEY/+p5JHtH0EOEBhEBLI7shTWrBF1wZefaqMwkFC49anMcZabvPHif30G61QR5inijpIkmzoACgp0jaGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768448552; c=relaxed/simple;
	bh=CXabxb3Zw1f4BNxVlkoM6a7qbgs2m9MsKQD34on7oNE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RVuWGrc7tH0vRJX2hWTRtmOKIJTiS818VMsMABXLzRkFv/E5gtGOhqhC82ePwxJf56Jc/R0oQg8io4UmX+QqR2HH92SXS8xI3ydxXMP0BcaezLBleAQ6TPl6L+UgvHX1YSCeNmUPnIabvmkJtzv2HspvZtERPvRemhQJCY0nDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3OUWuP5; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3OUWuP5"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4ee158187aaso4873441cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 19:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768448550; x=1769053350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Nu0I/bJG6gxkSeUHEMTyDM8gBd9bchiG9YjCWfP4ic=;
        b=N3OUWuP5kC0ppYCIDosGpYWx5Zp4OTAt43FzXTjVHP5cCBIYEUqEhP6It45UM3q8aD
         HEbpw40dE/6TAHW+zZ7DHyfv9ifOGC+vK+kBeBkGPDnA73Hxinj8s4jmkK/FuGu4uzBj
         YuI5esXK1JTGsbYk8TF9rjBs2Uz8Nm7o3NPbGiTPfUTRdDLhF3Stm2zuGUL34/53TUyV
         Lx2L8nX6i2gXl4NndB5we8C6rWyLHN6q3t+0gneoFBqnwyaY+18StqTt8z020+GcV9kI
         ERTZA6qbAsQ12bP0eiXIa9IAOoMGBwoutRE8SX5n7/jwuNnX95DHvS5r3Spx7Vy4ZfKi
         dE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768448550; x=1769053350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Nu0I/bJG6gxkSeUHEMTyDM8gBd9bchiG9YjCWfP4ic=;
        b=QXWslX+IycNR4BZPXKZeVYZvqRTkBajXyXUSt3O7bXiWxCluHrsnfI8GFatxReDtmM
         Ve+nz5L10QQxuAjo1M5Pw3HDt5maxBdByUj0W5kcj6b6oVrZHiINcCbPN40M1+UDriRF
         0RoWNolU+r5A+1AZr02c76atQKjOsjANPMyge+eaNQ8o6YhQc8uopSr2dl0+0A/qm+wL
         xq7Z9IOdXZmD+y79DYb1ZACR/EnpS8lYtxQiYTNAd+TqoJEqtAY12kmrm+Gs2fLKZ4i8
         aPROdp9md62PcpJz7zDwX0tUavEo7zBqG+iMDyq9h8haheVZREyB++w+4PQ1D3fZ2n6v
         bkSw==
X-Gm-Message-State: AOJu0Yx6++dsgycNwAi5H2UyDX+nguHMh/6GhF2YuAdIWBzHkz3UAZ3R
	CeSTICMCLmB1m1EyZtY3+9OIcFZQ5wPuoGt4x2yfF4yzY+zOOOaJewr0WdRHr5Ou
X-Gm-Gg: AY/fxX4qIhhvY1OF4gHy5sKKDz2rIOPqPmEqaUJePszRuBENJtHAprbIjw92gE0DQW0
	XmrJ/FSQfsIynEUOZv1Gd7C4NsDpAffHSiINUeZqT+47gCevNP3NcFFr6Xg6pqBNA42G1XUhLRe
	rkIdRjgenR/yyYGH5TQODp/Hv3j+5cd/yjTL4Eye5ujduAgTQy5l/VGVYV0jMywuYE5u/zXz+r6
	MBybcj6T/QdWiRlltazK4YEBVsJMZcsOtM6X8ZpoKaoDLy/ptMUK+A4bry2gpSCuew3HWCbnhpy
	ndRMHbR/8yLf5kSi0NE0EeDN/SSlsVJgqfuEyfGmlCaoQk6KOYCst4QBbWCaE6+NYVj2t4zDh6z
	LTe13ysDnKG2gVsY3GUjoXlS722AccOK4SBQt8YF/z2qSQyt3D6xWC4fXd+0e6nEPtS+NL1j2fL
	sN7UoSsFNNA7VNhWiwyg==
X-Received: by 2002:ac8:5f0e:0:b0:4ff:c5f3:7076 with SMTP id d75a77b69052e-501481e8124mr68931111cf.16.1768448549851;
        Wed, 14 Jan 2026 19:42:29 -0800 (PST)
Received: from [172.17.0.2] ([172.214.45.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772681desm190554726d6.51.2026.01.14.19.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 19:42:29 -0800 (PST)
Message-ID: <69686225.0c0a0220.2fef60.388d@mx.google.com>
Date: Wed, 14 Jan 2026 19:42:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6372693418453334506=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mafm@igalia.com
Subject: RE: Support for config fragments (conf.d style dirs)
In-Reply-To: <20260115022852.2841362-2-mafm@igalia.com>
References: <20260115022852.2841362-2-mafm@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6372693418453334506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1042572

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      655.00 seconds
MakeCheck                     PASS      18.60 seconds
MakeDistcheck                 PASS      244.55 seconds
CheckValgrind                 PASS      295.34 seconds
CheckSmatch                   PASS      349.93 seconds
bluezmakeextell               PASS      185.36 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      1052.75 seconds

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


--===============6372693418453334506==--
