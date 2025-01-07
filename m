Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB42C187
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277464; cv=none; b=ZDmZZBw/NGwhTbJ18l7lO5AQwt6YFsXMxHDiFFadqwoAWc8igoU6t3DzqNsxBXQENriAzk2X+imupmdorz1c7eTeeu9DADHIU9aKV8RrwSTebLkjvbxaGfQHSJCyE085YIP0SHuQ5Zb2981UIQfSHNOHar6pQoyKExuXicqde/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277464; c=relaxed/simple;
	bh=urAGsWhw1TFtdRJHJLb155KbO3AyZWFvLHsfDCMgEW8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ezIODApP6avnDf/mlWpDfB7U1j3Av3qz4XXvJZ6HSM4Efzv2oy816rND5F3wLTu8EyIaOlZ7NpWWtac/XydL61lV/M44LZw0qFi5phGHFMaTScIqCbjFiWAyZrJb/IQvQSufTR78fLVIsMI+HjF8TT7Ndhq25TP6yWYTDe2yWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5nlgvMP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5nlgvMP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b1f05caso230454575ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 11:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736277461; x=1736882261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DGt9xoieYCG34w45yVOogEfWzlG/XhJXYkRn/n7I3oI=;
        b=G5nlgvMPCraoF2zltCrfDm/fD1Qxh3NOoTrNLpTJjygWAL/ftgJ1gNle2ElLJr5ODi
         XZOoBijjzh2JLnxb6tWaaqHnQHYdVb7oNZXX3UQfVmF3YMWm8r6lk0oPmzUZYY0PFmIe
         V2LbPGl4UNfZPbE/YEfIk3Xa04WHk0d9bIDXhT+rZGlm/WaTQ+DEraq4xMeOJrGlEbp+
         wzpofPoPHOWVYjZJwI3nqoeeaoYXKWcmB2wwVaGyZDdFgZ70JXRt7A1qHM4OvAEf3EIw
         z72rsasKVT6el/G357yTgSNRhGe4PtYcbWFomO1DLJHV6fCud6Hg9yIWr4ZCFPSjmfUI
         FyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736277461; x=1736882261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGt9xoieYCG34w45yVOogEfWzlG/XhJXYkRn/n7I3oI=;
        b=gHWs5ISLscGLbOwXJmDgyzdVXLTbSX2AHmYYjOQELNsB/zv5H7pMvVp6T0/84NfJx8
         VbWcgYHn/OQB+07j4ZCKPU1wJ0dJOCy9aOgP1dtgfno8bJgdq30/Rrgx6tKbF78gX+FP
         PSHz4t4XcN5ImRlv+wbYvJ2e1xJIQJngm0kLyIe3tdnWGB4TiN3jA1i7rE3WlZh2qhiE
         L/9Jz4kCXBIBJXSaKmsWE1dl50FqKQ8KuKGkFjvZuEKRDtiCcE/e1EuKmDOWKrD1/Uy/
         yuRg+Jk2iBXFS5uhBpkOdCLofTElqk5eMzz15mMaFg5KA/gnTXtOwCfWvtwy6tv+LOR2
         vaHg==
X-Gm-Message-State: AOJu0YzTEgOX4iJucbnPZ5Zfsrx8TJ/dgeQOXNB2skEGm92b1DfIhrvh
	3iaN6Vh/OrYafqWs1XP9NuYZ+wngYTNcm4VZP6LBj0aFiwbrhC/3FtQm7A==
X-Gm-Gg: ASbGncs2OXP2NreG1vDDQ6xs0gad0/RxYZS0vWXJziets+uQ/zrh74h4LSRQUeHi0W+
	X/0XVns8YbzEC45eg72BiCoMN/McOotWO4sruYt4XH9ip4XNB+kre+Hw9TUcB14vvKV+St42eVV
	kLfpsh6gve5TwT6D1UKj2ZiViehvFKvA38nX0yCeqwgAXsprvMR8BMj5deRgsnsrV7A/0BQ0V65
	IeSYFM8HiSHu/OPELFWNSi86hrzoFvG/n/7fCAwb8EXJjkpkT4Wg+JyJqDZaQ==
X-Google-Smtp-Source: AGHT+IEbvlFPBL7zHUhMMRWEr8gQyMKXmL/1Goa/D+K3CRk/CCVPYdpBVW0pk4PDlj2ZEGlGslriqQ==
X-Received: by 2002:a17:902:db0e:b0:215:603e:214a with SMTP id d9443c01a7336-21a83f4b0d8mr3086795ad.1.1736277460981;
        Tue, 07 Jan 2025 11:17:40 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96312asm314194705ad.21.2025.01.07.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 11:17:40 -0800 (PST)
Message-ID: <677d7dd4.170a0220.149316.1f3f@mx.google.com>
Date: Tue, 07 Jan 2025 11:17:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1773531535779650289=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Make BTSNOOP_PRIORITY_DEBUG the default
In-Reply-To: <20250107173542.1449444-1-luiz.dentz@gmail.com>
References: <20250107173542.1449444-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1773531535779650289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923084

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.89 seconds
BluezMake                     PASS      1636.85 seconds
MakeCheck                     PASS      12.99 seconds
MakeDistcheck                 PASS      162.06 seconds
CheckValgrind                 PASS      215.91 seconds
CheckSmatch                   WARNING   274.43 seconds
bluezmakeextell               PASS      99.80 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      860.51 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1773531535779650289==--
