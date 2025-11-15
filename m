Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D224DCE5
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249197; cv=none; b=kh/KQvO5zqgFtkQm9USLKR5QYZwHfqPXEmEJb/X6FcIrQL9ozvJqDqgd8YSXjAhnrysgjpZASi6Tl+//7Zmz2E3456hTRxzKsm51GdR74J4dnAr3bQ5+EZEk8k9RniCyY/qtyh8h8P3VUJ1RKaPCLIpBlvrzT532LvHrrxvrEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249197; c=relaxed/simple;
	bh=byBQegQNgU7Y9XJYzCoQ94eZzTu0F3u+NbjrGmH1F3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DuDJRdnu4loAumbXctlzHpIugaRfuB88EFvsvxdST7tLDpqZo4poWvc1JFT9Bl7z8uLr0SgnGu3VALq/Y0AXxJAJb8v0NtWn9tcdjJF5lxhHhWuFdnQo6l6XyoND2HZ3JC9/o4Jm+NWMGDiNMMOvhWlEAmtM9+HlayOAXBDhCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV+sHYS2; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV+sHYS2"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9487e2b95f1so121502739f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 15:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763249194; x=1763853994; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fO+Tvyh5Ysz7X4iT+fVSQ2RAU+qJSNv2fwSI62FAimY=;
        b=kV+sHYS2hcAhgowz429j5zHu3m+5zbp0EtUNbha/E/P01AOQezolv2KPamdJHGQEJa
         wwwRUkJUy+46j8xE0nSi+IWx6gb0XjTd/571HoLCl4ldzKPF4TQ5m+mVgDZ7zGO2DCO4
         mDPgHteHaP6xoDkxWDVpjlzlpVkJwYxZJM5nuOvgIcLO+na49yHDmo0HlVSWEuxA2r5g
         PPuddRXL1hHRilioExeNgoXE3DxSUTCcLA+jcCweSCR5r1zpr2wTZIo/5ev8iTaCkcKG
         x7ErLRdUvl1ahfGVbMlnFNpn+MZuiYP8TT36BKstDOwt2nx2re/cec/Wnj7w9tDQGXck
         VFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249194; x=1763853994;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO+Tvyh5Ysz7X4iT+fVSQ2RAU+qJSNv2fwSI62FAimY=;
        b=uN3EzufABfleigbdghWUYQd0t7XfISJby8hol+MAWk/141+XH+BB1PxIsyCspRKt4b
         1t8fOZiySKeJOpQu4dqjdxLA/6/qUxlbau09cxP7zQmw9akwfnLKfsCR8gTp21yQOyCm
         yNU7TIidLgMxziTB3HJ8oyj4GU83wz5rdxQVNLeDOmS0Xk+YFhAffn0VQcjQKxpOyK+q
         f/goLfeivbc8KrLKlHzPqvep51cZhNXZGKvc3mm6J3fcuIaKX8vjGSuX/NUeJ4kDQiyN
         mC8lcmVQAj4+1zYf4thKwjW825xMH8149thgDm03TgDoLnI8aHAGwq0UGZvLZVBwAHCH
         IFoA==
X-Gm-Message-State: AOJu0YyzRsax79k8oe+/gwdQTdMm6sNio34JneeRTqmeIa0q5AHwEoYA
	eHluWVnZ0GIjnkq6g0NNRhfZQOKPPPDTH1bKXG3ww8hoJ4t36RkCpEM2foUSuPnK
X-Gm-Gg: ASbGncvCMqFavntdop7wxV9zQ5dZCptIjHviS+1n1V0WZwhBqEeCWeU0YGQnC3yWrUG
	UDKkTMcGIuOeUtBHTSvvBJ3wJsY0FTpMtI/PGrMxD0OBVDWawYHTcK+8rNs0NU+Uknln3IAjZC7
	lvcGWd/8b9Yxb7XstX9p8mSGUHWU2GnsayNBK6hVoBZFy6A/hPnuE0F3TXvEFuQ/2hswPHb6HLX
	sifu4mWhkt7qlYmOXysarXi/GpHBWYvuy3ewxfQYg9U3LhhsrJYM94vyEBYXaOgNoCpF747sFVE
	VylCCCNykx8VQhH/QtLE8qYeVBqHWRWj97ngs97SRlnjpNy60oz11TZf3dL5C/su6CluRqTwEdZ
	9HQKggzz2RV+iMDC1McAR77G+V5EzuR9I22IZI/T+fqKs96TnhzDE6lr585O7L4Wyr+PejYsVUr
	UoskSP6zjT/eh3RLPmX/9xnSvZShZY5Z2/DcQGtDUW
X-Google-Smtp-Source: AGHT+IF3AiTbKy8ijDAP0EZjOt/VzwteYDYyzjDoSv3EwhNAcpRPYuIGZVpY8Bmjv7zvGpjwe4d6tw==
X-Received: by 2002:a05:6e02:1aa4:b0:433:77ee:1e3c with SMTP id e9e14a558f8ab-4348c89620cmr134481265ab.2.1763249194264;
        Sat, 15 Nov 2025 15:26:34 -0800 (PST)
Received: from [172.17.0.2] ([172.183.157.177])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833c5c6esm48299285ab.1.2025.11.15.15.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:26:33 -0800 (PST)
Message-ID: <69190c29.920a0220.39ea09.90ec@mx.google.com>
Date: Sat, 15 Nov 2025 15:26:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8600049112067113915=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrew.smirnov@gmail.com
Subject: RE: [BlueZ] device: Fix the return type of device_irk_cmp()
In-Reply-To: <20251115220816.98675-1-andrew.smirnov@gmail.com>
References: <20251115220816.98675-1-andrew.smirnov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8600049112067113915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023879

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      19.95 seconds
BluezMake                     PASS      2582.05 seconds
MakeCheck                     PASS      20.02 seconds
MakeDistcheck                 PASS      183.38 seconds
CheckValgrind                 PASS      236.32 seconds
CheckSmatch                   PASS      310.68 seconds
bluezmakeextell               PASS      127.82 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      910.65 seconds

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


--===============8600049112067113915==--
