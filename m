Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2163364046
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071728; cv=none; b=LC+7CnJgvtrcq/caCqzbP+H14r8VCdqUUyfHLniACcH1rhICWHyVNgZItxX5n2Sl6xUcZoKDLPLP5WnAqRLGtjQJKfj8SLtzPXtH/HIE7FbiDK5w+S/GpPem9kK7/mqXx3fcJ10yQ/Y567CYCaDL32fGZMS/OebgmFQ/uqhGdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071728; c=relaxed/simple;
	bh=w1OieG+B7Ha0alaTHX20g/0oGy0dTetodfJ1jm+sIH8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o5wjyyCf7Mr6i8PwxeHNA43TC1jB3uSkmAvZrTcETuGokatCwezJNsOjXWfvKkHkPjGjI8/q5jF0BUsPyCe9H3lBd+SVR4IwyE0pmBv0vWl+CzjmHL3jNt/Gg4kt3KEkE+0ZnaXpOczLPF7YTQ4XXNF0Sw/z0cGgS6Cb8/K21RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTNS+6pQ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTNS+6pQ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47018d34159so2959137b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776071725; x=1776676525; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L9SB5VHeWjVFqj6uNU0/1YRF9TqRIziB9xVBs9FwI3Y=;
        b=PTNS+6pQEiSIUTBFlQ7TbQNtzqT5YvZEkXCiwUwHX5+Fm9H2rYGslUJ9akI1DuW9or
         V7grk66JRau5KYFfG10jf9NcPP/OSnHVY7XCjgBtQgtmkPSctRVOVSPOTZWhHe6hqrXq
         0/5MLT7DL4FeiG9lzmLlKqEVIVgcS3zlfBcaFXnOiEuoFHrAJSqophjvJxIYPEdGeJYm
         Gy2k44CMmmGGKfmmZ0ex98+v6Uebj6dwTR/cHBNoaUX+QF+JfOSY0qgYNZGNFJB9Uy4D
         fiLjg5VqRxHA3vdW8c2y+G/tpOY7KmK1ZBK3VsanPgQLNmspE7Fi+ytwbAdHJ1faj64g
         kVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071725; x=1776676525;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9SB5VHeWjVFqj6uNU0/1YRF9TqRIziB9xVBs9FwI3Y=;
        b=FgSe8tUKOXqXH04nI7n+1KlZAEiAf/bwJpvJ8lH8ZWnui/wIipOfVnyK8OSBN9Y+NH
         UmU8EDaoOXNUJ5SU5dUqXaICgpzLdLARRb8wqAi0s6x+AqSuegDwNva4VwpoKlir4TSA
         RxgBePgmh02J25kf3zyn0yaoB3PDwGn7ESJQdG3ZrD/jjCNFGmOxQAiNlvhU796otcrY
         gq1vacSDvBOQ87VqZ+v5uDHF15COkWJyLx33XT8tY7CT3DuO4plRh/ZH5Jt1f2Jj3UkD
         +UAs9TGHYjIhzhUKig6R5lFPur5aTEmUnRSfaKcbvEj0gTm4WiIKF1iZwMoGN4LKeiYQ
         YKGQ==
X-Gm-Message-State: AOJu0YwSV3/J6rIrsSsW5yBQFPy0dpI0CCiv7i9b9DnNyLtxNaiPOmXy
	FeiPLgX6Olu0U6thvZsR4Gbhjey8j++ohmx+gNQ4JclIrXRoMy0pqiJYrVnaVA==
X-Gm-Gg: AeBDietVl9AqBHRXaxpnS1sx5Vn0rGbJMUyRlDcCp3cp2W7/kVAZozjo38iHwYvjT/G
	1MK3B9tur+ixRMKxOEdLsIe0A6HcymAUSJPsl0TnaMHeYaCuUaS5PM5kLgxr6EInC67zxAdC/zA
	B/IGTQhMMH/6bzA2wt2f24fyWqy5kFUWTaGsG57/oIALQv7vhk7+iD8BtxRcVZukn6SFKgtZ/lB
	3ovICAafybn3nWDMYGjrlRTfmRpuSfRo/ipowML82nnPCHVVC+LRoDBE10Zlu6nzPkW/8Xr/QuF
	hr0NrxKbSrmCPCLs07kl/R/11vfaNgshodwznghT0x6SPGWCx5A1eOX7Kfal6w4VjoV/m03tN6K
	CML7lUwz1bEr23gK6oBF63UAwIatRQ2p0DKrKReX2SlNNBz+d9h0mMcrsxKeV4FneQMoWJFtynq
	JZOPEi/YUggX9enJ1ZR1UkI8lyYmIbCbRhw1VBGLH3jw==
X-Received: by 2002:a05:6808:1985:b0:467:100d:22ba with SMTP id 5614622812f47-4789d2487cfmr7090595b6e.18.1776071725348;
        Mon, 13 Apr 2026 02:15:25 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.82.136])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479378de687sm3626931b6e.9.2026.04.13.02.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:15:24 -0700 (PDT)
Message-ID: <69dcb42c.050a0220.184254.95b4@mx.google.com>
Date: Mon, 13 Apr 2026 02:15:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2932467279739684882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] audio/player: Ensure metadata string is valid UTF-8
In-Reply-To: <20260413071246.19221-1-frederic.danis@collabora.com>
References: <20260413071246.19221-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2932467279739684882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080516

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.64 seconds
BluezMake                     PASS      637.53 seconds
MakeCheck                     PASS      18.61 seconds
MakeDistcheck                 PASS      244.94 seconds
CheckValgrind                 PASS      292.36 seconds
CheckSmatch                   PASS      347.80 seconds
bluezmakeextell               PASS      182.56 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      1029.92 seconds

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



https://github.com/bluez/bluez/pull/2030

---
Regards,
Linux Bluetooth


--===============2932467279739684882==--
