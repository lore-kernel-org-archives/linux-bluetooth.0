Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781A1A0BF1
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635824; cv=none; b=uTsJeGLEu+L47vx2X2n6MMN59mjVaZ0MW912N64uik0qmRiUV9901+Q/AFdyIufB99r4zVgVW+7fvtkZJLTSI7+kq14r3t8OJHPuxstdarB/Do+tMr6wDiehYsb/328FjWa5eVg0fYxDlUn9FVVR1qsbb+5jbYRE0HPHeAiVYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635824; c=relaxed/simple;
	bh=fqiyeECoHzb15pusKZR9UNej6odZVhTIst/LpBleG1s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ShnzS1wPLJdXTMZaReZQTA0cK3Uj077kCStkbrhu+akpgEyV/kcNEWkbhnoe5UJzSiszSAihibpHt7L3VgctEipkkZ5BkNfxTlKc3b7oOSLX6QvRIaVcV8B2seux4B2hZcjC7VwKN7SaokZqdKI3DtKbrsnI5HickN960gB81Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHj9om/y; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHj9om/y"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b85d5cc39eso100147085a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734635822; x=1735240622; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O3m0tLodCguz3g7ir/P/PMaK72NGahatzHDUV+oIOwY=;
        b=MHj9om/yjggZPTsGEQ9s3v0yh9VB9034sRKYVFhUWvpvRQNJsNSGqJDNWl6P2PWmmC
         yPxoNW7Pfq9LGfIgaYv2jZ3frHRGxmySLcCN9rQQReySQUJNxMhO605yMyMZ5TROdkbS
         Uul1exhVlDYv6ERdKfKutpP8QsO32ZJLilpGv0oN80KMZjsaFkuIN1G3eCHk9By9FAHQ
         Ua+E9MnuSgBNsWUtezNaTt2T3MKTO/D/JzRHAJ2g7gCawHpmNqGsfcIcib17mcwW9Kzv
         RVx8iRqKZqK/krD5TdS03niixULZoNnkPKZayZohfYttxftlp4M2IQY0pK7J7wREJf5b
         79/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635822; x=1735240622;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3m0tLodCguz3g7ir/P/PMaK72NGahatzHDUV+oIOwY=;
        b=E9YMKH5MaXVlVTtPoBwGWaCL+K0yD2BjwExBA0dQuoO1nrhlN7eFtd4d2MOjemsUg4
         X86LprL97iN9ylIn9NHxQr/tHMod4AST16NxeAhqFWJyekuLxDZGwT7WuYEZiNG+uq39
         REv1VNZzQU4KoppMgxR0uQYdevcpSgm7i67wqkGufbfR/FP9faI8am9Qi+5rc/kjuZZa
         gFsfiPhwXid/ZBLEaqToiOmLsfgoFZdVppzUMNDUbL69lKoiqeWKU2sVOERDuvmtcnZv
         KlklPvHqnm8lMBb9TYIBYUhaSl7qcHsTQJBVKo38HKdNvSmIjSgNhEzaqRjiaoWDjXXk
         a+HA==
X-Gm-Message-State: AOJu0YzXAQsSwQ/RCEAnnaPFJ7CK9QK6XikKx+s6KeiwCAPU42Tzp8Db
	4BC2RlwI4OqhCRB28eD4gKYsSNtJOudWeke416EczkqrPv34dkNJqDPlKg==
X-Gm-Gg: ASbGncszmNKKd9otsk9lopQBGbDdPcioSHRIozns3E+hDEYYt2lHH5vFKzNXwc6+BX9
	kdQJsDFXJtPiMdR5vAx9BomXiDHxPZwBq19uk7t4mnaZvSfieeN6LU5tGJ3LnpJ5UqzPg/+Yste
	MNFuhgLX9zYX1jxhlxT7ZUdBir1c+NyG+ClDGshsoEaC99tzl3Cv/wjDcpqtRr9+Q83KIX09imw
	FAEeD2HOzN5nmsYUEvSOEFjpeE9MJQzftgy/YtgOrFu0jnLi3+SCeIn4zZjXB8=
X-Google-Smtp-Source: AGHT+IHZdqPk1yXEEj2KSgSFwL25/D76qM9YCvv4oKO2IcRaaAQZlakeFYAVHbAtQX91a4aSAZ/bYw==
X-Received: by 2002:a05:620a:4414:b0:7b6:eed4:6957 with SMTP id af79cd13be357-7b9ba853191mr895685a.60.1734635821802;
        Thu, 19 Dec 2024 11:17:01 -0800 (PST)
Received: from [172.17.0.2] ([20.161.76.235])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbd1dsm74375585a.18.2024.12.19.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:17:01 -0800 (PST)
Message-ID: <6764712d.050a0220.9f9d5.33ab@mx.google.com>
Date: Thu, 19 Dec 2024 11:17:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2892108296621056319=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kieran.r.geary@gmail.com
Subject: RE: Fix SDP buffer overflow for DS4 (Revision 2)
In-Reply-To: <20241219181140.423916-2-kieran.r.geary@gmail.com>
References: <20241219181140.423916-2-kieran.r.geary@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2892108296621056319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919589

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.66 seconds
BluezMake                     PASS      1619.79 seconds
MakeCheck                     PASS      13.05 seconds
MakeDistcheck                 PASS      159.85 seconds
CheckValgrind                 PASS      215.65 seconds
CheckSmatch                   PASS      274.02 seconds
bluezmakeextell               PASS      99.84 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      855.39 seconds

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


--===============2892108296621056319==--
