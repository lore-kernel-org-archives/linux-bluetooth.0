Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7784AE138
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151199; cv=none; b=LQ1b+fmROonS4GJHZn71OJB8nQqv6lCx0xtzayhRQw/0jQoBhcK+RBFPom8oyFqNSeg1VtcP240uVUIixKMY0uYG5G1Z9FLB/Z7DBF0nakqXOsO3TKtk4ztIS7LrGm9Lgcm564+SIkNkKO5ySZakNk2OYNnGo2FQGBRV7eDx8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151199; c=relaxed/simple;
	bh=vI8tFZTj2KQid+9cSWqHUhTQUOidOzuM64bVBDIAK34=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oja0Jgp+iZfz8FqBNaCriBHNhho3OblVxMZdDFXryvIO6xp71q24sMJ0BrIXi1aCORtg7BnbXyvMh0QZcoCm5GUyc+magdm96l/r9bczeiLN2MEbzWzBTr05vdb89Do5uMQTNcZEDztUI77cP12KQhB3NJet5JzkLDiRfxt6Llw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sf5BuN02; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf5BuN02"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so153189e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789151188; x=1789755988; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Wy4chUg4lj0qfK5KM/SPV3roS45+W71aUyAWCTO12E=;
        b=sf5BuN02NNsYa5ea/cYufJTKadIN6qb7E5Q5drtUfYnBhWL2KOWV3Cf2LpBtHYdRLO
         6rVdQMbZZsTmOxQ+DGIufNXgd/iFC+BKvZtAnOUyjcFkTAXlUQGyyKPT74ox6mE+7Bv9
         I1voPgF2za+Kd4rvdiy2PvXbiDGKDaVIRQ8AhPH2QHJ/l7Dn3kRrnFYsyY7YvRXV2j/Z
         hvO0wNghouhe3oKT8vw6MO3Vis0+r95cI/IOOpVcPl9fZi03RoPYtIOhPYtvWm9anAZL
         f5Ctj3QMsUuow3eiy1dt3BMzRlxCa1Zc2qDDyIOfRBGdPB6YMwkUEYRksEmNK2pWHizV
         ZDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151188; x=1789755988;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+Wy4chUg4lj0qfK5KM/SPV3roS45+W71aUyAWCTO12E=;
        b=IAF6h2Uia6kT5YMZlXLg9bx7eR5uQPgTgSU4eXJhxvq1+hgt+N37VfNP00ITXI+FQO
         LBXC6adJT1MZAYWaM9rOaCn6P3oGuOOXfyp1YnVCfcqDHRX7Hsn9KDdlcE6S9RV+ramM
         eZIFKbtxvd6NnyxJfU07oLo8FyT+vKE0YLPFvmGxdg8DkTdNf666fTqb+X0VGZ/D5rGF
         wNiDJqNLNgVzsUJQ1snnogwq7QWe/tCHKhVnkRivJ93kqazisp5EwMMfrVNVgjhRQKzU
         oNSHonMcySwYdlrU5H8ELdeQMAF2Fdpy03gYuCSr0yf12ESe8JNaq5ePu/KJxDRBuIZ0
         ZEEw==
X-Gm-Message-State: AFuF++klBaGFH0IKu/N2j+QFw2c6cLCIdPKCOOcAlXgfnURXcBSB+JfC
	oY8qmA0qA6PlteoKUE+rLtcNe8ut0Ga2cjeeeqcTKKTIias70Bv1RdDRDx+t5A==
X-Gm-Gg: AYBFou20ukyV7OgiKMWHAe3LvOnAqhEGc+V429f5Q3goxztYI/RrH0IhkxmF0m/4h/u
	pXQX06xgtualtzjHC3kC+rRdBoUv7WL1OkVRsRYJRXYzrCzBfDfbJVT0+O0Iy8bgwizTk8Mf7bO
	8fTcU2KksLmrEZVwJ2f5Ye24g+qUDWBtYcZi9ay3ZJHV8zbeedBSa/z37O/uiUM+I6QJzFco0w7
	FyHnUmai/4KSlgqTLJzVnT9fEQvq6gNKVWPwiK5EBLA35oYvDN55HK+io3eTyuPafzzzEF5yNIz
	9IF71OE5rotEt4UoOZLzKjHO32/N8Cptr9YIPOfqtU0oqQKFkTxMaKKCf1shzs3i8WQyYUUg9dj
	0ge8wAnhs345EEh2sUYyFzW7IfO5Y4agUIV4P+SG8DZJ7qB6m7pG8E0JV6BxMLdZKCy1Aqrj9Ff
	fLgIBjWa/fpTee4g6qiEMxQS4Lk+rkohz8aoszuc9EJciWpd1+qMkTrY4k8s3fpFibxY39jK81t
	jQi
X-Received: by 2002:a05:6122:341c:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c846284129mr10774775e0c.3.1789151183063;
        Fri, 11 Sep 2026 11:26:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f202856sm26891396d6.2.2026.09.11.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:26:22 -0700 (PDT)
Message-ID: <6aa447ce.f8a8063e.1c45d1.7239@mx.google.com>
Date: Fri, 11 Sep 2026 11:26:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0214215508311591957=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add ranging provider implementation
In-Reply-To: <20260827052034.1374180-2-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0214215508311591957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Add ranging provider implementation
   Pull Request: https://github.com/bluez/bluez/pull/2439
   Created:      2026-08-27 15:27:21+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0214215508311591957==--
