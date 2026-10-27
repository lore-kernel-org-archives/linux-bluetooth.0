Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136113;
	b=MdEmBvSurgirqU4/83nAap8XIJ0coAtwEIHF+wGbWPcvlkp3eIKAzixvnM9LUVLDHKUS
	 W1HvF4550diOpbRwI34rf+pes+L570GzfDD8RfRGWayXj2XuXfC6VhQHmxRyYjBwu0Ocs
	 eESF9MSeYxOvRaGTi0hFqMv6v1Z7cNiS/eK+6v49y2Egz6jW42fL+kyrL0mgYyyyqv0m4
	 MFf8ipwAlx7n8TyA4ofbDgZRlM4b6gbLq3vrb3LdQn+VkcaMrMt7bol6rAMVwmj2R0ih8
	 gdSCcrqoKK8lz3rOs/nUCv7K9bS86JyiNngyRKiJAdR0j49BkYtz27Svozpo6LkOVBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Wlp7imYB+46owhkZpev4JZ6nLIJgEeD5z03PBUqte7Y=;
	b=R5O1wDQkk4nnvA6/B0zNs5uZh9vXPxWunGYZ7v/+cKOk9ymgXNQo7wKgedbdA1lUUUx8
	 vza634en6WNM1tFJQKf1s5VXR48HQjkCPdoP0fhWTEGlNIFkQIH0NVHbuxieLFzkxftVH
	 QiKk2pki51rTWI7d+39eIlN56d4oACWVSVwbReDiIh4SDhS/1UX4NtyBwDMkMHw6ft6Vn
	 jZWMoC4ApWyudbxcU6bgxHQHPWGm8p4WMwBDAwN8ayWKeIUfAfTZLPUdo74p4pjIfDd3S
	 AJ+YvWaGj56X95nTVS6+rICDwvSU0B4k3HU1yl+2Kezrk3zX/zxDBYOQSCneAsREO+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoxLDOlg;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04964606A324
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 21:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04964606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoxLDOlg
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f84a55e31aso201728a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136112; x=1793740912; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wlp7imYB+46owhkZpev4JZ6nLIJgEeD5z03PBUqte7Y=;
        b=qoxLDOlg1PA5vFmVy+4mE7RjLBTDH4PQuov3qBmlYLZt8jcKaBON4uW7DsE1TZuXnf
         ZE6NunP0valtkLH3MoGbovpNHouI6A/XoJMQylXJKL8QbLl6eacdw28+bU1D+apZMThr
         OxP8u2dilU/Q3LfWw+g2+BiVjVSHO8ycGyGj/R04YrfOAkCQvhB1BAhuJXbVKiVSbZDh
         UmawN7+UToigdQOzVVcTMBs0xqzOS8WEoxjV+7ujZsqXulxmFWN3HhcTBCz2LHMvTUSs
         GXkdK/O5CiLo9ck7tHY3nybKT9KV3PbaUyL5EPxG5WGupj1dFTUl95WRBW4V77p+4oeT
         afwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136112; x=1793740912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wlp7imYB+46owhkZpev4JZ6nLIJgEeD5z03PBUqte7Y=;
        b=DGF/hVOdTmN42+sdNDKnm8DtvrRKq0/zQv38ztH2rTPMXOUsR9P5HkkayYw6lNI0y5
         5MdsfLGJkio4jlNBZRL5J8ioepASCP3afrBANj/VZ89KQkV2fRF56B13G1sUFxhioynq
         kKMgCTxkrf2FEYS/nKbwmA16XhZEBQrJ33tvbrRSsee3xr32l1PPmUshG2K5iD9SpIjw
         gFPnx5Zy2u4h3BSJXR3+qtGIvSrfM7ILLiOgXi163VJBCV5KGoGCKrL1h4tlVmpw8dJF
         XRyMSYrCGVt6rIRMPW8n+G5W+m4N67o0pQmBTv5nBHjF5QF8WBoqXbaXY7v4hQINrB8l
         dTpg==
X-Gm-Message-State: AFq9FYJqjsieRvGGtHeMVkHQeTentmZ2ju8F7JfzApINywLauP1yG/EG
	QpJD7IlGgI/FYKvP8iJCYviR0I83C850WtTN4YKp3p0Fu5A5PfuqDhGkyipQSg==
X-Gm-Gg: AYBFou3yRgOsrnNiXuDYLegwKcIX1P6zjsEVyyLs1RvnA3majbCSIU8MMhSJBc+Vr+r
	C1qMH1byQYfvyhvxpNo7MLikiivqQtnCOMDodPlGiJtrx9nWLBtpUxwS315MUDGbqTVWiclCNoq
	TnUWE1dEc3sHiV9XATzDssfmDqYwrZ/l/536yumMKrN3PMCXWpcEkzwcOxZRvWydJsAOSHOLi9u
	qfN7aTk0OQLrecKFEwIW72h6e2y1bcath3BUe2JJRXoFRE6aM/XWGnVaKUB9aVopoeby0oc3z5I
	qI7wzxGYOtvHEH5ANVsDo16hDy+2lR2BhTsspzElW7hHJURyHncxvHQxc8lEOxPFjKYM2Mg/j2P
	VhBf7RYs7YHv9djQjlDe6+DhxRPzcEBwg8Z3fnMj7wvHXpcZaFslg4AvbShAYSXdIzZonq0sfgY
	eyjhONa6zfOFOYuRwYEyZO8uBQ9rCGh5HIbRuQr0oG2mmPXsL55tTeZ8BHfNO593PGZwTfwP9Pp
	4mAzCjOgY/mCYiXMOXvztUpl4e+6fbKgnDiuVW/CMT7Z+49n03wp5u6T1hKWN0=
X-Received: by 2002:a05:6830:3e05:b0:844:d703:a2a8 with SMTP id 46e09a7af769-85ac01309fbmr558366a34.16.1793136111843;
        Tue, 27 Oct 2026 14:21:51 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.39.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fc0fc7a1sm12789695a34.25.2026.10.27.14.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:21:51 -0700 (PDT)
Message-ID: <6ae115ef.d643d4e7.31f61d.b975@mx.google.com>
Date: Tue, 27 Oct 2026 14:21:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7299446851825118924=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [v2] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
In-Reply-To: <20261027172730.86568-1-kevin@simpleble.org>
References: <20261027172730.86568-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7299446851825118924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194830/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.10 seconds
CheckAllWarning               PASS      29.28 seconds
CheckSparse                   PASS      24.05 seconds
BuildKernel32                 PASS      20.28 seconds
CheckKernelLLVM               PASS      22.09 seconds
TestRunnerSetup               PASS      453.55 seconds
TestRunner_mgmt-tester        PASS      83.31 seconds
TestRunner_mesh-tester        PASS      5.04 seconds
IncrementalBuild              PASS      20.25 seconds



https://github.com/bluez/bluetooth-next/pull/1010

---
Regards,
Linux Bluetooth


--===============7299446851825118924==--
