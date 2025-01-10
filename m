Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC56212D6B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525422; cv=none; b=dfK6+Cf0LzCRMaIDLTSIU1TuQDbTtghCseYeqOn1ucX05Ttsgn31/e9MeFIgB0rXwQ0DewQt9DsYfI2L3f3ICZjEbqEtZGoo7TMJME0evFhoCWUoCTybwE+ziTZY6kiqgqHEa6t8E2K7PElFa7vj+QDerbHOtPITIBSs2+B3XgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525422; c=relaxed/simple;
	bh=bszQNVC0kSqrONmv/8JjXNcWb1kHeIESva3CnBu8VOc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u5uTU6K0q2EcSp96EDg6jpXdEdm6v2tBZoee95Xhg1nliEmehdkm0GfVOr0hnxqKREk7uigJgkuTeJS6ekapkGMMFPl798RVsQkNM0RJZKQSxictHW1Fkz+swERFbFe3wQYTV6LlMVMF1wVHXmu2JZzROmxdvg6Xd9AaCclGyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJA6EJVk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJA6EJVk"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so294152185a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736525419; x=1737130219; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7J3U3INayL9D0Cj4Qh1YSprC25NP/tYyM7h6OyqENRM=;
        b=QJA6EJVk2uUbggHAcDe2xrqvLETKzMCYPQgnUPWPzVFOwubr5+80O2qtkPgXdYB+lB
         gLLMOvf6yPEY7JOs4owNzgSNsIGQOxdDfN2Fwx2IllGtPGxVqIOhRVQVIxVCNRqkLw4i
         3DU395ZmaPTPDEfdZskl3FSQ1PIOSygAZAnsfI3+NmL0cvXHPnlZmHdCFDmCd4aGv5ST
         kwhqJuxFBGlWTSbbFB9r8qemnsMckzbFpovb3xybiQt+mR9zDHRF7NuI917jJHpdXFEU
         f+tTC7a1iJCuobycJYMBgLlQKzQQ8CxTrHJX7YN/Y90RALP5p8JscywqMscULHEdO2QI
         ogPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525419; x=1737130219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7J3U3INayL9D0Cj4Qh1YSprC25NP/tYyM7h6OyqENRM=;
        b=w8wwXEgYWtLZJ+gdWBKkuJMq7plu9KRXgZM+FYRQ/Wc+mr1oD9Zdh3+SWyggAY/Go3
         GF1BBrSm/x4heT+jwEqDUoog3VZ56yYM6P8AmJCeAPQlunY76zMLf6cchU28WXfOInGz
         lgz27NOHCOxbjvbqPmYfpdDxF4QdRaUli6Ym2ED5boBg0AuwP8ZrPd3DojLtr4gOruwF
         Jb8RQXOv3Shj1ZAB8qMD0cnYHSyKDA72G81sEAuOGlpTV4X2b8zxOScuioIV+x7QNPUK
         wFZlA8CnSwpjUi7RJA5X9BnpBPVGiElAA0dV++lEVzIr0G5SwN9e3wMZbCv1EBKeCrJP
         H9sA==
X-Gm-Message-State: AOJu0Yydp4p84lggWcCa53hJzx6goDm4jEqbE/WK7ZoE9sgW8+2SpFSY
	3OwIjZcISmukyqxbS2GtlSG+cHMQJp7nGNlnuxDaDNVNssI/IHyuVV2rCXNX
X-Gm-Gg: ASbGncuqAbJGaw/Z+mGHU1OLriUjQ1p5VflJVW3o1v6kjn38rZFj2g6Kqpz3KfFNtTc
	HbJxZsKA684Jq0GC+1M0uoCeCVkhN79tdKuB9T4F3mGTkRrjTw4BbrgHYpo0SjwJUNMueSzE5O6
	/ROj4j7xOdwIng7CMPYBjie1phAJqs9IxOSOwQ4ckRPbXT4IsPwnqg8GkVLu5aYZ/tG9D6m8dsM
	VXCtQlLeAjXxFy6KaycwRQadIY6CDGviSgCLfGITH9r1OZPu1GA+oVhL1wGcH4v
X-Google-Smtp-Source: AGHT+IF+usdEwwlJ7ah7JYbt0GoyNNwKBbpXcK0SRl/ZBiq1C0dAAogjzSqslIhqB5KjlZl1RKafgA==
X-Received: by 2002:a05:620a:25cf:b0:7b6:e931:4608 with SMTP id af79cd13be357-7bcd9729aa8mr1794323485a.6.1736525419361;
        Fri, 10 Jan 2025 08:10:19 -0800 (PST)
Received: from [172.17.0.2] ([172.210.84.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad880dffsm10546196d6.38.2025.01.10.08.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 08:10:18 -0800 (PST)
Message-ID: <6781466a.0c0a0220.1542b6.5241@mx.google.com>
Date: Fri, 10 Jan 2025 08:10:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1251607018995854082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: connect VCP profile to MediaTransport volume
In-Reply-To: <20250110145019.2380299-2-michal.dzik@streamunlimited.com>
References: <20250110145019.2380299-2-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1251607018995854082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924286

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      21.20 seconds
BluezMake                     PASS      1621.39 seconds
MakeCheck                     PASS      13.70 seconds
MakeDistcheck                 FAIL      52.21 seconds
CheckValgrind                 PASS      218.94 seconds
CheckSmatch                   PASS      277.22 seconds
bluezmakeextell               PASS      106.74 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      884.10 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
../../profiles/audio/vcp.c:54:10: fatal error: vcp.h: No such file or directory
   54 | #include "vcp.h"
      |          ^~~~~~~
compilation terminated.
make[2]: *** [Makefile:10727: profiles/audio/bluetoothd-vcp.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4693: all] Error 2
make: *** [Makefile:12265: distcheck] Error 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1251607018995854082==--
