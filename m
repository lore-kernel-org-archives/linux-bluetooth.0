Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097A6995C
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228776; cv=none; b=MLsmjb5SGBuFgz7CsmyWBqBS4C6Gq2fOuHYwI4LLf3Qn34Fbf0Qble/05SLkemFTWi6KdnIcb0MlESP+mBn0ylBLtmclTsY11io0T95hP+gE8EQciaOZfZAH12waR/0BgYcqKaSxurAHfqm0L0abGxLPE96KS/A25otsjgL7xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228776; c=relaxed/simple;
	bh=LBA1QUpuo3ESR19ijs1o1Zb24BTxyclNmgoZZfgNPrQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GxVKosQctbnMyrNLrNkjDtSuI0eisRG9eb/jVebkEoQ31sR3eyYeUkEhDA5ETdO8L0GQwBvBUpHTVmv/tQXY+hkMFwM7YltA6DkbxRMLE/f0SWzEY9Pbtn4vNDy2dy9kNRnMBowCbaKPisXxjX8bNBV9dF9NXJ1t3f1taXZxctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhrLO3IE; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhrLO3IE"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7dac7cfbea0so1244570241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710228774; x=1710833574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OLhaW2olln9Os7RAJXuN3bCjsvdIAxjaoWuoJVIa1T8=;
        b=lhrLO3IEfqEOT+HRc7tJ6VPx/Y3kDAB1ZEZB4afcG0uMGPoxXQQw1mDh47pxKe/A5y
         M1cbIwr3w0ij29MAOoB1WRPuPpRR2HZRUcdh/9wCYa3BSgNMiNLIiKxo6NVx7mZtwDnr
         oJuLtKdIKFwJ89qve6nFDwTvCQjuQfvl5ttL/lL/mFed1cbFuuSCtYZ8u05wXYKw7Jq/
         FaxtXub4ynhknjutMMi4RQoQbOjUchX+UNjOtCl7GyOgxF/ZF7eZIsiY+GEvP7cKVgf4
         9IMPTKGJkcAcPZNLwZQDyDhN1+R06+By29ZTCsvaKx/N76S+1zMyPk9/TX+Cki5NKpVz
         E+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710228774; x=1710833574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLhaW2olln9Os7RAJXuN3bCjsvdIAxjaoWuoJVIa1T8=;
        b=FkArkgysO50AO2FB9Fgufuu8d+PC7Si+SnxHRlQpvubMC6UxVKPwYtDnkS+4/nfWLj
         axdVTgQu7PKYWGrBDOsLjKJ6weknkTBZBRKs05tUIqvISHut3v65Hd0Szua/qe8Ncpw6
         +TggTOPKJEkfWzwDYRoyGzDg+bfbOgcfg0RSpPm1hQtdYcnptNyB4W4/y8hdRACIF45D
         ah9qxFt1nfoH/ZgKZCYRSyQCm4+19bl7C9qu5/MQwJ5SuRBeEx+zf9K9wBt6z8FyxoH3
         mvfrA7qF36hF3seF382s99W8UjCUM5OK0vcLMgbjZmNS1XtrRaOkMoIM36awUWvBDxU2
         YGhA==
X-Gm-Message-State: AOJu0YwQYjtIonDZ0y8bzy36bFq6xRquSl5ea8UaJrUDJHRbgjTqbbdg
	ceV1OUjwDxVWxzwAR1KsRPPWS8GnNIIsIZKRUl5hkYMk27bWb9yCpTp6EFs/
X-Google-Smtp-Source: AGHT+IEgD5Pv6TJ++D2s5Ss1dflRtzUEhDtvTylYfaQuooAUDePGeG4AKWKJRkO50eW1v2A0F1ws0A==
X-Received: by 2002:a05:6102:5088:b0:474:c45e:4e2f with SMTP id bl8-20020a056102508800b00474c45e4e2fmr158234vsb.18.1710228773810;
        Tue, 12 Mar 2024 00:32:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.242])
        by smtp.gmail.com with ESMTPSA id f7-20020a0cf7c7000000b0068f35e9e9a2sm3412191qvo.8.2024.03.12.00.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 00:32:53 -0700 (PDT)
Message-ID: <65f00525.0c0a0220.bd647.c022@mx.google.com>
Date: Tue, 12 Mar 2024 00:32:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4667219653823588410=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Add the support for RTL8922A
In-Reply-To: <20240312065441.31883-1-max.chou@realtek.com>
References: <20240312065441.31883-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4667219653823588410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834535

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      29.60 seconds
CheckAllWarning               PASS      32.26 seconds
CheckSparse                   PASS      38.07 seconds
CheckSmatch                   PASS      102.82 seconds
BuildKernel32                 PASS      28.33 seconds
TestRunnerSetup               PASS      532.35 seconds
TestRunner_l2cap-tester       PASS      20.38 seconds
TestRunner_iso-tester         FAIL      33.38 seconds
TestRunner_bnep-tester        PASS      5.00 seconds
TestRunner_mgmt-tester        FAIL      116.66 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      8.01 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PASS      27.30 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.188 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.199 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.138 seconds


---
Regards,
Linux Bluetooth


--===============4667219653823588410==--
