Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777243E092
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446982; cv=none; b=JUsmqlsxj65ygd8ZVpBcZfwXFKd+O1YOmxbBvJlapZ5KdmXD6chH+SpcxF6k97Rux8Rp5KN2riA9Mg54I2dmcewyYUHjgDH7sv8/DBZfi9NbJ/fuVhNvE6L/bvF9CUxvEaTOOM5Hx+qARVU0fwPbO4GawPja0WlVz0MCRzdadPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446982; c=relaxed/simple;
	bh=qrsH1xxFphKfOjAbSmBGenVrEQ1s7Mkpg9a73VdPEik=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hvS+kBODtotavLQcoFB/ARSbwerWIc8vLhZj3B4O4GU4cD3RRS6TUHw3sW+ea6qUpc3fPYcJ7yIP64jzpaqLeBeKTMuClK/9TIxI/49n8ijaSOUNqcOTH4HC/MlDK8YVP4r2b9nECpr/Evkx+sod8xITciu/zrRyGx39MwbJ2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbA9MwoZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbA9MwoZ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4b5bdd578so1255262a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446980; x=1792051780; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M0f5aolGD73oo1C1wY0169nTLV9sWDghHV65q9snbcw=;
        b=LbA9MwoZM2Pxraya0/YeH43KT/FVh455cTqM5sbaxTxXAOksw7UiJmlUZm2ngwJMAO
         DA0txnQjabkP54B/aEClovKJj2y6nOKvDK2bhwal7UT78ORRdmeWMk+k3BSm5FP2NriX
         110KkiattsJ4O1p/kKy8YS2jV9erwXYP86KXxOZj8F0PgCGM4VLoBwHuNzBy94UPcOBR
         pA6Rx0OvLDDB7AJGR+yMf/8/l1vwwWqvTvvN/2qmpDGOs8yPFJp+1pd4kmR0V08NHwu7
         ahjvKiBo7zRF0ibFuekkQyd0BZpJNaP4sXPLvy4pMLXKuxDqLixcgN1nsfXpVvPnTBKI
         0XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446980; x=1792051780;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M0f5aolGD73oo1C1wY0169nTLV9sWDghHV65q9snbcw=;
        b=c0CvhSCMusuoFbPLbt3LY6fXLkpYfJUjjqjhIz0wTk4Brf9I+iXyx+LbZitkWBGNsa
         Tcm2quozbB5X7coAdRlTHEoSNUxeJ5Vq9H1DzArOFBr585Q8iJ3O+7F6uAtj1qD0vW29
         JOBBfLfT2PaZUoZZv53/cYc8lhECep1fjD2iED2/jld0dYJYaeNJ8RBInFB5RCkkiKV4
         KPyk55b/y6GV9utZi4o1L4hOvhyMwLC6YJp5lEXnH9r/mtp4jN4sThcwDVFsfHqLu3CF
         /n9UrGe9b4h43i9uvrmzI2YZErli9UBNDqOFdmsBVplV3Lsmj5kfhmjTsrFVmiqXL/9w
         YtOA==
X-Gm-Message-State: AFq9FYLc8B7T1TL5T4YHnu/lDPCfylOjuHrBNGg5O6djo0orMMmHF58h
	LyOBf0Vwumo7SRa5J6lAkhshLsItRc97XhaR4B7vnOSjF7tEQpgbT1GtrmKVgQ==
X-Gm-Gg: AYBFou28sMVTYdBl9aT54XciTGKRrHy4WnhW7yek9WEdAQYXX0I98Dq/XFTZjsDC/5y
	KtaMhof93V0tbW0DqcdJYqPfoJeHx67S1adbfJ4av/5R9sMfFFtcUcADlD3Vn9wGxnkVBpa6g0I
	lpxs90i9iXi6vy7QqW9ni6LTUgKYWbIF0yGA9VyAjtrnC/OtRVjdLAk1dY/7s8DHD2iAqBAMMgR
	JdDpscldYJwm3C8GqEvULmMaR9SitIsDGId80u5Ey2XUs6ASqlP49PjO9LRYzsLxcUJfllgAUCl
	DUAlqqWFTj+SYsZGUxmyD/HsuellWedyYAwW5XccUaQdwpZBTm22RyMdkj/luau5xJGKsacTWRo
	2K+gguTGkDEXn/uw1YzEBUS39RrgBnuyIFDH44m0PnmFyNEtKgJbZIZXDZDfLXVXBVwrZhKnwds
	tywlcxJjbBl3fB0MMbA6+ljJz5KHCJ9BY2D1OeYl0Ruq0vvBaeSoP9+3FkxHEUaQURcLz9lJtyN
	ZQN+dxJsbFpbOxwe8w=
X-Received: by 2002:a17:90b:3c07:b0:3a5:147a:3b60 with SMTP id 98e67ed59e1d1-3a8a13ca047mr3567796a91.52.1791446979501;
        Thu, 08 Oct 2026 01:09:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.210.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7a7445sm3092893a91.5.2026.10.08.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:09:39 -0700 (PDT)
Message-ID: <6ac74fc3.1537aef6.3a0e4b.cc63@mx.google.com>
Date: Thu, 08 Oct 2026 01:09:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1555467936827394358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dungvn2345@gmail.com
Subject: RE: Bluetooth: hci_vhci: Pin module for debugfs file operations
In-Reply-To: <20261008045413.465999-1-dungvn2345@gmail.com>
References: <20261008045413.465999-1-dungvn2345@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1555467936827394358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181255/

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.09 seconds
CheckAllWarning               PASS      34.18 seconds
CheckSparse                   PASS      36.46 seconds
BuildKernel32                 PASS      29.43 seconds
CheckKernelLLVM               PASS      35.02 seconds
TestRunnerSetup               PASS      785.49 seconds
TestRunner_l2cap-tester       PASS      12.60 seconds
TestRunner_iso-tester         PASS      16.71 seconds
TestRunner_bnep-tester        PASS      3.08 seconds
TestRunner_mgmt-tester        PASS      61.03 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      5.47 seconds
TestRunner_smp-tester         PASS      4.28 seconds
TestRunner_userchan-tester    PASS      3.15 seconds
TestRunner_6lowpan-tester     PASS      4.36 seconds
IncrementalBuild              PASS      28.72 seconds



https://github.com/bluez/bluetooth-next/pull/882

---
Regards,
Linux Bluetooth


--===============1555467936827394358==--
