Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983C522696
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068285; cv=none; b=UnxrcNDDOeQegPEWMFj6eb0DyNAy+yUh5uUB4NIifxr4ttWru7lE47VG7oF7hyNjual0udLqg2IBR3k0y386V/6+xvuGYMkC4CRo9doBTwXvIKh/pm95y7ee03uEyR7A1RLOF50fhb+GqbNKDOqjgTDoRcSZwYW4iOBCtuo1tmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068285; c=relaxed/simple;
	bh=P9wvvBV+7ogtHIID/gljHbrfrA5HRvf+GasrdVfvIAw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j22j6c4XnjeX7Igtd7QzN9FE5lrKK3kb5spjLSAbj/3N+iUb2FdolMr7Is0y9KLQa+rM9nYnqwJLV8fTHfZfnxRsqZjOilwq4t8cxTUtiAr+gq+0I/1cow3LDjluXDCd+sgzqnyzW+mfzySpPRopx00Rra29rEpIGdjtH+1j/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXrhVkT/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXrhVkT/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1034553a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068284; x=1792673084; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MrhXLjtIcI73EdUxmPZkcSSqmp+PNdgRkxd+JTRHN+I=;
        b=oXrhVkT/MvTglUlealnBXviG/4oLMTePXr1FGquA2tg3Yn3JXfpCATCbh0oVyYj6PL
         +OS0PmXzuDpUd2tZ4Lg8o57nnLoYOwFfUcK4Ulv9QrZEflgCBuxk+w0ylvUmuH2N7Ow+
         PFeyU5UJXYjfEl+qDki/kGJvnz493f30CFBSYPSiKuXPSJFuU6LXeKQVwMHaRKjxpEoc
         WWdBsHYvzhp++CMgt1Uh5wKYzUztXc7dru3nnJIl2wYL9HYr0Lqe+B5NxlMG34IsAxWm
         Bae2etudrgWz4TNghx0QXeuWsDv8zbqotKSwi1aQ4T9ekKukmP1w7lZSfdZJNC8lO2xR
         enaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068284; x=1792673084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MrhXLjtIcI73EdUxmPZkcSSqmp+PNdgRkxd+JTRHN+I=;
        b=NLxYA1hgb3U3EQqYZCqRLGodadGpqq8WLW7/rFDhntSRD0yDj7N1XvgA0ECoAuI5bO
         ymHprgmBSWVTN5FZpVsUldBdcmAT8I+OSEb46U4bcSeFDy09nHg76DZlqSmmRdStrx8w
         2cdEmwsf2uBCsv5zKyETly22xhXJTesQgc13171ETNMgbZwwsumiVZXCiTW8twh2DA56
         8vUnuW/fNV9MSJ+6Ee0ZLJTxHG/cCpdZiGpPVTtjm8LQzwQ4epRUEFzJy9UsP8Np1r0i
         nhwcDks9dwZa1TjYdF5P7YlCJDpaNk+oPXLOWOnzZKaIr3k45MOlxOK1d1/zYGNbtSIw
         sUPg==
X-Gm-Message-State: AFq9FYLHRi3nD4hhUEB55QmA8KLUvuPLjC3redqVjARNg35iRQSm5D/u
	sMo6PaeTrhdzy5ElW3v/HdVpenwvhu4djEaoMTnaJVXVYNQZ2dDQzxjAxsp4Pw==
X-Gm-Gg: AYBFou2MHQG2flaRJFm3mtHHfKwlYEaZ1j7hqz5Kso6MOG1d/3iAYPK9HMxLvwnYmWf
	gxffcqnd4sIEISbD73a3TFpPTrbD1RTjGFxcTIKLHDrcMCBnROGxqUkv8r/1EMFM5B5UGcvvuLj
	/X9WzYPBjespQkiidhGIP5RQmJUDdGVFaZ1l2Vx6aZqCBa1I9p34KKmeRT8J4yQUCTtdv+IMM7a
	oOWHar1WpZemM01kCsTDwYMpmePSznYGWFRkZM+cON0h70Pm0vcTx01yhgX7jDw0aQLb7qjjlyg
	9NcVA9eWdwuSLHp+dhtotsoFrX6rzSOUwNFuGwGiUe2cU2wfTlsUE2uQXSOy/xHCCwUApcDd1nq
	99R946toJS+NaC0dWy+iUGiW8evDFcN1TWvq/IDhyUh48d2CYpXIrDY2MauEA1XZ5hTGrsh4ZkF
	WAYFjxWw3QahYzMCPS4LA6wkBvIPIPfsHJyp8DYnJeM/Kve4bulaMpQfM5n0O/TR6u8ZqoGaTkY
	2jV/yVmsOnd30/f32o=
X-Received: by 2002:a17:90b:3d82:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3ab3ab3771fmr14044498a91.50.1792068283853;
        Thu, 15 Oct 2026 05:44:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944368e7sm4382970a91.9.2026.10.15.05.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:44:43 -0700 (PDT)
Message-ID: <6ad0cabb.2954bf50.f2390.fbc3@mx.google.com>
Date: Thu, 15 Oct 2026 05:44:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6399986782296323564=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nb@tipi-net.de
Subject: RE: [net-next] net: rename skb_unshare() to skb_unclone_full()
In-Reply-To: <20261015-nb-skb-unclone-full-v1-1-0dfbf01f60f2@tipi-net.de>
References: <20261015-nb-skb-unclone-full-v1-1-0dfbf01f60f2@tipi-net.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6399986782296323564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186242/

---Test result---

Test Summary:
CheckPatch                    PASS      3.93 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.34 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 FAIL      0.06 seconds
BuildKernel                   PASS      29.68 seconds
CheckAllWarning               PASS      33.91 seconds
CheckSparse                   PASS      36.56 seconds
BuildKernel32                 PASS      29.43 seconds
CheckKernelLLVM               PASS      33.75 seconds
TestRunnerSetup               PASS      706.95 seconds
TestRunner_l2cap-tester       PASS      12.60 seconds
TestRunner_iso-tester         PASS      10.85 seconds
TestRunner_bnep-tester        PASS      3.08 seconds
TestRunner_mgmt-tester        PASS      87.54 seconds
TestRunner_rfcomm-tester      PASS      4.41 seconds
TestRunner_sco-tester         PASS      5.56 seconds
TestRunner_ioctl-tester       PASS      4.60 seconds
TestRunner_mesh-tester        PASS      5.49 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      3.12 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      27.62 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[net-next] net: rename skb_unshare() to skb_unclone_full()

39: B2 Line has trailing whitespace: "--  "
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/943

---
Regards,
Linux Bluetooth


--===============6399986782296323564==--
