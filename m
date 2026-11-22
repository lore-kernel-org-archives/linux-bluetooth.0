Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387530;
	b=dI63V9ybnEvqxdlL1yAEZlb6sXda7D/k+e41lFIrsBuOfdAds0HoPcnJTc/OBNj/WPMa
	 clqnEIWGf0NL0ocBp8teu/fqy6PEhuAAMOmfpUP6jGszN+5XCC1VD0zot3+z38Wv5Ahg8
	 WBzQQvZDa8NS9mOOyJgdTTBodN7OKOIV81rZEtW4w7DHdZYb+1DLxkazXgkrFfWKVln8k
	 dCsC3In5R3JK8zXSEGjIZetyQsHkF2MBpqaeUrNHwRgBSaCL0SZAXmelbJy1XWXao7QJk
	 7pRksTBjMD8KUh4p1uKRvL2ICJSKO1lmlVfGr9Eu+iXD/2A90xfkuWxe6LJ8g1UzmXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NaHQFEYH8Q0P3/S8SY9LHNBC6ljDc1sPiIF3o3Gn9ls=;
	b=IzvVLg38YMUYMugEz/FyFxhfSKfC7w7l/NYcRlbk8NKO54gMDIq4vLdMclRVOInQXWFk
	 FFxDH9L0S+7gPKOTuU7WtAdtwwma7nGGhWwl4Oq14PwN+1cFncO+MsDsmD1mb7I4t6Qer
	 FzgVTY8Ge55bQiwyl5Lv+a2qzmVRGB5DvhgGt6FoeclRP+uvMRcoty0XhXmnWj5MVSGla
	 xEkaUdk3QcNRvzs8MWTmokDMyEZGuHfGKW7e6J6QfbtgDY8PTGiVy1oV94rMZ/I71M3rm
	 pdLQeHiqfEM+sWirHLBmrVwRNhn9JTUVvPZx+gimkI3wcKR8xwbsCi1W60hB49xk/zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGf6hQ42;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05F606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D05F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGf6hQ42
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-862b090e41eso1524012a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795387529; x=1795992329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NaHQFEYH8Q0P3/S8SY9LHNBC6ljDc1sPiIF3o3Gn9ls=;
        b=EGf6hQ425Cmqt9C4pZKQ4KNC/4SMWILKmEnOSVN8t+N+KwlYAWtGfM5ED4LiDBorrm
         LGgJ5MAFRaQxMY4G40OZXGmVxURRfXVTzNcDBKZiHZPepUWijXdDpwqgdvh/zIxgD964
         IvZU8lwzy10DFzZaX9yhLXRlpuikKuXnByrEEGqDPGiV9A+WimcZv5lwzSdJUTsgC3ra
         qC9cyB3mCAo5Kp2hWOCSRyGs5bHpeaBGd3skZRfmhkuifWH+0GH7kz3o2IEK9YQgOKMa
         RxR35yUKKN1+E7EN5khEf3w2e+g4g+YVlYi3+3/lHMNqnmtFGdpi/zx5rzqpFy9weGiy
         fzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795387529; x=1795992329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NaHQFEYH8Q0P3/S8SY9LHNBC6ljDc1sPiIF3o3Gn9ls=;
        b=q3TLD6h2R8lytYOkcLW8rT0EV4SVs8+EWYTSCfCmuBPVd8SVRmizsKJjNQ1LG1BNJx
         dL2GJA+awA/ujoWn9XeRo9PY0EOLB8NV6C4aT/1Q6I+Bv2YvGOTJF//nTkEoAzGzp0J1
         paGpSbk/F50FfHltpbLzs9oGYG7V063nwxv4asyVOi0oxoBsM2r1IUfzJvbaD2UFjzmk
         heHbjseMom+j+CUdWxl6u7odXcsP7Yx0Omyw1jxct2LlfcOrZpz7wzu/fif/tJhhSU38
         uHcSuwH5Dh/Ut1dR2HHNoiFVdWbm9YZXPilSujnzynes65xf4beZoiDNJ6RvWhrWvXyo
         uu4A==
