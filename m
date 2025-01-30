Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320B1946C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263707; cv=none; b=lvYFCyKXtFzeX8NyXUQMCnCEvL7bORCqSL2ArLQd3IAnggTRVgbHpI50x04AIAYwFd2L8wY74hB9fOCxUMTeSIAHO63eRVvU+UG7M83Wp5OsGBBkOwxjvoQfCpcc/JdOtN9DVPKY1QmaSXqmce7aTgL91Eo+N00n1qQHCxkuUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263707; c=relaxed/simple;
	bh=ZiVFyNz5BtJHkGwNUFGVnf8d3ZA0lBh9lq6EljpqYLU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O5cyu4u4Rm0IicGsnOnl/E7YPT1KmgAczyBvLWsYgc3UzcRbP0vYLddi9M9B4mDVxqWvEI4qHOCSBvVLNRbWaJP/VdWGmcqaSLZpOHH2dDPRffc7XJ5oqllMeF5dyHKoNzu9tV3RQfaDVpkgcG01zz9soekf/uxnDm4SM20khUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VASbR5fA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VASbR5fA"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ddcff5a823so8415006d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738263704; x=1738868504; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H9QfykyShYeO3lHD/wP2Mj+E+pibX6k+G9JEgkRTagc=;
        b=VASbR5fAz9sGDcDsB2/BuJjOFhhrr1J+6BJofIGrtHBlglHjq34o1lQXHvcYKA3/5Y
         F5FkTAW4sePgis72Roi0QDsEHXgarRVfn8qzKsyFXgQnpcqA2LEKUkCHnw7E0voaCRGX
         GKLD2gP+ilShBTHprQb0m0Z6BMcn5tU7AVnwT1zOeMduM7PmuIkgCjCg7Qgqt0nc2r5+
         yhN/SejJk+A8598hGVSutpDsoKCvY95njcVvYz+pG8svZTtgMfsoPm9A6WxpsnMAnSil
         sBe3uZX8pc6f+7eRN9YD1YqeZzs7kxNfOKddXb5CfQd86aC+o4sRKQ167Gf0ncHFytEz
         K87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738263704; x=1738868504;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9QfykyShYeO3lHD/wP2Mj+E+pibX6k+G9JEgkRTagc=;
        b=VJg9ZYMNX7ePARwXQJZS67PQZw4furYGe7ocOgQn1C1OqGzh0CYc0B65AQMAzhSCny
         8AKblnG9QPWSCxdrBTYO1ffQl8HPslSfmui/OL1MdFcW6OlfLwAfmRfOGljwQ3Sw6lf0
         Xrd99ZuKvz1mq/rFcvSgz/LvUCYNsrQFuH0XlPOR8E7mH7BR/f7AqUvPkCOs5KLe0GU0
         vRHue+F8T9T63jjTRaRrtlVBI1m9ii6xS3/P7FDjHeAxUuyuVV3t1S6WtoWXHbPfKS7K
         HF2iutJochurl90x2Ys058dexTtEvHhaFPYkFx9nG+LjGWmT7rIm7k7RUxymE4hTrOSo
         ljBw==
X-Gm-Message-State: AOJu0YwzQUkAVGxNEzqORWp7upoZ+ikGBNL7Fmjx/cJiYXWIHOVFKomq
	owzHAmqe+E0p8U7c9MXJvXW+AB6KNpKbddGoiqeBE0j02Yft+HsPqax2bw==
X-Gm-Gg: ASbGncsgPILmI3jQFVmZ35zaBlfKIHW1Q0ElGJrXuc/xKolfk0Dq8QijBRsYK3pwywo
	ts/3MJcsBDz8EaAJ++t2u9mBzPBKfIVFcXvhDyvTwmRRkiTzrFc1aoVSgdNaIvRQzFq2BVhYu9h
	0/6mbr8JQNlGpc0ku2g6/bVnWGoYyHTVrXhFHS9K9zLRV4P/BzquZjMuy7Oc2w8RAdiUE9tAP5X
	9FHrECWEWYkJDKnJK32dNXUeLOHeE9pZW2+37T5ntlPAg78Q+Ow2ELrsB+Tx+nkeagJtj8Wy7Gh
	U3APN7JiCWe9gSFvHL73ZA==
X-Google-Smtp-Source: AGHT+IGwzmmMvZeun7mcAzwn3gn1m2lq2CEuEFoeF/41eC7lYAbjl3w9+5tvu4N33VQ/hIFHQYq5DQ==
X-Received: by 2002:a05:6214:5913:b0:6d4:215d:91b5 with SMTP id 6a1803df08f44-6e243c0f4f5mr110665866d6.11.1738263704610;
        Thu, 30 Jan 2025 11:01:44 -0800 (PST)
Received: from [172.17.0.2] ([172.183.172.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814405sm9023966d6.40.2025.01.30.11.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 11:01:44 -0800 (PST)
Message-ID: <679bcc98.d40a0220.17bd21.31c5@mx.google.com>
Date: Thu, 30 Jan 2025 11:01:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1542548650072425118=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20250130183434.2394058-2-quic_janathot@quicinc.com>
References: <20250130183434.2394058-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1542548650072425118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929316

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.40 seconds
BuildKernel                   PASS      24.66 seconds
CheckAllWarning               PASS      27.03 seconds
CheckSparse                   PASS      36.72 seconds
BuildKernel32                 PASS      24.30 seconds
TestRunnerSetup               PASS      431.08 seconds
TestRunner_l2cap-tester       PASS      20.45 seconds
TestRunner_iso-tester         PASS      29.75 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      123.51 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      9.35 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        PASS      6.39 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1542548650072425118==--
