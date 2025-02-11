Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647F261563
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295558; cv=none; b=A5Y88DKlVS5E9r14tQUMoKpb0EcqAiB+fcwsM8VAPTD0ExS/w9Fz4vtXnkD6Lcc2MAhxyThXljgeWq4AZRs/zCYslVCV2bE2ZJN4Wve3pG2FTGLWJo3o035kZ0vBqwRPsTcfMpqZRsbGFebT+Xo7o1NORowpSJkM0GW/nxfOvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295558; c=relaxed/simple;
	bh=MaZm7K0EHECQMABFvvoRdvqlBwOV+wB759Y1YECv9rw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cUxkQ/Y23wAv/kBoO1uRlBsiKNexdD5fgyhT2cIprGxQvQTiNQqjzn51F1+V8t6U8ODQ/GmQK2LoGOk0YG8yb9uAWUBndh4NPN5VLSs1V5Muo1n4i+VzXEqisvachcw6d4lM45KQdzFCeWsh4b2rxibseJgzQIFOmqLgYVtV5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px7fQLQt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px7fQLQt"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4717bb7e7deso30955841cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 09:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739295556; x=1739900356; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zPSTuwfkzTni7/B9FA5+Dbt7kheQQNZ9kpHl/U5wD4Y=;
        b=Px7fQLQtwu6cgopVKLmJFdlBAlAeaSmzNU3ATvPG6MsfbOPgDiHEaqZe+4zdXMuANu
         8k6VxdvXW4sDUpATqeKufu7IXyIVWcI/rK7aYlKmvAj2dqjM0Lf6SI5lLqPh/hJm5eiu
         VvJcUUQw5Ssev1cUbZZNJFnrkSpYqpxm2zGlkJm5E4dkHaEYj0Zpvj4/oD2WclVwhEyC
         OAgBO8AqQE99Hq9w6DdcAMuf96LchW8Bi9BLzPYqRs0+KIFkE6NUR9IvPn2wwWPFSHDw
         B25SJB8RVXBlB5OZ3lNflm9BqGwC6sVP7EBTG8d9PHyBOD8Oa2x6f1CeRDmf6dnY/BqT
         K0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295556; x=1739900356;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPSTuwfkzTni7/B9FA5+Dbt7kheQQNZ9kpHl/U5wD4Y=;
        b=Ne5gcmUO/xUBpGPqfnPO6288vGyrjWLuLidh25DMweSQq/4Ru8fAD+9KbtfwHPRvNq
         SjbRvK9+htCYOw8L0njXsO20wGwlHOLHKOG53oCk87glQbDOLZvF69YlKAYPDt5YJf9C
         ED00XoIql2dyMio1pHTRFVAJhE52JfZmx9FVM5r0BMWos7zFwrFoJZsPvLIl+ReYSz8U
         q37rdKnE0goqG0eaXZbpe/tZza35i/ieaDBxJ2WgquGwX9ayyj+IlTyBaHRNVH0eRt3J
         g2FWTHJY9W5ULCyu+VjwEqRGwUZNkD2Ma0D6znqRe0C49VJIu34FQr84yTRErqKvIjCq
         6JNg==
X-Gm-Message-State: AOJu0YyD5mrwuQFbMiRHEI2T+FlF1biCFr6kAfBhSRW1UJBWCuiD37Rf
	h4uUvX+OUdT5r/OlaI7Yc7s98owP6zt/K9iwfMKztPvFFgooNcwKMSKcOA==
X-Gm-Gg: ASbGncuUU3BaXSq6WxDfHqqRZ52GEOXWeiPnfRp8SHYeE2I0fyIDhGmMQkpmrQfJJFA
	PcAbpw/yZ2V3OoYZEYZbburVlvx76fmAGYSgPJTpzo0uRXmCYoJxWqetsvm28cTUDrU8I+Q9nGq
	WbHvzld8Ni/Dg31SaF78iNAtxg9yxMKnLgvQu0qB6/5vcQ6MASjL0ThQGNa1uxL+MYj3XnWpN9a
	Cj1xfydMydQZEO9rWwmveVOMvydAaKszSNh9mOiz+z7ufyc1czudkhC7UIkG3jO9OUwl66mP8aS
	2wvi2KU0F23781cd+fkxkQ==
X-Google-Smtp-Source: AGHT+IF49vYgRvyt73atSEVjm9p5kQr5xXOJpS9kzs41OQzrE2PcJqQQntFGzleeHsCa/QxKLfvhiQ==
X-Received: by 2002:ac8:5895:0:b0:471:89c1:618a with SMTP id d75a77b69052e-471a1391f86mr64617741cf.15.1739295556081;
        Tue, 11 Feb 2025 09:39:16 -0800 (PST)
Received: from [172.17.0.2] ([68.154.31.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492a85b1sm62054111cf.33.2025.02.11.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 09:39:15 -0800 (PST)
Message-ID: <67ab8b43.050a0220.1e341e.74c9@mx.google.com>
Date: Tue, 11 Feb 2025 09:39:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4370455024906127317=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Register bap attached/detached callbacks
In-Reply-To: <20250211141936.23372-2-iulia.tanasescu@nxp.com>
References: <20250211141936.23372-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4370455024906127317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=932732

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.77 seconds
BluezMake                     PASS      1523.58 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      158.52 seconds
CheckValgrind                 PASS      216.97 seconds
CheckSmatch                   PASS      287.14 seconds
bluezmakeextell               PASS      100.12 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      869.67 seconds

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


--===============4370455024906127317==--
