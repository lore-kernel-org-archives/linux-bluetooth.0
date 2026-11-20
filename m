Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163214;
	b=OIpHxA5LuZh2aUtaKCSpUMMs0i9Xev7TmH5cGTDPlKooCgC9EfNChDFa9rOPGBOF8X3v
	 JZzpf/BIsC8Vk3IpHgMjt5Lhbnc3zimjfRBWi2vv/YUx6TosG8oI7bZPQ/Jh22QMLm1uZ
	 3spW3wpAeo6amxGAWBmkXAKWmbfRCgE49fI6qgdkCeVGnCDI1N6SEBFH0fUmTgygp76FS
	 UBSA6jew6dTHuBb/hcK87XCeooB867SZJZA9QnF+yGeidjy6LK7WSt3qwXVWEqTNt4KeQ
	 vYSu8s1fxRjwEqWICC4NIZFeLdTzUeRWmIEdgRgDm1haT2tTpvMzYIvxmH2WUoG4PrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163214;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3RdsJmKkC6IgpIevNBF79SFGapdKJgsNYchPj2f52JM=;
	b=Tz7CUB4R+kTmzVAIkUKvvngNemAxZdUDyZKOJ/Ag+1cSbV+ZH1DTrmb3rumGKwD12jqK
	 ejIvzJUbcYnjVHFDxD5LrAuZ9+ROXAiTS7p9SHwRqNq+bL/w9i/dln9eKnhD5MbTRetrM
	 HmTFSo1+/rr+sZ+A8KPYYN7LI7K8qTwxZbNU9/FnJoIDxEzveyvZtai6UGOEIE7+UHrjW
	 hLK4iGxNs77lpOtzLNmZsgKSzE4pFHw55vfutOIBPbw1NmbU9ovJCI/6X61HnV5/H1brl
	 iAfAO0OywkKSFowPVdLjKqIGagtG66+8ODCg0Lb2YalPloE1tjCA3ERb63HQP9jpePA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=s9mz6AjH;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52801606A33C;
	Fri, 20 Nov 2026 08:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52801606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=s9mz6AjH
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AK8Qg6H23249580, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795163202; bh=3RdsJmKkC6IgpIevNBF79SFGapdKJgsNYchPj2f52JM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=s9mz6AjHjMg2GVbf60zWBpeKWKf+25had9ZnSil7WCPhd80itF0OElPBqAtLaDOCX
	 kGf9aPjEY5DdZ9IeNDOi8F0smgoYwtDnmg/iJ7ltkSpZzcfv3YvowvO7tlKEdgAEX2
	 H/HPSRNf/eI9QcACPfVDRKGZJTuLyxWdINz9VxGWwO11xAhh2jNVrpgL3EpQ4IXIf8
	 57RvZ2bKP4zJKSKFjAS8y982r20rYjiqeocIcANYvvYh8ee4vXmB3AlbLNJC+RBfo4
	 ItmduWJJhzVtsOG1BpZlD7R+/6iQHJcaUp9qszcU8wOI6yhCnlFuk8LGt+MFAiTQEb
	 sNTy+y1J5K8LQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AK8Qg6H23249580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Nov 2026 16:26:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 16:26:36 +0800
Received: from localhost.localhost (172.24.54.48) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 16:26:36 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
	<jason_mao@realsil.com.cn>, <zoey_zhou@realsil.com.cn>,
	<max.chou@realtek.com>, <kidman@realtek.com>, <arunr@valvesoftware.com>
Subject: [PATCH v10 0/2] Bluetooth: btrtl: Add firmware format v3 support and RTL8922D
Date: Fri, 20 Nov 2026 16:26:34 +0800
Message-ID: <20261120082636.3834168-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This series adds support for the new Realtek firmware format v3 and for
the first controller that uses it, the RTL8922D.

Format v3 replaces the flat epatch container with a section/subsection
layout that can carry several independently configurable images, selected
by key id and IC cut, each with its own register fixups and optional
per-image config file.  Patch 1 adds the parser and the downloader.  The
new code lives in btrtl_enh.c, which is linked into the same module as
btrtl.c, so the lifetime of the parsed image list follows the existing
btrtl_device_info and no extra module or symbol_get() dependency is
introduced.  Support for the existing v1 and v2 firmware is unchanged.

Patch 2 adds the RTL8922D id table entry, the matching quirks and the
MODULE_FIRMWARE() entries.  The firmware binary will be submitted to the
linux-firmware project separately.

Both patches are needed for a working RTL8922D.  Patch 2 depends only on
patch 1 and the series should be applied as a whole.

Note that building btrtl.c and btrtl_enh.c as one composite object
renames the module from btrtl.ko to btrtl_core.ko.  The CONFIG_BT_RTL
option and the exported symbols are unchanged.

Testing was done on RTL8922D over USB (0bda:a82d, chip id 55) with
rtl8922du_fw.bin; the boot log is included in patch 1.

Alex Lu (1):
  Bluetooth: btrtl: Add firmware format v3 support

Hilda Wu (1):
  Bluetooth: btrtl: Add the support for RTL8922D

 drivers/bluetooth/Makefile     |   4 +-
 drivers/bluetooth/btrtl.c      | 226 +++++++---
 drivers/bluetooth/btrtl.h      |  87 +++-
 drivers/bluetooth/btrtl_enh.c  | 795 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb_main.c |  25 +-
 5 files changed, 1056 insertions(+), 81 deletions(-)
 create mode 100644 drivers/bluetooth/btrtl_enh.c

-- 
2.34.1

