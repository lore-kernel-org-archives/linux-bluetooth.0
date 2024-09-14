Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC91D04A2
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726335740; cv=none; b=uUwlvkwTSW8yPJGGKYP5unjLQ+LW4UD1YAk3vgCG92wQGjzPBoZsBNizb3u/+og2nyZ5O0cVt/ecx+O+mF1Y9SdJ66LZRFqIEFm5BPHVWP0LqFX3GFeM09ZxIrdwU2UPNe02YbykBjl6kcAzoU9EVgb3cCIWJJLP1lUlclL5xu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726335740; c=relaxed/simple;
	bh=dc1IgXz3smNRmH9DG3oNMIgIple6z0oEr/T2LdwWAA0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BzTquGimHjQ1EgEh0wOrpreck7kxTh3rKI3AJFsuYLblGpcDQx1kQPQT4s8AiBx6x/FmcG2WLqL1Anv0m6/rRhuXbShLEhaCj6ryHozKhBoh8eDlvyC3dE63MFIW4EGHrdkGezIUn8NsseZboAeXq1i3TJ4asUfIXWxWCzty+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt3F91wE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt3F91wE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-456930b9202so23520331cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726335737; x=1726940537; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fMIijz8DoPNlIsaG2Py+Q5ERVHEW5AdRrayiZp4BC+U=;
        b=Zt3F91wE3a4mm1nTUTa+TpM/gSWim8qjpf8RPf+4ciTYD7G5BNobtuYolwLzUmCtJ/
         L+1EUo4N+WokUAa0BLVjh11dHR/Wizo1J6+EB43Qhx/8ZLvRIl8hAmWP3H5lwe2UIsGl
         PlVUI/u11tXWjUWjiHbO3PAqDzve4Buk9tIBGTYhulCS4DwhhYHwNdOa9WqLhQaf3Hy8
         Z0cfT9VDYjwjk5QbvZEQAI7NKZT/X7U7onFHbqMlaTDEhUlVVA8mcP0jyjBfu7kFE8hb
         6hOyMphQaR3vLhsIl055atqzyg7e2uVFTABQBYI5ei41x11qFKQ6z8o9FRtvQnJsiqhc
         Fr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726335737; x=1726940537;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMIijz8DoPNlIsaG2Py+Q5ERVHEW5AdRrayiZp4BC+U=;
        b=eRnPvPCoEmrx4HIbmv15o/wravZciBT9FuEFpqhRlTIMQkRuY+oaT2M180b+mR0Qe5
         +OzvbAk8VsIwdKgBysDp/Zci39zOjhJp8q94zQLTnoN9czOCvRvY3663YiJpPILDQt0j
         AjnAQADmTLSR9B4yIVWE8ghCdqz+b9ns0bJf+d8mCKUOmNyR8Xs4qNTl1tNslN8qn9fF
         kcAuKPCVnxPX+EHRlTRo/GI4zpeJMwXCjdNJ04sbYbBteToVou4dyBR4NGouaHJ9rXBF
         tWdhM03iiv4blD8RO8V4qjbb+DXf2wfnVVyrr6EbNd9fM/ii69jvxjCP9nn/Foispts5
         n+cQ==
X-Gm-Message-State: AOJu0YxeDeWx0vV1apQBQmStPFt4+UAI/17zPNVFS6A5OjqZTRFwdSnr
	qJlRdrgVFDLrCzh2Ez1LrW0todQqJkQZ1SlbnaDNV5zgUcTUPPYdGSXS5g==
X-Google-Smtp-Source: AGHT+IF+iDh0a843GH6AlqUvDFAzQ51EC/9V6xCa911ORdwGFqi7llHxHUU797kGOPNNY6Wbt+iuOQ==
X-Received: by 2002:ac8:7c4c:0:b0:44f:f83d:469f with SMTP id d75a77b69052e-458602d9deamr138338521cf.14.1726335737306;
        Sat, 14 Sep 2024 10:42:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.37.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aad201f6sm9928001cf.87.2024.09.14.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 10:42:16 -0700 (PDT)
Message-ID: <66e5caf8.c80a0220.143f0c.2323@mx.google.com>
Date: Sat, 14 Sep 2024 10:42:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3564052031933821575=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, coelacanthushex@gmail.com
Subject: RE: [bluez,v2] monitor: fix buffer overflow when terminal width > 255
In-Reply-To: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
References: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3564052031933821575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890409

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       FAIL      0.53 seconds
BuildEll                      PASS      24.64 seconds
BluezMake                     PASS      1646.76 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      178.85 seconds
CheckValgrind                 PASS      252.77 seconds
CheckSmatch                   WARNING   356.30 seconds
bluezmakeextell               PASS      120.26 seconds
IncrementalBuild              PASS      1413.47 seconds
ScanBuild                     PASS      1007.60 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez,v2] monitor: fix buffer overflow when terminal width > 255

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (99>80): "- Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1869:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3564052031933821575==--
