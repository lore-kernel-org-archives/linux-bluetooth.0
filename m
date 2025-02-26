Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000D41C71
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597395; cv=none; b=iNNpfyKwTCkbY8AJSP9oG1qddRFmsH7xuoaAC2HjAvkUmuxocmoEPOvyvS5fzTLnINxLQ9zjj6kh2TVrhfrJGl8loT37epsT1Uyu5fDt2M4VbOYqyIrEMYB1fukDgdo1bavUb8bzcHPU9zSM+E2wciRhdAn3hxElUKF/Bof30a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597395; c=relaxed/simple;
	bh=m1tlaULFdGdRbVJfwW4vld36EFSQGk5asBzDzeSDyEQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iKl+0rIet6GtDmjStLnDbtXhpLrZbswPg21J8UV3cWHozT8IQqTp4WSDhr8B953Vy+3SM7elm5ktToB9CXQToGC8rHZuhvb1b7vp2OK1P1yodxDzmvRJsUdwYeK7DOm487GcGCgkla6g4pEogrdClgQel9kN7xIZCQ4oBM54Qr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJX/SmIZ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJX/SmIZ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be49f6b331so14892085a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740597393; x=1741202193; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5xszZpzcFM9WJ7pyh9XvTo+QASngDNDRaG5Dl7UXkuU=;
        b=lJX/SmIZnVVbtPl9+KcDUBM4o2ZLRRyARHlKUBzgGgLQ52913Cqq24kih9xibMtUlZ
         8iCho3oSAU4e3cQK965jexedrv22+9j4yxxOLEGcTOONAYicn6y6Fq3uSoBFGhDQKrlx
         GO5PGybMlx3LlC4lGcJORkytLyYbZekei+NkBxsqIlg0V16AqT2i2qH3zPrOzm2eTkp6
         /WyEm4Wb5NTT8OWqFffTkQSPWTRCwe2QTKJQqQqXyNCv+Ld26xkgzxwTtFweeb4CyPdY
         sBJ5x2oYB+iP+UEVY1aEm0ZMutgCiS+KUU3e/XdmTSX8Wn5mzwDSzejvvDJJApmATYkD
         Kpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597393; x=1741202193;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xszZpzcFM9WJ7pyh9XvTo+QASngDNDRaG5Dl7UXkuU=;
        b=mWnxXiIcsoMdBsWgWJpZ1DCEuo4+ghroUMo+z3JYSfDpctgyGOxIm86IyhN8mupBh3
         Yr9976NCpST4p6VxmOqrvGLbvzivEy518a8/dw0HpFzZZ8ydW4PKRVXo5BVFIWapIyEz
         puyt66ECOeFyxWP0PCvp9MWoPOKfaN0ug1OFpiFsk0HQSyPNW5PdyLj9TCEOBtzSXV9u
         pT+wL0lOoJu8/ca/+qaFm2IL1vRA84A0BBUtdcrpxhMQPABpu05x6ekVQT/OQbzn6HkN
         QMyRzMWEOmc5kbVQgwi0OSUwFkFWfB/BkdocARV8CZxI5Fa5pyNxQUYMwJX8dR4ShNa0
         0mKQ==
X-Gm-Message-State: AOJu0Yx8TQcbA9uTWY3l256jEmd2opc7aCZ6L9/XWspg2PiFvEiH4pxr
	hHfWeJ1k66FNeb/wdbCB7WBjDmoVA/2Y11ipmG5rMohmDfqEIz7D6co+Aw==
X-Gm-Gg: ASbGncvptN3pzD/tBV0ME/z5UGL5Tr62JJUOLAHke6EoM3RI1ur6ONyDS2e9NvRXJIi
	qmMAAwfIWs1anSWTV9qb66m3PeCvHuuJ56KGVrcVwUdOacZ6sJ6r+6gEqhAsC+auQ9RXwFULqy1
	J5w7npX6wGN4LYu9uo+kv86NzljukWGg8VAcvq+/floWtF9Z3f218nwkZpF27i6IxbsLGCH+whP
	MGbUFw9G5sZZXKB+Z/Qw75vXpBlNph+Ak6T9JfPnSiPxEv40R1IVgdALu5/J6X6AjB2/I+gKJQW
	tHmLUrCH/6dkYLdutt4Lr6FZlUd1UKmuFqE=
X-Google-Smtp-Source: AGHT+IFxHNZ8YK7O5gdWdK1ErfanRIVMhhlPJzdh3D7abXWSEiWUwzTAYh9Yo40CNgWvKhLvXPpLUA==
X-Received: by 2002:a05:620a:4883:b0:7c0:b523:e1ba with SMTP id af79cd13be357-7c0cf953f36mr3105570785a.45.1740597392957;
        Wed, 26 Feb 2025 11:16:32 -0800 (PST)
Received: from [172.17.0.2] ([172.183.175.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c29930asm289251085a.2.2025.02.26.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:16:32 -0800 (PST)
Message-ID: <67bf6890.050a0220.290bf8.c76c@mx.google.com>
Date: Wed, 26 Feb 2025 11:16:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3206856828563519329=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/4] org.bluez.Device: Introduced PreferredBearer
In-Reply-To: <20250226181129.2958079-1-luiz.dentz@gmail.com>
References: <20250226181129.2958079-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3206856828563519329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938178

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.53 seconds
BluezMake                     PASS      1523.85 seconds
MakeCheck                     PASS      13.59 seconds
MakeDistcheck                 PASS      159.75 seconds
CheckValgrind                 PASS      216.30 seconds
CheckSmatch                   PASS      285.52 seconds
bluezmakeextell               PASS      98.01 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      866.45 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3206856828563519329==--
