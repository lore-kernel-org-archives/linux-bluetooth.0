Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C21AA7A6
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771081000; cv=none; b=NJe4IoONER/+dkvHmvKcwH+JZ056xQCcGVTtMvvfIezxL4idNKZfRXaB0A8aJ3nomloSzVnqjxkfU/jilr/uDJGIQfRY5GMAXPslthMFItq8qLSr4nFxNAePxgZDIgmjh2Rw5fuIonAJQkNz8XFLz7YH5Q+X9GEkHTEs09Ki0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771081000; c=relaxed/simple;
	bh=2l+aXjSb9PdYv2htWl+qV8jpFP/GunVTQ1Rpmk9HFj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IA1wHLLEGNZ+5lOazOqqyOENCcZBn1okjEmp3CB4gTJe45JGe/oR8aKJR20VtTvFSWzJu9QGxcrVPCrocenBmP3UBVE2wIYSDR1uLI0mlK/e8zGhG+LQXlS6Vb+YkmZ59qEUqXSb1O3HB+bDtiGrt1M4AGp+F3YulAqLE6m86gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiJBpqkL; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiJBpqkL"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bab70f8c8aso1853993eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 06:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771080998; x=1771685798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VNiFkf+RW+MriXRGBaeld6mtzq1vv3VlyMPelhwyOAg=;
        b=UiJBpqkLx5Am2LyhbZCK6Y0Oqb9J5ETOOw8Qpi/GYZGefgwNQdwPjpUG7tDePEk5re
         kzN3QFxPHEt9UJJ60pGLfNic4oB2sTnSSR9bZ0CnzLtrRnl8zqe0mGUDv6GB12FGrz/Y
         2BL2OePz/Ud7z+PTDt58M2chLC3axvKIFJs0MeoO9ky22H9o/NENiWcmZsk7TRvZcyqK
         n0TqFI9gZTdyYuZmfBrIvStlOXMwtf25EHkM7lFsqd4iXO60BCY6Awk75/gh+rwULPvW
         ajHGn84l5czEnFWHUi5Pg/2z4nfOlK4LnSFGYpaE8S0Mg9H6W/1JB3i6Neo7lFPrUmsh
         c6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771080998; x=1771685798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNiFkf+RW+MriXRGBaeld6mtzq1vv3VlyMPelhwyOAg=;
        b=SZCqPsOe8AquxJ+Ybq9SWw1VEQavcpsz+fDgwutQqnynogXdCFYAnpolWoOYAnhe4h
         /0X5grI1+NrcoZgWURUggyITMGYU4zFdo+7z+wXMiDPi6RSN/Lwtu+M4wlPj5BKCM2Ks
         KB4lMzeQMISGnTnEh8kEpB19b8Ep9bM0FJ4XNsSfCfWv/vhU2Hs/c7+gsPTrS3EqQZBT
         OSDEQE15hfX66QIxo8w8E2dbfeZXU4gk0bw2lFSGAWUB3IFFmP/s3t9XshyMpwhWi0WH
         PcdHYnFSlEnAWjSnnQuLVX8aDnX5gWqEtip0hPyRgPt0j/6pSCjxgZJYl0At4NX+bpSQ
         0keg==
X-Forwarded-Encrypted: i=1; AJvYcCVxGJpJ5SRnuK5a1S7fl3r40oWTnbJKP7yjK5YbURJ0aXHEPTtCIDuzu4fBK3VUkPaO8vLxdPqTtd4qLvENfvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeY7epoJNp5OiZbwniJsTyZuH5L0z1UijNuHUsVu2MsTlAI3l
	FfJ4Zm/fTzAq5Y64HyhaB6rqK+KkrtPRCFs6pk84yDvzV0hZ5t+pM/Mj
X-Gm-Gg: AZuq6aJS79pY+JgyNkkFNQtZsCLGnPNhH+qpELNcrpj/4D1aYSvFy6OhQpTfpkjM2W3
	Uoe6wwMncYlMiFJmtnKaWoyDVO/7SevKCuA4jMwaknHG++6MheuXAr+zbPcbh95+OusEcOMg+M2
	Ep1HM1ra9cUkJbiTHYWIa9R11vF4HGdGVGVr1IC0APhjFhpccqItLE6gp0s4y3CT+gcWz2oQJf7
	edfLKaLLCDlC2sXE9sUsvz6Fgtdl76NVyk8XHZDN0DtJLRLyUS8Fq2iZ62Xtw+3gvaqr2pVmpsL
	7zkhOgIauwHKO/QHGlfODKmAuvYyCB9q5MUIHYvmzO2iCx4bTCktVqNjbRSXi8VB/Ohl0XsuQ59
	AuTaJwnKUfazQnlXzbhXulzDO3Ob2c2skoPyHgj/6zm5sii3/gIyuHMtmVAKN0Bsz1bj0LivRQb
	gTFp7APfHaLWyojisenZBiefXlb6GQp80BsQuqCbKf/W1KJSEsuxC0t9RFQyFRB8QIlqAKVwS/+
	12i7ZV852HQbMmldTGjWYjqAQ==
X-Received: by 2002:a05:7300:d50c:b0:2b4:700b:3d8b with SMTP id 5a478bee46e88-2babc585850mr1690541eec.37.1771080997670;
        Sat, 14 Feb 2026 06:56:37 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543e50sm2419386eec.3.2026.02.14.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 06:56:37 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: bluez.test.bot@gmail.com
Subject: Re: [PATCH v9] Bluetooth: mgmt: Fix race condition in mesh handling
Date: Sat, 14 Feb 2026 14:56:22 +0000
Message-ID: <20260214145622.6109-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz and Marcel,                         
                                            
As seen in the CI results above, using guard(mutex)(&hdev->mgmt_pending_lock) triggers a 
"BUG: sleeping function called from invalid context" during the sco-tester run, alongside a circular locking dependency warning.
                     
In previous versions, I had attempted to use a spinlock specifically to avoid sleeping in this atomic context. 
However, as Luiz pointed out in a previous review, I was incorrectly using the global hdev->lock instead of a lock specific to the pending lists.

Since mgmt_pending_lock is a mutex, it seems we cannot safely use it to protect mesh_pending in 
mgmt_mesh_add() and mgmt_mesh_find() without triggering this lockdep crash.

Given this context restriction, what would be the preferred approach here? 
Should we introduce a dedicated spinlock_t specifically for mesh_pending, 
or perhaps explore an RCU-based approach for the list traversal?

Any guidance would be appreciated!
                                                       
Thanks,                                                
Maiquel
