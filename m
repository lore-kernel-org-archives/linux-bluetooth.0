Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253534;
	b=oySCOTtqZ9bNbHYO5UWXbGFvFOWn4aVPTENGkUdltHZThCg/uj5N4eNd/Jq2oxkeZ6C0
	 iu0yF164Z5eotibxgH2B+kFLBlnPz2cEXVlbDNkG9mJYNxw6Ydu1VqeAUFf7Cnilln6sc
	 W3bI5sisE2W1Y5QwkRLOxpX/9I5v56DuIIsZZh0BApsAVHz/EiBNFQEw6n7lyJLmKdrED
	 DZt9flljJUGgqFxBaWQqRAY4uUkZUqFye5UlNfdFGbZ5PNdCzyq/yZDgvqGNVEL7Bf9tE
	 1rLBlPCsoKPxTnyRDKB74nzE/e8k+mGRxih+gI+kWJ/ubgpeFeGwgzZtcg7qE04NCTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NP+51CYI7FHoWWPGSxY6aCPzv39Q9OQfV2fPsxE3+Mc=;
	b=OoQeZZKS4VJKZJ39oMlL+j2ZTawVjb3kBBI3NSh+e3SmQqMsrnOJxSwWMKg8Yt8qsObV
	 4m4HtOB826C9RXVYp8REcI0ufIeZqcsj1NuiNF1qVHMhbX5ISifp5Ta4aNs4AVrQxL0al
	 ufVI8D71nZmi4jX+uSNC51tbNXyVNGCxQhe7Ro8pKLbnL+d/iDsyM4XtBk8KpP1sPRplU
	 44+kKoWaqmG9FaRoO0QsV1Y2a8Hv8Esr30bNcLX82wTykbrOYkVUm5QCHRRpq0pHRbUdf
	 w8VjSj84NwzizVmAiMOCAbfh15tUm83aPejorCsedz9EbS9CwWElOm2SoTjO2v6asSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kmac2fU1;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA79606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 09:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA79606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kmac2fU1
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4d198f1a591so1672336b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 01:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795253533; x=1795858333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NP+51CYI7FHoWWPGSxY6aCPzv39Q9OQfV2fPsxE3+Mc=;
        b=Kmac2fU1hk9ULvccxj19BYleIwtGtsUwgJxeOMPVtzIImBBpuS32hMwqpj217EgS9U
         I5ZEjHsXiKSoYBSl5dtmW0HEvTgQ140xyr6tkVv8DVLJRAV99i8c4hamltq/xwIicDoS
         zeFDlmV2AkTv5voBrEtNOv91MagfpwW+MhBHj29olpILS5kWbj8wKlNtXn7sM9lXVYK0
         BFWUEMcC5KlMsFtpYxirXpa1+ZlEm4lhZxVXLsB1pC7y5sCVcvQyDdeh5lJCMmD2Y0sM
         dG3NrMPaxrE5MmXL2+kul5jKE/+rTH92xBcliRnqxW5y8PUf1t2g0rbZdK74neyPycVR
         iP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795253533; x=1795858333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NP+51CYI7FHoWWPGSxY6aCPzv39Q9OQfV2fPsxE3+Mc=;
        b=RrhXsyJLqLchYNPwdeZSISyicnrY1P7dRGM2gjKO1iu5cNyneQCiX8o7EbBIEKRBZs
         SS+/STEDERkHQFxzDygUbBJjk0KJbfTlti1mA6m4GcVDoHuAuCGsbcTHIXf4RkOKhtPc
         74i1VlW6P77SpqcaGKlvVMKzSrHIjzX1ZrdVR4F7PY+iu5hKwVRh/lwkiyzp0BneiKXk
         rcT+efSShcSlsPv9snIGgrT1ht71DdbaK1cxF34mcnRrJYBObdWJrk02bt6hQrIeDP//
         3Qd8aUFl/px4nW2cwifGFDuHsIat02TNZhGFqOoHyLlnT4VkunTqXTfI7kxypAt0HdIn
         BCig==
