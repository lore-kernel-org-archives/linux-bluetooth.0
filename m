Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388066;
	b=dapO8hibYcE9o1Ql3kCT9H9XpjqItG5AZW3OoieT6YAS96QTpTbRqhlucbSZIzPCP15k
	 vDo+D0hUBY08OYknklHmsLydtew4BwwySkAh1iZyycRHcVKjWll5H8kbR7h6ir7RIGkxS
	 zGlh+zotK76Y5fCGWsw3qxVN3KUSYYS9ZeqLSctnJdJsCOhdIQSm+d5vVMdLTAKpn3NhI
	 eD9oD+gCp5+6fvmXyZo6yH2XcRt2tBQxfgkFN9GLpR2V9kBnQCYxUS2dUfAYbXzI9vNQG
	 JlGzYxKxDmOPl7/PRX6Whv9xZPKCx3ZSNmPusj7XxfT3ULGvq5cfbd98dvitK5LliMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=9ecW6uwn6E+vZpGLV8eeJiZZw1fFTsfUU9zqgmIRs3Y=;
	b=omKLtFXWOCg3O0MLXoJIcQ+EErD1j8ejdtklHbAl0aNgCMLxoEVlzKRJ3C0tpcil6xPR
	 8YgwLnwdT/j/1xpCO8I2yC3Voakfr8yqPQ3m8Ruo5FpZdJOoM5WWdt7RqgQlFIresZkAA
	 0tCvXyRN49EnfT0mvLuLKSSB2P4S1iKpTDv014tz6DvnGcgdy4r3c2FC/iLKW7gOtGdQh
	 vUeGEr9vhLL+sr7sbOgNsAVpbcJx0I5dD51XLvKMwyFtd/ow2mamv1BBNfy+VugfzVRmf
	 BLetF1k3LqoYlL4n3g5lw2+P9MJDV2z+Q65OImIRHAMxR9KDZ99gxNA9vZ7Acr8+k+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSO3MP5G;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701C606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9701C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSO3MP5G
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9215934a14cso1054006d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795388064; x=1795992864; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9ecW6uwn6E+vZpGLV8eeJiZZw1fFTsfUU9zqgmIRs3Y=;
        b=DSO3MP5G3pHDTG+hl7Q2qcI4dclapp1zYXaVouoW87vrHQmrN4uq1nEmuyUgjhvkEw
         zGtRdDm5PxRXkQAXPvu1hY5n+TptparKO8g40ryp4E8ssJCPobij+M4ZWuX2Vm7OpIBn
         bK60zVims4WkrfnEsQuiTRUX3BY2KVkbds/MxonHgTg+cQ3bk+fNTsDCtbf00j2q43Rp
         K2+j04aPYTeB2ZZbMpUnYZW36M1J3Z18TJJQmo0LFhJr2FoQd2hnjTFQoLuCwCe9l1TF
         SM6qdK8xlWotsf9mUj4msmlunm4YtT6vpFd0OmhFcr92SX0T4WCXAjrLsb9yt4hcxA1V
         1kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795388064; x=1795992864;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ecW6uwn6E+vZpGLV8eeJiZZw1fFTsfUU9zqgmIRs3Y=;
        b=DxNrqP38UvRKJA2WfxNXe/hj9S8FXQqssEKOQyjEHIorvDg6Da1VDb9Kt6WtMO8eR6
         7BblGwOIKdJ37Tw1dJRBNFBEgNQebcc38mr6hakXcP68WUnVk3Mx6egb4egrytIMpJ81
         sN07KTuDVkVOVng+zYCj1D9Kr2vnCmzJyGMf14wBZ2GglfJxv2uZNjdmRu7n4NMJVVOm
         Zx/FBDCfX2WJoUlSAHkK7y4mv7yhWz2TMoCpvkJvEY0B3vbIsvBceZivP9retkUIJVVL
         +LQsZg2wmC5x1q4ioiGgmWsY8ma+wU0zis+JN6gSKtTNXeBsaZW6d+7+VS2QkraEctL0
         D3Uw==
X-Gm-Message-State: APuU4Z+bCVQpA9ixcxhXZBQDLSdwa6BWF8ISKqrIKnDRBGsQ3jonRDNy
	cYSglHvKfCE4Kbsf/bzdqIChCJyQCm45iOM2NS8MBsmlmVbYsm/7FuCDDTKD/JHB
X-Gm-Gg: AZFdTZcje5+eyaGIHzN9pOxrfp9jHVw9U5BjE1soWe1e+mDt6MAOmA387eRkuoQxGUB
	NU1dH4blFuLnKmCoNHeix47NPngroNHAAEPbtdA23CeWbVFeGb+InJa7eTvtbmkiunvB3WLgM+s
	FHxEDLgvcqmLa3eKXLzkvidupIXnkf4RZrZ8bbfORjdWVUzqLTvtyac9QrlrdQwzHBHYYvMKyXB
	mzWYmhTsKI8Cy9gGQ0C81z83io4sVnjgXD6epoLh7tsEA5Jh7sXc9Bb2rDmJRYjEFR8zCOVl0hS
	An95egQ4DqaNlv8ydEu1tHRY3aJhhV3BalcnyFRmQtakhW/JLrCogW44leDYFLxWE4gJuErSBsm
	otuEtj/SfBU0kzufW6jgfIKlCsZDnNKLkiiBUcEtefpOpZgcDOMyFHeIzXPBYIaPdbsa/p9Mfg0
	HVjXxSZmJ0yqXpdEHIejLrkV6GrbhiYMx60c1eyTtW3H1T6/JdQpjgiYNorBqK8ypyv3wRAtTSG
	DMix4ONZbbe9uSrR8uHvi+GqPig7S93vfFCCu3hqpECpntm6SwVsj472KpgWKH9PT/R8kyCkg3f
	dxYwPT3w
X-Received: by 2002:a05:6214:3216:b0:921:1042:c47b with SMTP id 6a1803df08f44-9213496c230mr194330916d6.1.1795388064441;
        Sun, 22 Nov 2026 14:54:24 -0800 (PST)
Received: from [172.17.0.2] ([52.150.30.135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b0b10sm89759406d6.10.2026.11.22.14.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:54:24 -0800 (PST)
Message-ID: <6b0372a0.eb52b69a.c502d.2ba7@mx.google.com>
Date: Sun, 22 Nov 2026 14:54:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5753326776468299636=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: hci_event: Terminate PA sync transferred while not pending
In-Reply-To: <20261122201320.2851760-1-simon.mikuda@streamunlimited.com>
References: <20261122201320.2851760-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5753326776468299636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218947/

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.26 seconds
CheckAllWarning               PASS      35.47 seconds
CheckSparse                   WARNING   37.63 seconds
BuildKernel32                 PASS      30.73 seconds
CheckKernelLLVM               PASS      32.77 seconds
TestRunnerSetup               PASS      744.29 seconds
TestRunner_l2cap-tester       PASS      15.09 seconds
TestRunner_iso-tester         PASS      13.13 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      89.08 seconds
TestRunner_rfcomm-tester      PASS      4.51 seconds
TestRunner_sco-tester         PASS      5.66 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        PASS      4.52 seconds
TestRunner_smp-tester         PASS      4.41 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      29.02 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1192

---
Regards,
Linux Bluetooth


--===============5753326776468299636==--
