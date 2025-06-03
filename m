Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060422AE76
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950343; cv=none; b=exCROhvmSZW2fS+bCtMbJtsmTSX5E5nzqZ3SqP6FLLHZxeKn+Z84yE4O4v4e11EKmprskOCWx6EV/KEP3a1gRtq/Rrl9x4QbFVxrAzbWbDgr0dduWnGjb1C640QhSA+Pz9hHkut1pFusvMEWHmtgmfunpCrWeoWVqOXhzSxCNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950343; c=relaxed/simple;
	bh=WrP8H6IbiySz53F9Nf3d11rilZw55aVXVzSXRs/NvXU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ei0QzZLmlTdOwKWeEF8gcYERMtI1EV/hB9QTBXVnRrZ0HNQHn46+PYuj9lmdukgX2uKlYGCt3FXkeo9pFEIM1H1YWyaY0I4a8UCVdGtCBs4tKJT1RAKukbAApCyHMUDVEMXMAvOPS9Zl4ymBvhb/STvcmNeR+EnOjkoob3lk6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPr+5MU6; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPr+5MU6"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fad0820112so46469996d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748950338; x=1749555138; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fd1j3isSLjbqSQMDW31LRg5X+ADRUu+kqnqjn1sSKmU=;
        b=NPr+5MU6cfD+quAWeZoTOhGarrLRxmBAZkgBwN6SLhBZzk2mGBtDw6BO8MxucGe6ja
         3sueBIT9fSj34xPnX4pfdUqSkwk45Au1GMZcQkKYt7cAt8DerEkwKjsuoLJQiRcY0NrH
         lpwMFj2Q3jEuNpgou91dg+qTKPHlqeLcWbodX2L1HrmCwLjy1M/335O/FXZJ0k+z3rcY
         Ga4CA4uoVUutRk1vchlg0YEPWUbDlnRGeMAIagnldY2J4E0kXds/SzUl0Oe3cnjSoSKa
         XTUNMHmfsrlP/2PvtQ7AokQyaKZMLfyFbs7KlKEOSEifQ5gwdkBkqdyI4uvjxPCemqwm
         wo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748950338; x=1749555138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fd1j3isSLjbqSQMDW31LRg5X+ADRUu+kqnqjn1sSKmU=;
        b=WvawVs0DprO9ZbnU9AM97HdWXcwwzCDYrmjtgmulhqMaJdEy2QX839HrTBcjqwxHSZ
         hku1fhCiGytkxcIpuMuyjWhIA55ZjcuOziTeW5FSKCAbxRhcmc4nGl7vDbmTiq1VddfL
         pAC1cuX3VDt5QFBaivGHyT+dbMxwP2Jk6/0hdLP/MLE8BchKGCT/MLeB/Ix3dF7S0mnP
         vaHuY3NPixSJcMWKe7581NY/Z7pxtTGm5HmFrxdbcNJo0xlZWFS9yRxGDgaNV2lSq9Yw
         AVIcxyhFj6TlYHn32XStgOXNuMxr7oKcNReRlfopYuNCD++JtfrwoDb0xwWKgwnN8kLa
         KypQ==
X-Gm-Message-State: AOJu0YxqQf6yiNNGJcA3upRJFhkL0Tbn0svmLaz/efa+tvVVw669ZT9/
	LLFDs9C+pr535qxgYGR5fKf/A93IKjj/Fy006YcyPivgj9uphVa27zHrC9Ovi9GU
X-Gm-Gg: ASbGncty3CSIA0TYVjCz69Y9pmane3Y+CMH8rsSJ8SKLanbQ/k/+FmDw4d1ueK+SqWz
	hsRb6TCujJWk7GvsKmtkmJ6n0CKDHCsNi1ZJqYVnEmX9fGZUrrhuSPBA24Enw99qG4mxJUKm9zi
	NmYgTQJMD/xsl9JncHCAJERdoog/0WQiAI+gK/MaTbFDKXgMc3kkDKePy4Iz0JFAmwC8Wp1LkXr
	KEZkE5XXlPJMU2WM8tdP/mcha8W3DI46vkkYbAuVB+e9bQndaIHkht/QeW8ThFL6yepoxeLiDpL
	Gy0EnP6PgTq45eVMHvM5SOQY1tzYNsZ+cKTIAkDJWXqrCaeX/Ff6Oyw8a35B2rcDm78=
X-Google-Smtp-Source: AGHT+IFtNoXClCtJbK6aMHZBwRaXWVnz38L6gPHJuX6Akfz3zmxPhtEb56TMmi0epbrX5RjzpQ2G4w==
X-Received: by 2002:a05:6214:4d05:b0:6fa:edb8:b343 with SMTP id 6a1803df08f44-6faeede126cmr25700176d6.2.1748950338431;
        Tue, 03 Jun 2025 04:32:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.24.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e1c79csm79137556d6.115.2025.06.03.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:32:17 -0700 (PDT)
Message-ID: <683edd41.0c0a0220.3b5d97.9408@mx.google.com>
Date: Tue, 03 Jun 2025 04:32:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5995191802412955099=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sdoregor@sdore.me
Subject: RE: Cable pairing support for DualSense
In-Reply-To: <20250603095617.92785-2-sdoregor@sdore.me>
References: <20250603095617.92785-2-sdoregor@sdore.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5995191802412955099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968245

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      2784.95 seconds
MakeCheck                     PASS      20.42 seconds
MakeDistcheck                 PASS      207.03 seconds
CheckValgrind                 PASS      281.95 seconds
CheckSmatch                   PASS      304.96 seconds
bluezmakeextell               PASS      130.81 seconds
IncrementalBuild              PENDING   0.19 seconds
ScanBuild                     PASS      932.48 seconds

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


--===============5995191802412955099==--
