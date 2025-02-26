Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3F2459C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564878; cv=none; b=WlL+U+XCp8JBTspEPR0CXGxw4vre13clu9/dFzNjEEqqTvUIAHXynZ8Zwiiycdl9gUmWG7H+IorIgMswMS7egCnzI1tRLXNIghCK9aM8Qljqd46v9w7eGVXqMgqu/iv7sAWDs8kilXZdqhdmovyvY66Kokqt/8WG9K2gjyeYw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564878; c=relaxed/simple;
	bh=j15Q3KwbngqN5lMXVmjJ1D/aRz5vDP9bkQc7c3L+Jmo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mobyneMGX1rrMl73CXOebPjOYOZNz1D4S6db7fYhWoMimojZ/kgykqhyRiISLnYLOwSQZfrlzGYIimxenASEITBc1btgOgxDT5bKRQdb107j2IfVv2KIfy3y844uU+JQgrDO03UbFd0HnPlen2P8IXYSzOaTwik9jco8nsCQHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyOy/LQx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyOy/LQx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d601886fso100510095ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740564875; x=1741169675; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WEbD+lyiuTwkI5l3skiSgvZ5MAWH4d/Qtv+2RPDkU/k=;
        b=DyOy/LQxjGwYZpVG3MdLGc3Z+MmtXqrxeVNDTnv+yB67+8kE8LXSY9koXiPuG3EcD6
         TqvSFC8tOHYAxucgjGTcuMD+im+CMDA3AqzntNKdfiR/0TE9nYhMIqAXK5VngoVDcr+H
         OJHF8uucwivFSZd2K6P7QhNPQE8Hcu4EAzW0GnlqMZ6hZF8ipqnrAdnxl5YPg+LuILXO
         RJ4loAutSgsmw/vfNBxuSVE8Tjy8SfhWt6GHQkEJy+07EC8LfA7JuarkAL7NF3DEOk1A
         UNKcp1cfP0b27MuYV7J5D/qNYnXBpFii9s4TJfOPTpFX/KuvJS9GZS3Ta9dp7ll8qOy1
         /1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740564875; x=1741169675;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEbD+lyiuTwkI5l3skiSgvZ5MAWH4d/Qtv+2RPDkU/k=;
        b=IMyfLnaS64DsoWlLRYCJFT47g1j4xGjC5CtRoHDtLkeVZGtZDK4PS1DRObKLMxvcy2
         TO96j1Pp8Fthw8az5A7IW3nqzEa79Gj6Jt22LwefTw+2I/QN0Fbu3qsMe1VQcFKcaTSQ
         4oBBfo/NVdR6CJ9e9jLQXQw8bnCbd52ZjefJN30aOipMJaoBWaf3mj2ZHlzlr7Nr9YX7
         hMnJNM+z1nF8MXPftC+bcP0ApwL7zuLXAkPtSH6nAE0wBbfUgMCfa2Gg3Bmw12wxaBwS
         oSqKgrTYK1f3wzRugarUuFCbN7g8sPw9vBXbknRrV8zQVacvJ504jnjzaIiImi7wLMH8
         A0Bw==
X-Gm-Message-State: AOJu0YyqlUQbTv4Aup8TWg3MjLmxeiURmVhN95E/lttuyVZhrow7VdbK
	3cwxcrFtRMRYJWbQkhpigAMXbgnfvEzMdoEiS7yfToBVspddzZsrL1ZRzQ==
X-Gm-Gg: ASbGnctdCXgTzlK07SUQy8/9wd8cGtseNL2Lg0INva0Aux0soK7c1v1tcLQ7u7REg6n
	PEatzs2plp8LVA4RJz74J9DF7GaHglpcsHra9w48AfEJabe2f6DjKMjRoxg1x9HnfisWXUpmx05
	jrkoky6FuP0lgRCN3PMuPnX51yMWZdBMZ0+VObLy3Qyih/ijQhosnIcEF/YysfpM8QpFwBC4jpB
	7XDn9WRcB755wXoy0UN1I9KgKyjhPkJ12xxvxEYCWQpyUocbdn+4c+BqYESWYtPq1eaTm5XDgRY
	l6kFrQDfuSSGk7MbBji9vTSgJCyCrayYX7PiDG2jL8twiKGHsw==
X-Google-Smtp-Source: AGHT+IECGn9102Ktl4Ce0Bj18Bs8G+70buIhKbjWbOxOEc9C9FFxYxs7qRbnZR3dcALC/BSD0z4MvA==
X-Received: by 2002:aa7:888e:0:b0:732:5a8f:f51b with SMTP id d2e1a72fcca58-734790c6cc2mr12464171b3a.8.1740564875409;
        Wed, 26 Feb 2025 02:14:35 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81e976sm3004924b3a.150.2025.02.26.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:14:34 -0800 (PST)
Message-ID: <67bee98a.050a0220.180308.6d53@mx.google.com>
Date: Wed, 26 Feb 2025 02:14:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8463660822746777100=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+ye.he.amlogic.com@kernel.org
Subject: RE: [bluez,v3] adapter: Prepend the new added device to the adapter devices list
In-Reply-To: <20250226-leaudio-no-media-v3-1-8f4f93d8a41c@amlogic.com>
References: <20250226-leaudio-no-media-v3-1-8f4f93d8a41c@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8463660822746777100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937918

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      21.89 seconds
BluezMake                     PASS      1575.97 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      169.10 seconds
CheckValgrind                 PASS      220.23 seconds
CheckSmatch                   PASS      291.90 seconds
bluezmakeextell               PASS      101.46 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      916.39 seconds

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


--===============8463660822746777100==--
