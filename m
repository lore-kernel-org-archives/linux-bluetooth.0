Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA2472528
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865445; cv=none; b=JJ85t1zdip1tBsjI4GDkm5lfkNCurrknFyuqNJvt+SGkBSDJq/8U8Jf+GxQEl9jC6NFLPM+Wk63aWGoYeBDH5dl9n1NKaEbAkmQrrTVy61f8GmE6WcYAbFnkNP30cw3uZKw88qPO/nftJkkbhLNFYvIOqcUe47niHzO7WNztFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865445; c=relaxed/simple;
	bh=aN2gWl4pT5lDNNIlMygRFR/TOXo3tRQ7lanbtF6n1vU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Y0K+7MDTJp1f2EkpGmF8YfH77mK1sZaWkZd4Z9azDWj2AlwfH4Gr7o7ST1UvpelYOUF6z06KAbIOTo2yhofFwpq3V3KzdLjVQc3xa5VVUfioSpEg6Wn7sHsyyHbkXnR2S66or1CKnstzpV5lgPLe9oSUF1nCZbCSMiRyzetdDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtYdZW8P; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtYdZW8P"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f84a55cc06so1556909a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865443; x=1792470243; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0HUIwp1x2V88LDH+xZPc8KxLub9URT06v6ZMWlg7dZw=;
        b=WtYdZW8PH6JAW4yAHnOR+Hb7+fXn1o3D7XCZQLybhkzLgrwvyoblc1hkMD/tMsI6AF
         4IM7mqECV1Si7JrYBfH6NSGnoj5fAGY9NazwoGvXpMEiiyD3kyzRnmYJMIuIoOTDV4wJ
         +QiFkeOs7jTFY8kREyqx9gTvAPWwEEWPQeZo13CJ7tCJwsVdxp4Go+PQG4ejmVwdfJBS
         dGGytZgwBZn7HSXLdLfOp6Ck2bre/4efXmsxK0ZE1z177jq0e3UcOZLKPDpgX24YyJpU
         BRPwVHY627nXDTmSjzniJ4oM3aPHXAJUWI7TX6pMyjDHTxGph5qQ4d+g9Ba/9+63/2Q6
         TuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865443; x=1792470243;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0HUIwp1x2V88LDH+xZPc8KxLub9URT06v6ZMWlg7dZw=;
        b=kjQvIyx/1LcdjobE5m8HTr24XDGFpLwIUCO2j6rXR4cSFwctWh8EVSwrJhWWzZVFgH
         ERX1AX8sUdm/lBKLkC4vjpL9JZbyLOq/0SqbDpNVXiffQUPcqor0K/GUXTBxejBJHkrb
         pKLg4hfJ+pb6+4mUDLUiLfh6825m5fuzwxJO8OpqhgGDEycc5ElCQHVHZjpp5WTmzWJR
         a3wmnj8Kv9cWbJoRWWoWfNs3DKRdYTolRK8NcIqKTl54oUNqFn64Mfxzxs0dtOkf9usl
         KaTr2h+otaw6ej7mxQsOmXfgVkecXOl56/v+Zew0h0bUvYslj/oGSMfrFP3RI5078zDN
         n9dA==
X-Gm-Message-State: AFq9FYKqSKPKkM8sz6npVTTJxPRHawcezD2+m3kEHZyyWzg1Ar5u55Qe
	dJ739+8isNNeBYH8+AkL+Vbn9j0qO1Aga46XgVWc/PnA/hNsYqKsuJC8CyMo5g==
X-Gm-Gg: AYBFou3N/2xixy6hh9OLyUYmQsy1Wm3+Wrv/xHMNULsbxg4E5LC6VsQg7CXZcQVtfIL
	C09bZGoZmFdJhf/OU8id4e+4wTvgojmqXCVx2TQIsOanDOukKAxyUndtq5P2YDqDKx9SOjB8gtp
	5+1aGAYmN9d+aSLJEHgCACL/8nUoNrq4m4OF1aE9bKtWGDVz9XazwyLftNnanDYoO7Fw39VxG3L
	Liw6y8OzzbA/l3B2ng/aYuWsooMVDrxRPJId60LXjMc5Cjozldzgtnzavh6dqprckBLTwqoQ87F
	Ki1HygjvCptTubW3Bu+HfbQN8p5gG4bOkmdw/A/RstdwYOXTFxZ1c48dYr9Irwb5LfuJ15fgvps
	IObtOGpwkko4HBumZAj0LR+JtBILya64GVauInPyR1rxu/ComGEMgTzvWluZRnDwPXEvtYgbebA
	tmX9Q9lkUTgBpXOrjkH226w8FDlnrN/ghhr9+3HNLKfWAwiNiHn7BSCKAoXxS7FYNEFmEOIuA5/
	aibGA==
X-Received: by 2002:a05:6830:81da:b0:822:a29c:a0e2 with SMTP id 46e09a7af769-83095b2e1a6mr11311370a34.11.1791865442614;
        Mon, 12 Oct 2026 21:24:02 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.202.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328ee6sm11910987a34.23.2026.10.12.21.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:24:02 -0700 (PDT)
Message-ID: <6acdb262.2eca3aba.37f0b8.105f@mx.google.com>
Date: Mon, 12 Oct 2026 21:24:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5564829043233299481=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] Bluetooth: btusb: use shared ACL buffers for TP-Link UB500
In-Reply-To: <20261013032742.497402-1-cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5564829043233299481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184337/

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.08 seconds
CheckAllWarning               PASS      26.61 seconds
CheckSparse                   WARNING   28.16 seconds
BuildKernel32                 PASS      23.23 seconds
CheckKernelLLVM               PASS      26.84 seconds
TestRunnerSetup               PASS      535.88 seconds
TestRunner_l2cap-tester       PASS      13.73 seconds
TestRunner_iso-tester         PASS      13.59 seconds
TestRunner_bnep-tester        PASS      2.74 seconds
TestRunner_mgmt-tester        PASS      83.63 seconds
TestRunner_rfcomm-tester      PASS      12.45 seconds
TestRunner_sco-tester         PASS      5.05 seconds
TestRunner_ioctl-tester       PASS      4.23 seconds
TestRunner_mesh-tester        PASS      5.07 seconds
TestRunner_smp-tester         PASS      3.96 seconds
TestRunner_userchan-tester    PASS      2.83 seconds
TestRunner_6lowpan-tester     PASS      3.96 seconds
IncrementalBuild              PASS      22.18 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/908

---
Regards,
Linux Bluetooth


--===============5564829043233299481==--
