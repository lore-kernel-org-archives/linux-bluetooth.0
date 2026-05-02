Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34332346E46
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 May 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777743846; cv=none; b=Yx0Hs2hPg8mDY4Fjz9UmFOphctIC9yeA1G6fulfmOLEc8y4YkZNd5v9hDxD5Uy3Atw8AS9K0L54I0dKgW4uZVlPnbxo+skGdeeOR8SdE9Q43qhp70Zi14/l5+FQNQur7AwQIMzWhIjwUAMgf/mvEq8rIhNUVMDLz0Eifw+PpeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777743846; c=relaxed/simple;
	bh=1Q8R0RR2Xl42iHU4iOGZW0nZtngisqRmtjFWuzspKGU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iXcIy4HYrZ45emEJC1T1e6KvsJlgYrOqHxk87uCkbOJo/Ztct6xXKLRhsLbvXz5sqwLKDUJnOwKqfXcJR+NMPsAM/YAtHGEbcJNS0Eaq8QSuAkahmPyJk295fBSL9vdw/4Gq1xOGwhgaoWuZp/eLddPI4dM/KM9yfhilxsYiM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQi6GG80; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQi6GG80"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d868d014a5so2936230eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 May 2026 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777743844; x=1778348644; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OJrhyq8+uoqb/oyVIuk1BnUnX7QX/Vw/iCHRQvToWJ4=;
        b=JQi6GG80iBTKGIEMHBXgjRP8DYsLgZdlAQBvmFwMBVZ6O/QrS5r7rktWsGF/EFlLcD
         1DxRR4cR9hXo+HL7QBfr7xHvHELr7OnOlpy24zkXKVR54JMEtRcwt0LE6ETrkxtKr6JW
         5V/DvjIzUmtiiYD2v6dUFTpo6nOjIEowwVwfUNksNNUrt7cyzqKUKJOWg8dPkUiiAr+G
         CVI6eNfTdX7MhtUOfBU5jd/dGldgZ3k3jWs20bZWrGj0risVXhEtkLg/BnUG680YkYw/
         8iw58g23sKCvRl8/wLdRQMdiwSxuQ/zdsXgU/yVhNhHrYXhRi6bTc7DqOGs5YoUHc9Xx
         Ss+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777743844; x=1778348644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJrhyq8+uoqb/oyVIuk1BnUnX7QX/Vw/iCHRQvToWJ4=;
        b=oecKj4RyvyW9wzxaU9HpQjBMUdthTY9BxIq1XO6P+pMfUpNskIFSAGnArI6EnHAFt6
         eici5KBqfPBR05tNBK1GM3o/feMoXF8XQ/+IpQxVEYvfSYlxFjkp3J+S9KMNtbijaaf0
         BOX6pAONgN++uxfOpkUk5MWgHZPlidiWMYfPHNpfl5KM11K5gyMna9IsDHxqhVTZvHCy
         +MBokaY33tf5HePDd0OdCOHtuOSrp6kP53o32TOmuZPZa9LTdtTBYg6L0fEftVk8Gnj2
         NvraJGvH/uq7Zs+B6mubUwTY2HqGCgLnbkvnHc7hGaIgPNbGMGI59LkxNpgLy8w1oeUv
         h8lA==
X-Gm-Message-State: AOJu0YwlZvP3Dq/KCOGjHPy8Kf278EZzQYDjxU5la+gELDTojo/5aDip
	mc989SosCgR7pTmOG95Jo6/EsuBWHZt+/wt0Ct3H6JPY5pJ5et5KiHGWAEg+/g==
X-Gm-Gg: AeBDiesS5F24LoJvAaBaUT6L9XsIRY4TftZhLLcsS+SdMJzoklDqKoCpM+oEkNN9D63
	kjskoQk50hn3/+qFVSZrpTuQJjlRXahVyMS/JJL3kJyF6SmLlbLdy16R9NUt7/oNAa4IQPAkDrl
	6/ujkSJdfk7o5VDDC1FIWyzIbkTw4rzuBy+PBN8YeSVJfieqQhsbvWKNSbJmQE7hqbi3gh+zEJi
	c/hAuvfb9cJZ0fWkxrbm7aT41LNU99+VKkVVeoJjyznd10tMMTh70C8yzaabQmDTGbWHEbkT5kN
	ugdtlRa5kwcF+7jPuol6bbIoUi06L/7mFa5iIBNHBaIPv10VS8ttRLb4W9q8uPzrlQWKXYgphRf
	ifNeW9MikWahb6zcb4echDbfoEuLb/9YPWKjzvmRPdDhMIIiZVLqwhCrNX9fnuJ0N4xrSDaTTL5
	qBR66mBUd7Z/8P1Kvp5nV8CkIK7ulvpNIlTQqL4DC/1w==
X-Received: by 2002:a05:693c:2d84:b0:2d9:a799:3c4f with SMTP id 5a478bee46e88-2efba289d64mr1606315eec.24.1777743843780;
        Sat, 02 May 2026 10:44:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d634sm11095861eec.3.2026.05.02.10.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 10:44:03 -0700 (PDT)
Message-ID: <69f637e3.050a0220.2838d9.cdd7@mx.google.com>
Date: Sat, 02 May 2026 10:44:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5396055999089580047=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [v2] Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem
In-Reply-To: <20260502164303.2299816-1-michael.bommarito@gmail.com>
References: <20260502164303.2299816-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5396055999089580047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1088829

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      28.18 seconds
CheckAllWarning               PASS      30.05 seconds
CheckSparse                   PASS      28.76 seconds
BuildKernel32                 PASS      26.27 seconds
TestRunnerSetup               PASS      579.48 seconds
TestRunner_l2cap-tester       FAIL      6.77 seconds
TestRunner_iso-tester         PASS      295.82 seconds
TestRunner_bnep-tester        FAIL      6.75 seconds
TestRunner_mgmt-tester        FAIL      8.99 seconds
TestRunner_rfcomm-tester      PASS      29.07 seconds
TestRunner_sco-tester         PASS      68.13 seconds
TestRunner_ioctl-tester       FAIL      37.43 seconds
TestRunner_mesh-tester        PASS      27.11 seconds
TestRunner_smp-tester         PASS      6.58 seconds
TestRunner_userchan-tester    FAIL      6.68 seconds
TestRunner_6lowpan-tester     PASS      22.83 seconds
IncrementalBuild              PASS      25.14 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
42: B1 Line exceeds max length (86>80): "Link: https://lore.kernel.org/all/20260422011437.176643-1-michael.bommarito@gmail.com/"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -30.849 seconds
Device Info                                          Timed out   -6.201 seconds
Reset Stat                                           Timed out   -6.204 seconds
Set Link Mode - ACCEPT                               Timed out   -6.207 seconds
Set Pkt Type - DM                                    Timed out  -14.394 seconds
Set Pkt Type - DH                                    Timed out  -14.397 seconds
Set Pkt Type - HV                                    Timed out  -14.400 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.403 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.406 seconds
Set Pkt Type - ALL                                   Timed out  -14.409 seconds
Set ACL MTU - 1                                      Timed out  -14.411 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/140

---
Regards,
Linux Bluetooth


--===============5396055999089580047==--
