Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7F14B950
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791253047; cv=none; b=LVca6yMA4t8By62J4phZ8fqmlRo3h0AO+RWFif28QwWLgSwMZniR6g21hWB9cIiKtUEp1xX+5rO3Iy+4A1HmABYlMQANX9vvFAmRtHcic9IgBzPZ780rMecemx0PKqYZYYb+gZExAGT9gmCSp7YuYipt4Afhf2QYYL2mlbZ0uSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791253047; c=relaxed/simple;
	bh=vcUGe1o/p0+nnveead5NyxyrI94n4V2eayNHmMj30rk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N7o5yCGfkYxhxuJc+oRwNG5PVgu7j5iIZyfG5QbMGUnn1BKCCWchm6DMvQ/yO8yAo+oCXc2BGbBxxp4ykRGXJ0gL7SeGfLVffsMl5nh6bZYypNdQvxCHSin1DEW3ntPldhrIUl3D/EaypKh7NiO/sN1unpKhzPTvACYPeuWcsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHTiLgMl; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHTiLgMl"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35118a5991dso1403102eec.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791253045; x=1791857845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U/mqmnXHKqQOT8BsOFdWZfPS9aGanM5RCHyo1nwcfQs=;
        b=CHTiLgMlGDytE/JNxB3xJwo17Sv2AdAA+ZawDWshjEeTDT/sNomklZdfc/SIzXSV5j
         xiRVYRF+5OjbuEkO3iL2uXZ63N/lXuOtCNJAUaGzINknbXkBQk0O62nRDIrtjTEMTnxJ
         avI2yphNg+14158m0zQ9vfk6xZyV1pPxA/rqYLDyrkX6e1hx/oIEHAnmLdJYtcZry0RZ
         JlJ0AfGm9fAldDtO04Mt/1aIE576dKvQzBj2/bkEnyoIXNLjP6l0AWU4fW3k5rF34iB0
         obkeiRMMu8bIhgFb99FPpI+iArYzduWyICmy8IkiKtHJDx1IR/65HIUyGL2/kdpA1+uq
         k17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791253045; x=1791857845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U/mqmnXHKqQOT8BsOFdWZfPS9aGanM5RCHyo1nwcfQs=;
        b=fwiIyCWW9+1Q532V+XCvX56Tk+m8oEDYBl8+zKlYEpimQvTFXpHM9FIeJH4CSK/41K
         nDxATchvXm8gSgt0+BFiC3CcwxFTq1foH6flKnMKqXza/HsLzgssTG7/fwjc0gZICPSy
         33WNOjxFgpBNgcTNumxAUf86ltwJk8TxqFbUbJUX+/1blChSQecTFjrnKsj3TSrSV0kU
         nW/+y6ybz6DteSyyNgwMGtOtxxDXPzrzptiVHtV5bwlQZDObPGGtLaFmMjG7Qcb2t1ML
         GF2NtlVtlYre0tZrgq04e525JHPbL0dsiNqCuIHaNodZhgnUlMve4oA8IY8UgNpuidpz
         FS5Q==
X-Gm-Message-State: AFq9FYJ1Mae+X7uMHafyAyvajGtOp/n8obWOk8W9Ew/z30KtjlixVRn5
	ubxr9irws7VzWxT+k3OvP5fyyNCnSRg7tvYajYmodNl/f3bBunUako/EWyY16WEXRu8=
X-Gm-Gg: AYBFou1BjH20A2VTbFhViEaEHtcH0COp6jYzUWevNpDGpQo0V+tmUUUkj8VI6xkRdoZ
	CQ0wDjCTvWYD7aOfnSDzqSrFWSoRIPIhvtvRoPiZvAcYpiitkcTjuHPqTT9B1mv98uEyXmWpVx9
	Dvt/vePhq1WO8ovxyGYvwfVD0/TBc50OLTqB47PlcczG/VovgR8lD4n5vhNu+JBHuBIWullmWtN
	Z1jyiZZ6XCha1nngWMKds+MsRyuuNXcGDsxKgnQwbUHAL/ngpjmy4egSO5O3Tv4q6siHkrUYyDG
	Ernip0j93HMBaIECUv9xsTA6RHlgpk67oCj2yzCaiIiaF/YSu75v2cgEDcPH70u++6sePys4xyj
	6QivvjsdItEWVDxXr9/fhjFnVpuOGrs5C2GagTFAD36W+PxhGZfwZAXxGXjPahfsKmLTyJgfp31
	lJZyz8jw3cC5avAC9IECUHxsFKqD6XBLVUgxrEIs7hQ7KBpdluphwWx5tatQZcxqlc4wmOgIq80
	ekl
X-Received: by 2002:a05:7300:33a8:b0:34e:67d0:bbb4 with SMTP id 5a478bee46e88-34f150ab83amr13475681eec.10.1791253045268;
        Mon, 05 Oct 2026 19:17:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.70.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f73fcsm2496862eec.10.2026.10.05.19.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 19:17:24 -0700 (PDT)
Message-ID: <6ac45a34.1c58379a.19a693.3ab0@mx.google.com>
Date: Mon, 05 Oct 2026 19:17:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3953553742581747348=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/4] Bluetooth: MGMT: Fix advertising instances with Global Advertising
In-Reply-To: <20261005204420.3684587-1-luiz.dentz@gmail.com>
References: <20261005204420.3684587-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3953553742581747348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179910/

---Test result---

Test Summary:
CheckPatch                    PASS      3.21 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      1.05 seconds
SubjectPrefix                 PASS      0.64 seconds
BuildKernel                   PASS      28.56 seconds
CheckAllWarning               PASS      32.39 seconds
CheckSparse                   WARNING   35.46 seconds
BuildKernel32                 PASS      28.14 seconds
CheckKernelLLVM               PASS      32.04 seconds
TestRunnerSetup               PASS      710.46 seconds
TestRunner_l2cap-tester       PASS      12.96 seconds
TestRunner_iso-tester         FAIL      24.88 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        FAIL      62.14 seconds
TestRunner_rfcomm-tester      PASS      4.21 seconds
TestRunner_sco-tester         PASS      5.28 seconds
TestRunner_ioctl-tester       PASS      4.37 seconds
TestRunner_mesh-tester        FAIL      7.67 seconds
TestRunner_smp-tester         PASS      4.05 seconds
TestRunner_userchan-tester    PASS      2.91 seconds
TestRunner_6lowpan-tester     PASS      4.11 seconds
IncrementalBuild              PASS      44.09 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic

1: T1 Title exceeds max length (82>80): "[v4,3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic"
[v4,4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters

1: T1 Title exceeds max length (85>80): "[v4,4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 136 (96.5%), Failed: 5, Not Run: 0

Failed Test Cases
ISO Broadcaster PAST Info - Success                  Timed out    2.582 seconds
ISO Broadcaster PAST Info RPA - Success              Timed out    2.000 seconds
ISO Broadcaster PAST Sender - Success                Timed out    1.998 seconds
ISO Broadcaster PAST Receiver - Success              Timed out    1.824 seconds
ISO Broadcaster PAST Receiver Sync Lost - Success    Timed out    2.701 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 503, Passed: 502 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Add Ext Advertising - Success 5 (Set Adv off override) Timed out    1.950 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.519 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/864

---
Regards,
Linux Bluetooth


--===============3953553742581747348==--
