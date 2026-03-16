Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6E283CBF
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662732; cv=none; b=IcqtyktMAlyhJJWD6sL8hPYKHPkSgoqD8A5B1e8aMPk23p9+etymB5uEzHZGTHFS5QgoyTXw75wkdUp6PI0xDmopNdTM6TFrnFhc4IkkoOr62gHkBvvphB8mDhtVHjkYpnqipwgvwuILBPMWmNgewxUJFvIr7KfExty2xVl7YsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662732; c=relaxed/simple;
	bh=uBFABQTqCkGwD5imievo7NBf7iztFV3TdmoQYOoAVAA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NnByWrS1VKBW2qc9UTqubSVlcqiYgJxH2yqE/+t098U4rMPkqXzFfYV+IqRvy6OTbtcS58merKuUfJoAzTonfSHXrNsHJ3L7PZ7pMvrxXNUMDckVFL6wk8otwzQ0381ZYEKcvz6DDrdBA+Xf4vCcEK08T55hSX0OSYqhCx3COHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsUoomUD; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsUoomUD"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271195d2a7so364648c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773662730; x=1774267530; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dJGAT6SjykzR7dbLNW2zNLo6jx0yWWRhHiaS18xZyJM=;
        b=CsUoomUD0dz9bNCjp+JgaVRmZuGo4zE+KsOm99tPiWNmHkGE7DXaHNQ9dHUvppILPA
         7ZKPZ4HtvoBQMKxv7dZgwaG/vu7fCClfnE8CwKrKyIeHGNl/EpPg8kI5F0ucfEgdPRQL
         rAqvNCCmtcgsJ35P7CKr7QUgpa0Zx5395EoqWfTE+xEBgRu+Vl/7UobtqcaxXb0uzb2o
         9ZJ4wbsHyDc1qjoa2ksIOcPEH4jjem0NOz/U0GFvhv9XmkK9ekOk54PTX0cX1sR4gu5N
         cnwLg1twyK2kY2FEey1XIQzrPo3rThCbenixcVmqxxCpOZcxHO+U8glWsWBaLWhwAvcr
         Sdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662730; x=1774267530;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJGAT6SjykzR7dbLNW2zNLo6jx0yWWRhHiaS18xZyJM=;
        b=UGbRUAlkIhTbQFtCzgnCDOxgiOPPdSTXPaoCQdltNykdEWz8J1qrBU6DXnglKSMb7x
         OPxdHG0ffKi3cr8wi9EzYdrqA4aSOxujG34Y/lKUufnwnNg9qPVR37Ec/zaByxWvM8Rq
         5bTyE6wPD+kOaxKVBMAMJ2ZkXdOJYpvtgmSc8yxgaBCYIG91ytza7wMYd4Mgx2bAt2DW
         Lmirgjvc1Y+xG4uIuOn1lU81hx8GIdiBBj9e6xxSC0ugv4w3GG4ScubF3RM4lzH+NCKQ
         j3xUyrF4yN3vPA+haRSNS3wi6eMWUbDznJ9ztMWy+Ip5vDH3GB2ukFEaGHP5oUDOhxNL
         pe/Q==
X-Gm-Message-State: AOJu0YzyYmKg4fRAQ8aEddRk9nXauguAzKwT6aCXfNrTpXmxHHUP6yAx
	vnrDtCD8zZ14oFjdiP6p/x/+XLz8+eFfYhanFWALouLuYeywmSiNBE3dSc1f6A==
X-Gm-Gg: ATEYQzybKI6P0NxipCDOJJa2w/sKrZJSTfO0Q7enuf6j/tOAMeae3np3jYiU2OiOqKi
	riVjFfzjvnmLGJ9tzrX0O/oTAkW45fVtLLuNvlKPBsyZJMbhH7VgWNY3hGvsYhK+0FOCG8884oH
	HRir0O1foGRixtdJhftPn21y1GNVFMM9/1e3EF4OOwDLLslCasZsX1GmTGPNnjZjcDvaf6GtTRn
	kSL5GTJI5rMt/FbeSxd9ibycgGxRqiyMjLU3idaVywj5lMHhp2j1ALAvzvSWBOjoIqpi3QaqMEQ
	UOpI0HsMjiYG1Z/TrpWaAIEP4EiLHiRdeNsyk14Vwq8PBQertX6jP3tFfRnp9NBM2MRwFbX1RIa
	vgbeHu6yhn7lcWX9j1tmOTVReiLqx3xUqi3+ecX8iI01FYh5X8qDW7kXjrxTkPYBiAaqPDu6t5G
	x9wqqc/KaBF6cGa4+YDvEd0hNvMXRoAGgm3lBEYQOq
X-Received: by 2002:a05:7022:6281:b0:128:d036:4ea9 with SMTP id a92af1059eb24-128f3d3bb47mr6458460c88.11.1773662730408;
        Mon, 16 Mar 2026 05:05:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.211.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab525c5fsm13940255eec.22.2026.03.16.05.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 05:05:29 -0700 (PDT)
Message-ID: <69b7f209.050a0220.1b8bd2.a390@mx.google.com>
Date: Mon, 16 Mar 2026 05:05:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2537914410468255026=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v5] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20260316113047.100627-1-hildawu@realtek.com>
References: <20260316113047.100627-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2537914410468255026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1067266

---Test result---

Test Summary:
CheckPatch                    PENDING   0.59 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      28.58 seconds
CheckSparse                   WARNING   32.10 seconds
BuildKernel32                 PASS      25.39 seconds
TestRunnerSetup               PASS      563.76 seconds
TestRunner_l2cap-tester       PASS      29.42 seconds
TestRunner_iso-tester         PASS      80.60 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      114.80 seconds
TestRunner_rfcomm-tester      PASS      9.64 seconds
TestRunner_sco-tester         FAIL      14.76 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      12.45 seconds
TestRunner_smp-tester         PASS      8.78 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.63 seconds

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
drivers/bluetooth/btrtl.c:2178:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2179:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2180:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2181:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2181:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2182:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2183:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2184:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2185:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2186:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2187:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2188:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2189:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2190:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2191:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2192:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2193:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2194:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2195:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2196:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2197:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2198:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2199:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2200:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2201:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2202:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2203:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2204:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2205:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2206:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2207:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2208:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2209:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2210:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2211:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2212:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2213:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2214:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2215:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2216:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2217:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2218:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2219:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2220:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2221:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2222:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2223:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2224:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2225:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2226:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2227:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2228:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2229:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2230:1: error: bad constant expressiondrivers/bluetooth/btrtl.c:2231:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4689:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4689:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.737 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2537914410468255026==--
