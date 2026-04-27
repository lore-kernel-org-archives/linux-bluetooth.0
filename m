Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E43AB285
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324235; cv=none; b=M3g3lyBWH9cmul/DKR6RKeXzf+l7gdvGDc5MKKLL2P6siKWyn/tsJAWEjNXcp1gIJV+94eYsXAboVHUYno+n5YRj8ldLl8AJ/Z67o5StgsXxJb6c7yg0BZ6KmMx8CuWwDztjaBOdbRm6KdrYFaNXIKkDspOcx9iwRG8Vg6wI1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324235; c=relaxed/simple;
	bh=w+SR96W0zMDt6eJN1BMeptWgvUCaqj/NihlI6FdzOQ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HPEiLn9BhvOw3mbzDMu9QUNQXhyZBGAlwRwu6T3TebcLg2LMu6BTh9thUvRVPcT+YhfLQtFkvTMjmViIJZHEu1GrCYuuTR27HEM/we64jyvCGyjq3cb9IPdorBN3qipcWRtssAKOHn7MUweNgY5cCErCNZj8tG/b6/7M3KN6ltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klrK6Csm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klrK6Csm"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d65f4073bfso1464636085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324232; x=1777929032; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Nc0JRqbGpHUVsVWuxDs2aMkmhYROwYG4a4YIydB+o=;
        b=klrK6Csmh1pATTK/4lOFi19QLjTQ625CrRmcnp0L3hFoeQp3SrUiFa3f2LnpXiEMRL
         Dg9V7+6JJ5d25E/C2vSJ2y4SlIQiBKdkFrISt9CWqqTnnSBLgot3wW4jKjmyG0d6rTxJ
         B02uEHfvHz32wjpwbTMWZXb6hb/Xay8oB3WaS+jBngYQjFq7dCTu0G+DPgzi8StHIHZh
         AvpOvMnWmVHGmThnACQBD6yUeqviqXG5A8uU6EWmU99v+Km7lySOpVx39HISPPhwZPBX
         yb4S2v42FPkI9Hfy7xEOSqJrnNp/KQDgkGfT9z26YWsvy5HeyCP3fSVDjDNfsqALUsI7
         umaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324232; x=1777929032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Nc0JRqbGpHUVsVWuxDs2aMkmhYROwYG4a4YIydB+o=;
        b=Q+PRjr/TG/7qTTE/ND83EyJmOOosWXwdTyFxNlH1kZLBADPLVjLiNsYTT/J7XLgrTI
         DYGyNghnEm5OJOwh0IRiBa/uApjX1eRBUXHQN8hg1C+cg2dHlMPpFlXhms3KarbB85mj
         A3Hvq7w9fW+2UufhO80G8BwNcKX086BRSP2SGkx0RUxai796UI0rj6ZKrzBcEkAU+Rgo
         CVZHs+VVmcSZIB49BzFl0wcpWHonEUVp7am4v8gVhHksjEENvcF+YLQnenji+XCssbC/
         YmYLOpwO5ETIIFYIak8leNKJCJoBqOy9CHQAXpIARgTGWByvnitX+RL/22CjcOTCOLxS
         qd6w==
X-Gm-Message-State: AOJu0YxZpwPoFMlDyme2d4oUfeKtFZvz6KMKBGEZbPBUBqonU2V4xQA5
	ecTwJIOPLJVX3hXFaCkyMbD25qT2cCtLunIWblOGYF1YwgcpeZAG30S33YEHww==
X-Gm-Gg: AeBDies7EksAk+vkIH8zc9uwx57Ybh+/aNv6+7zXd6YC2W3fUnrEm16f3/QXUPrgY3L
	67uiF2kTtN679k84q3mMdyoys9Nct+xklKMfc68k2fTj6gTmq6ug2vAeR3OmGRAwaK6qFfMpjn+
	L2WLhsO/u19Bn7SVT20+Aq078O4BCkiXSJ/P6YFFY1hBbq/DOyRonElOPKB1yAtCDYfasx/qO3d
	tZ0JXHEm/Ru4gAgsHyzTVyqOFY6coiqbxIT1t4Gec0AwEDJChOroO/R9kL35Kv7KBp+OLJc4yxG
	JIY7rTF6udKXDT3FRJpY4aYyFCNbyA43fB4s2f08Gxv6THNbWotWfs4KIrxVudPPg0u7yc1+4Er
	RG79v2BIYG1ZOzoh1wTV7nJ9nBCDRsX2H12+RnefN6HXy3/tBT/hHbTDN4601Kw6rPKlZ16s6pA
	L91+k5QtH1WVI2r9EhtDD+kRzWhgtfmaFPStCDFgz5
X-Received: by 2002:a05:620a:284d:b0:8d8:3a48:35c1 with SMTP id af79cd13be357-8f7d95f9511mr41435885a.46.1777324232325;
        Mon, 27 Apr 2026 14:10:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c51ae6easm41157685a.19.2026.04.27.14.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:10:31 -0700 (PDT)
Message-ID: <69efd0c7.050a0220.2257c8.c135@mx.google.com>
Date: Mon, 27 Apr 2026 14:10:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5819801864016273665=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Add decoding support for Public Broadcast Announcements
In-Reply-To: <20260427192223.2875358-1-luiz.dentz@gmail.com>
References: <20260427192223.2875358-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5819801864016273665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086393

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.43 seconds
BluezMake                     PASS      645.74 seconds
MakeCheck                     PASS      0.94 seconds
MakeDistcheck                 PASS      244.36 seconds
CheckValgrind                 PASS      220.79 seconds
CheckSmatch                   WARNING   346.21 seconds
bluezmakeextell               PASS      180.86 seconds
IncrementalBuild              PASS      647.19 seconds
ScanBuild                     PASS      999.77 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2000:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2078

---
Regards,
Linux Bluetooth


--===============5819801864016273665==--