X-Gm-Message-State: APuU4Z/FmoQ8PPaGnOST9sc8aM1Wkg/Jlb0QA5bDPXIV8TTyLfzXgjIq
	S6JnvpTlj8tbrNOI1EDHm9PQHo1Tovv9Mmc5ywMlV5JUMgbURJb9gLRMFLhBzg==
X-Gm-Gg: AZFdTZcv413j8JrRSnM+DewHC5q62SEKgNQkVsQv3XL+mXjmriBosPCGagDkoCDu8xf
	FZJdSaOuJw0YU6EzxZUV3xi6yRifMT/vGO3hWnzuWouXClzQ6KEYtBflloI0PXjoqhUS3Gov3SX
	Fh4VMgG99j1XF7gYJkYQYGkDkPFCVu5hQdWlwwVpYDGhenmY7lE9O83vQ05QFbNoJEIoSV2Bl2W
	eq54xIdo+8LGTWcu41v8w17I9vGonRDNIftKB/GsbNxhsUBGN5hotJZZvB0UzT/nAvlLWNPE3ny
	3xr4xtHhd9R7iFtdm39cljo73RUqldGmrABfXQKfXC/gkAKb9He/BTW3ArU+AhhjiLpyBA6ZZTh
	Z9WNA1Dd23zlgLcX2pv8HhKd6KkCRei/6M+Whuz8tznInIZdf7bqgEH+dZlrMVbUcLLralK3nw2
	lIw0d8qqN+irYe82sRFfTeqemTrgaQrnrDHQg1ZhEgZC5ulTuDk0WNm5TFNHhrC5slX0d+roMTY
	M+NjGU4VE/RrX8+TCVsw/TC7HYd5Je67d/xX3xNTo6ohjaD4FmXJDPoid6x3Bg=
X-Received: by 2002:a05:6808:5198:b0:55c:928:69d1 with SMTP id 5614622812f47-57a0b750439mr6553660b6e.56.1795253532745;
        Sat, 21 Nov 2026 01:32:12 -0800 (PST)
Received: from [172.17.0.2] ([20.40.223.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35655a5bsm4244001b6e.13.2026.11.21.01.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:32:12 -0800 (PST)
Message-ID: <6b01651c.a6fa7752.23d37b.bb53@mx.google.com>
Date: Sat, 21 Nov 2026 01:32:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7800574023123532070=="
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
To: linux-bluetooth@vger.kernel.org, andreiab9019@gmail.com
Subject: RE: Bluetooth: fix bonded LE peripheral reconnect completion and holds
In-Reply-To: <20261121033104.441146-2-andreiab9019@gmail.com>
References: <20261121033104.441146-2-andreiab9019@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7800574023123532070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217910/

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.52 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      20.05 seconds
CheckAllWarning               PASS      23.01 seconds
CheckSparse                   WARNING   24.33 seconds
BuildKernel32                 PASS      19.95 seconds
CheckKernelLLVM               PASS      20.35 seconds
TestRunnerSetup               PASS      433.53 seconds
TestRunner_l2cap-tester       PASS      14.55 seconds
TestRunner_iso-tester         PASS      10.59 seconds
TestRunner_bnep-tester        PASS      2.84 seconds
TestRunner_mgmt-tester        PASS      82.63 seconds
TestRunner_rfcomm-tester      PASS      3.99 seconds
TestRunner_sco-tester         PASS      4.98 seconds
TestRunner_ioctl-tester       PASS      4.11 seconds
TestRunner_mesh-tester        PASS      4.10 seconds
TestRunner_smp-tester         PASS      3.96 seconds
TestRunner_userchan-tester    PASS      2.86 seconds
TestRunner_6lowpan-tester     PASS      4.01 seconds
IncrementalBuild              PASS      31.77 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1171

---
Regards,
Linux Bluetooth


--===============7800574023123532070==--
