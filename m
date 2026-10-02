Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426030D402
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904348; cv=none; b=G2IP0oVfAXpqADW6pfo2oGvMaFds857sQeLdhGpzj7aM5ttciBjSUcrVy7gj9aZmsWMgkBPD346PNojuEvQqeXLXQ56TvRjpRDSrWhV+4vQkMna/zF3u2m4l5SS5eswPsygEBZpWHrE9N7id3RMfCFwNlj3Mrek15QXUNAdP8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904348; c=relaxed/simple;
	bh=kZI89yOlXiYsDvofh/WtTjLUnb7HWp10I4jru0/8Jh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ona7b3fx/4QvlcakrHgtyvoFNYNmEJ81Xco5i1oxaEeWHeWsIomkc9ELkjOdHjMdXFx937hemBpdqj5eHKbjITbiltAUqXgAvE2yOWdD+Q7fhLtF0UEg7I5iY/OlaEkRClE2QR71B8+luVaph8Kmv22z753NZTp/aDBViYoyfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjGvvrKb; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjGvvrKb"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-81c2131b1ecso798283a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790904345; x=1791509145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hA/VQ66U6s58Eb4wx5IlG71m91D/QLj21C8n4BUEC5I=;
        b=VjGvvrKbYuSgCoQLDo2Ac99IUdt0hcCqqpGCUoN0mp4+HAP4YAcHDgvktl/axyDCaI
         IMlvaBLmlO9y/IstlcHfqo6DR2TgxqWYsMYpF1S4krXQ9I4MQoGCLGUnq+p7Z/HqraRv
         L+UIHDPvo8jnSgIqoZAVjLpkOnTB5VzkMCH0hNGHHKaq27/5Kv1fsfto5vPek6oiOBFc
         iLJYZRwxiruFD5WwbEHZ2RUR5HDLDuAcemS5UdwTL1/YFlXJEbu1u/6lNEtaupCTV721
         wVal2F45jFphfAB9LDBRrUvDqGGmOwHhVeOeBhnlYSxS+NszFYwT+eSZDPZE+g0KG+iL
         ISIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790904345; x=1791509145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hA/VQ66U6s58Eb4wx5IlG71m91D/QLj21C8n4BUEC5I=;
        b=DcLnLpKsXVtKQtpezJ9yFezNBuf1C+bOeoup8vQCM9fJEC+6FgaKmvlMLxqCwT+29e
         wVcI2N7c5CYQqEhQh9tD7SoAFPGQwqEFzfgXNLWb4ChlMid9EJUATJtMk5R63gIY+JK8
         hLfwDLxmdAKQM0hU4sZjLXTKNyXYc2/RoA3su6BhUkslsNxv9lVkTSOCAfay1PJMvd6C
         5uYWDGBqSgclf5rezbsjqJvNoCykSNJKvJJ5+7VhUaidhjkzlgsMRKwcnqSa78zGG99M
         y1w4VpP7zYDwK6MbI6CviFxwNN9xB61RzMYEKODm7ZGIFI5+XGIN1os7AJ88OqpVAeHs
         Fk4A==
X-Forwarded-Encrypted: i=1; AKwUvBxmbyeCPB11WzcF/4VaQnGg7D+pd8L2xEi1Vkm90g9CccNprBJC2RWeNvnLOEyvTZQvOIkajbRjZAUCzeuCzIs=@vger.kernel.org
X-Gm-Message-State: AFuF++nT+gGXu7Z8Pa2eDOk6hzm3imQyPNFE8uvzu93DDXFuMtxasPOZ
	1wKxz/tSmh2gy2Z3xy5BItY7hNbWRXXp3JEMiLUbEyeRiip8F4HG0YOi
