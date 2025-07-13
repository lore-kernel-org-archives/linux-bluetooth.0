Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6758210
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jul 2025 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752433678; cv=none; b=j7fcogKEU4usCZooUF9LqGXRcAjJqKnMMfxFBhd3M0UNbyO0Ps2Nb3Vl4Umq8UpbaRvc2a6CB3dmLzzj9Zv0SKIW04mSFB6ej9IuwQfhUi0S1ioCqAY5LrtfMhYX/u1oGXu1mm38k9ehxUhI6RBlhwcC93dqyVLGZVzuaMv7KSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752433678; c=relaxed/simple;
	bh=T9k1W7CBW5HomyFGmJGA2J0J13cHhCvCub8hpO+6Dw0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hCC/8IkckbH+QoVf2C70X3NBw+z4j2hEfv17Udnmma1DtsK/tGjDJOMgvfEMQtAXTqrsUt00Fc3b/r3LA55d9IFsfgIkvLqwSAltNUAqpaDuBbR0TiCjN97eEVgIoBZRKvCA5FWU34eAu0IBKsg68aAM2L/2tpvV1HieoAxbieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI02XngD; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI02XngD"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so55320226d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jul 2025 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752433675; x=1753038475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l7NqHxhE9ZBacoib4z9G2bSmDPlho28hi3rf4mgmXtg=;
        b=AI02XngDrgK/gABH4TAici9WlO/qp1aVxLvYZJwouhRwiX/IvamPvwcHqmCNRkgY00
         iKGu5WvcszQi18MKNuS4XSadI0cAWII4Kkt8SfKZ1M1PmcPUR8aYafXlYY+tOwrO9w5g
         mazUsOd3epwsDqdJVLt5tjG25PqqJHXxIf4QoqBjPMAVCuF/7E53T4zIj7noG4aj129F
         Ta77oNqjHmz2sKhX3CuD/8RJIb4Xd7WqXDC5CLXmpE/nMEud19F9XIt803P0lE1e6PMC
         HTyzGbu5elFKF8d1cIRL9g3eE+XyqQMc7I60tjSR52odJMNV0jtF3iyvBHpzdo0xOaCz
         8DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752433675; x=1753038475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7NqHxhE9ZBacoib4z9G2bSmDPlho28hi3rf4mgmXtg=;
        b=EY0RR3M3j0ISkehUCTA9pZ1mkdc0+Eo2l40OXugPkpRzQT3q4fPnLtcQ2c9RgyXkQz
         nOkgUPwrM/FT7I3apziTEUBZ+dMvwrvJ+IzWoCcRYT1SPGOwl/svM4ZCehGhjHikFLBe
         PEMwkqDt003DypOD7s7lkNShwCUvcBNZhLXJTq85XTygTW1mTzOSc2TfpPZRIvb1lDzz
         E1esWLw9rnJai+kX+BOq2E8Ec0Dmi81J+t7KpjMODQEJxT6ufv0TBaSsHaKfXfh9PK4i
         11n3G73pwF4uMzN0xBkBsZroOiydyjLDIvCXhRZDubEJ3Xr3YozyS3wF/M0lNQ3pGnHr
         UWcg==
X-Gm-Message-State: AOJu0Yz/4TCrUJSHdz7c/q8QVHWfpxRDfk/zaAuIrcqyhzQDGzr/7QgY
	KnZQnFrjWzgjacfe5nR9BmdWV/78Rl9c+zIlhU6vs0QgsuXEGF0dTDUjo3e5Aw==
X-Gm-Gg: ASbGncukuX5ocL8ucrlrBPBOoctN3CFOct6GH3pgDvEu/RA1JTGEiNyhkctbZ4SYmOi
	j3okdqYxzcXtOfWNnmZilaiLWX3HzNxYK3kp+GhNQitXdjNpGJdW1+8zYhaI7pdMU/J932IzfHT
	V1GXxGrRDOIyrSczwAcv0aIIPH9+ZO2FJR6xiuU5jFUqEhFVZupZ7vt1dcvG1t0ImFKHabQ1rZU
	sqyI3woHGFXReNLta1C+lDbvmwzZokelDddZX0n3QCnyJXuVtZnwU+n/ToFikoeoU0efcUFcgWc
	CU/l/68ilgDOXpo5+w8cSApHNRyz+PmeubFxsvXyCcgj9l+kYpcelJea9jKZ7xU2f3uctDCorRP
	pkPZNdhRefbeziJC2Q9Q601nYh8eu1Drnof5wvqA=
X-Google-Smtp-Source: AGHT+IHXhyrGzf2HhB41U48YEsDlp12bO6r2TaTgypR0o+KzGupZBmV3pj4EuqlA8gUa6iIcyAyQzQ==
X-Received: by 2002:a05:6214:1c4b:b0:701:894:2b91 with SMTP id 6a1803df08f44-704a339a946mr188149256d6.14.1752433675579;
        Sun, 13 Jul 2025 12:07:55 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.139.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b5960sm39754396d6.33.2025.07.13.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 12:07:55 -0700 (PDT)
Message-ID: <6874040b.050a0220.3200bb.e737@mx.google.com>
Date: Sun, 13 Jul 2025 12:07:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4258864614982638066=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nt8r@protonmail.com
Subject: RE: [BlueZ] obexd: clear pointers in `phonebook_exit`
In-Reply-To: <20250713174550.2041002-1-nt8r@protonmail.com>
References: <20250713174550.2041002-1-nt8r@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4258864614982638066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981848

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      19.96 seconds
BluezMake                     PASS      2582.75 seconds
MakeCheck                     PASS      20.68 seconds
MakeDistcheck                 PASS      181.62 seconds
CheckValgrind                 PASS      233.05 seconds
CheckSmatch                   PASS      302.82 seconds
bluezmakeextell               PASS      126.91 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      902.18 seconds

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


--===============4258864614982638066==--
