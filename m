Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B32D0612
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591978; cv=none; b=A8KxxngEKwBIaje0nCZiQ8uhyH28FepGVrYB+lTESKsMJUhtVrcK/FsDbxmIWL4dcRaTDGTSmybSiw+T+MUrF93F8SXmRoHjwISkqdwEfHh614SajH5vOO5dIc3r2roJNuaTlU6kvjf5P9+1X+ujNG2SWQhJXIVSiZUiqU9DZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591978; c=relaxed/simple;
	bh=1bhjo0DCQ1qelg1FzyzaezZknXLRhRZkSegK/srHPxg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iqtRIYgWgvCNCcGEV/X9g4jQS+jMsKHXkdAXHkIRnmcwKuQPJyCg1UKnlS53j3+sFX9Hm315fIkwpQRWLtmSX4aTbGuF4wt+/9oOfRw+Qm5a5Ma1UBxkPfPcW7noAs4o4k7EQpcNP6k99EYzWnpiEjO8ek4Fuw+dVobu2TXCNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5K75uED; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5K75uED"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso641713b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757591976; x=1758196776; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=COI4hz3wbtvUt9V0MvTicXFXRQYLyvfnhltwkudnEIc=;
        b=h5K75uEDPUPQlFXHv//3/gLEP87c/DhJnMK7FlRUkjNUBaeC5//WY7YSKN3tijj5Ha
         Vh486HjhH25QTkVdM+lwi2lBQoR/rbwMQPTcmC64HJZOnoKKUJnZJQPcKHoFkQzEueV6
         +SKo5pPBUiYYkz5+RNZRHBsOx4I2kcWpfqB4ROWVqUsOV6R+FowDUeGKedDVKbXrSrVs
         /N1ChRMgElziNYV5ouVq99GZmLHfECgbmDF7sVIe4+YCKcnouw/NDvpR6qpNfy/iLlmd
         2C3Ys/RUzskMH1eMZtazuFtkRyjv8brC380yl2vXRfRwhXVKJblU1MUwGskBZF9XV97q
         hFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757591976; x=1758196776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COI4hz3wbtvUt9V0MvTicXFXRQYLyvfnhltwkudnEIc=;
        b=mcCQlSibaORYsqH5olvlcKUn+rqxWz6414L7zeI3QtOgoB+uOuQWohiyNCKOwThSGx
         gGj/CLTtwqQYCFIAHSBQnXkSpg/HVbnzQJZ9SC/HyOemJrD5D9reo8EA0QG2yPi1HmiT
         HVhAynDGLU/Kc1NzuCOKkCzFJHNOF7u1AsTdCiRfhutSI8EE6o95DzzmhSyaz4u1t0Yl
         LLZwsIXO7k4QrlLdx0tEbqZhhbT9AHdjCd2G6QP01fxhcF/msW59G5hikf/GvjqEJpkn
         hvaxaSPA2URpRiGhGGFU1IRD8ypkJmWVU80u0BtvmhZGaDh1kyIJI4LCqs0GYNDTznE5
         KQnA==
X-Gm-Message-State: AOJu0YwfMqkH6/h+c85jX2a7+bv6Gwkh1qPRG8oyBH3sHIcNRbmTdqPe
	h4SN4tFU6Z/o4Uc5r0wO8kqOJLxWsgRVIKYn2W2VthxIoIAzPhKyDFhICqfp6A==
X-Gm-Gg: ASbGncvPC048gy8AeEhc6R9v2ksq+yhzaGgXjMX+5PCfTZIiNfd869eouWD/u17zUNM
	8BHN+yBtftU34QIwTNK8KptNhoNAhTJfStEKVnJKRwgr7y/7m+9TzJmVFX7TlqI/9Wr1DuFLniR
	zgmQVRtyM10X0l/435kGTOE8AHeZxiewOFHo6J4kI+DV3SGTmCl1DIXTVudgdkvgXdS7tNJu677
	9n9pXeBRNjzatYnp+C9sGA2yeLzyRK33Cg7EPEfqkkhRhy7wyExhFg/5jtkc+YHJ/lKtjgE9qeB
	OlHU62CUg5X6/NRCT0NMElPZgG7LkPJHr2PhQ5SaRG0yAHwG9O0XShxzmQl4RDDf20luqIdCkiO
	rcNNX2N1JCNFVhlhuM0Z3JRi48q4XKXPGvwJ4ENJ2aA==
X-Google-Smtp-Source: AGHT+IHmreUR3mow1a24sE/G/d2E0J679g5eUsaUV4JcZEPvF1Daa8nPD5zNGfUbvLPqhp9c2JMxQA==
X-Received: by 2002:a05:6a20:6a25:b0:248:7a71:c25 with SMTP id adf61e73a8af0-253466ebf3fmr26692307637.50.1757591976356;
        Thu, 11 Sep 2025 04:59:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4781dsm1969801b3a.33.2025.09.11.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:59:35 -0700 (PDT)
Message-ID: <68c2b9a7.050a0220.1e413.428c@mx.google.com>
Date: Thu, 11 Sep 2025 04:59:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2250239208314026341=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/4] shared/hfp: Add Operator name support
In-Reply-To: <20250911102840.2090361-1-frederic.danis@collabora.com>
References: <20250911102840.2090361-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2250239208314026341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1001291

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      2758.58 seconds
MakeCheck                     PASS      19.71 seconds
MakeDistcheck                 PASS      183.38 seconds
CheckValgrind                 PASS      236.93 seconds
CheckSmatch                   PASS      306.51 seconds
bluezmakeextell               PASS      126.69 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      914.55 seconds

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


--===============2250239208314026341==--
