Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41755287271
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050287; cv=none; b=miDKJqbeDMG/vP4Ew/tfzNB4CJntUznP0+sl/8fwXeHyF97QgjbWgLUG5+6q26ggsOEP2qh44igXyvPgNlRWedzi69088TdTwWPScfUXth/W1Vpqqh4InkD+xbBkFfsv8D5nBC4sMuxyCPll5tQ5yh++czWIXgxwF2UhbuSUC5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050287; c=relaxed/simple;
	bh=e2yvS3mUxEbye7DiVjW3mTpYlxwf5f01Fvaxj1sSTEE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nKnqy3vqu5PklDImIZBD50PRLUSqg131tmcLs+97cZG7kHOMhX7NyDSnI7GXdu327ISSjaNx29H+D1yz/7NleP3XRFTvKUmlODpzi7PS0/q3UjWqdhs81+mAtPizov8u2fG3tLVemelTjjeQbUcbJ3fBl32A/lslFnzYVr1PVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crS3lF4e; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crS3lF4e"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4242bb22132so14600965ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050285; x=1760655085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+hEMKzkaIhjjY5aWPvAz3akYQk+dYRNewyNMiB0P+Dk=;
        b=crS3lF4eFmIBp5zK1W+z33Wr7DkroJZNefbjpZKQa+wBUfSnlVtGerpSsxILE0U4pN
         jB1TTP+d8Jds5Z98s8QWQ+ioMST/523RMasZwaIZr+PN4tWDC7bYge4tEprMOQSX3H7x
         rgo86cbRMIIcPm+fNfaNiZV6gMRtRYnZj3H/5rBKdIveZy0gIdS0kD5qaT1pCDO9zjQl
         ebhKXm4uDDW3X8t5084cjgy0+fAsoExExXcKfdg1C1HF5YWJjuDzpbOPgqehHHrncoGI
         oKVWVnUuM8w6FoBJAbBl1Vddk93m5t49bkwvr64KPVbXOao2vOjhlenlQjS4TQVc4oJn
         r7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050285; x=1760655085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hEMKzkaIhjjY5aWPvAz3akYQk+dYRNewyNMiB0P+Dk=;
        b=URFtKgBQuH5LRwCa67VSNkhpSwPb5+W+iw6JYwvgVgrgAiIRyMUBM514Fqv67KHmAU
         KzpjLmBOGLzjr3v5T4XSfw5YnBFc5t8kuUxkSA8Igqu+09ADeLff1/xK8d+bkeJliIoj
         MyGjv0YLpOEJUKYWK1jfSsBp/J0FGN2EE2ddJI/bAg3mOJNpxc0S4HDsbYjCtH3Kughd
         pi1Ri3O5i6XrmaNlG9aw/ziR24B06wGqOpZFM2UorXycIu6KFSxtiM2WFLBIH6wpvFVV
         NqDFt9/22mORvD6js5+4cWz1RRbD5lPPnnGbvQIlgK8D4d2i5fbbPb7i8yTG0ibcho75
         sdpw==
X-Gm-Message-State: AOJu0Yya4NZ4GVa1XNrNMpSuu2lolqo1blS3+QAjlBGfjYnUFKpKSD3A
	Yf+yOTkHD320rLbObrP0a+KMct3S1ohk3JerNYW2z8qGqVu2GMUcHZ0wLGA1wg==
X-Gm-Gg: ASbGncs5iCN/+z52CSKye6XsyrTwceOhPr1uj1Rk/nf6jXTb28zOG7HUE6/OG3h7qya
	M17mALtRwC8bSbRdUkgszND0Wy6mN/Fegq0G2lJzoQxtWtYyPSu9/JoloR5MxkaDct9zbhwzC47
	caee49ma8zl0EdXVguK/H1YDcO9sB7nRKhMHgZIXkG3VUmYMEDHKYozwVm8GkaMaECGjWkpwU6r
	gHiv6sh8x1/cySsBjcGASNFHjBBHvh8L2wxKL6UrfJtGhFlbePo1/xWcPib/SU2w4TU7guv6mFX
	+MC+Q3vG+UIG+wXJxpl5DAnAbiEGMDkuD2H95xSLhBSdLeuSpQqq8zVTx4I9LtzIXdv++aence0
	c+naABniYRICScdYZgbfxQnAvWnRJDNnL4rFT8mL+f81EUxzZIX+VGoSoc9AspYih
X-Google-Smtp-Source: AGHT+IHbZXDw72oB+FenNkP3aJMqNykPy+Tr+mt4X6Z/MuBjzE8IIFGyeOHTM1XFo6Ozhk9X+HEmDw==
X-Received: by 2002:a05:6e02:1608:b0:42e:7a5d:d7d6 with SMTP id e9e14a558f8ab-42f87346ffcmr93536535ab.2.1760050284872;
        Thu, 09 Oct 2025 15:51:24 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.142.230])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49553esm266192173.15.2025.10.09.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:51:24 -0700 (PDT)
Message-ID: <68e83c6c.020a0220.31bf9e.0a65@mx.google.com>
Date: Thu, 09 Oct 2025 15:51:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1820996944357137198=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,01/13] monitor: Use PAST to refer to Periodic Advertising Sync Transfer
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1820996944357137198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009899

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.43 seconds
BluezMake                     PASS      2855.29 seconds
MakeCheck                     PASS      20.08 seconds
MakeDistcheck                 PASS      182.11 seconds
CheckValgrind                 PASS      233.33 seconds
CheckSmatch                   WARNING   306.53 seconds
bluezmakeextell               PASS      126.92 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      914.40 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3837:52: warning: array of flexible structuresmonitor/bt.h:3825:40: warning: array of flexible structuresemulator/btdev.c:459:29: warning: Variable length array is used.emulator/bthost.c:678:28: warning: Variable length array is used.emulator/bthost.c:679:32: warning: Variable length array is used.emulator/bthost.c:896:28: warning: Variable length array is used.emulator/bthost.c:930:28: warning: Variable length array is used.emulator/bthost.c:931:32: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3837:52: warning: array of flexible structuresmonitor/bt.h:3825:40: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1820996944357137198==--
