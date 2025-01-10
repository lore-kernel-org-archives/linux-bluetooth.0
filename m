Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767492135DF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530739; cv=none; b=cR6nuzYBH5SAcumhruLauuOJ8L5ZbZmbCKGrdcwuk6HAoMlDAdHsubL0gifu1+8foSnGc7Xb9jM1PBQ0UUqhaH80srj8L8LwCYOnwvUY7xlG9iZ7bokaKkKD11FvSjSj+ybmG5Pe7JCeOIrpVFgzMqXRaHzYl8osQMT8W9bbIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530739; c=relaxed/simple;
	bh=DU6P+cW/w/VhrIngS8b6sjihmWgarPGBnUs6tDiuq4k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DMNqT9fQMjWJoahoH3262RAWNNohkcpaVe4zFbspHS1oleHLQyQuDmlvkCcNCc1+nhkrq8Kcgky9y48pbRVfUqQz7qaX/LqyYttsC4VgtJI8HtmoZRyRMdtR/0Dd05W/Q3ChudULxRwyQtB4RxK0qTi68asjNFxnKW8Mt8y1vyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzueuyNS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzueuyNS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166f1e589cso46807215ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736530737; x=1737135537; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PkglEs9ppUqK5U4BWxRtcTXzA0St0J62UZj90RfaCpo=;
        b=YzueuyNSi7ovp/xjwa4UJSS7ikrZtKPnebTUVfR2fciYSUbUQTXKhWRIoLMH9mmmHR
         vxNKpSH0ZLe0Hdit+Y8NQ1+Ta0l5oBST2MUtbJ5bDKzbjCBwLjbBqPXU9+2zCsy4HXpf
         pcCzsJaEt4z5xKG3Y1p2ETGxBAf5JItGZuIENp21ee3tEX1ORALbIr8ujnmG6pEx8eHr
         Lsa4Q6DL40QNHl6uxDvocyyGYiKQby/Q3tnUxjCUVQViN4g1qF46H5MjnnfBfKC+Uass
         AY8j8rotCjvVys0XyEXXJPgWuZ/GbyGg/sXXJh/0sJwZkBUXGn7BVXQ97XdgCpC+Efbz
         bkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530737; x=1737135537;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkglEs9ppUqK5U4BWxRtcTXzA0St0J62UZj90RfaCpo=;
        b=A2+5BP0eNtXogwDooJxcC+5jqqtREBoSleNcQu5QopP1+UZ7y0SPXpMLmzNIrEHCtv
         bQ/QQCGsmmE75t/RVPTFVMcnF/fQ3b8CAMLOCd7NsP7qi8s5AD88XBOyVyghthFrGIKO
         GzEbU98PMroEQxH2AGAZWkNPcw12yWx1UYS2BDnCUlk3cu7fOBHISzMItGgfk5st+02f
         BaPpIM1jqndkyn+F5oU6jHtmvOEQ2WCg134/b/2sWiGz1vWgrYNnfpjhhz7F0KGMusQN
         qn2AIe4ER07vL7381L7CbcDnzvNNuJ20jUfW4cE0IOnxjkYKwGSbMk4U+JupCurKm0cd
         fJmA==
X-Gm-Message-State: AOJu0YxMrodrAASAV7OoWyjbrF9nDUHYCjNOEKX1d//k45sTJas9c6FT
	57PvD4g7/K1GnbyreXsvdJ7Ms3XzKEmgOo3dqNDJKWjdcqEzOyp6SV2UKw==
X-Gm-Gg: ASbGncsB1bhr8VwFldLlh4Kfi5tXZJCCQckFutX19GHuhgH19fOy5/MJDmtCqO1owJw
	x1ipc5/reDZVafWaFbjdlw1SIZJyTajua9JH9QWjYVGSvOnuBRyqvCprgOSsKkjx/WNnp3aUGP6
	pgnIMNpQcoBEpnJXYzSkvuqZeirFoPP5T844zCp8SA6zJTNBu8ewh8B4efM90qtbkS3/6gAfXdv
	z4WUtAUwUyy8M43N8z46VnS6C7PYiDFOQ33E9uBH1W3pNcjFIyw0EO4UmMali4=
X-Google-Smtp-Source: AGHT+IGaIAP+0Ijh+E0lGtiTVV7+nqoKBtmY4r50oEtjG3ZhGXUfs9sTQPZv+3oZz7Djfbp0Ntbzzw==
X-Received: by 2002:a17:902:f68b:b0:216:32c4:f807 with SMTP id d9443c01a7336-21a83fdea82mr178936705ad.45.1736530737473;
        Fri, 10 Jan 2025 09:38:57 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12ea8dsm16280155ad.63.2025.01.10.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:38:56 -0800 (PST)
Message-ID: <67815b30.170a0220.3dbc27.ad45@mx.google.com>
Date: Fri, 10 Jan 2025 09:38:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3043983569479680571=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] build: Fix --disable-asha
In-Reply-To: <20250110155132.2647060-1-luiz.dentz@gmail.com>
References: <20250110155132.2647060-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3043983569479680571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924316

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      1585.82 seconds
MakeCheck                     PASS      13.27 seconds
MakeDistcheck                 PASS      161.22 seconds
CheckValgrind                 PASS      217.10 seconds
CheckSmatch                   PASS      272.25 seconds
bluezmakeextell               PASS      99.00 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      875.17 seconds

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


--===============3043983569479680571==--
