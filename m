Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADB1D9A54
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765917655; cv=none; b=gBac2+8+JjUIMRBVYDMifJGfojwvHYa95QA3bRMMoz88lviq0Fs7l5qAI5X3VhTl+GnuUCc0SDkjPsQmJUX1rPJa0RFokxcRFK5CvrvbVXd2WmfgtB0kGvyxRVU8D+sis62cOZ630jIgT8vnQDabQYXQaOXiAU6S3qTNDHjFtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765917655; c=relaxed/simple;
	bh=/HC4PdImE0wWKVkUP/2ez3aODL13+KeL21GlSO3zdz8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P3dx/4hbKwMxM+b4d6CYdA4dcLahRlpjBi5jMD4FY9uAUfJKdpbNehgS7Fxpc2fbElOCIIS5eJMQHVL351qcPsfJ1kQgbajjLmH9XhJCZoRdY4iVFvaiqVl6YqQbf62fPlsacLVI0B3Ff/Nx68IuJk+5IsORcx3DGDSyYviKEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMkaWfBq; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMkaWfBq"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7f1243792f2so3390420b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765917653; x=1766522453; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OfZi3yBsX6Bu351o3uubhK7MfECMkv1CSYMG9n7590o=;
        b=VMkaWfBqHkEghL03lSKSmtCGGCabYNQ0a5CK4wVu96hS/wxwPvqh/aRf9lQsIa4meq
         NhXXPBjwPwqk5QJLQ+O8cOaOjYnTE0105MHCKuNx0HDk2D96XieF0LWdephcAKLIRqTw
         jEo5ty9Q7q7mOFxLZ4WM7FvL/qm4HaOXEZnG+TLsLLjrP9O+7Of59lXE5txo8NPp/dzL
         6VWNMACYdYp3LWJhQRsvfpH3X7mEqGHBWRTjGb+8n/HyLL3i4bfjC2ucVF2+U+WqszS/
         VKnrj7XGnpEv36oyUOEd6bfjQbKi5bcqL2ddTMYpVUNv+jtcOPBBaR94JO59rvqwVs8F
         Ty3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765917653; x=1766522453;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfZi3yBsX6Bu351o3uubhK7MfECMkv1CSYMG9n7590o=;
        b=o4YE+eWi7M3RWLcT+j6eET5GrZQAlGq1UWzzbU0YMlM1i0PqNcPp+X4EZoua/e84Od
         bLnessaPWOmsSM6IupL/RaVZdn0BQmjgQSmS49h0BtjwRPFzfCG/3z1Gbyr0dsdpyovZ
         CyDeY7CXXEvHvHohunquUVEXrMtxSkVfgqSh9D6YE/x6aLaZm7HG8TAdPQE3XbxL3OuY
         wmEbW9pJfGxdpetP2fkH4bmV39oXfPlcD3V5vjh/1O7rcnpWsv8LqSgnGWsL66oKY/fa
         1JhUpoCh3Rd/9LJ9VuRqeVjIcBEdKqgdL5YricW2tMbCPOLYvMB0i40b3euf9of1/aTw
         /+NQ==
X-Gm-Message-State: AOJu0YwGLXtF93bT16gkroMLyXg6ws/Zy0A7ThDntcTOY3HtTOel12N9
	+Uztpb0PHMC9/ROkjGQEmU6QdBAdvKy1NjdEt5rX//hcK4LLiZBGucWbKuxCTORM
X-Gm-Gg: AY/fxX5U//u1KAkPn1WiHbtOIxcRhpO2S/Q6/64CeezNzCJZJks34r0Vyx72siwhdPi
	3vvPYe+mLR/aAq0EyVlCyTdz2wclJMbQpCkdhNrZNYoZVaXQFid9fmfFYv7LAK0bu1hL9Q+MLke
	O/e5mtDMs77KIprEgK/1Z4pxqSFeEidEfpkSwnBNBpGHoYyZtv74V5ql0GMxFsQ6eSB5SxW0OGr
	0KGpPLh8QcqsV8VcBjGF+J41pE9XKZVWufAvABWVx6tPcWvROjyKlu6E29HNP6ysDF1EQINhtOF
	aa4oVQB/D/5+BA1tMxAH8umW4porDVSpb5RZStNJBX2lrRzowYgFr462BN8QCJRlSougM/obapX
	HymmU9SiQkcMd/LaWJBiq+TWZkD50rx0PGZsuh1joPKLVSeXk2TA87JSoN+LkPXk3WmlTt5gz6q
	bxreAMJBK6D35UKxhh
X-Google-Smtp-Source: AGHT+IEejESkBaH65c5ewdiER9GMTxRqNcS/El55TPBkAvlbPUkYGyxHfMdkLH5CElajdRqNtx6sQQ==
X-Received: by 2002:a05:7022:7f14:b0:11b:9386:a386 with SMTP id a92af1059eb24-11f34c593f4mr9464635c88.41.1765917652771;
        Tue, 16 Dec 2025 12:40:52 -0800 (PST)
Received: from [172.17.0.2] ([104.209.5.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e304766sm58149181c88.13.2025.12.16.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 12:40:52 -0800 (PST)
Message-ID: <6941c3d4.050a0220.2f327e.6b30@mx.google.com>
Date: Tue, 16 Dec 2025 12:40:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5590463699609324157=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] shared/mcp: emit MCS error if value changes during long read
In-Reply-To: <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
References: <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5590463699609324157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033906

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      19.79 seconds
BluezMake                     PASS      644.38 seconds
MakeCheck                     PASS      22.21 seconds
MakeDistcheck                 PASS      239.01 seconds
CheckValgrind                 PASS      297.79 seconds
CheckSmatch                   PASS      346.90 seconds
bluezmakeextell               PASS      179.64 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      1006.66 seconds

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


--===============5590463699609324157==--
