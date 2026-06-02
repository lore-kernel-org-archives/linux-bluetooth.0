Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB122D7B9
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438602; cv=none; b=nUY4r8U/x6jDwDaWM0nJhoYq0EDX7DMgSg2b8y8Mh/PejQtCalTnZ0g4pMvi96m1sRrNW2LjNJOApqMoOwspW2zEeTR4P+tK/Kii7tzZl3GjnsmbcamifFuBw4DTTs/R+c3ovEEcnULzkvbRwHJDIGPT9Avql1SAYtboEK3DXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438602; c=relaxed/simple;
	bh=iBYPpIg8PM4ME6JqkwRMihlnNwVyFxNg1HCG75nZcL4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E3AWQyG96j0uZXtSm8lsmce7PJbIV/sWXE3VWaK0tEfIts9QkRt1W5ftDK9LWn3WpSkDgzQrKGjWlr7mb0IXHPswkUjIRAxaXQKCiERRA/YGChy8UiCmZbLUDu/3LWHZtGcyCgnCSdZbHQw+IgnGIXum5THOSy7p/HuTgkao+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJtCw+1p; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJtCw+1p"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9155183b42cso8734885a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 15:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780438600; x=1781043400; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeD8qBVBnk/V6UYnTAL4vEQaNYFOaOWzZWwvTb5A1Ak=;
        b=XJtCw+1p80D/SB2vORQ/h1fgmlsYJi1xm+RU8op7ZrFyQO1IgWfrDoiN9IgA+J8cyB
         g9LZv9/EwT5Fuv5ph7ubZyaq8N5S+miSuLEH5pReWRlkpnIQuFz07aSci1GpmqlBEftR
         PM0o764QqXt+zPh1ILUW6So5yZklmoWlUk5x+ZQnX13hMqyhj06aPiWTW5DFIeGOz5aX
         AVXfAPUQ4OIh9zOqmmjgV9RJQDFuRReFxaSXVIYFV2mWJdWSPex81FGxvnJJ+SE5Vyg7
         xyV0nIGCbYEzK6kcVOWpraKZA9P6kNiip1AJ3/5If6Nfda7VPjowMwBWq7z7LvCgkkaS
         VSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438600; x=1781043400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeD8qBVBnk/V6UYnTAL4vEQaNYFOaOWzZWwvTb5A1Ak=;
        b=Pf8YpEudagPqKEAgTci/9SIdAkjWjojjZy/a3s9e5phqIlKbyPK12pwE1h1ZXo+3TJ
         8dvsY7yAUBFCysujuXAv6vtjHnZKFxV+wbMKPuRw6b6NOpr5b67WqlvbYpbLaGCVyBS2
         WPFuhcLIF5ti2HT8/hhVvyyxH0ch2mgtR2kn2M+REgy1YPxmGycj46Yn3w++Oq0Z1hmr
         xc1+Resj0Hd47Kcay95CGU+zKMmc5idfBuM0CbItke+dgEvIh3pumPsZFPoTURAGfd59
         HQwxJvoXHagTsFvq4TqASyLVTyrCXGYUD+8ttmX7i7I/ScL5PMXtDf03xMdTEzLV2J/j
         /IxA==
X-Gm-Message-State: AOJu0YxJgxNRrbB+B5q0lDsPbVZdUOFjlTglMDPqsT2y0gTh8M9KvbSN
	1/zQGCBgxAXkGe/y1vH/BxKSBxSc+4H5vFsdkVUUl5RaeUKnvohVpGOAKYrAjw==
X-Gm-Gg: Acq92OE4wGdRwfOLZCq2PycE2QC1fDaKiKkcLgl+W0rFZ/NwhM/RcfUZgHDay41EPPu
	7aslyPxyo+Jl4S64CbmeQqkUmxt+Uy+kY9K+KBmtbjM9nIC9TFc2YAeaZsFSmFhd0kAMEsbClzZ
	3OSAQh0XpQQnVgubxTRTfGI++O/zZEIo9np/GGa7wP4tZc/YA3dT/0IsTFV/0A1i7yo70JHfKZi
	3rGZ9g51rUYhSudDuMXbwRreOtlpD1YzFq4Tpg4y8EkzxLlJ04NfEtPDqSqyAcveqdkxI2CfkBf
	AbkDd4nplvodYvlyPfue1odEmx+aE1Owvdvs8DFqWSd8Lpz1PE3ocAfzfO9nvIASR/Ws3KXOrm1
	LjGK2d7iUQoePuQOFTQgE54lS0toL20aAC/mMJNdBGEQjPs2hOjTTuUXqsQUfY9Z6iGs0v9Rz9D
	RG1PDiUzWVCyBNg07stv1fW1MTNuFMVtcOdgyTHcGC
X-Received: by 2002:a05:620a:1793:b0:914:b31c:7001 with SMTP id af79cd13be357-9158b5cc468mr95487985a.6.1780438600231;
        Tue, 02 Jun 2026 15:16:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.47.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd07629dsm3692356d6.39.2026.06.02.15.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:16:39 -0700 (PDT)
Message-ID: <6a1f5647.3b2754cf.39ff73.36de@mx.google.com>
Date: Tue, 02 Jun 2026 15:16:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5472099481862058319=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] advertising: Fix sending extra bytes with MGMT_OP_ADD_EXT_ADV_DATA
In-Reply-To: <20260602204749.210857-1-luiz.dentz@gmail.com>
References: <20260602204749.210857-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5472099481862058319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104846

---Test result---

Test Summary:
CheckPatch                    PASS      2.26 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      20.58 seconds
BluezMake                     PASS      696.31 seconds
CheckSmatch                   WARNING   355.44 seconds
bluezmakeextell               PASS      182.82 seconds
IncrementalBuild              PASS      668.57 seconds
ScanBuild                     PASS      1026.46 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2167

---
Regards,
Linux Bluetooth


--===============5472099481862058319==--
