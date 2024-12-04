Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0E217712
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333499; cv=none; b=Cq4vmDLrqsfi7eHgZCBX6WXXeBIK1WHBiWBCb1T9UFFc+7b9CdTHNX5xafZLrmIHRtPq8u87IKFwsQBQJXpnFFSK7UhNXFodlMs5rLRqYRUYXJ2qOUiD1d36R90NgVTiyQeNKfZj0qs1I+ULsmVNus3ClSud30RXUIRiCSJrdWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333499; c=relaxed/simple;
	bh=5UJLrLV/nQZBn4h5lKCj1v+EXP8tckBOa4PQV9rCtIg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rjJTtow3Mzkq7VAhr8e1dujh/L3j2roKYA+hYuke0ESITnWNmU+PcOjssk5l64tPHzE9R3P9jHCKCIuFBuf2g9R/dO3WeQ1pKuTAs6WMVnjsiQn5KvzotHGBfarxGu/ydpcj8Ar9Lz58hKGCa2NzV2Ch/F0v6ZVk1u6ZOvHdr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRyqSqmt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRyqSqmt"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724e14b90cfso74534b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733333497; x=1733938297; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p4PHNg29aJDkU6ssdXTs4kFhG/f5sh/v7gFftyzsVNc=;
        b=kRyqSqmtI0PdZ8EhIhqnUHvSz7+yJH9eDCWDiarV/jc65l6uXheFP4i1CxzGTDE7WS
         IBLDYvDrYf7DzdP+CTlc8DaLOwH24soItguJUDq5BT20vuzvzXc22e22L/o+kq0GMwy2
         BlO4md0mhdcZvpWS6BR6pjnRhFOZFAZ3ZH5kaL66sgF9hhuY6cIi3HzycZRsNvvgyiW1
         G79vzFl+q+zKBnN7xLrZkoHEnByKqjhi8rmtUVlsMOKwglkmLhgn8rD92ZBVtKim5UHi
         ef3ORTl1YT/ajXk4xNba2jKkG3bXJVLXht8CF6r0FBFNq4CbBNR55EEhhHetUpRJfMW1
         Ofkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333497; x=1733938297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4PHNg29aJDkU6ssdXTs4kFhG/f5sh/v7gFftyzsVNc=;
        b=sCTCFNJ2uyFx90QstfcD5j/ORTtWVGVI1sL2X7YsaIbyPLwVieR7F0ofKeTQerPiC6
         9ircL6xRGmA+eSJdSwPvCVqioStYxV1YEHQMEUGWBHhHHhh+UtCjoihNaZ1cWgOZMy9D
         UvUGBAUwdAT7UlH7JfoqwbUyCt4E6Dgu++pKajmYXE4DRBZDj4GL+1UBN9FDCS+0406I
         e9moS68TcVxwRdvr8tSkuW9vjqRlLTcM6x3HUd95dN8Xl2u014C1XUoRXUqnvbhw7ExO
         pJ2EOb3BiilCAMt2k+e8knJY50SgWMlcbbxhxYEBqEFk1k3l8Uc1E2soIN5fFi13VQkE
         dONA==
X-Gm-Message-State: AOJu0Yyd226+IS3qkmcOau94rZkDXLgZZDZHGBldJcURJgj/TUHoJfII
	4gP2FSM/Ga892J2sDDvh8jJzc8VjvotHHM74Gm0MckPQcadh2eNyXgBVOg==
X-Gm-Gg: ASbGncvn0jtnBeHWnvaSJ1dPn/fJi3OHxpHnfQ2/cXaKXciyuMWpvN6BfdttlA2M1Nq
	3j5+nO4NQlx1jz3BwFT2/olRkA/WEQzY2eDd2103g8JmxFglt2bfLImpKKJQyAKfQzWUxLyy+Tc
	ev6UwRh+iKqqUrzlqVjuE/JxMTsDfzQ7BMIyNdSAFI35iTnm1dSJSUyDEekh2Z1W/sk1wf4YpLx
	HaYIufGXhI+XzFBcbDu+umSLoNyVOZ/XZZlDGikWDyUNne9t/CBCh8=
X-Google-Smtp-Source: AGHT+IFIAs+rHzAgR3/3X35u5ottdNhKjNNSc5+pceKsx/AeAVgU22oy6nhz0VHoEI7oySWVvJlHEw==
X-Received: by 2002:a17:90b:5307:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2ef011dab20mr9140191a91.6.1733333496487;
        Wed, 04 Dec 2024 09:31:36 -0800 (PST)
Received: from [172.17.0.2] ([4.227.115.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078b46sm1681001a91.39.2024.12.04.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:31:36 -0800 (PST)
Message-ID: <675091f8.170a0220.9e070.bf93@mx.google.com>
Date: Wed, 04 Dec 2024 09:31:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4550749743150335209=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: Fix sleeping function called from invalid context
In-Reply-To: <20241204165849.392564-2-luiz.dentz@gmail.com>
References: <20241204165849.392564-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4550749743150335209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=914655

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.20 seconds
CheckAllWarning               PASS      27.74 seconds
CheckSparse                   WARNING   31.19 seconds
BuildKernel32                 PASS      24.93 seconds
TestRunnerSetup               PASS      446.35 seconds
TestRunner_l2cap-tester       PASS      20.67 seconds
TestRunner_iso-tester         FAIL      27.63 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      121.29 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      9.60 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.47 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was not declared. Should it be static?net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4550749743150335209==--
