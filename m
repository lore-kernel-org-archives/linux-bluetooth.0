Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD252F5B
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718509; cv=none; b=K/Us/vYmzqSnV9ZWLZdAOlj1It8U0kl7f52BKOv+cMYN//FYihlzSFMQBw72spk9qW3AnQMwPaTZWprSQ1gM22v0jCwLUEBjByfDAWueUHJfAehSpZjcPPgEMQg+ywo3+GIDJ97sNX1zqHRTjDH52eNNO5lSM+f59MR3ydLYOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718509; c=relaxed/simple;
	bh=mQewd7ludYBJG/lv1/iY+8Uv0yTM144pTQPPbL9F8K8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f7iv+5QkmjpvVbNv7jnwMMDgPBCoHZnI7wMfe9F4IqTzsv/s8MDvwW3JLdY+Q27kSGSMt3AFr9G/NFubyx8KEQEXvvBXFs+6Ro8CYqqzBCXn2OwggyM2QqrFuu7QgfNDiY7q8qUcdfuLOsm0MJKviqaInOGou/fw3BKlJXvlCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVnyCfBS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVnyCfBS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1b8264c86so174597385a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 01:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763718507; x=1764323307; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fm4jmU+af1XHBKzefdrVkbAxHt+9b1teWhCbzSo7gOg=;
        b=EVnyCfBSkvP5xIBrrkArMXPeG2Lf2uc4lsYe0G1n7FzhOPkxm7ZMOUXp1ON75h3Mkd
         CGS2dsfqrgMqmXpJOzkaG0pogKWjkLU5ISqv1MaMjpSs4qpMdDSR/MiR6q8VaI6uJeES
         YKI/HoUbipmosGaGtoz988lMwaIB9er0MmBSMJ7smVyCpzncplPig7U1+UjHSW5bOUMz
         mK9c8MO7DbzeKg27/Hke8lkFLVEALMXnYHiiAO/HuLbjBqsVF+OsCsM14gFKPyX8DpsC
         9/4yPQQIjx0y6otQHiqnChe6w/s0xLhO2eYDtUhTNuE+HpTggqsv3LxcgNLSdTochprD
         gtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763718507; x=1764323307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm4jmU+af1XHBKzefdrVkbAxHt+9b1teWhCbzSo7gOg=;
        b=XXEBxNwTAxDNGZtNuO7w6Rg/LZmHLsWutLfEZkflOhFAlAbq8x312Ia0AwzP5M9xL/
         5MKIby4nSdOk394Ewz+pbiKRieZO29GjCitNud1wu2VHgqPvSwEU3yalIHia16gT0zOR
         jZyYiwpmkSZd3LCIrOz+9ZYJMR8gTIX47VYevojvwXp5JfvS1+fD8RaOuKGc6o+c8EvL
         AoH1PvDEDBvgWSJO+uiZH+Y3vIMHpdtFNByXtFpJisdp7jN4RtZx9gc6ax7sTxE8BaWG
         matPSWoJIbROvglh2PTqHSq6HD6g6mjrdtHWm6LI9qytT9o21Gvcua1/1Y5Fvysczo1B
         oxcA==
X-Gm-Message-State: AOJu0YyVRRUqahT1mYZ95G2SK8UwqMmN//Rh6qPp6aux2aIQAa7rrfEf
	vLQ5krJAQNdTmv1uzGfEkw3bXJ+/avL6euQ+SwKOW090xvCD/BHRF0KLLuIoNA==
X-Gm-Gg: ASbGncvCIRVYCGZRaR5r2imGDYO0gembiz6v9fVTajVjYzqhTSa/xIUZV3ecmrqn5AT
	WuyT8IKJc9E19vC2S3V/sFku+pmPEHfpkULUZqCPZGnJCRrFn/FbmIbjSra6G9rrKcWzzTIR8MW
	Ed+jrKXc0/Ltwd4AFjlVB8o7+IOp0eWqAESmxzUb5EpY3xGHpK/rGKbErT9JRSBg0EPQ1KasAn7
	oDimgzlJbL4Ah0ZFSRB6yk52JgB0mSVQeDSC+0R2SOOXRiJhgUKAitBIgzD7r4H0nFfP+jmzVd6
	YvxH8FBZkxNhmrqRakZayfGO2SX3qdXRn0e6x9JYuwH6rBsC62hLasgr2GHvdLaYJvEcPj8n/iH
	0u3maI7ScUZXAvJM4p/bC1EPnC/ZhP3EQBu0YQgFy9i73HVSS5qtff6ulLhuiFIz4N252vGBxFo
	hRVvRWz/LcHpuCBsoSog==
X-Google-Smtp-Source: AGHT+IE/psqxTs4EppXjBhw3dnaUfqjrWcf0+QB7wJ9n+dDMJ9dMBQEJ2gdcW9pGrmD8UqV9hKPOXA==
X-Received: by 2002:a05:620a:1714:b0:8b2:71bb:2b85 with SMTP id af79cd13be357-8b33d1b12b2mr160152085a.4.1763718506832;
        Fri, 21 Nov 2025 01:48:26 -0800 (PST)
Received: from [172.17.0.2] ([145.132.102.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b329532770sm333429685a.22.2025.11.21.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:48:26 -0800 (PST)
Message-ID: <6920356a.050a0220.208b8e.8c9a@mx.google.com>
Date: Fri, 21 Nov 2025 01:48:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9163965164494474523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez,v4] bearer: Implement Connect/Disconnect methods
In-Reply-To: <20251121-bearer-impl-v4-1-b52149dfd9a6@amlogic.com>
References: <20251121-bearer-impl-v4-1-b52149dfd9a6@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9163965164494474523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1026215

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.70 seconds
BluezMake                     PASS      646.66 seconds
MakeCheck                     PASS      21.98 seconds
MakeDistcheck                 PASS      246.19 seconds
CheckValgrind                 PASS      302.87 seconds
CheckSmatch                   WARNING   348.82 seconds
bluezmakeextell               PASS      187.04 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      1013.86 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
profiles/audio/a2dp.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/asha.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/avrcp.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/bap.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/bass.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/ccp.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/csip.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/mcp.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/micp.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/audio/vcp.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/health/hdp_manager.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/input/hog.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/input/manager.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/midi/midi.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/network/manager.c: note: in included file:./src/device.h:244:61: warning: no newline at end of fileprofiles/scanparam/scan.c: note: in included file:./src/device.h:244:61: warning: no newline at end of filesrc/bearer.c: note: in included file:src/device.h:244:61: warning: no newline at end of filesrc/device.c: note: in included file:src/device.h:244:61: warning: no newline at end of file
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9163965164494474523==--
