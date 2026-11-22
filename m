Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388154;
	b=oIlb3I8r/muJ8Tv1mNzuvxrXQNjD440Uz1p20qYjclmIH1kGQzyoMnDNZ3RN+Yr9EzuX
	 TRCU8QUvxTbusAXjgqsXacVdu7PvHdFDPUq10gKlkib00dE+aJEYOzn5x5EV4e0yiArFL
	 HMcj2yQ4ZTSK1gmURdvdalPh88PlmKCXRWj015zv+IySgSrMtMly7fZ7aVE+oYK6gQj+E
	 uPonJbfKDGjW+G7hMgKlP68GKhFl8GwHIiBGcc+xGyxSNAd3kSVJcUgofEx403wcv9rgc
	 e3NCuon3QR3rskw1ba/bLorm6Ivvp1DO9itSxJcUI1mk7q9cr4GdOKlIn8ivmmw1gyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6VbtcQeN8HLpWFQae5vQeE/d4MjLKzYM2/nsAXvkzf4=;
	b=kMMbdE+xFcvJbhREFUIt9G9M4EEMehrGbUL2UIWLYDXBGlwf3/pyY5ILriBREuaoxcP2
	 dA8jVZ0CNll9VN3z7qOrLymrmSpFYExSJjqLZm0uw1eZX+wO6BkvjhYayq2vg16hutmag
	 AFMGhPaM5sUMmgkZcgqOBk/XCK53xOfAPvtJbKDdsB7+797z+EiquQ7VkRQW6Nxtal+Bz
	 f+bkGskIHKUKeYibsztN5vR+A8AexwYqNh+EVZ/oxEWAD8o43F4a3QH9FDPJwATaQFVY1
	 yqEuF/MaWDvAq9PEBl0OI9HhxMFK4HSeu8vrAWp+N9pygSG5r8tbjWnIyxrYKs5aqjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gLgdMWKy;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055A606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8055A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gLgdMWKy
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so3773900c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795388153; x=1795992953; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6VbtcQeN8HLpWFQae5vQeE/d4MjLKzYM2/nsAXvkzf4=;
        b=gLgdMWKyXUzbFMRRKOIV6REipJK2yxjWVlJHpUhObt9LvaHCqx0a0n4wsqmH3zLDxt
         MvhmWSGFGE/XvoIN2nK30we4adfYCBAPzFjSQq/32ibmvZ+OlB/pXpobJU1GD+KvIWWr
         t5i9BEo4/Jid9YBMOqEXDMtbPFTA/tGbaHU4QaKAxKX+kX+Z5F3yHMuZ6gLbgja+JnSM
         ASJqqnfFAGARSeBbauYUR+jU0+XifoQQxMmwVhjyxc+KSblHqXFD27hq+rGMT9iJwow7
         DQXYJIVJP2j0l9dBLakLltBRXRB3E2EkL6qKXvwxxblJ1QvxmSt+X39V164betwvtEid
         JKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795388153; x=1795992953;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6VbtcQeN8HLpWFQae5vQeE/d4MjLKzYM2/nsAXvkzf4=;
        b=2TX8kXH2CJsUEI0+dedYqZ8RE2tskxcrflOY1YvTleFNMGN9KnmT2itg1fxvO/7Em1
         M+IWNp/WKGFHJVFba7hECQoI5Cgw5gbnanq101ncCjVbZ1uttA6wgAv75RkCVPm2q297
         YG9TPW8Jq+ixsGg5SFH+AdVRfi8+jgGH+rinKM0KPDN7tLhj7B8VnuvGUz8IsVo8EiWE
         48tal4Dr7inp3yhmpnCjS4ZK4v6e97GUEJ3YFfU3omRaVglyX2iCExFDliGAbjxCRG6v
         pfGPAZ6jNiPcZsH9g4Dj/E6si5xTehXiPULz7tKaOtJHves6bfJ40W8nVjMse1LcNbTr
         QWFA==
X-Gm-Message-State: APuU4Z8BOSSxzGBGApXquM86UWAyuzkAok1S/opyWmOK5gcbzTbqHyC7
	4ju73tO8gBQ8NU9KpxpV7c3OfXKT/Pk3QWG7kZR7DwaI1mtQnid+jFQr0oZ7ite+
X-Gm-Gg: AZFdTZdeV5nI4Vo5as2/G9Gt8rg/Hodx8hdcpkoiox2wteOsjongJY4XbH1JXpPbppO
	6R5H15OaQHEX5jNAc5yDMIk90ZB0UV8Rf88WHzj2j/RskNVjFgZc1Y9jsRaZSm8P8GA/xqOhLj4
	hvJel62FL63DkBy3nQ3YaXi/euHw+gvqkT/3ZbInnyGr16xgI0MIkV4flomvGCSVCUY95gw5WnV
	ucljQb0DOFEaEFo36SmfKSg/7sQWRKnY6igIFf7JFK5KHysIUOi+Xmfu7Tdo7gj7DKrQptstSQY
	NV+z5ks4+Y49bmrppjg142r7CN5VfbepVBwxuWyd7XlNWSEpordr2TKaU7BVomjTG3LdD/wPKHc
	H3PFg/Y1qz19o1PDaVU6GsG+TaRmsPQVmukkL67zz7Gfteq0qJ3+8gPU0Odr9nkQopPW4ACs/De
	3brCGyC/YAeYST62ARzd8qbAY0AGyUexyB+buKgLYeI8PxBugJg6RVF3EH9eWEutRvwvT0VOvyL
	H5A1RIG/vds2N4ooPeeQb66f9gbxx0ZtzFxsbDa190whY8p4P+wtP0CNxB+gwUFVCThTE/Wxmnn
	z1hhMY5r
X-Received: by 2002:a05:701b:2918:b0:192:e5a8:6bae with SMTP id a92af1059eb24-1b570d52afcmr1829485c88.40.1795388153441;
        Sun, 22 Nov 2026 14:55:53 -0800 (PST)
Received: from [172.17.0.2] ([68.220.59.209])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm37348055c88.9.2026.11.22.14.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:55:53 -0800 (PST)
Message-ID: <6b0372f9.ccc6ed06.212c36.daff@mx.google.com>
Date: Sun, 22 Nov 2026 14:55:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1728857241411706776=="
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
Subject: RE: [v2] Bluetooth: hci_sync: Don't enable instance 0 on Set Connectable
In-Reply-To: <20261122191904.2261177-1-simon.mikuda@streamunlimited.com>
References: <20261122191904.2261177-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1728857241411706776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218913/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      32.01 seconds
CheckAllWarning               PASS      36.22 seconds
CheckSparse                   PASS      38.44 seconds
BuildKernel32                 PASS      32.05 seconds
CheckKernelLLVM               PASS      35.91 seconds
TestRunnerSetup               PASS      758.95 seconds
TestRunner_l2cap-tester       PASS      14.85 seconds
TestRunner_iso-tester         PASS      13.27 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      89.43 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        PASS      4.53 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      28.82 seconds



https://github.com/bluez/bluetooth-next/pull/1189

---
Regards,
Linux Bluetooth


--===============1728857241411706776==--
