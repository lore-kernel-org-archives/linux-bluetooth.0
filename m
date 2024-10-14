Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376919F42F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904147; cv=none; b=s6jAao5ELUALSaCXDEZ59IJ8i7KAW/PPnqlCHjSaEooX4b7jRt6bISP33TMZOz4eO+rP7jWlBVU1e0SqxH5Golc5MK/dsz6dVP5SKBLte5eISK9IimeZAQUkx3Qi4t14ze+aVwUEqtY0OKxMGkYb+3RjbcUNeVvUbjlv08Y+8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904147; c=relaxed/simple;
	bh=Qs1/0G5a2QtiIWqGSj39G5CS8yHyLa9WzEUJQKJ7neY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u2eQisxn2vHk39XsF1sbommk3Nuz1fA7deDbxeLCNNC+1ZT9RX718tCDSwngtPXMIkoKVvzx4ziRNfcHJZf0/o3a1kONMS+YGSoQvON7vklx8wd3IvH8wQwBte8mBS+76JjxaKxB6byOReZTBB/GxtGvfqxTONuU4cEJI+l8sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBGijMcu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBGijMcu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afcf96affaso213317885a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 04:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728904144; x=1729508944; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lTb7/wYnRN7Q/Phll3Ghr2brUzD84gmcMJG2LyC+bI0=;
        b=ZBGijMcuyYYtrRxDudBj/5Vzeuxl+UOv+kuDwxJV2TFzEBIZtmKaa80hzm+M0MJuaE
         CTAj0wBaup/AvrY85idf2QonlskkF9oL0W5OUHj/Z5Ha44uznYLZU+aQlN9J8mFqS4B8
         RvxzDu6RXheFFd4ayOcj0lhE2XUZwAeJLHUrYrWtCUh1lrzZQootIEZHBsx3juw0Nooo
         8LXIII+pPCRAAY7gLcfIPIDFB4zwcAA7vTBkqoYJIbTqTHqeEHLnQQD+2dLuyu4Vvrgp
         dfti2qHxpaJulWnQl3a9gLcIi6wbbeJytYdgHk1CjoKhK0u2CvYRfeCAIJ728RWzT0GS
         KQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904144; x=1729508944;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTb7/wYnRN7Q/Phll3Ghr2brUzD84gmcMJG2LyC+bI0=;
        b=OCVffOPppu5MRAju2Cn0VI71Dmm4oc8oaXcv/lW9z2VT4KQ+1a5T4XmQPhxtpGWn+S
         wIqicHpynIHZfa4jMs4Urh7/Z2rP6AZ58XWUry0fMDB2MocEsQbf9qsSw3M1pWcA2DIH
         1SqK6zDGMju+4DvMKtBdHs9erGU7g0fS7vUu+gHj0SYP+GFiXeOLQttSDaq316G+oc2F
         anFNRz2syDvE5KYKxN3mph1QJqoneLqTdepldvESeX/YpeJt7z/O8N5KknVOja9fUNxB
         H4Ae+Z6jzTzofeSOh1Mew0wg1Lhh7ZCnorglvqfUfLWrNON8aPtyqTzyH/UVPJGWZM5v
         /u+g==
X-Gm-Message-State: AOJu0Yzclf+R1UXBcpJsnjset3kmnvXbLl6RGOj9vQqdwOaoDjudGRhT
	AeISTCf8b2HOQZQzRgWrUhCcmkIeHQli0YMQWx6iDOBLDg1vG/18DUaTBg==
X-Google-Smtp-Source: AGHT+IE8oTW/lZCyK3C1x8FKKx3msJO4RfeCtIP/bgdhzYeHK5zK8D4BUbtu0XE6OXRZ4g0AQP8teQ==
X-Received: by 2002:a05:6214:3901:b0:6cb:ba3c:80f0 with SMTP id 6a1803df08f44-6cbeff7e388mr188402556d6.5.1728904144363;
        Mon, 14 Oct 2024 04:09:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.77.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85d857bsm43572676d6.66.2024.10.14.04.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:09:03 -0700 (PDT)
Message-ID: <670cfbcf.050a0220.18e738.ce82@mx.google.com>
Date: Mon, 14 Oct 2024 04:09:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5242459401869946083=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tot0roprog@gmail.com
Subject: RE: mesh: Fix segmentation behavior of Lower transport layer
In-Reply-To: <670cce2d.050a0220.14053.42b2@mx.google.com>
References: <670cce2d.050a0220.14053.42b2@mx.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5242459401869946083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=898733

---Test result---

Test Summary:
CheckPatch                    PASS      2.12 seconds
GitLint                       FAIL      1.27 seconds
BuildEll                      PASS      24.90 seconds
BluezMake                     PASS      1680.91 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      182.16 seconds
CheckValgrind                 PASS      256.27 seconds
CheckSmatch                   PASS      361.24 seconds
bluezmakeextell               PASS      122.15 seconds
IncrementalBuild              PASS      6303.61 seconds
ScanBuild                     PASS      1060.98 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,1/4] mesh: Implement lower transport layer for segmentation and reassembly

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[BlueZ,v3,1/4] mesh: Implement lower transport layer for segmentation and reassembly"


---
Regards,
Linux Bluetooth


--===============5242459401869946083==--
