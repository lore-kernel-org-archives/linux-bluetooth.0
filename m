Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5D19DF49;
	Sat, 18 Jan 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219530; cv=none; b=Vkh/c3Z2MhBA3bSFJJyYOFgFWmMpYiQeKJm7zcWMcQdciSjGvM2dCyftxLx6OUEWhvZhyYG5Xg7hjrAOeXemf28pqNZpfQkzVM9legf+giRGXP/97iZJzzOSjJaLbWmgLqU/NySQ5x6Ku9BMcoQJh7fiR5PU6QvHG6ZOAmcDbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219530; c=relaxed/simple;
	bh=Wad7o9Nhl0by+kpcehRF4PWr5uVvTb0iaG2V4hT5vL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4b2c/gwpRSby0j/xc3NJvaXwYc/IO/PNUP8xLKG8B+7A4ATqUUF9dP4LxFlg/CxwYZgN3TXDFRg2aqrVGfO6oSR5wXMrjKl2ql3gIymZzOpDw4OBV/M6bsN7KTxEMkohYb5d5ETqzeTP2fuaWJ4o7YXSxS0XklGUa2Ev2mObkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy2/IL/+; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy2/IL/+"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71fbb0d035dso1700739a34.2;
        Sat, 18 Jan 2025 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737219528; x=1737824328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1y0ZCBBg0Ud34GfVfOi+9b944wjZwzsnzcdabcPULM=;
        b=Oy2/IL/+qgMslSwds6Ne6yIPxnfBAQoQ+tH2IcUC5RsXcoRn87/wJaQ1YlI/kugkJc
         o2iup5+oNlHqMXiROmTTzJ/LakHGTUmz7Ri05n2YrlXJBQmjVqYz4Zui+eGyPYST2S4t
         6Gv97EcCksQJ+U/0islCOBAIQQZFNQ8LGsrW/fuRL1ahF/EXriQYColM2nLnQQqpvvUd
         WjQlp59Ldf/bzbCuonqrZM0Qvh+6Gy1IxOkAiDHBcVc7qWGijTBdCivpcxEgeHAPjw45
         LpmWfyjP6nawXKsWmixWvjYln3341XooZaZUXQd2FknGHgCjqKtV8ddH/ybY8xA4v+lS
         Bhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737219528; x=1737824328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1y0ZCBBg0Ud34GfVfOi+9b944wjZwzsnzcdabcPULM=;
        b=Ca08RRfGmuhr5K2z8aZ7/QZR0sINaglyYylLrpkO9kuOBcvVToKBDnxmqUKHxpW9f2
         xk5wDWdX8//zqkzHTZeEjDGgixeY+Q+ikz3R0UdoPPXPGQCp4XY6Pox87h/wR4tM+aKN
         vOKu5nCJe7827DRz3AwATiLI0SHRiaqHW/0ypAJ/gC7eN3invMaDk5PhpwEiUPhFmDoO
         nIK6YTpx65uubeOaiExlWSBjzYoby4l476SCVQB7L6fhBRg+JDlf11WZhURmG/4/IJff
         APtPM+LV+ZT2yqZhK0W4hrZBSAVVjBQXNIqPH7XHYqV3gQyZGvzGiXds0pDxvI51hFny
         Nx2g==
X-Forwarded-Encrypted: i=1; AJvYcCVgjciQ3M+D41gzUMSpfCLZa/XLETO4cXPCcZXzgKXAui8erfI6/Bi+Fj05oYhgd1aeZ1U9FIKblWahWtzq300=@vger.kernel.org, AJvYcCWTCRNhjDJqlr+80DbN6We7R3xCqZR7/AodBV6j2UPt5upDnJtbeIjWNO8afXfav/45z/BEgUcCPrHwFnWU@vger.kernel.org
X-Gm-Message-State: AOJu0YykboAoWQLDS2yQdw5/f3ajvavseRoAlAnv+cFvjKuyXpbJ2HaZ
	808ItJLIP7wBOwsDGiOgI9zmwvi7hsrMO8PZYKzywqyEqqpsBrMU
X-Gm-Gg: ASbGnctc7sgOBNVngRaS4TS+CMYIQt2X3W7HjTSsHlOa2rqCtqrs1EIMsXcdH+XA9IL
	bguuBFKCN5TFrI7sxIswGHK4ge/j/94CJVw21ceI9KnJ9htPrDrqUZ5bSiWyH8R5uGYGa0jZSRf
	1/oXp0ORcdycNB/gA30EeUEsbd8UqI++2HLXudn3suXEAzX98Ew4GhPZsYYhsUUEIVYQ+ynpAKb
	iILhMce3rcushq8atkuUfYO6mPe6kTi0aNzL6yxYzN67pqGcjDuHs/+JPq4fKrAATx7lbVUqJ5j
	zNVh
