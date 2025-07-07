Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D11E7C2D
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903333; cv=none; b=KgLzMGZehZszCGTpt7WFuXccH+MqThhrRa2Jgl6Gxa44nj0Knmg0s1TEjDR+P2ExpOUklFLaItE6p8WoXUk4FF07PJIP1Nky4j8FmVJdwET4cwCp9kn57Rw6dAbBohoqsYz5B55THONydx0LYXcysTSLAC3Ewwtj4KmGaEEHkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903333; c=relaxed/simple;
	bh=2kYO8Puhe1wu0FjFmDrL4J2xcXvXHqJUhxRogNZ3oC0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JE5Wt49CbLQfrd+j0OR8M2YsVxIv87/xOA+/FQNZrSZGNSdq4DMNCKi8SHz9iCy/DAeMThW3CHbNBZ42Xm9BgjMmTpnyoJ3VhZw8Xns9k0nvBOEZlf5v4uzywM8T/Zh5cFxwy813Aud7OA7qIcVqO3fERpYq1vBe2YVRoverJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXs4Rk2U; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXs4Rk2U"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d7f0fcef86so126534085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751903330; x=1752508130; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ERLdGPX17VDEnOoc4pDGvkvtYCALI1xQS1R3sheQekA=;
        b=XXs4Rk2U65lSyxtbR3M0gg/OpCHhlMOkmBjgmAaK/4dHX9HPg+Es0YFmlI0jUjI5bI
         29zhjv3NOfQ/AUkHeHb/p8icgBBo0lIK4e9BdWfq8urPerzwm+V0PD/MtGR6vfRGbOl0
         MpBCKr54304gG0EHVom/77Ld6nXBF5pBhBKtaB2QoueIZ3MVdlToyumK+dLvGlkcZGrj
         Q07o8xywy7Ahuvs6iWEZl6uuwaYYL0QFuHtkK1pHh1ZYCaZgzYyQErvgYskIWQ2F+SuE
         ipHX4kyyfUdG6+CWLtOxLWphhB2qlVl7uCPNmdNUhP2Zw8m6Xo88YVfRczH04OZM9NBS
         iBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903330; x=1752508130;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERLdGPX17VDEnOoc4pDGvkvtYCALI1xQS1R3sheQekA=;
        b=MmCDyXZpLnQ6B+RopTrb1Am1VD4a1rGYcxXjBugNLzC+o82vVpdyb3XZuBCJOynst8
         7j1rnPhyZtKMH/fJkP5dSegZb/rC0KbCK6UGqRoDfN7Sbd4TO52EleJw/MR+p+SBaXsT
         YbvXRMVeVMqgJvSrkC8Z/foPHEGyBPnHIinhNRVQ4U+8J6M6EtuZzkKMOknIvN53ZQ35
         edqWxF10lwqTS0qtIGrYu9xko6y7wtLHP1dFuy60xw4Nu2e2kCu9Wgu3hWk9qMptdEks
         q/Hm4JluqH2Z/VWXny+1zaRTo9i5CCx/6JPHU0yxezD6awUTYoMRhm5XEyjacSYyxjBu
         bdxg==
X-Gm-Message-State: AOJu0Yy6/EKK9ltPqLtf0lnhBqUKxfJkz5s9MpZCn3fZdPNUNmT9tUCq
	3xgyGqWaht9wvVhrhFW1RyNiSTjyImjVVNvDZvL2rKve1r0fakqZrC15ODeDfP04
X-Gm-Gg: ASbGnctwCs/kTF6V9ZbblbFM9Q1wKp9Vq74AEspAga5gl8DwkG2UerpEsnUIdLBsErN
	iUUKptu9RGSyQeHztWGVzfbWDduBSEHl8954pBlfcg9iobEGmDSKqqznR1X8d4NLpF76nq1txaq
	eleZo+W7wx/Z8nFrjq5p13EijTDCUnIAXwQrXsvoyW46FpmYf/DZJQ+G4eUNxcuZnjWUtyrrhne
	UpztYCl06NmO2uW9d4iElIO9Gs9UqGXkgAkRJXRsTRZ+V7rMm4MQdO8SCa2rp1niPN4C604Qqat
	a0bn1rD3mZbzNZcc+atswvUbM9w7oeWMt1FCDw3xDBISFe//kAR1EDaQ2GKZP/vfAY7/+4Q=
X-Google-Smtp-Source: AGHT+IGyFCND3UCntF7V7B94mb5Av2TOj4Ak+hfY9apR/DBt3HsN6IHmUdz4pDgwy5krHz40gBP3BA==
X-Received: by 2002:a05:620a:2b8a:b0:7d4:2841:9c with SMTP id af79cd13be357-7d5dcc751d9mr1853053685a.8.1751903330447;
        Mon, 07 Jul 2025 08:48:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.164.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7bb0esm625834285a.69.2025.07.07.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:48:50 -0700 (PDT)
Message-ID: <686bec62.050a0220.ecf2f.5b80@mx.google.com>
Date: Mon, 07 Jul 2025 08:48:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8964713334984064357=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] shared/shell: Fix not running pre_run on MODE_NON_INTERACTIVE
In-Reply-To: <20250707142350.2404116-1-luiz.dentz@gmail.com>
References: <20250707142350.2404116-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8964713334984064357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979707

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2584.81 seconds
MakeCheck                     PASS      20.80 seconds
MakeDistcheck                 PASS      190.62 seconds
CheckValgrind                 PASS      243.83 seconds
CheckSmatch                   WARNING   310.43 seconds
bluezmakeextell               PASS      130.31 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      935.85 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8964713334984064357==--
