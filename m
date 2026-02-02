Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754237E30A
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Feb 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050193; cv=none; b=E48zPY1Hgg9oKHRF+23AJY7wT2hpNe8WdcPHi6xiKGZ378uOhF+Hdf6PQVzi59+EGFbsndA2mm0iwc+1dRz24J0mbqrD5XAxWOprVzn/ssDN1oToFkx8I8roeW3jjMJs6/IixShDWHk9nKvszTbQt7bB98tz1vlk0TTUUiIaJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050193; c=relaxed/simple;
	bh=d1BbO8NVIrp0EeYIeRPC/b+cKtZScidRx5Hdig9EPdU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Uif/XQIH1wK3IS+llZ99JDnpn0eA7nS4+zPYmT0ukHI4B9xV0vsqj/+XA0YsJgv70rHc/Aw+qFTaf1hA8Xuv3CGlLag+e5eogCpCQtMGeoprTlb3TSLOfis9XcSqG+YDaTa8PGNQjfLMq0TMR5q1yFPUlc6FzRjmplJzPxCHEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXKLB1Qj; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXKLB1Qj"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c5386f1c9fso632155685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 08:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050191; x=1770654991; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zCbB7Q43d3sWbbRbbOoLd+CS8SpODIztVydoESqDR8I=;
        b=SXKLB1QjM/AkRyIHdpSlgYx3f0KSO/GeogCg2iJQ56p85wMq1eATzWwudJNvtWMNQG
         HOm3JYPI5BYY2XwQy2wfBz24nIE16wVUWcJQbJbBIQLIvmVkb6D9AMWnWWM40lYgM1+S
         yg1ecThx6WaxWxZ/iQB/5QxYHQfeDidTq/eEpDJtO6HxCHzfoxxWMfEbsLTsTYhbTt3e
         2VywkTGazm5gK6iYaQAKf2lO7ohGHVOGoi45HAH8fjYbLl8PGbgWCF0Yn8ig4X4I/2cM
         2gCq8smQ4lGdanz0WbV2hk7CULqcJa+PsQrcAqcmRBqLD7wOXcWjXJH437Tq+DC1tC0j
         CSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050191; x=1770654991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCbB7Q43d3sWbbRbbOoLd+CS8SpODIztVydoESqDR8I=;
        b=SyDGIwDuq19yQCm3ww//2/KRl6gr1ibiNnzl9Pvan4XRYxALdcq8Nq9tQBC041O3cm
         fevwrLHAE1Aal85pkyUKyy1vYQ0HlsOQFpmfSOGuYnMtuuv0VCS9A9oVgUVCtmIL6DEZ
         XiN/FoQpeWdGc7OD7e1iWg/74GIaGwL7ojjRg7Dt82g+CnIwCBXV384mtf/1zRv3V/r1
         bdDjXmKTEN7LFU4c6fXYEw9FzKnfFYCDAE5R1/sfHYkqEoXTaGdAqTeS9b8GfP2SlMgo
         H4g8cHmNuVvijDq86kNyS37tiUjwuDammNPbuFPYWHe2QG1QwTqXTCR9oQ/DtavT9Skb
         +Jow==
X-Gm-Message-State: AOJu0YyGP+Ndv46Nm+lA+jozB2VmEeUKF5wENY+OM5IS+l9+3T+ymQmj
	dWdBpp/zk7xDi95/UkdLZ1l5LJ4ChQGHxsrfsFNoPED3Nh+pJaCGo1PAq3LW/tDH
X-Gm-Gg: AZuq6aLGqqk69ecTr2nHbM2IsirIF/bUjLxEx12hVCIe+Q3fortbsqdmNg/2c8pu/3D
	IpRB4klVkmxP2IZtp8jshb7rFsRZYVEzI/Xv+tQ6oBRWj72g6jlVNUVPtADGZzFnQK7Z5ERhFO1
	WXh39uAMtj8MloGuWquzf8tnNyVgCHVtaICKPDCvFGsNaXbexQHK6WigzIWiDuV58vEHvKAybUb
	fAvYb4qLnVjEwtvWZFkWt45ghRF+WCcFZHzA3QnDVoBacEiOWlgxMLk4iYkhMwjuj7hgzL8atzY
	Rf3aRliHgre+HcxbdWNG8DteVWLenqjhsRw328CCjlFZUpV3EljqbWouNzM6tF6YSJDlHb5OZYp
	a/mDX1JoQmf2CPw7aU6NnaB/p65f5JWBKiebNsB0bqObHRDOmzKNxAlHkEC4Uhq07t4zr1/RmfF
	0bbfxinwHXPsBXyEWuH3E=
X-Received: by 2002:a05:620a:28d0:b0:8b0:f04c:9f0f with SMTP id af79cd13be357-8c9eb32a21bmr1614361285a.63.1770050190873;
        Mon, 02 Feb 2026 08:36:30 -0800 (PST)
Received: from [172.17.0.2] ([135.237.130.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7ba79sm1216148885a.11.2026.02.02.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:36:30 -0800 (PST)
Message-ID: <6980d28e.050a0220.3ce8e5.065a@mx.google.com>
Date: Mon, 02 Feb 2026 08:36:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8093268362696671219=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, limahaliyana@gmail.com
Subject: RE: [BlueZ] shared/att: make att channel respect LE socket security level
In-Reply-To: <20260202153215.27593-1-limahaliyana@gmail.com>
References: <20260202153215.27593-1-limahaliyana@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8093268362696671219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1049845

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      647.34 seconds
MakeCheck                     PASS      18.93 seconds
MakeDistcheck                 PASS      241.71 seconds
CheckValgrind                 PASS      294.33 seconds
CheckSmatch                   PASS      348.48 seconds
bluezmakeextell               PASS      181.38 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1016.02 seconds

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


--===============8093268362696671219==--
