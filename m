Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB161898E9
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474736; cv=none; b=FzN/TGea/ol3wIcsnk8oOxZ6bRBYZsH7olZLSadShqJ8J3gWdVS/bCjFjWL6hsbX+fFnwfqgx7ygcwkd1wfLj0IvK9WbTgM/Nd+/U7NGcPKRQM9Bg9OFV2wMPJLzJAiECCcIDcN3XGkp1paJ8rtdlTksUB/NMlHi33V8FJh6PsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474736; c=relaxed/simple;
	bh=HMxRa87ASZSs+MF9FxhtecpDlOz3a0eGINDUeJe1S4M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I9hzJcMPS23NCuxtajDmFp5XwRjrJpBMMtm8yNr/76lcZ1QfSuDWbRksbPGxSPdjelxD4O1Jfxvcn3PbRkSxaLGsfjfqMkdA0ph0ONSoSUg4edhvpxiAbNwp8bR0XlwRqzuAx0rZUGD6zMlaRzECkpoz90CV8MAACXMZsOcdXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0OMjRkc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0OMjRkc"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c3e1081804so1379253a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727474734; x=1728079534; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qHVeumN/KYyZjQs2qbiqw7cFo3XkukHCIYwj/QVfYPI=;
        b=Y0OMjRkcYiXrSnEyrx6cqyv46uI6onLY+NM3fFmyVi8yTJlRRNfQ9fVIoSeyHYUGAd
         hoj3jaxI7QpTbtRVD+yXVtlUzopaQytGAJm2uLGAfU8MCcDF7TEOwFhjL9NDkxmgoLCl
         5u9sf9blVo8HZMRdbmqb+1TqcBn7W/x3OjSWz32/jHtjtwr+rUrOCtnlPYGkIg/iz4ct
         WIV2XeQ5K9E8G0ZUaXRjqbpFnsKI+D0y0hlBG08XWa/DUp9Tc9aoOoG/so82OJbkb5pk
         gVVAYvVfN2NYngTSXq3xt5gtELWWT90ajAN1eRi1jcAfeKfDbt4wKbAyKHJlIMJPe2/l
         cyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727474734; x=1728079534;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHVeumN/KYyZjQs2qbiqw7cFo3XkukHCIYwj/QVfYPI=;
        b=F279xIjOyd4pn8N7m6XTXd17XASHgh7w7pB8S/tgxNLd7Jqi7wS8Laf8cPdmdHWJP9
         P8WohM/Q9WUTp3q6zqEJReK5xIYdeNRIFlchcssFD99wmQa88z5HL0IJ4VU2SmgziUjf
         eIZZ8ExF0A2PhfCUixJjUnl2r5yxALmmMWz5odetUUZKG+jHRI0K0sBIz+MWFCT8HNf8
         fQNpO89WhzkxmnbMYuFtXTPMRrupLp2C7APbFBljpLmH1oDRoMpg9Q3Tmsk5dUA9ojnE
         c+7GJASHCkKYouWjirrfJCAMrBHM0b8wrlKYbMJ5nZv4rPEjoKIpW5qOpu3JK9gU3qJG
         +a2A==
X-Gm-Message-State: AOJu0YxFHQV9FK33lrvutlM0YHCziIC++YE+IFAl6GCfiTlKOU/n2aWh
	scat4yJZK40uqV69N7bjIVLh6nWJP7BnAxgfvh+7+9H+RVN4lBWyi57k9w==
X-Google-Smtp-Source: AGHT+IE1oAwZJu3WwblXIYKR3oOlEnQ8axTLhxIG4DqHGG3JCz/nvnpgi5bkmmafVBVTixpAYI8hlA==
X-Received: by 2002:a05:6a20:c6c2:b0:1cf:2875:c4af with SMTP id adf61e73a8af0-1d4fa621567mr6597550637.8.1727474733619;
        Fri, 27 Sep 2024 15:05:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.24.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c6875sm2115590a12.46.2024.09.27.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 15:05:33 -0700 (PDT)
