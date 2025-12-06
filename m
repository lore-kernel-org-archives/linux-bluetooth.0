Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B99257459
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980846; cv=none; b=WX7k4BXYSGj9iLyxKhqiJwMVizb+cGFH2fqi1bQpmtocD2t2W468LKQE3QtHKStIGQ15nl2u8eSRtekNo3PdPNRZa0SEs1gVEH6X7GfI+Mp2Px5fGeoy3ep4/Pm0V/MQRTL2veS0aolnz4ReSF5hQ92uW8mcyMDPmTKVOYwqLyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980846; c=relaxed/simple;
	bh=bttASISDGMnvpRVjMK5MVa7z3P/njcXZlCvmxEn+UBM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WH90c4GW0VAE6OkL2I4DY8zP+YhgmE9TjVOXvJTa7kuFBJzNcv2Gr/6EmzvqHgeBh2mBpT3J0qhm7QnWtWeHa0pCD8AYIFmUchNtKJS5fztXlGHOgzo/ZOrXbzTViJuvQizrwoQJkoyCPNl6KExADxLoCa+KZn7vp4qME8FgP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goyFhklm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goyFhklm"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bdb6f9561f9so2548943a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 16:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764980844; x=1765585644; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aUlSk0IyrQMyfXe8rx9lbXSLgqWsxS/Dh0vRkr1NfgI=;
        b=goyFhklm5ciBP8Tg8Le2Qum6F1/cumX5rVYkPQrr0YVT1UOcaVaEXvYz3XPD/iEjQw
         RxcnFzg+gZ/3trBGw3qYh7EivfJCAtr5qBY3jMWu6Bkz4CYf+KqBS1b9M/xDAnnURiUE
         QU64bRev+d3MgDV9Av9fyYjdhFMhMb45Q1AiOeHFFAKfO/Dxwq9Qy9coKbXkpOB+lRU9
         nCivaFNu4Bbexf98ySYFFX+A7kS06COuM7ecbtc4SUVk2nkS2Z+jiCTzIkpGy7Ryde9c
         WbOu9Dt39qBPaXuaU0+/Stt9K+iBmy7YYdKB4NZnTuPIpBwIVb0HbL/miJwJcN1KPeoR
         5cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980844; x=1765585644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUlSk0IyrQMyfXe8rx9lbXSLgqWsxS/Dh0vRkr1NfgI=;
        b=Bgo6RPQaA9f9rVSj4xgzKkd30G7JOONqYcaBvFWq8QXDG2gtRadB9u9MdyTKU5zYIh
         6dQAPGJ8j7FfyDU02i8lrhoYVxuGjkyUlkQlkP1/Jm35IN+zl9VVdqRrf/xN25H6tHvB
         BQssUc7A9IY3erNxOvcD1JtO+fbUpsQ4EkJ9wVb+qC9mCzM7BABXcu8KgJ2v/OivYMOP
         scGKALmakikJFdkVaNzwMB9czFjzQAHqcAGfvvrRZCN3yXzEiy0v7Ia6AXIbbV1rPddH
         nBTTOAebPaA6Zu2Eooe3yfu0tUzgrLJ/59YzoUj00q/fEEQ0X5ZNPacmsHclAbuThMN3
         kmaw==
X-Gm-Message-State: AOJu0Yyr0DCzrHZeynCcNB1NWCqc5l2yfsfRlPBBMcGu+rjVv9+AcRvO
	0qKvkHBtHk6Eqq9lVC+PMkPtV5/G69EXjU3qAgi5kZLTFi7S8Vc+6yJ2QBZ0QA==
X-Gm-Gg: ASbGncuBNxkEQnAI343E5y8MjZeIB4pp8odRBq+hr/3iFPBplYU45eSrcOF9PkQXGjO
	qdMVA5c9PfW2NY4118uxwGSaI8Pxgb3VBW8jdyY0sSegSHiH3d8LjmLVqZiz+t6NdWmuiyRe9xI
	HJ3/d00aQY9Hmh6XHachn1Lkb/MAQeFElHFE6E9i52D2Aqn7Gbpr0SiQ+qEDyLLjKaco5qjkM4U
	h4ieplZfAzzzj0/Q/xQTIC37PyI640hzHvfybwZpLvWdVWCtNLQZWkA6vuBF5B804ifb5pfgKLA
	SxzvOTrYWOu3Q3sdk/DXeFqCMoQLHWrkXhaK8rYkbpD4XyBuPJBtTvE0Yx/kiObrlSqKeQKPjWJ
	ZEi1BEakzsHU/YnojNAukUq7c9kSRIBjDug2j3rY4LQmnry5Ky2ToYWePzySPCXL8l0cUfr6lUu
	SU178x68pOloSSn0EvBZ0=
X-Google-Smtp-Source: AGHT+IGs7qwqPw/a9ad78V3Uql/2kiovukAjCgR5y+dC4whPQU2KcnpszMAkXZEhQPEO2/ITK7UrwQ==
X-Received: by 2002:a05:7301:4448:b0:2a4:4cbc:5bbe with SMTP id 5a478bee46e88-2abc721d586mr793406eec.31.1764980844296;
        Fri, 05 Dec 2025 16:27:24 -0800 (PST)
Received: from [172.17.0.2] ([172.184.191.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba88433fesm16944393eec.6.2025.12.05.16.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 16:27:23 -0800 (PST)
Message-ID: <6933786b.050a0220.898a8.b4ff@mx.google.com>
Date: Fri, 05 Dec 2025 16:27:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2965985288390598833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrew.smirnov@gmail.com
Subject: RE: [BlueZ,v3] monitor: Add unknown options decoding for Configure Response
In-Reply-To: <20251205233253.550032-1-andrew.smirnov@gmail.com>
References: <20251205233253.550032-1-andrew.smirnov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2965985288390598833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031008

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.17 seconds
BluezMake                     PASS      650.69 seconds
MakeCheck                     PASS      21.59 seconds
MakeDistcheck                 PASS      243.11 seconds
CheckValgrind                 PASS      303.27 seconds
CheckSmatch                   WARNING   355.85 seconds
bluezmakeextell               PASS      184.68 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1053.31 seconds

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
monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/bt.h:3854:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2965985288390598833==--
