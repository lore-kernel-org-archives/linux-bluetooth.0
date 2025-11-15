Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B69296BD3
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215392; cv=none; b=j44iFhu4MRwVpNnpYIQq7kcixDC8/hnf+bsGZwh6x8HgB3nAt2w3NkMHWJTOthq9cW5h5r7BlY7mO7ZX3bnzy5W9uS9nWDPXZuzvTfNaeZHZGR//XQ/yIFASpIV6N4WfU4fzteRnGCCzg/lb21jMkUEhsbKBdv6OBKcFY9XHeeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215392; c=relaxed/simple;
	bh=KPMls7cdnzP/WVFcKOzt29ZWLJXUmcVeVpnAzqn1G9w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=owYgVPBb+dOk0x34cyCazJna7+8JG92WHgRLoDFQjVPnlo6RipxCJpBeXDYIkQv6HnzLyjbh/6xs2pymNjtU1L6aJ3z7+y2TvmUGuVFkgAsyfwZQ97PTUsP6H+A8upiu4eBzcGKoxb82cOoprW9SCPfukkzmgSq79E+Kt6ti6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2B/g7Fz; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2B/g7Fz"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4330e912c51so13043865ab.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763215389; x=1763820189; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+w1hw3J1Y+djwMMpv7+g8Zp4G6CHwGldCzf+7lxzM9E=;
        b=F2B/g7FzjrfM1hQB/1rWkzR47fQ1CpL5Y1VzdVJmyRCBQiyt/aLWQZVjlVEkrnp/vz
         753PJ1VBtH810tk6/638ypn+fEf6oUZC863bKO14eOK7ZGmNOrOypiIIWNiinOrNEQzK
         OE9PBxtAhmuMWIql84C9fY05kpOREiKZc52GfJ7lDg8ISQ1XGmukgdc0Ue+lrQrT5xJM
         ZVSLmZfjFuicrbpcollI+2nzXDszyzdek0iF6RVE3vmIR8mFoBaszmUJEimERGEkWcpe
         Lm84AAY5zU+/sFHvqkoXM3sarbzyI41TVFNetwm5sPppp6Jf8wHHAu/L8i3sM/uv0rPZ
         vC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763215389; x=1763820189;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+w1hw3J1Y+djwMMpv7+g8Zp4G6CHwGldCzf+7lxzM9E=;
        b=TJipgFpuTMIyCFt8hefPPjzbampnx3ZoPSAYXjmZmZqWrfCaU/oTDcqxvnlVnORM0/
         7j8TJGkIowclRNfhG0TtnOu10ZrekGtiCghv6SrrD92lAJQCUXSFKE3cGd+CaxJ18PLe
         6kNCu3wl5xyn3hShpNi4bT9Gyq53WZzfiMKkHVJd57Ifbpcet7Wll6QcF8LMRIBBiuL8
         FPRxOaNlAkg0hAGiGZEfB7KUmZt6UwRel7u+Wgs4oUXrZUHpvWageOilZ7UjBWsN6YxF
         Uqo6E5gISXup0sv2Eh/8V6bwFu+dVQHYYrLSYR7ieS2c8zo03Vt/GHBYv0F+JImtDtqv
         VBsw==
X-Gm-Message-State: AOJu0YwJpb69uWrKq1E2kBsr8el8SQBY4vFiGnrMaPIdQAEQtgSdXaGp
	02lDDalbzWTBVgF7VgcH81rY4ynypPk6z4eX/HtumGhSFPNSw0V5pYaYaHqRig==
X-Gm-Gg: ASbGncvQVtDxzTFjomFmBCEtpoudXwHqb16f0aU51jYvSz6q/Hdxd5HLYsmvkgU0W4l
	TLzWcPyqA/qmGHq+hHMYeKBpUEMON8zWOw3p89JP6pjpY7RnZwCc7tj2mFa3Wxd9TEqcFFP8ilB
	kSKrYLq4uOs/L2TvX1mKxqT8242zu5t+D2Ue1GhbbyGiOGQ0JbmyU//1xxV6manGg2E29CiFeST
	AynvyG/MFXCaoj5Jz+VQgvX/W5mLQe+Pxu6nu8044muEQhM6poo3gF29TwgBba9pTH74zQVn6/i
	2mTVnP2h1B3447oZKIsvE6YC2CdG3oV8TZohsK77CrjtKPihZmF6UH4EeTnk8VD9WGBLIj4V4Kp
	bsEO7IZXtALiJ9zfGMJS2d97ohwC1Bb5JzqkkzrnTghC5NaibPxFeDHttKKdGBZYDTbgn4hsJpr
	LtrCW0REbvQ2lRrzC22hgsOyT1pAn+
X-Google-Smtp-Source: AGHT+IH8XiCJgvVu+mJuYAcxMsTggFS606GLkYtzivJfVURfV7oIFiW9AmgiiLY+xaq2DJ4n3jeelg==
X-Received: by 2002:a92:c26c:0:b0:433:7896:3e51 with SMTP id e9e14a558f8ab-4348c878e29mr103077805ab.2.1763215389368;
        Sat, 15 Nov 2025 06:03:09 -0800 (PST)
Received: from [172.17.0.2] ([135.232.201.64])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833e920dsm42010825ab.12.2025.11.15.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 06:03:08 -0800 (PST)
Message-ID: <6918881c.920a0220.15a1c6.8311@mx.google.com>
Date: Sat, 15 Nov 2025 06:03:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5192296850599287238=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v4,1/6] shared/bap: fix channel allocation logic in bt_bap_select()
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5192296850599287238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023839

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      637.47 seconds
MakeCheck                     PASS      21.92 seconds
MakeDistcheck                 PASS      238.39 seconds
CheckValgrind                 PASS      295.57 seconds
CheckSmatch                   WARNING   344.68 seconds
bluezmakeextell               PASS      181.02 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      985.35 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5192296850599287238==--