X-Gm-Message-State: APuU4Z/ZWWY3/BVpuj5mmDILKX80uKX6j5LYzi//x55aUqQpnho+IQ3I
	MQVZD0K2C8EdaZEKx9FDTUW2l7qFWqUjSvsBKb+pbgDQ6fN4IdTEdddsLhoX+aTc
X-Gm-Gg: AZFdTZeEuUnqnbF/Ubeinoixt7dCqai80odlKnXqh5Kj5FkB/tP4Cb9PlTk/uXa3U9c
	xqmlCuethjfzVbM5kVIHygbOqloWLt1W2+r9xEh3kGuxsClaxQh81aTD8cRngP+7wzl+0oHGvfI
	FYOz40frUfkfpI5Ewu8TxuDfLUah84gZJp2TA0FX26tdy6GaZjFCb/cak4ETlubZJ7HPEqBT5+U
	tNPCRoYu6dx5hamug1sxEw7/KwShBZ7M2e+dnBOlRKXKVb6h6vHizHon19ZHkzGeD/XyJr0PR+L
	v7HTHVFclWfmM5pIoTmbdYnG6Ad9emo6PqY8cvous7oJD1eVUt/dyp4iCSC+cycwsLiUdslB0v7
	vk+A2cXPf5+vo08O9WpR35UF58uz3OI3nOKHalIbszgZfscBo0o6mHxn/kFcRSl16HIuxeyNqow
	hGzCND20DMf7jZYmE4AutZ59iwLDgiajsKRIUjH2F9o4PXcy4qsBlGHO3avkbvOHnF8pagTidc0
	ndehc7lBltFVs7MPdrLjsjV3AermVATBqfAlBC/5YC14m/qXWTaFfgL3o/r0w==
X-Received: by 2002:a05:6830:7182:b0:862:cbe7:668d with SMTP id 46e09a7af769-8631537c601mr11480674a34.2.1795387529145;
        Sun, 22 Nov 2026 14:45:29 -0800 (PST)
Received: from [172.17.0.2] ([20.64.49.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86316910337sm6994010a34.23.2026.11.22.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:45:28 -0800 (PST)
Message-ID: <6b037088.98a28ad6.96404.902b@mx.google.com>
Date: Sun, 22 Nov 2026 14:45:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6816639344465809326=="
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
Subject: RE: Bluetooth: hci_conn: Terminate a PA sync while other PA syncs are open
In-Reply-To: <20261122201337.2853259-1-simon.mikuda@streamunlimited.com>
References: <20261122201337.2853259-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6816639344465809326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218950/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.10 seconds
CheckAllWarning               PASS      22.23 seconds
CheckSparse                   PASS      24.58 seconds
BuildKernel32                 PASS      20.58 seconds
CheckKernelLLVM               PASS      20.44 seconds
TestRunnerSetup               PASS      446.09 seconds
TestRunner_l2cap-tester       PASS      14.75 seconds
TestRunner_iso-tester         PASS      10.88 seconds
TestRunner_bnep-tester        PASS      2.85 seconds
TestRunner_mgmt-tester        PASS      83.24 seconds
TestRunner_rfcomm-tester      PASS      4.04 seconds
TestRunner_sco-tester         PASS      4.96 seconds
TestRunner_ioctl-tester       PASS      4.15 seconds
TestRunner_mesh-tester        PASS      4.08 seconds
TestRunner_smp-tester         PASS      4.00 seconds
TestRunner_userchan-tester    PASS      2.88 seconds
TestRunner_6lowpan-tester     PASS      4.08 seconds
IncrementalBuild              PASS      20.95 seconds



https://github.com/bluez/bluetooth-next/pull/1195

---
Regards,
Linux Bluetooth


--===============6816639344465809326==--
