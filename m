Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851415;
	b=4n/fvJmwfbpIxrIpKxChyiudjqJY7kPJrNrbyt6cbgrIDEttuVKW8xMn1iNSVMS7aab+
	 ag3O7EUUhlDZtHBlCuImLk5KQkciYCz3LvslKM4yJKT2u0s5uPRhZLywSi0sJQDQP0uUW
	 UAFRksG6KMRIgx29o/BmUnWhx9WqTGTIm1ea95OY/SGsBTUn9w6ddhVsYA2ZntfjhPdIU
	 8z/1Fkni8gt6UJTs4gOvlULnv/j6pU8JpUeZ117roW78HX0UPvVwD9wpEhrcOV1JTOc/6
	 3vLDnleEpxXfhFvw4NvSiXpElqqDG17JSbnjwm55i4SY338krCHE0LILWgqbk5Hhnqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=cu80cWPhr8cVKQJ1fARSpuqChODI78R4ILeV/iyWmxI=;
	b=U6qKGOdO3xqIhcoj2aPJ44n07t/VHk1cTGuNMKS4gkrTtDx0UEYHPH67NBl3FtPPOoxX
	 3qU8TqrqmVH1N6+1SkZnN3EJSB5fbkISv507dSkdMsFr5J+FFLllVaLze3sZ7i+qcF2zy
	 dw1ofAnd1sqNwpA3eV0RjeBpJ7lEa0HJK8rVNYAKuzGcl/j26E8EcDWRPt1FqMHPNoCll
	 XCTmW1o9uzmH7MSdg0SclA+n7E75+/2qM16U5dcdbdhvXlOoQpdphrtQH65FYMHS7DrGn
	 k8reu2sCpw/svkaI87XaxlciBWdRRoEQNejyo9vvM4P58ZcCUk1FZVlZCESIoTFQ6fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=apNl61Ua;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B464606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 14:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B464606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=apNl61Ua
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-81ba09a5d23so2073680a34.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851413; x=1793456213; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cu80cWPhr8cVKQJ1fARSpuqChODI78R4ILeV/iyWmxI=;
        b=apNl61Ua1AmPRhpelUb8uvmFGhn8o90BL2vUoQ0d6kEn7r8eYlVozEkKWxT0cGuMZm
         FKbCS+Plpv5zvG8u8aNnDDbYkq6p8kKIkC6ooSpeKs7HaC40f+Hn20BQK4SrbUpQME2h
         DkC16vg3eGPzcv4K0DSZXQL9mHTz6EIjQKz2D8+w+cSmiK2fOyEMNzbz5kTUNXTBvrFT
         P4VvKzqoC90IoqtC8LOdque9nVcC3TVwa5Hv5B9uUJbrOAyRiIix90e2VadDDbXaBGtF
         XhRrHBwcRamc0ARlFUYgBtq889T35xkEsXzx2MY949896ifPWCITg2544M9blBTCNuii
         QQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851413; x=1793456213;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cu80cWPhr8cVKQJ1fARSpuqChODI78R4ILeV/iyWmxI=;
        b=Woxhi+xAgxOxdu915j47MMHB/nvJfBvLQSrCprp6u9r9Rly8L258j2V8y0PoY/Lfco
         X4H87YDrSl5ofOx/pyisGuJzXxsSSaJetgv96g34yF7h+InVgxDoczlikmwaryQESvAo
         F6o32Lu5dmeBs8nUPxcU93DPmmBIZ9rdmz0jCK8W9nWFKebvkae3WGVHRhHCHWibZSlV
         Eu3obieSpysodGQKyB5pMLJ9f/OUm12y3d0J0zJ5kylMgFhGCK17noAmBg0TpwmAFt88
         11c5XuYaZlRMqjX4cZZsiRHL6ffLwjBpIoIwoWBrTJhiz+nMyhxPy1Yy7gh+RyXPM1np
         da3Q==
X-Gm-Message-State: AFq9FYIt5IRnmhv7aKDaYD5RiGiJDDQ9Tlq6NawXq2RUecIZDnSJr7jK
	LrDmfvJhMLv7Ad4S73lpzJWlr/j/0QLr3urO7d1aR+WB5tJy70hL7MYzJQWOLg==
X-Gm-Gg: AYBFou0x5zYMnDWisChNauKTEfSArPQcXEIuLYMtBRVeq6qhOXiocv4Q06ou2PSrG+/
	5A8pjwAvrJuJtnFn3WSTM8diPSoJkvF5DidzObFAKvvI2BVfJU4KKwvKbR5kTJkwsKIs1PC5HoP
	VAKrCujobz27fiksAxDHhkvnB/jiVf3IPa89/QPAcoY58F/ZTSIwz20uFNBtkMV87+woqGIgtYw
	VWZPKiJfGl4hW5ujcMEm3MRqlyF8seDVGlX9mV8DUAM3vlPS397CwQ+o3C8tW+asU8TK+7uE0Dg
	9r7cy0+m8BHCyc69uPWnIDJd0zmWfBnuysbKtPLbQMjnFslGRBf3mDLr6zsXeFksnF6SSsbyHHZ
	VzI5KKyCdEg8g5hunfE/5qrf5p4+EQ06XYwDjH2YffsvdVk4fp54TnajIEB+DWV9z7iM75ct8j8
	+ND8oOjVLdGN56xW0mmF5DXbbz2NYkMp+qK1TAh2c4Ppe44RQPLFiUb6aZdDzqh0ocug1Ax6d73
	LcEKtuOluXar3VHl5Y4g5ey21T6yYwUPwaA5QqakyzbNmDubROWew1cmR8nWQ==
X-Received: by 2002:a05:6830:2e06:b0:81f:b198:5b6c with SMTP id 46e09a7af769-850ff38c0e9mr1846731a34.22.1792851413495;
        Sat, 24 Oct 2026 07:16:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.230.180.6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fa99c4f2sm2353984a34.6.2026.10.24.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:16:52 -0700 (PDT)
Message-ID: <6adcbdd4.e6f78c0e.325a79.c2ab@mx.google.com>
Date: Sat, 24 Oct 2026 07:16:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4304704558006855413=="
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
To: linux-bluetooth@vger.kernel.org, turbine.bmw@gmail.com
Subject: RE: [BlueZ,1/2] smp-tester: Expect the identity key in Pairing Requests
In-Reply-To: <20261024112527.249473-1-turbine.bmw@gmail.com>
References: <20261024112527.249473-1-turbine.bmw@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4304704558006855413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192642/

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       FAIL      0.58 seconds
BuildEll                      PASS      17.89 seconds
BluezMake                     PASS      264.23 seconds
CheckSmatch                   PASS      233.69 seconds
bluezmakeextell               PASS      87.41 seconds
TestFunctional                PASS      1023.40 seconds
IncrementalBuild              PASS      267.16 seconds
ScanBuild                     PASS      927.38 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] smp-tester: Expect the identity key in Pairing Requests

16: B2 Line has trailing whitespace: "    "
19: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluez/pull/2708

---
Regards,
Linux Bluetooth


--===============4304704558006855413==--
