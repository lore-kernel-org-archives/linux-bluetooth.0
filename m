Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC482D98
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741989; cv=none; b=DWpKojIdmtPRqA0RfRAP0byGWeKUm85sQTpn5OTzZufxqhw9E/zz+OzGIibrpamVHhFW4kdEFpAPkCNltmefUbeGzicWF2Xp7ZpwaU1qhV+c91fSLHJeXMuaqMQQXS28fHRtkSUSsD2RmDYRrW1XY484vPqgwO+rnn/jwVUwtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741989; c=relaxed/simple;
	bh=hNWxt9BWPuQpt1XvJtNlsra932XvgK/Zr3Z2OrLQo28=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qBjdGYbQwxtWDxTT/xhhWFiQwpyg6Vlq1xzAm2Ws/Ub0dlYO0ltUirW7AFn9hlbZ20IfBxUDLf+yje70oDBGTB5gDOVAIh94wENX70LLMafid0CHC/fNPBqUWCusKhuiYfWSYG8dFWjC+9kC3ORtxTsmeSfuKj44J7eH2NghLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OItHNSmL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OItHNSmL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2156e078563so34931715ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 10:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737741987; x=1738346787; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kyQjH34zQjno503RsCUxfi/U+T3DlMV3R22vSdCe3SQ=;
        b=OItHNSmLfY6HZCZV2IPtm3l/mk7kAd6TtecRK1CVz2rx+oHs+apC0pT7czzDLiUTfq
         tuJevQpxF68ohzOncs2Rl/P6eWMGdDY8cTKgrNogjZ+PT9s88tk6Pg9y24SYjVx/W0cc
         FO1hnoNsXpkcrcXQgrt08gu1RvDLRh4lB2VX1Wx9iZ3H0btmDKjiJh3UuJT5RdB9vERM
         iP8NQmwLgi5mpGU4YgN4RdGVpB8qqPeqAayRVOQ/8ZIlLkVINyCpNLh5ReeykiMJ5Tnq
         TfcCFszFeJMfgBjrx53gGik7Ko5iaks14tN/2u8yiPPYV4EIXFpTcSS3bLkoAXWMDeQM
         slDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737741987; x=1738346787;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyQjH34zQjno503RsCUxfi/U+T3DlMV3R22vSdCe3SQ=;
        b=TDVjqIZNkp/l4y/0vQHA2KuNUe1Mt2f/NMlymW1aOyMIfXcSDzGqu90LTo52uplzI6
         /pxWWPL2d2KVmDLvjpRrVigwGFDwe+bEtqdkCR/jjW8XjDgMEWPltbZTiqs+poAfg81S
         5oB35s+wkcOBtgAF4f3+vuF22lQXl8wJLdBxRA/4x3XsduRSpAWjopu8eTOYVtm5tOFX
         wLiT1uZij5aUwuSdz+ZWJcEqSwbQLs3TnxAZ33lzWXbxa//tzZI++sXJf9pm7ZiyVmXe
         fNYmUV6f0ib1lXn8Fa59uCpDBKyKfYs2OsSSdwmpVYf4al+OIFbhatFHYYVNAbKXBhoC
         icug==
X-Gm-Message-State: AOJu0YxVZD40rYTNrDDAT8SM4ozPTn6KvGE3zllRr/O5Dgeq4L6JCLuq
	1bIyfJmGZ1KPrfJMORBbg1tjdqc31pIJCiW73PufraG/OZ/a7+WEEGQIJg==
X-Gm-Gg: ASbGnct+vi806CV8E0rXteiwxFx496ul3tibGn/mK8H5QbG3CKNbMFENtdLRaLvcZmi
	WBmfMW9POGhL57TUGlX1ycSIqe9ZZ6j5HaNKTLppp9kwxYnweNDxunot9r7xI/n2Dz6fYhiVKUJ
	alcUs3ZLFWiW9pA0V7wuwkAUIAHqeabd+eBRTTTb56oiwLW7RnIACGqAy55URyTtmm3mBIBoe7i
	6Gzm6D5aePyMKO4XFUlCnXsktJmR0oKh4G5nP5AFx552nK9mu0OSBsX/3Z/1R5RC2pax/KMh9Vc
	dUG+1UUH
X-Google-Smtp-Source: AGHT+IGrt2EPD1vo2UxHZCmnl6yoQIbvGZ/YM/OeDCpmZqksHqy+pFcwS3+KuM3HLzPfQN0FSzx9RA==
X-Received: by 2002:a05:6a00:240b:b0:728:b601:86df with SMTP id d2e1a72fcca58-72daf953cf5mr40459133b3a.10.1737741986667;
        Fri, 24 Jan 2025 10:06:26 -0800 (PST)
Received: from [172.17.0.2] ([20.172.7.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a761172sm2169976b3a.110.2025.01.24.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 10:06:26 -0800 (PST)
Message-ID: <6793d6a2.050a0220.25cf3f.022c@mx.google.com>
Date: Fri, 24 Jan 2025 10:06:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5874018487765154228=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] mpris-proxy: Add mpris:artUrl support
In-Reply-To: <20250124164611.1175429-1-frederic.danis@collabora.com>
References: <20250124164611.1175429-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5874018487765154228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928196

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      1454.28 seconds
MakeCheck                     PASS      13.11 seconds
MakeDistcheck                 PASS      159.40 seconds
CheckValgrind                 PASS      215.86 seconds
CheckSmatch                   PASS      271.86 seconds
bluezmakeextell               PASS      98.20 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      861.03 seconds

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


--===============5874018487765154228==--