X-Google-Smtp-Source: AGHT+IGbP27AbbOClCTCIkR1cnDE8YRBZyPTtMGJMtWHw/+weozHCb/XJ/XWVucTdPdjgwFMUv7eMQ==
X-Received: by 2002:a05:6830:90f:b0:71d:6221:d4b7 with SMTP id 46e09a7af769-7249db0d787mr4159608a34.28.1737219528177;
        Sat, 18 Jan 2025 08:58:48 -0800 (PST)
Received: from localhost.localdomain ([23.151.240.73])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7249b3ac6f7sm1589013a34.27.2025.01.18.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 08:58:47 -0800 (PST)
From: John Glotzer <jglotzer@gmail.com>
To: sergio.callegari@unibo.it
Cc: Aaron.Hou@mediatek.com,
	Chris.Lu@mediatek.com,
	Deren.Wu@mediatek.com,
	Hao.Qin@mediatek.com,
	Sean.Wang@mediatek.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	luiz.dentz@gmail.com,
	marc.payne@mdpsys.co.uk,
	marcel@holtmann.org,
	regressions@lists.linux.dev,
	steve.lee@mediatek.com,
	tiwai@suse.de
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
Date: Sat, 18 Jan 2025 10:58:40 -0600
Message-ID: <20250118165840.73110-1-jglotzer@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <9ae25475-e8f4-4ee1-8022-7621fbe8ebc6@unibo.it>
References: <9ae25475-e8f4-4ee1-8022-7621fbe8ebc6@unibo.it>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Note: additional discussion has taken place under
Re: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And Hibernate)

Hi,

I have dug further into this issue and I think I have a root cause analysis that
makes sense (at least it does for me :) ).
The TLDR is that the root cause is the following commit that was introduced with the 6.11 kernel.

https://github.com/torvalds/linux/commit/d53ab629cff57

Furthermore, the problem must be the call to usleep_range() in
drivers/net/wireless/mediatek/mt76/mt792x_core.c as this is the only behavioral change.

Notice that this commit first shows up in v6.11-rc1 and is present for all subsequent releases,
which matches perfectly the breakage pattern seen by the user community.

What, then, is the evidence for this?

First of all the entire community has been unanimous in the observation that the issue
started with the 6.11 kernel. The universal experience has been that any kernel prior
to that had no issues, and all kernels starting with 6.11 were affected. Also no attempts
to mitigate the issue in code by attacking the problem via the firmware download code paths have
been fruitful.

The next piece of solid data is outlined here:

https://github.com/alimert-t/suspend-freeze-fix-for-mt7921e

Here the lead paragraph states:
"A suspend/resume issue occurs on systems with the MediaTek MT7921 Wi-Fi adapter when
running on Kernel 6.11.-. After suspending, the system fails to resume / freezes and requires a hard
reset."

The mitigation for this issue has consisted of one of two approches:

- rfkill bluetooth and wifi on sleep and reverse the process on wake
- add the parameter mt7921e.disable_aspm=y to the kernel command line
(anecdotally I have seen reports of people doing things like turning off bluetooth
 and/or wifi before suspending or for that matter rmmod mt7921e before suspending).

I personally have used both of these methods with a sucess rate of 100%.

The way to unlock the puzzle is to examine the 6.11 code with an eye towards
- what changed between v6.10 and v6.11?
- what is the intersection between this changeset and the disable_aspm paramter?

To cut to the chase the answer to both these questions is just the contents of
https://github.com/torvalds/linux/commit/d53ab629cff57. I confirmed this by
diffing v6.10 and v6.11 and then going through the diff looking for disable_aspm.

The following lines were added to drivers/net/wireless/mediatek/mt76/mt7921/pci.c

	if (!mt7921_disable_aspm && mt76_pci_aspm_supported(pdev))
		dev->aspm_supported = true;

The bitfield aspm_supported was added to the struct mt792x_dev in drivers/net/wireless/mediatek/mt76/mt792x.h

and if this bitfield is true then the call to usleep_range is made in  __mt792xe_mcu_drv_pmctrl()
in drivers/net/wireless/mediatek/mt76/mt792x_core.c.

		if (dev->aspm_supported)
			usleep_range(2000, 3000);

By setting mt7921e.disable_aspm=y on the kernel command line, this code pathway is avoided
and no crash or lockup happens when the device is woken back up.

Disclaimers:

- I don't claim to know the root cause for why the call to usleep_range() leads to a crash or a
  freeze.

- I don't know the details of the specific issue the code for commit d53ab629cff57 was designed
  to fix, hence I don't know the consequences of removing the call to usleep_range(). However,
  I do know that the user experience has been significantly impacted negatively by the introduction
  of d53ab629cff57 into the 6.11 kernel.

Thanks for your attention,

John Glotzer

