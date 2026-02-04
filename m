Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDC32E72C
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244980; cv=none; b=P99SLjg9cwg628GGG6vU9xQLpU1Kr4zoO0yY3Eyaqp9gUiPMGt6isJxkTFEivpISeqLOHp++kv+W5VNyRCPaLwin/1/Jv7HiASP3H80miUZJl+jwlaLwchPLq2TQyBUvj4nyiEwl6pyDnxlR2ZEIeegu4+tgeB+DVtHDiP/+NPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244980; c=relaxed/simple;
	bh=OjOdeIt/KidMIWBQpZ01+uY3YpA1nb/2bRgKBquSHVg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Upg1UWzIiuwC60u+Z8VWutP0Zctkw/wzBPV24s70lenjCTFE6JIDU78RrJCzCvUR0Ti0BuOi5iLETNYv5LOqwmmauGeP9TPsfbLeeuDlAcaLQeZnspc13bQH30CZax5nh6cCFvm0PyB1L9aeQaZvgUHcPJgiCXIz+i0olrLi7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSIHssyK; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSIHssyK"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c7146b0854so24791085a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Feb 2026 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770244979; x=1770849779; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FmdVFu2eCGXOPkK75AL7sbI3zX2p0h3orVqLj2PGivU=;
        b=KSIHssyKQfzLAcT5kd9HSWWBpL8VTYe7B1BzncSyMdibWBFKUPbxR8KPTrySLAc7r/
         D+5daM4fQQMsbFqYSkKRyp2VnV55vHroWo4zs5HgutK1wH77XRgJZl/jooGi7+uMgKaM
         U3ofPSjBfPNaglWpLou48X9Gmvi0a+rU/ii/EIS1iMfKUYHst6xkOt3lfHTmKINCEseA
         EI08RLzonbHjNsn8Y7qis9SD8jABs+ulDbKPPA524s6RbAxq7LophBuM/NkAtGSyYe8s
         WZzCVd6lLdtV8+VIF/vY+LdW90rxZO0uqDmFh6UJQHKhtFlpAGA1dUl3W8ZrBq7pdvhi
         3aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770244979; x=1770849779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmdVFu2eCGXOPkK75AL7sbI3zX2p0h3orVqLj2PGivU=;
        b=BkB6VJxi0OVTDJ9JIlN6BhRY1Ip+jfz0oTRwjNtpzruIE+/eJ+lxeC85T4LwNY3mM+
         XV9fVpxe/USMqZgyRLl2F1i9yELrR8wbijR9h/bQXOvY9z+0C7WCQdWer2MRf4An0SuS
         O8pOnXj1A1w+msN/LJSy6eNr48mEZ/Q83GSsDyS7VGz2xrXMqDaoiOzxGJUSYlBqWv4Y
         Yrjl4Ab//ywcVDhZz69EtUQUUWXegb1Pe58kNy0aI8GX/WUWErDRtA5J0cL1kCm8ZC6Z
         wApRRzQk2bbuLvooshsDbcaCByCG1Pgk70+ETfgwvkm+F4EJZkwctSVUyu5nUTdd5BO9
         l82w==
X-Gm-Message-State: AOJu0YyoifUOlbXRVmiAB9ZJyT49qnk+fN57vXk1ceoZVK4vzcjeybpW
	TsO2dcfr9tkBDt0/s1uSriR49EVUa5W3vo/roGy4YaDvSH69PQ/OW+Vz8GwWaMhF
X-Gm-Gg: AZuq6aI/5XzQ/NM/qVnzjK1WDGdFDvQV5g91Mlc/ZnjX1PLRNhD3Uif2i5y+wxwxKtx
	9u7vo5VSGKet/3QcjJBbOSAEqDGketYKXzzACd0MD5fKESA1Ts5UyWt1vp1f+h8JpluKu9BLnqn
	05I8r+ljIlrB2KQWf2rkZpXyBDY3C7FeqnwzsWXrNcrKhH16vGj5bq03ZmnM51LdhU/wWsUHac7
	YakEk9lHWFb63/OPEFdAGErw+Xwy83XSVZZ4D0pIFLnGX4u0en+tMiIFEbFAbfPEAvn2eZAU9NK
	BBHHO8jqls7lZo4yQCFylNui5t3reJMAXcIkTdZ5vjA6DT0wjIqs3rMrDI3ee60/RWwLP6qHCKY
	Pszeo8O1YF3y9HKbr9FWL0PFrgMSiJ8FK9EMqJnE0nxpOZNROyfjVKCRcrP7N3uVBdm68CbB7oF
	kZyLoCXq44mjMdWh2rwQ==
X-Received: by 2002:a05:620a:298e:b0:8c7:7a3:501c with SMTP id af79cd13be357-8ca2f9c0714mr592643285a.52.1770244978680;
        Wed, 04 Feb 2026 14:42:58 -0800 (PST)
Received: from [172.17.0.2] ([172.174.223.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa5e315sm282087785a.9.2026.02.04.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:42:58 -0800 (PST)
Message-ID: <6983cb72.050a0220.25908e.ce96@mx.google.com>
Date: Wed, 04 Feb 2026 14:42:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1734035107065273713=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
In-Reply-To: <20260204214400.2376083-1-luiz.dentz@gmail.com>
References: <20260204214400.2376083-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1734035107065273713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1050911

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.59 seconds
CheckAllWarning               PASS      28.46 seconds
CheckSparse                   WARNING   31.81 seconds
BuildKernel32                 PASS      24.96 seconds
TestRunnerSetup               PASS      558.85 seconds
TestRunner_l2cap-tester       PASS      28.09 seconds
TestRunner_iso-tester         FAIL      51.30 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      115.64 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      15.89 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
IncrementalBuild              PENDING   0.66 seconds

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
net/bluetooth/l2cap_core.c:7762:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7763:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7765:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7766:1: error: bad constant expression
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
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
Mesh - Send cancel - 1                               Timed out    2.715 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1734035107065273713==--
