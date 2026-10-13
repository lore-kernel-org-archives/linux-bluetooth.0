Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB593E1203
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892096; cv=none; b=nkPlClMXIGbhyPMs/FNAAW5xEp7SVjxUqoeJmbSxCz2dyvnHvqAUzKsCibYvKNIazkSU0RFBVP24xtiPM9OS8Yno7kbq7vdKNHelB8lwMy119pvKpKzSHSS7fgu+J/p7DT2OZP4Y3t57CZQkptuiwr/HqZUUGZe1v4QGLA8nd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892096; c=relaxed/simple;
	bh=tOcNgcy6fKRMLxs0oUhQRvkXxRTXoMpgZ/nSbh01dm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lMvLKH/3SV3zK8eETPMhvTTjqjAZKCBrssGX/WMVQkByCXjldf+bQjiN6Dm2aESwdhmnHMedG1lQYyFc/rUjbZrFrO+UWFR49FfS//KTzhcWOHdN2aR2mA5Y+hpjEJQ9KwMcH6ngHtFa3mM+QnzERTyEWNcVFgaVWarWau5sAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYdwnZX8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYdwnZX8"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-83bbcfba0ffso202911a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892094; x=1792496894; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vLFj96UdJY1KHV/nBgKR3lrm8S0b/BzBEXsiv9CbhYo=;
        b=fYdwnZX83MaPbNYfiVQP8Jz2xIp7elGbvqOCYRdl+qnnMhjrPX8d5YFZCgEd0I1MxX
         C1hutncyw3wAaiHsLSSwjFNzWyKtvuv2YevD118hqaz8Vhx7vTRQH6uuD0YypYpFHTnR
         rbBHAyXO9QOM0LkeB1Lqxu+EfXO/46IKwl0pD66rJ5jx3JED8or371HAIh/HODtNm66t
         YaU5U2EsDP8z2BQ8b2DjeBJvSACVWvWNQfoUOlbKxhBqsoYpaMcYAh1k01QOePviGU/6
         M1vAnEVDEsZtzIJi2xyKHyJyb3b6C29BOLXxC9LIUysrifKRUNC8R5GpEYGeipcDuP3W
         79Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892094; x=1792496894;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vLFj96UdJY1KHV/nBgKR3lrm8S0b/BzBEXsiv9CbhYo=;
        b=amBgp808suQdoTNa7UIQ7UxbQS4LAZuWuzCaWoLbt1W0nA+H8bzX2rD4lI9UbHZxzU
         2SeEgJ1y9XrrWSa3inoYv2D2oeP5THHObImf/8M6VJkOT++Z52p/a+ZdKLiVarjyWdbk
         ZttDor4YYeABdJ6i8aPN8/w8xBzOJg7VBPWWwp8t6Tn1Hk16lQqCrYM+TQ5R67ZpzNF/
         n7SEkiE8IgpZtfEh1ooeLpwap0SqG0gLPmgyR0/qPGlBin6ZbNsx8YIwd+vV2YDEaqcL
         0Z76OJizqtoP1XgP4DqC29d6E5DaMtgsMkH9Sbzq0xK1wsxBRVkiEEJvNBsH6HSwgHWj
         e9Ww==
X-Gm-Message-State: AFq9FYLyf8Fi0eTE54PVo5R5aJDPif2vmHWv1kmBjps29/VWIe0cBwEB
	hv78l2GbAoflzfDG1VjsgV3LusfloQM0Ox1RAwo9mXEsPzz+hE2RwddQcdWFM6KD
X-Gm-Gg: AYBFou19hI+qUtyhgBpuTYJe2ifsZLnUhq7QNFKrlKT2qCFmuu900oB0l+JVFIdXYiy
	mQxhzizdGqbxICEd+tIbJQkTqHQxGDT3/k1hqqO6NxYP2lAQhfaKOmvg4Km94VTMWnkqdtJsZYR
	Aeyk0iFT4zaxm4pcprLNFoz6alFlNJ1FZw0QFsNzsXZs6V4CoTWyW3JX63w86NpDwsiz1IduIJh
	9a2UMc/IDLFDE4/zMhnSU6XZHHWLjAJailKgXKkMqT0dDjVrh6vJQIY5BitYSvxOwWcJAYJyyPB
	h5M0D8abolMp0CoE5UzsoVD03/T9FNS7u51LCZtvS811g6R3MzJqfvnvpN7wECSrHIju6ZOLv6/
	d9q3fwI0v8ySaJ9G+g41tVpiRS5VZASVOesZ00HZioTsNRiJD24bnO/zHsZMn/DKiZ2Aaw9eoEs
	8t+WViNqap7UHPL3oWDxSTgBXRjElomsZVcbmBe6+yrTq+ZMO3C3tDF25mhOnYha6a9/mqxRy4F
	tiRjg==
X-Received: by 2002:a05:6830:82be:b0:80c:d30f:97e with SMTP id 46e09a7af769-8309843fd8cmr11682138a34.31.1791892093866;
        Tue, 13 Oct 2026 04:48:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.215.101])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83bf78d27a1sm414160a34.15.2026.10.13.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:48:13 -0700 (PDT)
Message-ID: <6ace1a7d.39268df7.2e182e.df55@mx.google.com>
Date: Tue, 13 Oct 2026 04:48:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0270138900141543059=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@californiaopensource.com
Subject: RE: Bluetooth: hci_event: Fix LE link drop on remote features command status
In-Reply-To: <20261013071615.76382-1-kdewald@itba.edu.ar>
References: <20261013071615.76382-1-kdewald@itba.edu.ar>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0270138900141543059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184442/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.84 seconds
CheckAllWarning               PASS      22.68 seconds
CheckSparse                   WARNING   24.51 seconds
BuildKernel32                 PASS      19.64 seconds
CheckKernelLLVM               PASS      21.72 seconds
TestRunnerSetup               PASS      419.28 seconds
TestRunner_l2cap-tester       PASS      13.04 seconds
TestRunner_iso-tester         PASS      8.82 seconds
TestRunner_bnep-tester        PASS      8.91 seconds
TestRunner_mgmt-tester        PASS      80.46 seconds
TestRunner_rfcomm-tester      PASS      3.97 seconds
TestRunner_sco-tester         PASS      5.13 seconds
TestRunner_ioctl-tester       PASS      4.05 seconds
TestRunner_mesh-tester        PASS      5.02 seconds
TestRunner_smp-tester         PASS      4.12 seconds
TestRunner_userchan-tester    PASS      2.77 seconds
TestRunner_6lowpan-tester     PASS      3.96 seconds
IncrementalBuild              PASS      17.90 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/912

---
Regards,
Linux Bluetooth


--===============0270138900141543059==--
