Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131013959D
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003220; cv=none; b=TTEaJGfVF1ybzdGqGQ84IXFsUqfmHvO6E1JM9UJnN4CtgFxUOL2iCsvbgIu6bw3Rzwlk8AM/bvMFDYBD1j2PFwYaK0BfJOmVwNOnkVjed27a2YxoHVS5wVTwGrQNuFKo2SwCt5mA5PeuwRczXX0uydEqxKc0utwwhytxwfXjlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003220; c=relaxed/simple;
	bh=KQ8XEp6qw74Gwv6qWSLZjcWsR/mjbR2exUpGXklXE0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T/Viijyxoqmmvl/vMpbUrrxXrZvF2Gy8EsIWBQLpFWl0sKo+Rlwq9nnJ1E/bn3hunPgiqFyci6mPee5UdWBDhxIR7fcBtrFGpcgXeomzRIV59DRjMzU8JxKCJUtbcw3Fa0vHAy05sM2FaSZJ5/3q/UGHd1YOF/P8PbQXDsrWLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECXuAx1q; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECXuAx1q"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03a8955ae3so823129276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 03:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720003217; x=1720608017; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KdhtQ6R/LNlMhr89EcyXHn5YLBxZ7d0p03BnCAFx5kE=;
        b=ECXuAx1qZ/sXuYp3QcHz1iTksYh6NrbwJTq5oKOulEQWQzoWBzLZMW0rqzvPN966aR
         868n8h0PmfU/oxs4oWFTZ6tW6D9Hd1XGBh/LFpv7msQuT+8HvhJDsh+CR45I9K0W+6fg
         qp4DcraFUHYsX+cyZ6VNKPIA1U8J/swAyn8S4HcCglYaFnRg48oLQsmqSu2xEntJ1Yyv
         eQga0naoTYHHbSvHZjjjQOvw3W+cDxHU5QBvqD/63VYfvzfL064ITmHkiYS5M8jdvvJd
         1TBzMlivvfORIw7xA3LgwuXyHcdmq3Yh1itmyZE6CIsH1MZsl7ew4lJ1/i6gJ0oiJK9t
         s+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720003217; x=1720608017;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdhtQ6R/LNlMhr89EcyXHn5YLBxZ7d0p03BnCAFx5kE=;
        b=WxXIW1SBlT78NeUPdRrRj5qH1t3pPjzII2OY9fYfuxWC52l8V8Uz6jH5v95dBSLWJf
         IqK8mJ9qblvAlDpvAwSxKzgEKS0XDa+8qHtDuaBi/WTntmYXxyzPyL2XJtvBLmGqZdtf
         AyOBkmt1AwYGJ3W2UfJtWl/gFBMJI4S0AGfE83aDXPTJyrNPh+TeqttMuzZtZWgyhDDk
         Ls1LINXMnxMXAcPf4GMTnF8rJF5auHm563WFnnlUrtX9y2661Yu9uQInamhXvZJ7vglK
         xQ95v+rzeKeK+AZflmc4vY8vDmtZEt3RZHZKd1/6QWzolPPUbl6Lzv58TXLx1zNQ5UVY
         U9pw==
X-Gm-Message-State: AOJu0YxhwO9assDD+xJxJF9cUdessEhctt92RzyUd5hP4O1z9MFmzP/d
	qPaiFGDokhg8rv1urMrcFvLL8hAHC0x/899lI4wSzFw6NsgezwiwM6pdrw==
X-Google-Smtp-Source: AGHT+IEUnpuyMW6G9TR5SqsXRX1MgSPIQmMPDUWsFS8UXkKvUTK5aMinu3Z07PNwK5///Vnsl4Y7gg==
X-Received: by 2002:a25:7bc6:0:b0:e03:b4cc:d9d5 with SMTP id 3f1490d57ef6-e03b4ccdb93mr241882276.11.1720003217366;
        Wed, 03 Jul 2024 03:40:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.55])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5df21b3cdsm6767376d6.113.2024.07.03.03.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:40:17 -0700 (PDT)
Message-ID: <66852a91.050a0220.1bc80.260b@mx.google.com>
Date: Wed, 03 Jul 2024 03:40:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6400986595148449594=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] shared/bap: prevent dereferencing of NULL pointers in ascs_ase_read()
In-Reply-To: <20240703090305.14542-1-r.smirnov@omp.ru>
References: <20240703090305.14542-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6400986595148449594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867893

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.49 seconds
BuildEll                      PASS      24.47 seconds
BluezMake                     PASS      1655.50 seconds
MakeCheck                     PASS      12.76 seconds
MakeDistcheck                 PASS      177.44 seconds
CheckValgrind                 PASS      251.55 seconds
CheckSmatch                   WARNING   353.10 seconds
bluezmakeextell               PASS      119.45 seconds
IncrementalBuild              PASS      1439.56 seconds
ScanBuild                     PASS      986.28 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============6400986595148449594==--
