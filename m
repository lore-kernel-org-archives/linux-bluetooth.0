Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327843382F1
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995837; cv=none; b=KJVuDBgdLbK3vV17yCPTtBNKJvzgwkX4e+Ky0jmE4BEV8dkNEzBQe+zL1RQxYpzvCh62VKCuKDHyEj3z9ESGAYVhGptkgMncEM38yzY/rCjALlheWg7wnsZ/BlIxX4VSONNN0Ffe4uXPV7L3bMLgX/1E1P+qDG9NMCgGSc69rnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995837; c=relaxed/simple;
	bh=AKkspdV1aS1/J6D2Z5uNwZCSg3ky7QOWd3yig8UQcG8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qGZle6u8upSAJUDOi+CV8Gbsn9l78P08aR6hNiL4HhAMPyBO6jeRKR6aM5ojOtboiU4cAff9TUtkG51tOBP01knDPhFRAHiCzQxK9tAKaMZENRkQtJ3wqb/nYgYs8uRcarbIjMDEQ2OmEkheWKhkEwTHCekqQmNf9DG/5N8dWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1zm1daG; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1zm1daG"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba895adfeaso3395766eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775995835; x=1776600635; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7J1EoykqO4r8E52bEjV6rt0Z5HkFP39KecU5h1T055s=;
        b=g1zm1daGUgvozdx2JuUrxR0s3wlFUW4blmF4CnFL15hLjbUfWA/N7ElQVAdNvm4Rcu
         obvkBvOchfc6HLWdIzNQblw5bQPgSqy9qvz/J7dmb/4VS3egmPSdHYbffk9LI63vs2U2
         93e7Kx0V5Mid5aBkjQ00uhockrXY8SKpZkC+1PP62wRWDahUG/4XIq5ieVyahARhyq19
         C9FINRXthN5/xlaaa8qNkLMNomMmh7n8DnF0fJgrzmgOF6qQRrQXa10ah6IEHiKl8Rrj
         z+7FPGCmhGiHMqz3jbBvuwnlZb+RGb6lk8D+fXnq8Zd04z7Nj7hYfXILPk43g4Jv6Rpm
         fkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775995835; x=1776600635;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J1EoykqO4r8E52bEjV6rt0Z5HkFP39KecU5h1T055s=;
        b=bvTq+MtZt8ivm8PO+Y/q/yWBEnEMzJYzb186HBVnM9lxl+ouCckFZkFcKNUdwNcCb5
         WAC7cSbO6KyEG2INwiW/u0ujPmNYmVJSw5sPVBfz8uyWljr7V0ksCdUEtJOeJSNRubSd
         nhqMKwJox+yx+OGgGF6GjD+3ZbqJhUK3sEXlvWqzFtUZoF1sx8STFyKPWHLFOOpFdEiA
         SPUJrPDlq/3qZwIQuIoDGfAshOAhamG7t9uamO341yKgsv4LdvmnJ6oARbj9TE1HNI7s
         Pde7hsvbOv6qSxERn/HhVxPO29FI0Ec/MIl6pP2SZT0RTJz/NEg0Wp2XlxT/blMVXDV9
         TpqA==
X-Gm-Message-State: AOJu0Yyvv+IZ/B+8QiG3U3FJpb1Ehuf1KiEmuOf8iRRhNMV634SEBGtp
	sXBOOqk6rlyQr9X2B/+O7UvWo9onNdHTZ3hDAxtx2Kawh99KCiwkjFcEXbyw8g==
X-Gm-Gg: AeBDievXKayYDDVMfIMxkFyK+Fp1Ah/t0uX09gFIFzeZi8coPkL5bYhr9Hr0EQG4ylj
	9P/W9TzBtgbnYI260Ei4KYsnqVDUA4K6Qon6EAZHId3tnk4BtETYfD1I4qsdjMb5iXPgOUzVxBb
	ZLVdGiGvs66yPhcr8ABbk/Dmz3kcCfOAwX94jzMujzaNX63YteIw5qTQWDoeZz8tjnaGWk2VfWR
	PRjYGtY2Fl24BBv/ixp9rEomOtw+At4e2L7Z8xq7g7z30gigMjspSEIhKVqbeameRvTngldgmPk
	pacVJD21Xe5zlD790ObBkwqbG5HkaVnvUA5iD3QFxz2RW6UgD3iZ80G3k519Tf8Ec73mBeMPCu9
	0lkiMzk32JtZoV9nhgWsUlNNVu6iurxwj17RNoIXgXfCvYSs7l6rSPaGV1BNbYM4dzvAQPa2oXH
	YZnxJJbaPAtf/Q5ktZ7sJNvkd1mQIbs/Jw
X-Received: by 2002:a05:7300:7313:b0:2d8:b2e1:20cf with SMTP id 5a478bee46e88-2d8b2e122fbmr659458eec.10.1775995834875;
        Sun, 12 Apr 2026 05:10:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d7d55sm12257646eec.22.2026.04.12.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 05:10:33 -0700 (PDT)
Message-ID: <69db8bb9.050a0220.2443dc.20a5@mx.google.com>
Date: Sun, 12 Apr 2026 05:10:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6874312502298784214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] gatt-database: remove database from dbs list when destroyed
In-Reply-To: <3806351a2fbd1b5e463c9530203f7d121f673f61.1775992233.git.pav@iki.fi>
References: <3806351a2fbd1b5e463c9530203f7d121f673f61.1775992233.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6874312502298784214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080317

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      643.90 seconds
MakeCheck                     PASS      18.19 seconds
MakeDistcheck                 PASS      244.06 seconds
CheckValgrind                 PASS      293.20 seconds
CheckSmatch                   PASS      347.57 seconds
bluezmakeextell               PASS      181.61 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1014.90 seconds

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



https://github.com/bluez/bluez/pull/2029

---
Regards,
Linux Bluetooth


--===============6874312502298784214==--
