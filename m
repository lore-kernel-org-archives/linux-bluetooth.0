Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF9881E
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752914678; cv=none; b=DjL63AFh9QzZL7P80beb/E4kVrRFvOfShmhqfM5w07SHRi4nzMbrkbp5Iqa89MyzAt0Cojonip/j5fQvzupAfTXD3gnf2u6NHGsK+76r1zQu7lXe4MVaTHeggrBxnMbRBVo70SiDN7kRGRd6kCrcZGLcvmSowh+eWhnyqSDevZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752914678; c=relaxed/simple;
	bh=MvKJZmVYd+bYcN9t1TXc+c8lBTNt3EX623hFCIkcxz0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W60dxYK4DruGkDjaXnmdW6YCrz1ZEXVibtwID4MxQENq0/DmJi/B01w0JvU/itbwtv3RGvv43f3KZZLFpIteGlfHslFTWtXLkfJqA6+X+XguvghPXywYdtC7JgOXLLWRZhYqQ53qO3stDT5JZAi++iPojVdscm+8dVjwXyYNfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPLTDSHp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPLTDSHp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23508d30142so33759365ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752914675; x=1753519475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zu2lM8pL3ZWJmB1g3X7zxPF2uGLmP06XlCSbhljrDI8=;
        b=SPLTDSHptJA9v/9TJO/2G3Hd3GIgBpnRoatktuL3elOo+Wmv86h49CdQyZx9RKdrL4
         Yd2YpvMnqdVnJqaCozIluahkfmLCIO3Zt8OX7dedBehZ/XY2z+Squ2cyQrnA+lpQiC8n
         UODYfQteKDWIKCJZ9Z4Hewz0ec/eEILa8JR2qq4rP4NzDuVe+eTUrC42cZ1W7ykll0NU
         NtP1doTs3CsAlBgSyzVR9iV4RVIYpWftEV2iN9uli2mZQPdt9fqxoCtTQjbIecCw/rXs
         1PkQfhBXEmQBYYDN8lOCAxpO5fshuZwLkgzFxigtPgZuuMCNwznIl/a78ToStgPNm4ll
         DHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752914675; x=1753519475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu2lM8pL3ZWJmB1g3X7zxPF2uGLmP06XlCSbhljrDI8=;
        b=UmLozFOcnDUi3LCAPUHa885n27b9n5FvFmIdMerFvqHvyQOVaRXjyoNhKsfKjvAVl4
         BrTT8ZjeXus+3t1oOlr+4qXEWAsL3uqdtHlu0vEstlFaL1D+oscCPcZZqVlcHkLH1N30
         hbOWu/k18Y2dj94tfFf5QevKC2ppZrS6uOxvh5gX2onQBBr8jGbM+QybqMBt3U7WxPQj
         FXHVEujq8Xg9ulJzSdRpKljZTMuVv0FVBKy4tffloQd4qNIA13oNdSOXnWIaRK1+Exie
         8Pf4MTBUhXWA/uHsiCq36oMLutggfbeHuuIkYgGT/K9SNDMG01VzZxOJDtQIx1y46fz9
         9Z5w==
X-Gm-Message-State: AOJu0YyPv8haZK5Unnc4S1ZmdiTfd+2WsqHxiVC3VGhnpd9v3pTxIJO9
	u7k66vinSc5lZc/kABp9TAl8g8Il4IFCCaIqVNwHqZa4/Z5M+maLC0tg/qfuPQ==
X-Gm-Gg: ASbGnctTrGoCTVUSvtLqF9azNRdcxrIOpjwYsCAiYalxdNFiaGtFTts5qORZsVDm/KV
	YCgtyLlpcWjipKUUjph37KZoip1MWUZsYFtu2ilx0opT0VxPzVtXtB3PbxSDJDVlV2pMSdzjewN
	3VENLcmtIHUPXrJBO+AEAyHCYse71JobMWERxEwwVEAYLxJu5AsLLX5dSb0hJvDliNbwC+WsS7f
	16V0AleBfpGR0QSZgByp8ek2GsM40fPeHsuLNr18Grm5tV2Sy8f18KN/T6vSG77aGuM99o4DaXQ
	u6ozy2HuKg0QqOKgee7cmfs3z+/wr4Esfp3aKWr2uc6rjdTDq5cG2Pv1fvRIUFjhtbJsnJlVthG
	/EnVWUyKY7FGaVC/sUnLxvFPgatAgM4I=
X-Google-Smtp-Source: AGHT+IHEzzvFRSunjLcGfF83+QLXTXDN3N24q28tB2wrns96xVaiTm+R41JRikcKBp4MBlJIMfwQOw==
X-Received: by 2002:a17:902:d486:b0:234:f182:a754 with SMTP id d9443c01a7336-23e25772cfbmr183247605ad.47.1752914674586;
        Sat, 19 Jul 2025 01:44:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4c76sm25213505ad.116.2025.07.19.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:44:33 -0700 (PDT)
Message-ID: <687b5af1.170a0220.31d4f2.f5a3@mx.google.com>
Date: Sat, 19 Jul 2025 01:44:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4539164283880636984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ziyao@disroot.org
Subject: RE: [BlueZ] client/mgmt: Print UUID and flags when showing experimental features
In-Reply-To: <20250719070547.9551-1-ziyao@disroot.org>
References: <20250719070547.9551-1-ziyao@disroot.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4539164283880636984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=983945

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2635.95 seconds
MakeCheck                     PASS      20.42 seconds
MakeDistcheck                 PASS      186.75 seconds
CheckValgrind                 PASS      237.17 seconds
CheckSmatch                   PASS      306.43 seconds
bluezmakeextell               PASS      128.32 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      922.57 seconds

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


--===============4539164283880636984==--
