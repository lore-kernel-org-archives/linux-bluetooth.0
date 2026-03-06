Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B8346777
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833708; cv=none; b=WMyRSX5U1WTsKlDvqcBZEwMC/mLapshR+4gGwHZK4xm1kv+GnhXi/L+mwId2mCSRayEGHEoxMGTlCN5EDWAkP7cScQa1sFiY62tGHXmvQgkn7RzhSDBtSLyUFIlnY89d0RsqWDRphI7LHBV4yPZTkiAaEzH6F6LnWJ2sHUvD1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833708; c=relaxed/simple;
	bh=leGNSVBiFbO42LCf70lTndz7SIZE/Ib1ZYWHuZDBoK4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fHXzwfrV8+z5i+NLOZ3n24DTi0G6NfYxxvDFl3Vp5/5OuKuJXF0IdWSqyNPMR7j1jwKOwHUqHikmOBqKuGO3E7woUo71B2duMwUATWjPs/3vjQW1ncgQXPxOl/TzURY7spMXZUochG3qGcoyNGjIjX00cD32UJGxwoy/hhlVo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1q6GGCD; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1q6GGCD"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be26d11b95so6862839eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 13:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772833706; x=1773438506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ns5szxgj/cKGwa9WSTvrmXxG1xv/ePtS60I0l4Q+WmY=;
        b=E1q6GGCDSgJIhq4tJbRJxfxoL4D1EqrzOxR9+L+N42FE43C3cF9lCzj3qMWDCGG7GH
         wUiFqdvn9EjzxCWigpfep26Xzb/sUI/pk9/1FFcFOMAhyKnR69FoTty4MGRztacrFWJs
         A7zKe2929mbsDPP2VwqIZ4So9yMtT9HOxwcHCo1tLRudjiRTPhu/ZAVFuwSeSDaiiEYR
         hKZU51MD/PM7Sjg+LzMZwfOHnBcEiuziZiwhMjOhAk5W7849S0x5CYs2JDpPSBYQ5eVf
         AHcfdFWe2yPHFD0s2PoeuxSb7uc4ymAu8MwNsT/MeeYdgahVX0Id2FF/ZTeiqhOCff5F
         Tf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772833706; x=1773438506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns5szxgj/cKGwa9WSTvrmXxG1xv/ePtS60I0l4Q+WmY=;
        b=erfdxLd6pOcM0RbD2/qdIBH2wik7diuP7hdSNcC59+obv5FrxBSGoYtxTMxgs7uaET
         G7fQ77FQBCHi5FW39WhyQe7e8K1UGqzqCEZG9t5eurDizcz/LpuSZTfTfjUdm5erd3wP
         dIqpQ2kvLBOLra/7DK3Ye6Yhocv+7cUbSQZgpgO/7phePkeeYiDLhvqa+el403/y8M49
         jobA1tveSSuL0BmCV3b9raRW+bdbXDQ53uE5xeW5wqo8mg++KpwRrUkxjKUJUuX5KGz2
         D1AEjijmaRnZikcQ6O1eiR7nkNYZUCUn1itC3CtYQDXG75hRuTtAcvutUqWrlNIZep4N
         sDhg==
X-Gm-Message-State: AOJu0YxL4O4H5vqndOdRnnHGQWIaZrT+Yy+hNNaQr1dWenr061oHphdP
	vh4vRtvCNdtMnMLUNLccrDjGySYX45SA3vT52tVRRBhULzZQH6c9jTmB26M2Cg==
X-Gm-Gg: ATEYQzxEUjz1A9nmj+Fn4srC90ffvEYz1VuYAFY3lz5m8B/WCExb+2vkhFFCPzf4Sv0
	y5e4xdbPUKMQhh/WCWUBdwb9mO2f5peXgMYIvhkEeiOKgwWStbdV0j1IqetR4eea/6f/llgQ38D
	Bt7kWvGaeCyvcaylviN2xvw+wN1UAWgUl7b4Ks0hDQvMC5dZjR7tmivfkOmlbcZfhexZLajtrum
	Uc0CKwXToLPJ16kllbg6AY+SpQKuNpSHWl1rRlPhMNa5we5vRh/yPkMJLraoTcdZrNCpqA+xVrL
	a3fT+74RV0Ksce+2KK5da8RWBU+cZShF2EX0G6TQX5tXqzaWpHpjOi2OMCy56/p1mI8Tm+ah3/7
	ymXqvk+E7sd07Y648MRV2SiIwEHoNGNKzeO+x9s9B2d202LOFXP4ECwlfCJ5InczJxitV5aS669
	y3ra8uG3yYfZjQrvyCwRZf4W8Tx28rwg==
X-Received: by 2002:a05:693c:3104:b0:2ba:7606:ace0 with SMTP id 5a478bee46e88-2be4e03e9aemr1635365eec.25.1772833706004;
        Fri, 06 Mar 2026 13:48:26 -0800 (PST)
Received: from [172.17.0.2] ([172.215.209.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82b1d3sm2018194eec.11.2026.03.06.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:48:25 -0800 (PST)
Message-ID: <69ab4ba9.050a0220.114ab6.43a7@mx.google.com>
Date: Fri, 06 Mar 2026 13:48:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7978450861601813725=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
In-Reply-To: <20260306205504.701128-1-luiz.dentz@gmail.com>
References: <20260306205504.701128-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7978450861601813725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1062835

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.94 seconds
CheckAllWarning               PASS      29.39 seconds
CheckSparse                   WARNING   32.74 seconds
BuildKernel32                 PASS      26.58 seconds
TestRunnerSetup               PASS      569.75 seconds
TestRunner_l2cap-tester       FAIL      29.55 seconds
TestRunner_iso-tester         PASS      80.96 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      128.88 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.86 seconds
TestRunner_ioctl-tester       PASS      10.58 seconds
TestRunner_mesh-tester        FAIL      12.54 seconds
TestRunner_smp-tester         PASS      9.31 seconds
TestRunner_userchan-tester    PASS      6.83 seconds
IncrementalBuild              PENDING   0.88 seconds

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
net/bluetooth/l2cap_core.c:7799:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7800:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7802:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7803:1: error: bad constant expression
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 90 (93.8%), Failed: 6, Not Run: 0

Failed Test Cases
L2CAP Ext-Flowctl Server - Nval SCID                 Failed       0.114 seconds
L2CAP Ext-Flowctl Server - PHY 2M/Coded              Failed       0.150 seconds
L2CAP Ext-Flowctl Server - Set PHY 1M                Failed       0.152 seconds
L2CAP Ext-Flowctl Server - Set PHY 2M                Failed       0.160 seconds
L2CAP Ext-Flowctl Server - Set PHY Coded             Failed       0.145 seconds
L2CAP LE EATT Server - Reject                        Failed       0.110 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.115 seconds
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
Mesh - Send cancel - 1                               Timed out    2.447 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7978450861601813725==--