Message-ID: <66f72c2d.630a0220.ee5da.c9de@mx.google.com>
Date: Fri, 27 Sep 2024 15:05:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6510902270873697026=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client/player: Make endpoint.show print all endpoint with no argument
In-Reply-To: <20240927195416.2527923-1-luiz.dentz@gmail.com>
References: <20240927195416.2527923-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6510902270873697026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=893563

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       FAIL      0.69 seconds
BuildEll                      PASS      24.15 seconds
BluezMake                     PASS      1594.08 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      179.98 seconds
CheckValgrind                 PASS      252.34 seconds
CheckSmatch                   PASS      356.04 seconds
bluezmakeextell               PASS      119.47 seconds
IncrementalBuild              PASS      2854.97 seconds
ScanBuild                     WARNING   1035.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] client/player: Make endpoint.show print all endpoint with no argument

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[BlueZ,v1,1/2] client/player: Make endpoint.show print all endpoint with no argument"
10: B3 Line contains hard tab characters (\t): "	UUID 0000110a-0000-1000-8000-00805f9b34fb"
11: B3 Line contains hard tab characters (\t): "	Codec 0x00 (0)"
12: B3 Line contains hard tab characters (\t): "	Media Codec: SBC"
13: B3 Line contains hard tab characters (\t): "	Channel Modes: Mono DualChannel Stereo JointStereo"
14: B3 Line contains hard tab characters (\t): "	Frequencies: 16Khz 32Khz 44.1Khz 48Khz"
15: B3 Line contains hard tab characters (\t): "	Subbands: 4 8"
16: B3 Line contains hard tab characters (\t): "	Blocks: 4 8 12 16"
17: B3 Line contains hard tab characters (\t): "	Bitpool Range: 2-64"
19: B3 Line contains hard tab characters (\t): "	UUID 0000110b-0000-1000-8000-00805f9b34fb"
20: B3 Line contains hard tab characters (\t): "	Codec 0x00 (0)"
21: B3 Line contains hard tab characters (\t): "	Media Codec: SBC"
22: B3 Line contains hard tab characters (\t): "	Channel Modes: Mono DualChannel Stereo JointStereo"
23: B3 Line contains hard tab characters (\t): "	Frequencies: 16Khz 32Khz 44.1Khz 48Khz"
24: B3 Line contains hard tab characters (\t): "	Subbands: 4 8"
25: B3 Line contains hard tab characters (\t): "	Blocks: 4 8 12 16"
26: B3 Line contains hard tab characters (\t): "	Bitpool Range: 2-64"
[BlueZ,v1,2/2] client/player: Make transport.show print all transports with no argument

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v1,2/2] client/player: Make transport.show print all transports with no argument"
10: B3 Line contains hard tab characters (\t): "	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)"
11: B3 Line contains hard tab characters (\t): "	Codec: 0x02 (2)"
12: B3 Line contains hard tab characters (\t): "	Media Codec: MPEG24"
13: B3 Line contains hard tab characters (\t): "	Object Types: MPEG-2 AAC LC"
14: B3 Line contains hard tab characters (\t): "	Frequencies: 48kHz"
15: B3 Line contains hard tab characters (\t): "	Channels: 2"
16: B3 Line contains hard tab characters (\t): "	Bitrate: 320000"
17: B3 Line contains hard tab characters (\t): "	VBR: Yes"
18: B3 Line contains hard tab characters (\t): "	Device: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX"
19: B3 Line contains hard tab characters (\t): "	State: active"
20: B3 Line contains hard tab characters (\t): "	Delay: 0x06a4 (1700)"
21: B3 Line contains hard tab characters (\t): "	Volume: 0x0059 (89)"
22: B3 Line contains hard tab characters (\t): "	Endpoint: /org/bluez/hci0/dev_94_XX_XX_XX_XX_XX/sep4"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
client/player.c:2206:8: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
                if (!strcmp(ep->path, pattern))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
client/player.c:3476:16: warning: Null pointer passed to 1st parameter expecting 'nonnull'
        codec->name = strdup(name);
                      ^~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============6510902270873697026==--
