Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FB5103F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580620; cv=none; b=IfbDe2p+qhxNJX6DeLNwHN4kZwjXH2VvFHxpG3uxZWSe9vwljtseQhtbWZxmLeJJPoEcJwe5NrdypXc8W1/xYZhjzWM8V08cEwhjhHFOVQb1Ju0w8nVwG8gUxrjymW0SK0QEL9DHR9O9aKBdl+rRilqS//yVDG8AS4YXx+wVrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580620; c=relaxed/simple;
	bh=D0L56I9CO+0AmJOlKRbV7LwWM17ag8HheAl7CZNQdGI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DhJiKC35yVeto/GpXaIxczflO1k+AQW0tA3igxzfFzOY7wEqEbTfjeKOYWAu9g8ijNsApp/3QUKsYvp71+8m6Jr9P72Iowvi8EIEh/1nej/lh5MahvOODvlIhwmpNOSsFuZqOm5YroTiFexx4IvhmkmBCbzKOSkTp8dbaU2jEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXpRrOw5; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXpRrOw5"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86d1131551eso198213139f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752580617; x=1753185417; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HKwJZ0V5AoZdnzSbcPNwdLe+aSgPXFvwJNx8FMRf4HQ=;
        b=QXpRrOw5rKLygKbPioFV48E0m4bmdq8qCgpXV1J5nprm+Zv3l95BlyS3p7l5vTWe3i
         2MDuBJCl4zjJz9bQ2FySRuqtSE4u1LOOuAmE3Xr33mCJE6M8UkNGhPXJ2u4NYpaPiSoc
         8g6icsky46he/cyPZXHfvTn2A0HpPa3XFWUQKqJHR4tmCztjI8IKLIihfpBb2ACTIp5m
         S1tnM0ceGUtAwny3Cl0++qREKUoNrchWN6uksAJ3jea9hxColoq2qWjg+cWrjmEqcHMx
         2R76w9MbAH95u9WEsPIWXvm7DXrsyBt0qQ+BY7r4FBaxuIV7SL6NvWmsr59XrWGuRhtF
         inMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580617; x=1753185417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKwJZ0V5AoZdnzSbcPNwdLe+aSgPXFvwJNx8FMRf4HQ=;
        b=EpGRRKpWaaMZMm2yB4TS2+4zBbtrlHKrAMliYeIhn1WHHrVl0QivJfpVlpcsjqxUaI
         HHDpJlxPDMZDGAN1Qc0ZovK6LXaXEwpWAOhy0lQ+na7yqzpa694Ac2yCrZuoFaEkSbYU
         kh9ElZY+5qfaec/rAJV3W9QWqh/SEzuod/QVN/yYLPZUHoxGWMhaTU1jYcdvs1I/KPOS
         7ZN/cQIro/oGxiE/skxk77eRP9Vc6SXFvoPQ4H1o8ZLlFOqnsoVgwynccgyzus6eakZm
         oIy+JQUEK364CzCU7HpecU+bHq1bKB3BFlb5HASiasbzFxoiHBqjW0Hg189CHGN/twkD
         VohQ==
X-Gm-Message-State: AOJu0Yxu8yJez/0T9xSdWLG6JSLMZO7ZW/f7+/zjihZXE4qiOA68jF7P
	Pw6M4FkIWA8bR+HbS1qAcVtxfoMxqRg7bw1g6OdG0znL9YsOYIQiSGOtkwAGKA==
X-Gm-Gg: ASbGncuU6HxCEuejZ4/OyU7CrxQdEdcTQ8CNTYKw2et9pt2oakxhBL6ruSJABXQx2pz
	JWIc9XdUnxyTOWnLNzBABpwwMVooXjPvpmwXMQSex915W/B0MIlZxZvC51SFi/D55QOFcX6U6IW
	m4I4yYUIfPMC1MXEd8U92x6NAHql21GIfI4KimXWE2GhpKXzLQ+W1fCdWjE1aWdlTKFDaTUYO96
	mfpM+6/Qmfw2nN5XX/Waw+zQ2M92p+dkSH7jpLJ204P7csmsGoSXyCTwt1AYltUCsVOR92yIzX+
	c11EGLwqmst3FiYLBWw+EPxQUht25AFbhp0XfCvBKH352NjIqsaqBm80+7Ltknj056JbsrhSJK2
	GYoougg8ZI4kKhEc2YP0zf0XU2IWiCg==
X-Google-Smtp-Source: AGHT+IHWg44Qu1oxNzd9H56jqKADprt1CSf4syNPd7f8mvRD8mVGdnxImWSo7DYZxCnMomTdbryPiw==
X-Received: by 2002:a05:6602:6d15:b0:86c:f0d9:553 with SMTP id ca18e2360f4ac-87977f74cc2mr1821986939f.5.1752580617381;
        Tue, 15 Jul 2025 04:56:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.178.210])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556973063sm2517371173.72.2025.07.15.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:56:56 -0700 (PDT)
Message-ID: <68764208.050a0220.284035.384b@mx.google.com>
Date: Tue, 15 Jul 2025 04:56:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6722039473625891146=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] doc: explain SCO BT_SK_PKT_STATUS socket option
In-Reply-To: <bcaacbd8544b62688da6e401c354e1bb41e62e3e.1752575647.git.pav@iki.fi>
References: <bcaacbd8544b62688da6e401c354e1bb41e62e3e.1752575647.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6722039473625891146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982465

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2502.10 seconds
MakeCheck                     PASS      20.03 seconds
MakeDistcheck                 PASS      182.97 seconds
CheckValgrind                 PASS      234.59 seconds
CheckSmatch                   PASS      303.93 seconds
bluezmakeextell               PASS      127.88 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      918.81 seconds

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


--===============6722039473625891146==--