X-Gm-Gg: AYBFou2fFilkt0TWPJJlTcGD03rLOvtW13IvRCYakQ8iVm/2GGoRY5dFetkmHqRq6TI
	9EQPdAEKi45iTrVNpAdOxOvYoowmrz444tJt0zQMnMatCuFykI9MR8K2GzghwbWYFtWKdxm6dlZ
	B2/HsSOCklc7ZwcYc+2EMSTkIVURrHU3gEcwYZW+3s3UJq+DsV4TkgEHen6heUVX/6uM3H7KWLe
	ue1Ulwr6MIhOm7PWt17HcTRi0zCmn/VQlY/HySnmx7FYyPtZ3cpHb+RtSrnRN0p2mHNmua1Lyhj
	+/RH4bQbd3fm31oRa67s/WHDPpLO8r3LQ8HgY7/XBNZAaTS6NUbRkZ/uaYALXecpp5AEjnhfrfW
	IONuwgknomvXmz2MCz4gY4tOJkLxpii49vJsew2p0fHUoL8Ep7Z9TJ6zzo5YoRStclz8PjAldYG
	Iw8It1Gh+oPdE/P2dG4jbqhKrFvi+Yzf7ekC3Hh02Z8gtbMQ/DxfC706Np8hXn/d57rrBTIYpWL
	INtQUUoJf+q0QQvjNyMC0diUNjilpAogv4JFJ4nYYvpCyTIWGOGwA==
X-Received: by 2002:a05:6830:4107:b0:805:98ae:2160 with SMTP id 46e09a7af769-8228147557bmr2111785a34.2.1790904345564;
        Thu, 01 Oct 2026 18:25:45 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a86abbesm1749053a34.24.2026.10.01.18.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 18:25:45 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: stable@vger.kernel.org
Cc: Tibor Harcsa <silurust@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Please backport dc16388d45ec ("Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table") to stable
Date: Fri,  2 Oct 2026 03:25:42 +0200
Message-ID: <20261002012542.473669-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

please consider for linux-7.2.y, linux-6.18.y, linux-6.12.y, linux-6.6.y
and linux-6.1.y:

  dc16388d45ec ("Bluetooth: btusb: Add IMC Networks QCA9377 to quirks
  table")

It is in mainline since v7.3-rc1 and carries no Cc: stable tag. It adds
one entry to the btusb quirks table, beside the existing 13d3:3501 entry
that carries the same flags:

	{ USB_DEVICE(0x13d3, 0x3503), .driver_info = BTUSB_QCA_ROME |
						     BTUSB_WIDEBAND_SPEECH },

None of the five trees has the ID. The commit cherry-picks onto each of
them and btusb builds with it on each (checked 2026-10-02).

Without the entry, on an IMC Networks QCA9377 (13d3:3503) in a laptop
running Ubuntu's 7.0-based kernel, the device is matched as a generic
controller, btusb_setup_qca() never runs, and it stays on its ROM
firmware. On that firmware I observed:

 - "unexpected event for opcode 0x2005" during LE scans, as the commit
   message describes;
 - after a transparent (mSBC) SCO link had streamed on USB alternate
   setting 1, the next HCI command timed out: 12 recorded instances
   across four 7.0 builds and three headset models; in the investigated
   ones the controller then stopped answering USB control transfers and
   only removing power recovered it.

With the entry (the commit applied to the 7.0.0-34 source and btusb.ko
rebuilt, nothing else changed) the driver loads
qca/rampatch_usb_00000302.bin and qca/nvm_usb_00000302.bin from
linux-firmware, and neither failure was observed in the test on the
same machine:

 - 0 "0x2005" events over the boot;
 - 16 SCO links on two headsets, including one that had wedged the
   controller before, with all 16 hang-ups answered and 0 command
   timeouts. A diagnostic build enabling only the QCA setup part of the
   entry had previously completed 58 links over three boots with all 58
   hang-ups answered and 0 command timeouts.

Runtime testing was performed on the 7.0-based kernel; the five
requested stable trees were cherry-picked and build-tested. Logs, HCI
captures and the exact commands are public, exhibits EX-055 to EX-059
at:

  https://github.com/ivoitovych/qca9377-bt-hang

Thank you,
Iaroslav Voitovych
