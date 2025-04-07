Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A322DFA0
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025994; cv=none; b=drHQfRJDaQVYBwZnNfEwXPv9dermjmEUcO+ERdxtWuIxakecvzJgzOaZG9Q/njXM/U2EUD/9uf1xTVzQhjRFoUSoR9UyBkWM9OjJMf0RfwZuBNBlbS5SANRD4YVac1VeeO3FIqLbbHVI4UkgMfnhSQ+Z0yadTsqq7M9s2Yx/zXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025994; c=relaxed/simple;
	bh=EhfCFOcWzy/IozR5KL66MnSMzgd1cYp0lsv4oZc30cg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sSdOCjl9hIgcDj/t5u0yQre8s53wS11PHcVarHudEHSYJGcwcWqqx+iiX6GnQbXwQr6ZnOYRQLuAQxebQ2tIMqIwX0mwifHhCfrIj72mgd6bOUNzALNegT/veLw8nVxxaqqtw/g1lqRbciJUba1yN2cqpJssAAmiM0nDQztH9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He4T5zhl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He4T5zhl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30572effb26so3670273a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025992; x=1744630792; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=icnT745Hi18TmYNEA7v25BWLtQBZP+GvOVM9XU9S5jc=;
        b=He4T5zhlgCYfWOUYkArrLZYdb4OU514gM+Kygb5EJiRdByKggylT3j18rgxCJQGid2
         CjsQtW5118Na9ykPema2lwqQ8MGVtvf8CXA/3ZRIYyWBCDLsD+xJflb790F57SZ5i2K4
         xuARuIXqIniWj1QZt6C6eQSnhy4ItBTu9jrgA2aPOp0mvak54Bvp3P2WRY9NE23JEcim
         I0fEzyn7CNVwn8MruyiM10s1qyYCZiBSjTxBJFr5cMpxjEE8wWuC7hfg6xvtX6jFWkNM
         uxhMZT73nsGCl0gOQ6SbLTzZWGTU4m0YjL7D8E6DklByLHl4LgmBUAhCF54apxOdEMus
         dVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025992; x=1744630792;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icnT745Hi18TmYNEA7v25BWLtQBZP+GvOVM9XU9S5jc=;
        b=kLFv/lQ+D4VPDlc3zqcH9X8/HmU0aBCWqKoSdAKRgB/vQrmypVVpxvUYMALXPKW118
         DB5DfEM34K0udOrVyZFSgxwW3S1ZaJ6C7k5g/g4Jzv7Af1GXvYG84alAbyMDgO7YkkNc
         dPfQqz9CKtCSy3KrJGv9qisgr3P1ztzVAC51OQAfAPDVJxd8ysFM93WOs+0g3G6xOsAf
         v7LWRoMx0gD4EKRSXmB1gYbjtSWflPhVXy7vC0lG5Q9QxOyUI1Fw2S+0oMiR4+1C3NW3
         JhwJXDk1NS3fmAACoL3HPrR9vVC9U7/g8cdzuws/tUMOJXU1Osnzhj8mUsKXNY9CqVsQ
         sZxw==
X-Gm-Message-State: AOJu0YzfizOpRyW6DmrDnMK3DCpwjmu+Y2CJyIx2yxMf3OwSj/BvSILx
	dMnpmPgg3E1rgZh19A2pxVvsFeoQfNAc4pMHycw83kWtgXyM983Ia4kHrA==
X-Gm-Gg: ASbGncu+ijNujDMLX5FRhc/sJazsAaUnhktUQOLMaokGNLpwBz7RMQf/73EPdzMo7V1
	nbA7FpLLPCDobI7uCPOCEYnAax1LCZJkKr/zMVEFOdxmkaVlZaHtz5s8gKOyR+ImHpnQcMh06I4
	60tpfKInEGWj3emjzN3nQa06dmuQnXMw16emDIUYvmmnNC4TUH+6rn47L/eGCDTBG+2QXT09BoP
	HOkiZBZ+yQubM+ulEW0llWh+POYXV4JbvVwzi7gsE8hs7WOcbwmzTLPa/td+1DYv4Vg3VlSIm99
	WNhPEdFDh4GAPX177+wzRRm92Vg7zSzDKbChxHEoJEKtte44jt4=
X-Google-Smtp-Source: AGHT+IGjORe9u5MVLvWXhP3NqeNGfhnsUvaw4sJzo4s2zMz9ddU2BooKv+Y4C5XJDPj4YciQJhSKTg==
X-Received: by 2002:a17:90b:2f03:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-306a48a57f9mr15268309a91.21.1744025992331;
        Mon, 07 Apr 2025 04:39:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.155.62.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a2f6b2sm8672781a91.24.2025.04.07.04.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:39:51 -0700 (PDT)
Message-ID: <67f3b987.170a0220.12708a.e9b5@mx.google.com>
Date: Mon, 07 Apr 2025 04:39:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0152085675423287454=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bap: Add idle notification for ASE State
In-Reply-To: <20250407-bap_aes_state-v1-1-dfc090c49cea@amlogic.com>
References: <20250407-bap_aes_state-v1-1-dfc090c49cea@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0152085675423287454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=950501

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      1606.58 seconds
MakeCheck                     PASS      20.68 seconds
MakeDistcheck                 PASS      157.73 seconds
CheckValgrind                 PASS      213.33 seconds
CheckSmatch                   WARNING   283.70 seconds
bluezmakeextell               PASS      97.99 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      870.13 seconds

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
src/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0152085675423287454==--
