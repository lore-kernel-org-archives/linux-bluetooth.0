Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6919BBA
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001545; cv=none; b=crOcvlCsp729viEtQvyZ1JjG2EdW1ReG9Xy0ktY2Zz5yCqfLUQwgeLZPBx9kpiLK9vy1b2aDVk0tYo3YC0bhTLb3DQbGssNU1Q3VLHPqRqcUFUSLQ6r0WuEKcdlhhnvr4qJPkjP1Qq8NMTKZrPcLnePvUiSO75sBg3iu0TV3+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001545; c=relaxed/simple;
	bh=hrFb6Qcn3yWzWSFB2Z6rsy0pL0285LCYZN0I4upWld8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XbcSo+Y5Yt+MQqSvoJzFpDhEUGjfaEnt0FLVWosTWZmml4ON5m4IcMa9gYSjwPRAEyPkZ2Dxv3gEMYyWcj/E8G2dc7cNyzLu7j511rFGlcumxTPGaS7wfkAuOFG19p8LVpB+URzUkohhxce0KFY/o4beKyZ8vwx3TZmezHHxav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbUpdEQ8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbUpdEQ8"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so8115216a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 10:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738001542; x=1738606342; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cm2DPgZiXhyPQrv5Gowx8Uxri6tjIaDgXtXYWBYZt8Q=;
        b=MbUpdEQ8eKH2nEgVjodT4Zb50ajcLZK4g8F/6a3LkXF+KptPqpJP0DrTmqyaWqZWuN
         9NXosHavbmjwwUi6ZFPn+KtqrbLZsnV3WCQybjFTACbbPSrUSHf8dsYxB4OMMrcP1xpP
         lwg3e6yonYRRFlHNR3BDd7VTjPydaA5W9ANtpD+zubgsDloqy6Y9o6xKN+i5kQXXn+z7
         JMf/gjyhmOu2TNgcv9mVwSmRXL30q891xFMKkDbo/2+TF9MOqgUkC5Z/GzNyL8u5vhdf
         qVghGh21LHMT2GfbBzb5GSZDbGwbM53b1U98zcThzvvBueat39Mgi4oG87gsL7UTxtjf
         ckWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738001542; x=1738606342;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm2DPgZiXhyPQrv5Gowx8Uxri6tjIaDgXtXYWBYZt8Q=;
        b=iqLxy8IXAO/HICLGt1DnF+Ry/xXz1gcOTP03VkeI692cw6eyW3Jim8Df284vSSVKTd
         raZ7H36YY8QAoMAHoGKXCREWDbGHMNpLy4Q2IQ/oiiisjkODCavkOcIdkQCTFOYetXHE
         3jYJjR8Wm98T2w+gM/5/ia1+FkCBcQhMRp2K0+yWRwJJ7N9LLDpQqiw+4KE0mLI1HVo7
         gBmTD8vx/r8cImKC5xl13Po5H4QZjXwxAvi15WCOut1vUFmNysFYnFSZFtZdIKVNRYdR
         4xU3Kjgd+LquAGyurhGbqlC6XjiQcqbopz3Z3ojHR0JefiZqyal9Z6L5SkjRbPgGVwyg
         EL5w==
X-Gm-Message-State: AOJu0YyF5K84qbU7vju1GsWd36vgeQrgteEUXENrs8nDrfYtSuqw3SFt
	d8DviUJ4TNB0auhhAM9JYLF92eVhA8jhztE66OsG1mEUgNsl+I6lWVqViA==
X-Gm-Gg: ASbGncsn5+bwNaKZmrRy3Xpz1SWEwg6zTT+OAdQ/POZiiSXCKLA+5NBU5XAqoG+/lOQ
	wbkLjCtKA9h/GLTYuAhqF9rLxJxqfebG4TF6Rah3Jy3xifTgD/zDiwh+hiuN/FSI1F9SbXE4lGD
	wp6DRaviQ0xBtmduiU1IdmY93+P2UJtBnC4LXhXL+2pYsdyRhvSHYUz1pmDaun1a6u/RA+IyW/G
	EcDtckqoKSglsxliNzbh6prU+bK6reawYxwKGjrg3bF4sJa0cM4a3gROMOyiIzdHSSN4oYb5i5Q
	hCy0O2A85yw=
X-Google-Smtp-Source: AGHT+IFl2vs5q0GjKzkY1C163sBnXrEQPI15jMQpSh1/T7rtYIzrPnchTDDQJ5PXQ3cxrifvvK08rQ==
X-Received: by 2002:a17:90b:1f8c:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2f782c4ca09mr55757080a91.6.1738001542546;
        Mon, 27 Jan 2025 10:12:22 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac490ad0024sm6663952a12.43.2025.01.27.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 10:12:22 -0800 (PST)
Message-ID: <6797cc86.630a0220.110aa6.45ed@mx.google.com>
Date: Mon, 27 Jan 2025 10:12:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5400845048196171643=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] org.bluez.LEAdvertisement: Add dedicated Scan Response field
In-Reply-To: <20250127165833.866133-1-luiz.dentz@gmail.com>
References: <20250127165833.866133-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5400845048196171643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928598

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.48 seconds
BluezMake                     PASS      1766.91 seconds
MakeCheck                     PASS      12.69 seconds
MakeDistcheck                 PASS      160.16 seconds
CheckValgrind                 PASS      216.43 seconds
CheckSmatch                   PASS      272.81 seconds
bluezmakeextell               PASS      98.59 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      879.93 seconds

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


--===============5400845048196171643==--
