Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388127;
	b=bnQJuPXVF6Nc0g+lhFXIW6rrKnsj3w+njoHTEokNpGLsn/t4/mYgXQCeqFnFK1JQfDu2
	 94lyWksBQD5nC/D/BAiXrHxs+SJqH1SzOTn69u/MrUs37O+4A9mwrItF1QR1S/eYj6kwp
	 ubo3Uhv6gcknDCsLG3ugR+AdlTFSxOQaqzVzJ2fI+sXjM9YGLoRI+BkgXYl71hqFYKJ8/
	 IrBspuCsYxCSq85K/4xPUVoGTaVTlJ7GaEZ/wjtzQmfUi9Qd0UNzLHmgaPGaRygNYglBA
	 C3mt/gJUWACsvHlp+0IfbnUM09iVlQLOn8fBBxHm4NK7IHIJiBp76Xi1k1b3VVZ6PNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Y5lheYKtBHaK8l3lNb1zt4TcrsCWP88ARvgLD7/+feA=;
	b=byFm4zNwiDXKvP4geJAJDpQXUfOTMq2O18yfrnC5U21vJ/+AynySUJEhuZM7cbvniIJj
	 5sCdeGKVnyHQzCAaAIDzXAmoN5SqP+3aKoRUTgTiO8k+4W9cK6taqg7lGHkyBWOts1hjn
	 aDkpIu5p1TB5jTV1CACy4dSAJc6hbowEJdZSGyOwdCzH0n/5BUICUBiopRGwhTJLpW6PT
	 tzSDUIVsAoQ8m36og48qZzpg+zlGna8ivVHUmg0EHWbqYxLDY2xWyOwWUpKPFlRGc2Sf5
	 ZNneKCsx1dAzfHUS7eVwfGcj+zGpCOTwsl8JpS9772x9e/Qy9ias8MREgDsiQ+sDxaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="maVtSuQ/";
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FB606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 085FB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=maVtSuQ/
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-94999a08973so274850385a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795388126; x=1795992926; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y5lheYKtBHaK8l3lNb1zt4TcrsCWP88ARvgLD7/+feA=;
        b=maVtSuQ/qxhg9gCvDjBWY6t1tC1W/RVRfSAFx8NFA0KCkH9CD1XYnfA7MKo27rs6ep
         dW/2K1DBOdeVdgUoibUz8AdP7y7j1Ab0zJ69sxPiQHlVaozXBeKr0AgvKW7zFmq1C8LT
         xD53zZEb/0Ldi3zDe+cR5lZofPtW08ZdzoTC9nLTdZ+Xc8Z8sn0kaTQa1yDjvF2bFT8g
         5Ym00/WEr1Q2X9RXTy673Km/zgZjoU/r+eeotuAOk/xeS5Nd6QAYVIP61etdJ7PwIVLs
         KHTTPUHbMwlsHKWwncY2Ls3OmQ8E/V1j3aY3n/ZgJdl9UrA5DdhqFoySS4FhH314Fc/3
         GsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795388126; x=1795992926;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y5lheYKtBHaK8l3lNb1zt4TcrsCWP88ARvgLD7/+feA=;
        b=V8eqRlWPFZdYVYH/O70Aax1Cs8eAaCmWEY+kGpyI4NdJDN3LBLvtxSI3g0XSVFA6dS
         gEgrnvwo0kRg5K2K67wXnXNrpDO9NURQtaFsCjec+yL8/P1Jz0ixLKq+n01Bh6vFQmyw
         CBrxBMQ5TeSfh5TFVNpwwDw4MdY0q4fvEmpCwRMmxZv+SlnBKORJt8Yd/BP1yYzNASzk
         nH7TGnekwL5zEpHKFtECprA0rJWl/OOaPxWjmvHBJKVCNvXJi/U64PCvHfJjuYFhFM6O
         RnUxnCnGde6Pbky0KtOgY25hGvp+JytgkusEqPtLrchuDPi+oSuHIR/SUUvTl8E+GFvI
         wmFA==
X-Gm-Message-State: APuU4Z/sFLuYvZccZU3rFKfqV0TIUdQeSceLEp8X7EFZwZFjD7XNsiN4
	Hg6OL4kgK0O5ZCVJe1n15MqkkWIqfgUuxc/bPe4LfrbXgPSE71AV2p/f80tANDfM
X-Gm-Gg: AZFdTZdUIynpemtP77QIin2OUQY6o2evjWY4VXU13Y3e5KVENcY7/kHS4KLZ+DxJJCp
	Ea6wEG1pYJb18FapNuKTPqwy7S3fRC3rE6D3OnF+88Y5DKAa8aEe29FWIIrmzN1r7qkt35gVEhN
	yuQA8Oa3/Bt96HJhTMyRuNT2/lfD7nZr4l2Xn0saSy4INOLzVfmUaR80xAp0JzqK+CmQvMXAF8M
	7fF5UzGp2ME3EumIbgVb1m464Wv7ukctym9j3oeLjBF6+LfvMYokWkF/q0r5vPQo+NbrYgehq3C
	IbdX2ryZeirYHG6tWJ4tsyYrzBjagh+Qg0AZIE+yD1eAK60O4k+rhoHmTJKOMC1oitDNzHkM/lT
	YRhosO1iDrAoyycdoOQew4wB45r/U6F23FjOg2GnC5um6FDCutqFhHw3/2u+fuqkh7IJi8o13JX
	3FlzE9U2+LgU6xj36+CrIHfzw1bH4A+EodecW+CEs4ANgyTgFiYhIC0BuF98e/Xt2AZOLnDCQ3l
	hRS2y1oPUb8yfSP6ox7tHJJ29bzNGRDjod8HoMv7GUtZ742mG+qqlDVzceEQw==
X-Received: by 2002:a05:620a:2985:b0:949:7281:1972 with SMTP id af79cd13be357-949ba955759mr1715761185a.29.1795388125913;
        Sun, 22 Nov 2026 14:55:25 -0800 (PST)
Received: from [172.17.0.2] ([20.84.69.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb4219c4sm680091185a.41.2026.11.22.14.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:55:25 -0800 (PST)
Message-ID: <6b0372dd.202d391b.35e81c.fcb6@mx.google.com>
Date: Sun, 22 Nov 2026 14:55:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3802301083315440238=="
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
Subject: RE: [1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes are still bound
In-Reply-To: <20261122201351.2854661-1-simon.mikuda@streamunlimited.com>
References: <20261122201351.2854661-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3802301083315440238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218951/

---Test result---

Test Summary:
CheckPatch                    PASS      3.01 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      31.92 seconds
CheckAllWarning               PASS      35.66 seconds
CheckSparse                   WARNING   37.92 seconds
BuildKernel32                 PASS      31.20 seconds
CheckKernelLLVM               PASS      33.07 seconds
TestRunnerSetup               PASS      749.01 seconds
TestRunner_l2cap-tester       PASS      14.77 seconds
TestRunner_iso-tester         PASS      13.12 seconds
TestRunner_bnep-tester        PASS      3.19 seconds
TestRunner_mgmt-tester        PASS      88.93 seconds
TestRunner_rfcomm-tester      PASS      4.56 seconds
TestRunner_sco-tester         PASS      5.70 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        PASS      4.58 seconds
TestRunner_smp-tester         PASS      4.41 seconds
TestRunner_userchan-tester    PASS      3.27 seconds
TestRunner_6lowpan-tester     PASS      4.48 seconds
IncrementalBuild              PASS      52.80 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1196

---
Regards,
Linux Bluetooth


--===============3802301083315440238==--
