Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596438;
	b=zn8mJu1uuhVjFkz9+BSMFqH/dMe+7fOnfPN8iLwK4692Nk+5+71vsJ4OFFFWGEu34ynP
	 k/VZ9cpLcRjMVri0qVJkWeEkVcYOFueqxXRAntbA3LlXK4GOas42vduwACX/ESdyFnfDZ
	 lFaRR6zoEw8m2+L4PYJQiL2apNmE5mQquqGJk5xmRqBfVYi8oHn2HpUOPWDwU3t9XfMTa
	 avSPIRqoPiSAIzR4BOX+MneLZG2d4N05q1jGDlj5/0MNkCXGeSls+opde/qUpBkRnxhm/
	 C0qJN13p9TE5nKEhpqhXZijgZduMuDNqFPm6A6WgiX8o3ZMc9g85d8xEnMa4e66/sKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596438;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CY+RbvCWChjjL3SHqHvwvoll+M1JeoUvLibqMMnrqTI=;
	b=b9RVfBhMrYmKwCgw7nokGa277IOWay/RmRCpnRV2lTLkH9KVdkREURsMcxmrLBXiJWBT
	 cYIpg8Je3+e7ESZ0yZY+HnIaHKXUcEh09x0FWBqUbbADtdXMrCgxxbzjLmPncSSvMXUzg
	 lDI10aCXnXD/GCxwV6twWMJuUKRnBG2gT5YGpSXEt0XfMO//4H6BkQexeFFLUxIbffi8G
	 RsjqCrSLTkMcWxMS7LPW0yC+e/wTxUotjRfI2KJ3qnDVARwcPT9iC8iiDAJVW9wtOcfrA
	 ThWpyQoe92XodxZqmVHnI6uFGMx1xj8BpdptDhGMhsYeMuXq1YAtwQfSJ9n7AZiIQAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b="OSB7p/Of";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B08606A332;
	Wed, 25 Nov 2026 08:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B08606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=OSB7p/Of
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AP8l3whD3323401, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795596423; bh=CY+RbvCWChjjL3SHqHvwvoll+M1JeoUvLibqMMnrqTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=OSB7p/OfTOcD11+HPOAJz9zIRqKrbhcuyvmeyz7Iz/MU38tENLUjZmUsVG8NKTyuW
	 lG6KfbXQ25o+vpwkVQO54sGwRLp9bHKuvsOAnEmITD5sW2R/CMPEf7/5/wYkif832C
	 /4exyAlRueDctWF4NRb/+/NXNKW/tc1zDxH1kRJlewvQeTyqLbgorw8vsoNn1ZCnkr
	 ACGp2LkqaxxuW4kRvfu31P1URPH2nUGu9oF/H9PxZlcQ2W2kMyMLkCEmLwPJGrRZmW
	 YaW4YUtarUNIXRspcejf1HUYdkoi09uXeV5aBVgOuFzUtDy200pFLyTzRDgBBjn+IB
	 O33xuTXA+Z2oQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AP8l3whD3323401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Nov 2026 16:47:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 16:47:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 16:47:03 +0800
Received: from localhost.localhost (172.24.54.48) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Wed, 25 Nov 2026 16:47:03 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
	<jason_mao@realsil.com.cn>, <zoey_zhou@realsil.com.cn>,
	<max.chou@realtek.com>, <kidman@realtek.com>, <arunr@valvesoftware.com>
Subject: [PATCH v11 0/2] Bluetooth: btrtl: Add firmware format v3 support and RTL8922D
Date: Wed, 25 Nov 2026 16:47:01 +0800
Message-ID: <20261125084703.1578601-1-hildawu@realtek.com>
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
btrtl_main.c, so the lifetime of the parsed image list follows the existing
btrtl_device_info and no extra module or symbol_get() dependency is
introduced.  Support for the existing v1 and v2 firmware is unchanged.

Patch 2 adds the RTL8922D id table entry, the matching quirks and the
MODULE_FIRMWARE() entries.  The firmware binary will be submitted to the
linux-firmware project separately.

Both patches are needed for a working RTL8922D. Patch 2 depends only on
patch 1 and the series should be applied as a whole.

btrtl.c is renamed to btrtl_main.c so that it and btrtl_enh.c can be
built as one composite object while keeping the module name btrtl.ko.
The CONFIG_BT_RTL option and the exported symbols are unchanged.

v11 fixes a link error reported by the kernel test robot and addresses
the Sashiko review of v10; see the changelog in patch 1.

Testing was done on RTL8922D over USB (0bda:a82d, chip id 55) with
rtl8922du_fw.bin; the boot log is included in patch 1.

Alex Lu (1):
  Bluetooth: btrtl: Add firmware format v3 support

Hilda Wu (1):
  Bluetooth: btrtl: Add the support for RTL8922D

 drivers/bluetooth/Makefile                  |   2 +
 drivers/bluetooth/btrtl.h                   |  87 ++-
 drivers/bluetooth/btrtl_enh.c               | 794 ++++++++++++++++++++
 drivers/bluetooth/{btrtl.c => btrtl_main.c} | 238 ++++--
 drivers/bluetooth/btusb_main.c              |  26 +-
 5 files changed, 1066 insertions(+), 81 deletions(-)
 create mode 100644 drivers/bluetooth/btrtl_enh.c
 rename drivers/bluetooth/{btrtl.c => btrtl_main.c} (88%)

-- 
2.34.1

