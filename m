Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9B1E32D4
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343890; cv=none; b=kR4mbTlLQcZs/YYS/3/sxyDREEmVI+G9itbASQ2ptyz+EO/wRW4tmPzvb/iwX7Ly5EY2nCUWYU1ijp6FPtbzyz51p28RaipZlGvRqXr/Y/4nsPhZxSovs2Q/K7xtCIFvpcZylr99DG1arTSn/Fbw6EflZaxUBb48FWNKkv40Juo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343890; c=relaxed/simple;
	bh=5Vi3XzbAKJnvTif/iD9MvyuOQ8Fyue+Lmn+2usmLisM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bHOSeBndhEY0l8QuxO3zRi8W8QY29enbmFvnygb6qQbnIAo5tSUKtPhNlu2jP4XNHOczDgugUunlLPfg0+XbXTvGhBVlzkV+pw4qAbkyR8pBx5Q4pOoLKrsGBJS7iiZNFPDBb2en7yeCgA/VJl6tMgqfSef777/n+WFm/CaQyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbfjkOFq; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbfjkOFq"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b10dd44c8bso762637137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738343884; x=1738948684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MSO+EUHxsu+TOq4cP9U8FHSZK2Ik6YeshVQB/sD6F4=;
        b=YbfjkOFqnsZVpFchmDtK3cPeuokLLfA/wOqGmoqV2nBYTJinygTEOBnMamCRwevqIl
         AboGDFMrkGxUVkZE4SqGyj+Bx1Nk6tyxCDPb6EELuaTxtRMogGVslWzxWXnLA46p4+ws
         Olau9g6V+FMo9aXqRhMmHpiHzHGaDaYtkm6tDIZECJC3CcHwhXHrE2DOxmDUANpcCFkt
         v1Dw3v/LnsXHpaiFSOb5f8MGrix5oIJfQmsSZrlTcSo/OEkrglXXTOijTfN4hsbcgW0g
         v4GBgyulBeHjiTVg7/qKfNavruyz2bPnLd2KfXDwj9ciwykdV0IB7lJn9TaHRUs0/qzs
         9nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343884; x=1738948684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MSO+EUHxsu+TOq4cP9U8FHSZK2Ik6YeshVQB/sD6F4=;
        b=gwBBSDFGTK5dl4vSSJJsQbmrc5wkKd0vupX+MwvcGRqgEgt5X4dRYXnU0xPgfYfm0Q
         r+OoOUFGVYZADmj/SW1Yqq5WUD+rKKQ8EYujSLfAr8hOh3nuOcbZTdRCgv6vff4nraro
         qnqJsG79iZQtnMs3vG/t8oU4gNxfAbDpRRo+C8J9HDXgkUeLeRvzz18N6bgr7fy2Wnv0
         6xSOeaCm4n3iEgx1QvPnzN+8Sagg6/0iMoAqisUl0zCc4SG1Gimt9Vvx548+AUgNrq3i
         +cS3vtr66vvIOWhq3F/wBG/QdTWVZ3m7t9ufge9tBeam5ESrT96fHN3Xb/YT705mQ65V
         tmDQ==
X-Gm-Message-State: AOJu0YxmEg7MnKHKk9tEYy1ozDYyGMmRY84S+7KtoekVqePAV+C1p9xO
	qEDcWZYBbNzMQk1oPv6IH5InjNrpO/Gjp/mEaoxTofYV6SIfMFEg1uU1xw==
X-Gm-Gg: ASbGncuU6WeMAYd3FtZgPa5SBBThO7XPNDu0YXz7djC/cK18vfzRmj3Ej/DhLRtTy++
	Zb/Z1KUElr0RwMHK5Bwgx4dcJXtQ/ZhdSjRFUnfJmUb+O+9zod47lgXrv/HMCk9LOfp6eF7EWbH
	mTYeUwLhoBJbsXcn/MXjiCZWtTyDLt8yGJo0RmcXpTIfomAEt3DwemszxXdONUy19DHgCccgBNv
	3iEW/kIPOIDDB+Q4A1ylSzcJsT4GwaY2iQDU/8kcORsnux1ti5K1nHiBNAJJHs4CcvSgFfJOG6u
	vFBuM1s7Cfxh4cia7rRHzp7ZxYDqtDRLIwK6b3/6SFlTsnCf9zJPcImHOKeQVss=
X-Google-Smtp-Source: AGHT+IGqn3PDxiiD9ljAI0fjiYVReTUczJjcL0t3c6xIe1K0qZDYBhI1DOvJBK4jsA2tr2/FowxF8g==
X-Received: by 2002:a05:6102:32d6:b0:4b1:20b1:bff3 with SMTP id ada2fe7eead31-4b9a524fccfmr10415278137.16.1738343883114;
        Fri, 31 Jan 2025 09:18:03 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baad593fsm679834137.13.2025.01.31.09.18.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 09:18:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] build: Remove AMP related functionality
Date: Fri, 31 Jan 2025 12:17:59 -0500
Message-ID: <20250131171759.1642480-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

High Speed, Alternate MAC and PHY (AMP) extension, has been removed from
Bluetooth Core specification on 5.3:

    https://www.bluetooth.com/blog/new-core-specification-v5-3-feature-enhancements/

The kernel already have undergone similar changes starting with
e7b02296fb40 ("Bluetooth: Remove BT_HS").
---
 Makefile.am          |    2 +-
 Makefile.tools       |    6 +-
 emulator/amp.c       | 1041 ------------------------------------------
 emulator/amp.h       |   19 -
 emulator/main.c      |   23 +-
 lib/a2mp.h           |  136 ------
 lib/amp.h            |  164 -------
 tools/amptest.c      |  655 --------------------------
 tools/parser/amp.c   |  114 -----
 tools/parser/hci.c   |   53 ---
 tools/parser/l2cap.c |  339 --------------
 11 files changed, 4 insertions(+), 2548 deletions(-)
 delete mode 100644 emulator/amp.c
 delete mode 100644 emulator/amp.h
 delete mode 100644 lib/a2mp.h
 delete mode 100644 lib/amp.h
 delete mode 100644 tools/amptest.c
 delete mode 100644 tools/parser/amp.c

diff --git a/Makefile.am b/Makefile.am
index 29018a91cbb4..0821530e68df 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -78,7 +78,7 @@ lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h \
 		lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h \
 		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
 
-extra_headers = lib/mgmt.h lib/uuid.h lib/a2mp.h lib/amp.h lib/iso.h
+extra_headers = lib/mgmt.h lib/uuid.h lib/iso.h
 extra_sources = lib/uuid.c
 
 local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))
diff --git a/Makefile.tools b/Makefile.tools
index 0dca43327fdd..e60c31b1d907 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -97,7 +97,6 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c \
 				emulator/phy.h emulator/phy.c \
-				emulator/amp.h emulator/amp.c \
 				emulator/le.h emulator/le.c
 emulator_btvirt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
 
@@ -229,7 +228,7 @@ bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bluemoon \
 		tools/hex2hcd tools/mpris-proxy tools/btattach tools/isotest
 
 noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
-			tools/scotest tools/amptest tools/hwdb \
+			tools/scotest tools/hwdb \
 			tools/hcieventmask tools/hcisecfilter \
 			tools/btinfo tools/btconfig \
 			tools/btsnoop tools/btproxy \
@@ -251,8 +250,6 @@ tools_avtest_LDADD = lib/libbluetooth-internal.la
 
 tools_scotest_LDADD = lib/libbluetooth-internal.la
 
-tools_amptest_LDADD = lib/libbluetooth-internal.la
-
 tools_hwdb_LDADD = lib/libbluetooth-internal.la
 
 tools_hcieventmask_LDADD = lib/libbluetooth-internal.la
@@ -436,7 +433,6 @@ tools_hcidump_SOURCES = tools/hcidump.c \
 				tools/parser/lmp.c \
 				tools/parser/hci.c \
 				tools/parser/l2cap.h tools/parser/l2cap.c \
-				tools/parser/amp.c \
 				tools/parser/smp.c \
 				tools/parser/att.c \
 				tools/parser/sdp.h tools/parser/sdp.c \
diff --git a/emulator/amp.c b/emulator/amp.c
deleted file mode 100644
index 6daf00189f3a..000000000000
--- a/emulator/amp.c
+++ /dev/null
@@ -1,1041 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#define _GNU_SOURCE
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-
-#include "lib/bluetooth.h"
-#include "lib/hci.h"
-
-#include "src/shared/util.h"
-#include "src/shared/mainloop.h"
-#include "monitor/bt.h"
-
-#include "amp.h"
-
-#define PHY_MODE_IDLE		0x00
-#define PHY_MODE_INITIATOR	0x01
-#define PHY_MODE_ACCEPTOR	0x02
-
-#define MAX_ASSOC_LEN	672
-
-struct bt_amp {
-	volatile int ref_count;
-	int vhci_fd;
-
-	char phylink_path[32];
-	int phylink_fd;
-
-	uint8_t  event_mask[16];
-	uint16_t manufacturer;
-	uint8_t  commands[64];
-	uint8_t  features[8];
-
-	uint8_t  amp_status;
-	uint8_t  amp_type;
-	uint8_t  local_assoc[MAX_ASSOC_LEN];
-	uint16_t local_assoc_len;
-	uint8_t  remote_assoc[MAX_ASSOC_LEN];
-	uint16_t remote_assoc_len;
-
-	uint8_t  phy_mode;
-	uint8_t  phy_handle;
-	uint16_t logic_handle;
-};
-
-static void reset_defaults(struct bt_amp *amp)
-{
-	memset(amp->event_mask, 0, sizeof(amp->event_mask));
-	amp->event_mask[1] |= 0x20;	/* Command Complete */
-	amp->event_mask[1] |= 0x40;	/* Command Status */
-	amp->event_mask[1] |= 0x80;	/* Hardware Error */
-	amp->event_mask[2] |= 0x01;	/* Flush Occurred */
-	amp->event_mask[2] |= 0x04;	/* Number of Completed Packets */
-	amp->event_mask[3] |= 0x02;	/* Data Buffer Overflow */
-	amp->event_mask[3] |= 0x20;	/* QoS Violation */
-	amp->event_mask[7] |= 0x01;	/* Enhanced Flush Complete */
-
-	amp->event_mask[8] |= 0x01;	/* Physical Link Complete */
-	amp->event_mask[8] |= 0x02;	/* Channel Selected */
-	amp->event_mask[8] |= 0x04;	/* Disconnection Physical Link Complete */
-	amp->event_mask[8] |= 0x08;	/* Physical Link Loss Early Warning */
-	amp->event_mask[8] |= 0x10;	/* Physical Link Recovery */
-	amp->event_mask[8] |= 0x20;	/* Logical Link Complete */
-	amp->event_mask[8] |= 0x40;	/* Disconection Logical Link Complete */
-	amp->event_mask[8] |= 0x80;	/* Flow Specification Modify Complete */
-	amp->event_mask[9] |= 0x01;	/* Number of Completed Data Blocks */
-	amp->event_mask[9] |= 0x02;	/* AMP Start Test */
-	amp->event_mask[9] |= 0x04;	/* AMP Test End */
-	amp->event_mask[9] |= 0x08;	/* AMP Receiver Report */
-	amp->event_mask[9] |= 0x10;	/* Short Range Mode Change Complete */
-	amp->event_mask[9] |= 0x20;	/* AMP Status Change */
-
-	amp->manufacturer = 0x003f;	/* Bluetooth SIG (63) */
-
-	memset(amp->commands, 0, sizeof(amp->commands));
-	amp->commands[5]  |= 0x40;	/* Set Event Mask */
-	amp->commands[5]  |= 0x80;	/* Reset */
-	//amp->commands[6]  |= 0x01;	/* Set Event Filter */
-	//amp->commands[7]  |= 0x04;	/* Read Connection Accept Timeout */
-	//amp->commands[7]  |= 0x08;	/* Write Connection Accept Timeout */
-	//amp->commands[10] |= 0x80;	/* Host Number of Completed Packets */
-	//amp->commands[11] |= 0x01;	/* Read Link Supervision Timeout */
-	//amp->commands[11] |= 0x02;	/* Write Link Supervision Timeout */
-	amp->commands[14] |= 0x08;	/* Read Local Version Information */
-	amp->commands[14] |= 0x10;	/* Read Local Supported Commands */
-	amp->commands[14] |= 0x20;	/* Read Local Supported Features */
-	amp->commands[14] |= 0x80;	/* Read Buffer Size */
-	//amp->commands[15] |= 0x04;	/* Read Failed Contact Counter */
-	//amp->commands[15] |= 0x08;	/* Reset Failed Contact Counter */
-	//amp->commands[15] |= 0x10;	/* Read Link Quality */
-	//amp->commands[15] |= 0x20;	/* Read RSSI */
-	//amp->commands[16] |= 0x04;	/* Enable Device Under Test Mode */
-	//amp->commands[19] |= 0x40;	/* Enhanced Flush */
-
-	amp->commands[21] |= 0x01;	/* Create Physical Link */
-	amp->commands[21] |= 0x02;	/* Accept Physical Link */
-	amp->commands[21] |= 0x04;	/* Disconnect Phyiscal Link */
-	amp->commands[21] |= 0x08;	/* Create Logical Link */
-	amp->commands[21] |= 0x10;	/* Accept Logical Link */
-	amp->commands[21] |= 0x20;	/* Disconnect Logical Link */
-	amp->commands[21] |= 0x40;	/* Logical Link Cancel */
-	//amp->commands[21] |= 0x80;	/* Flow Specification Modify */
-	//amp->commands[22] |= 0x01;	/* Read Logical Link Accept Timeout */
-	//amp->commands[22] |= 0x02;	/* Write Logical Link Accept Timeout */
-	amp->commands[22] |= 0x04;	/* Set Event Mask Page 2 */
-	amp->commands[22] |= 0x08;	/* Read Location Data */
-	amp->commands[22] |= 0x10;	/* Write Location Data */
-	amp->commands[22] |= 0x20;	/* Read Local AMP Info */
-	amp->commands[22] |= 0x40;	/* Read Local AMP ASSOC */
-	amp->commands[22] |= 0x80;	/* Write Remote AMP ASSOC */
-	amp->commands[23] |= 0x01;	/* Read Flow Control Mode */
-	amp->commands[23] |= 0x02;	/* Write Flow Control Mode */
-	amp->commands[23] |= 0x04;	/* Read Data Block Size */
-	//amp->commands[23] |= 0x20;	/* Enable AMP Receiver Reports */
-	//amp->commands[23] |= 0x40;	/* AMP Test End */
-	//amp->commands[23] |= 0x80;	/* AMP Test */
-	//amp->commands[24] |= 0x04;	/* Read Best Effort Flush Timeout */
-	//amp->commands[24] |= 0x08;	/* Write Best Effort Flush Timeout */
-	//amp->commands[24] |= 0x10;	/* Short Range Mode */
-
-	memset(amp->features, 0, sizeof(amp->features));
-
-	amp->amp_status = 0x01;		/* Used for Bluetooth only */
-	amp->amp_type = 0x42;		/* Fake virtual AMP type */
-
-	memset(amp->local_assoc, 0, sizeof(amp->local_assoc));
-	amp->local_assoc_len = 0;
-
-	memset(amp->remote_assoc, 0, sizeof(amp->remote_assoc));
-	amp->remote_assoc_len = 0;
-
-	amp->phy_mode = PHY_MODE_IDLE;
-	amp->phy_handle = 0x00;		/* Invalid physical link handle */
-	amp->logic_handle = 0x0000;
-}
-
-static void send_packet(struct bt_amp *amp, const void *data, uint16_t len)
-{
-	if (write(amp->vhci_fd, data, len) < 0)
-		fprintf(stderr, "Write to /dev/vhci failed\n");
-}
-
-static void send_event(struct bt_amp *amp, uint8_t event,
-						const void *data, uint8_t len)
-{
-	struct bt_hci_evt_hdr *hdr;
-	uint16_t pkt_len;
-	void *pkt_data;
-
-	pkt_len = 1 + sizeof(*hdr) + len;
-
-	pkt_data = alloca(pkt_len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
-
-	hdr = pkt_data + 1;
-	hdr->evt = event;
-	hdr->plen = len;
-
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*hdr), data, len);
-
-	send_packet(amp, pkt_data, pkt_len);
-}
-
-static void cmd_complete(struct bt_amp *amp, uint16_t opcode,
-						const void *data, uint8_t len)
-{
-	struct bt_hci_evt_hdr *hdr;
-	struct bt_hci_evt_cmd_complete *cc;
-	uint16_t pkt_len;
-	void *pkt_data;
-
-	pkt_len = 1 + sizeof(*hdr) + sizeof(*cc) + len;
-
-	pkt_data = alloca(pkt_len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
-
-	hdr = pkt_data + 1;
-	hdr->evt = BT_HCI_EVT_CMD_COMPLETE;
-	hdr->plen = sizeof(*cc) + len;
-
-	cc = pkt_data + 1 + sizeof(*hdr);
-	cc->ncmd = 0x01;
-	cc->opcode = cpu_to_le16(opcode);
-
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*hdr) + sizeof(*cc), data, len);
-
-	send_packet(amp, pkt_data, pkt_len);
-}
-
-static void cmd_status(struct bt_amp *amp, uint8_t status, uint16_t opcode)
-{
-	struct bt_hci_evt_hdr *hdr;
-	struct bt_hci_evt_cmd_status *cs;
-	uint16_t pkt_len;
-	void *pkt_data;
-
-	pkt_len = 1 + sizeof(*hdr) + sizeof(*cs);
-
-	pkt_data = alloca(pkt_len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
-
-	hdr = pkt_data + 1;
-	hdr->evt = BT_HCI_EVT_CMD_STATUS;
-	hdr->plen = sizeof(*cs);
-
-	cs = pkt_data + 1 + sizeof(*hdr);
-	cs->status = status;
-	cs->ncmd = 0x01;
-	cs->opcode = cpu_to_le16(opcode);
-
-	send_packet(amp, pkt_data, pkt_len);
-}
-
-static void cmd_set_event_mask(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_set_event_mask *cmd = data;
-	uint8_t status;
-
-	memcpy(amp->event_mask, cmd->mask, 8);
-
-	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(amp, BT_HCI_CMD_SET_EVENT_MASK, &status, sizeof(status));
-}
-
-static void cmd_reset(struct bt_amp *amp, const void *data, uint8_t size)
-{
-	uint8_t status;
-
-	reset_defaults(amp);
-
-	amp->local_assoc[0] = 0x00;
-	amp->local_assoc_len = 1;
-
-	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(amp, BT_HCI_CMD_RESET, &status, sizeof(status));
-}
-
-static void cmd_read_local_version(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_local_version rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.hci_ver = 0x05;
-	rsp.hci_rev = cpu_to_le16(0x0000);
-	rsp.lmp_ver = 0x01;
-	rsp.manufacturer = cpu_to_le16(amp->manufacturer);
-	rsp.lmp_subver = cpu_to_le16(0x0000);
-
-	cmd_complete(amp, BT_HCI_CMD_READ_LOCAL_VERSION, &rsp, sizeof(rsp));
-}
-
-static void cmd_read_local_commands(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_local_commands rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	memcpy(rsp.commands, amp->commands, 64);
-
-	cmd_complete(amp, BT_HCI_CMD_READ_LOCAL_COMMANDS, &rsp, sizeof(rsp));
-}
-
-static void cmd_read_local_features(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_local_features rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	memcpy(rsp.features, amp->features, 8);
-
-	cmd_complete(amp, BT_HCI_CMD_READ_LOCAL_FEATURES, &rsp, sizeof(rsp));
-}
-
-static void cmd_read_buffer_size(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_buffer_size rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.acl_mtu = cpu_to_le16(0x0000);
-	rsp.sco_mtu = 0x00;
-	rsp.acl_max_pkt = cpu_to_le16(0x0000);
-	rsp.sco_max_pkt = cpu_to_le16(0x0000);
-
-	cmd_complete(amp, BT_HCI_CMD_READ_BUFFER_SIZE, &rsp, sizeof(rsp));
-}
-
-static void evt_phy_link_complete(struct bt_amp *amp)
-{
-	struct bt_hci_evt_phy_link_complete evt;
-
-	evt.status = BT_HCI_ERR_SUCCESS;
-	evt.phy_handle = amp->phy_handle;
-
-	send_event(amp, BT_HCI_EVT_PHY_LINK_COMPLETE, &evt, sizeof(evt));
-}
-
-static void evt_disconn_phy_link_complete(struct bt_amp *amp, uint8_t reason)
-{
-	struct bt_hci_evt_disconn_phy_link_complete evt;
-
-	evt.status = BT_HCI_ERR_SUCCESS;
-	evt.phy_handle = amp->phy_handle;
-	evt.reason = reason;
-
-	send_event(amp, BT_HCI_EVT_DISCONN_PHY_LINK_COMPLETE,
-						&evt, sizeof(evt));
-}
-
-static void link_callback(int fd, uint32_t events, void *user_data)
-{
-	struct bt_amp *amp = user_data;
-
-	if (events & (EPOLLERR | EPOLLHUP)) {
-		close(fd);
-		mainloop_remove_fd(fd);
-
-		evt_disconn_phy_link_complete(amp, 0x13);
-
-		amp->phy_mode = PHY_MODE_IDLE;
-		amp->phy_handle = 0x00;
-		return;
-	}
-}
-
-static void cmd_create_phy_link(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_create_phy_link *cmd = data;
-
-	if (cmd->phy_handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_CREATE_PHY_LINK);
-		return;
-	}
-
-	if (amp->phy_mode != PHY_MODE_IDLE) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_CREATE_PHY_LINK);
-		return;
-	}
-
-	amp->phy_mode = PHY_MODE_INITIATOR;
-	amp->phy_handle = cmd->phy_handle;
-
-	cmd_status(amp, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_PHY_LINK);
-}
-
-static void cmd_accept_phy_link(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_accept_phy_link *cmd = data;
-
-	if (cmd->phy_handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_ACCEPT_PHY_LINK);
-		return;
-	}
-
-	if (amp->phy_mode != PHY_MODE_IDLE) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_ACCEPT_PHY_LINK);
-		return;
-	}
-
-	amp->phy_mode = PHY_MODE_ACCEPTOR;
-	amp->phy_handle = cmd->phy_handle;
-
-	cmd_status(amp, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_ACCEPT_PHY_LINK);
-}
-
-static void cmd_disconn_phy_link(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_disconn_phy_link *cmd = data;
-
-	if (cmd->phy_handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_DISCONN_PHY_LINK);
-		return;
-	}
-
-	if (amp->phy_mode == PHY_MODE_IDLE) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_DISCONN_PHY_LINK);
-		return;
-	}
-
-	if (cmd->phy_handle != amp->phy_handle) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_DISCONN_PHY_LINK);
-		return;
-	}
-
-	cmd_status(amp, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_DISCONN_PHY_LINK);
-
-	mainloop_remove_fd(amp->phylink_fd);
-	close(amp->phylink_fd);
-
-	evt_disconn_phy_link_complete(amp, cmd->reason);
-
-	amp->phy_mode = PHY_MODE_IDLE;
-	amp->phy_handle = 0x00;
-}
-
-static void evt_logic_link_complete(struct bt_amp *amp)
-{
-	struct bt_hci_evt_logic_link_complete evt;
-
-	evt.status = BT_HCI_ERR_SUCCESS;
-	evt.handle = htobs(amp->logic_handle);
-	evt.phy_handle = amp->phy_handle;
-	evt.flow_spec = 0x00;
-
-	send_event(amp, BT_HCI_EVT_LOGIC_LINK_COMPLETE, &evt, sizeof(evt));
-}
-
-static void evt_disconn_logic_link_complete(struct bt_amp *amp, uint8_t reason)
-{
-	struct bt_hci_evt_disconn_logic_link_complete evt;
-
-	evt.status = BT_HCI_ERR_SUCCESS;
-	evt.handle = htobs(amp->logic_handle);
-	evt.reason = reason;
-
-	send_event(amp, BT_HCI_EVT_DISCONN_LOGIC_LINK_COMPLETE,
-						&evt, sizeof(evt));
-}
-
-static void cmd_create_logic_link(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_create_logic_link *cmd = data;
-
-	if (cmd->phy_handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_CREATE_LOGIC_LINK);
-		return;
-	}
-
-	if (amp->phy_mode != PHY_MODE_IDLE) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_CREATE_LOGIC_LINK);
-		return;
-	}
-
-	if (amp->logic_handle != 0x00) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_CREATE_LOGIC_LINK);
-		return;
-	}
-
-	cmd_status(amp, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_LOGIC_LINK);
-
-	amp->logic_handle = 0x0042;
-
-	evt_logic_link_complete(amp);
-}
-
-static void cmd_accept_logic_link(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_accept_logic_link *cmd = data;
-
-	if (cmd->phy_handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_ACCEPT_LOGIC_LINK);
-		return;
-	}
-
-	if (amp->phy_mode != PHY_MODE_IDLE) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_ACCEPT_LOGIC_LINK);
-		return;
-	}
-
-	if (amp->logic_handle != 0x00) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_ACCEPT_LOGIC_LINK);
-		return;
-	}
-
-	cmd_status(amp, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_ACCEPT_LOGIC_LINK);
-
-	amp->logic_handle = 0x0023;
-
-	evt_logic_link_complete(amp);
-}
-
-static void cmd_disconn_logic_link(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_disconn_logic_link *cmd = data;
-
-	if (cmd->handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_DISCONN_LOGIC_LINK);
-		return;
-	}
-
-	if (cmd->handle != amp->logic_handle) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_DISCONN_LOGIC_LINK);
-		return;
-	}
-
-	cmd_status(amp, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_DISCONN_LOGIC_LINK);
-
-	evt_disconn_logic_link_complete(amp, 0x13);
-
-	amp->logic_handle = 0x0000;
-}
-
-static void cmd_logic_link_cancel(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_logic_link_cancel *cmd = data;
-	struct bt_hci_rsp_logic_link_cancel rsp;
-
-	if (cmd->phy_handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_LOGIC_LINK_CANCEL);
-		return;
-	}
-
-	if (amp->phy_mode != PHY_MODE_IDLE) {
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_LOGIC_LINK_CANCEL);
-		return;
-	}
-
-	amp->logic_handle = 0x0000;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.phy_handle = amp->phy_handle;
-	rsp.flow_spec = 0x00;
-
-	cmd_complete(amp, BT_HCI_CMD_LOGIC_LINK_CANCEL, &rsp, sizeof(rsp));
-}
-
-static void cmd_set_event_mask_page2(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_set_event_mask_page2 *cmd = data;
-	uint8_t status;
-
-	memcpy(amp->event_mask + 8, cmd->mask, 8);
-
-	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(amp, BT_HCI_CMD_SET_EVENT_MASK_PAGE2,
-						&status, sizeof(status));
-}
-
-static void cmd_read_location_data(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_location_data rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.domain_aware = 0x00;
-	rsp.domain[0] = 0x58;
-	rsp.domain[1] = 0x58;
-	rsp.domain_options = 0x58;
-	rsp.options = 0x00;
-
-	cmd_complete(amp, BT_HCI_CMD_READ_LOCATION_DATA, &rsp, sizeof(rsp));
-}
-
-static void cmd_write_location_data(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_write_location_data *cmd = data;
-	uint8_t status;
-
-	if (cmd->domain_aware > 0x01) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_WRITE_LOCATION_DATA);
-		return;
-	}
-
-	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(amp, BT_HCI_CMD_WRITE_LOCATION_DATA,
-						&status, sizeof(status));
-}
-
-static void cmd_read_flow_control_mode(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_flow_control_mode rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.mode = 0x01;
-
-	cmd_complete(amp, BT_HCI_CMD_READ_FLOW_CONTROL_MODE,
-						&rsp, sizeof(rsp));
-}
-
-static void cmd_write_flow_control_mode(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_write_flow_control_mode *cmd = data;
-	uint8_t status;
-
-	if (cmd->mode != 0x01) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_WRITE_FLOW_CONTROL_MODE);
-		return;
-	}
-
-	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(amp, BT_HCI_CMD_WRITE_FLOW_CONTROL_MODE,
-						&status, sizeof(status));
-}
-
-static void cmd_read_data_block_size(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_data_block_size rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.max_acl_len = cpu_to_le16(1492);
-	rsp.block_len = cpu_to_le16(1492);
-	rsp.num_blocks = cpu_to_le16(1);
-
-	cmd_complete(amp, BT_HCI_CMD_READ_DATA_BLOCK_SIZE, &rsp, sizeof(rsp));
-}
-
-static void cmd_read_local_amp_info(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	struct bt_hci_rsp_read_local_amp_info rsp;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.amp_status = amp->amp_status;
-	rsp.total_bw = cpu_to_le32(24000);
-	rsp.max_bw = cpu_to_le32(24000);
-	rsp.min_latency = cpu_to_le32(100);
-	rsp.max_pdu = cpu_to_le32(1492);
-	rsp.amp_type = amp->amp_type;
-	rsp.pal_cap = cpu_to_le16(0x0001);
-	rsp.max_assoc_len = cpu_to_le16(MAX_ASSOC_LEN);
-	rsp.max_flush_to = cpu_to_le32(20000);
-	rsp.be_flush_to = cpu_to_le32(20000);
-
-	cmd_complete(amp, BT_HCI_CMD_READ_LOCAL_AMP_INFO, &rsp, sizeof(rsp));
-}
-
-static void cmd_read_local_amp_assoc(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_read_local_amp_assoc *cmd = data;
-	struct bt_hci_rsp_read_local_amp_assoc rsp;
-	uint16_t len_so_far, remain_assoc_len;
-	size_t fragment_len;
-
-	if (cmd->phy_handle != amp->phy_handle) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_READ_LOCAL_AMP_ASSOC);
-		return;
-	}
-
-	len_so_far = le16_to_cpu(cmd->len_so_far);
-	remain_assoc_len = amp->local_assoc_len - len_so_far;
-	fragment_len = remain_assoc_len > 248 ? 248 : remain_assoc_len;
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.phy_handle = cmd->phy_handle;
-	rsp.remain_assoc_len = cpu_to_le16(remain_assoc_len);
-	memcpy(rsp.assoc_fragment, amp->local_assoc + len_so_far,
-							fragment_len);
-
-	cmd_complete(amp, BT_HCI_CMD_READ_LOCAL_AMP_ASSOC,
-						&rsp, 4 + fragment_len);
-}
-
-static int create_unix_server(const char *path)
-{
-	struct sockaddr_un addr;
-	int fd;
-
-	fd = socket(PF_UNIX, SOCK_SEQPACKET, 0);
-	if (fd < 0)
-		return -1;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family = AF_UNIX;
-	addr.sun_path[0] = '\0';
-	strcpy(addr.sun_path + 1, path);
-
-	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		close(fd);
-		return -1;
-	}
-
-	if (listen(fd, 1) < 0) {
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
-static int connect_unix_client(const char *path)
-{
-	struct sockaddr_un addr;
-	int fd;
-
-	fd = socket(PF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC | SOCK_NONBLOCK, 0);
-	if (fd < 0)
-		return -1;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family = AF_UNIX;
-	addr.sun_path[0] = '\0';
-	strcpy(addr.sun_path + 1, path);
-
-	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
-static void accept_callback(int fd, uint32_t events, void *user_data)
-{
-	struct bt_amp *amp = user_data;
-	struct sockaddr_un addr;
-	socklen_t len;
-	int new_fd;
-
-	if (events & (EPOLLERR | EPOLLHUP)) {
-		mainloop_remove_fd(fd);
-		return;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	len = sizeof(addr);
-
-	new_fd = accept4(fd, (struct sockaddr *) &addr, &len,
-						SOCK_CLOEXEC | SOCK_NONBLOCK);
-	if (new_fd < 0)
-		return;
-
-	mainloop_remove_fd(fd);
-	close(fd);
-
-	amp->phylink_fd = new_fd;
-
-	evt_phy_link_complete(amp);
-
-	mainloop_add_fd(new_fd, EPOLLIN, link_callback, amp, NULL);
-}
-
-static void connect_callback(int fd, uint32_t events, void *user_data)
-{
-	struct bt_amp *amp = user_data;
-
-	if (events & (EPOLLERR | EPOLLHUP)) {
-		mainloop_remove_fd(fd);
-		return;
-	}
-
-	mainloop_remove_fd(fd);
-
-	evt_phy_link_complete(amp);
-
-	mainloop_add_fd(fd, EPOLLIN, link_callback, amp, NULL);
-}
-
-static void cmd_write_remote_amp_assoc(struct bt_amp *amp,
-						const void *data, uint8_t size)
-{
-	const struct bt_hci_cmd_write_remote_amp_assoc *cmd = data;
-	struct bt_hci_rsp_write_remote_amp_assoc rsp;
-	int fd;
-
-	if (cmd->phy_handle == 0x00) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC);
-		return;
-	}
-
-	if (cmd->phy_handle != amp->phy_handle) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC);
-		return;
-	}
-
-	switch (amp->phy_mode) {
-	case PHY_MODE_INITIATOR:
-		strcpy(amp->phylink_path, "amp");
-
-		fd = create_unix_server(amp->phylink_path);
-		if (fd < 0) {
-			cmd_status(amp, BT_HCI_ERR_UNSPECIFIED_ERROR,
-					BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC);
-			return;
-		}
-
-		amp->local_assoc[0] = 0x01;
-		memcpy(amp->local_assoc + 1, amp->phylink_path,
-					strlen(amp->phylink_path) + 1);
-		amp->local_assoc_len = strlen(amp->phylink_path) + 2;
-
-		mainloop_add_fd(fd, EPOLLIN, accept_callback, amp, NULL);
-
-		amp->phylink_fd = fd;
-		break;
-
-	case PHY_MODE_ACCEPTOR:
-		if (cmd->assoc_fragment[0] != 0x01) {
-			cmd_status(amp, BT_HCI_ERR_UNSPECIFIED_ERROR,
-					BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC);
-			return;
-		}
-
-		memcpy(amp->phylink_path, cmd->assoc_fragment + 1,
-						cmd->remain_assoc_len - 1);
-
-		fd = connect_unix_client(amp->phylink_path);
-		if (fd < 0) {
-			cmd_status(amp, BT_HCI_ERR_UNSPECIFIED_ERROR,
-					BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC);
-			return;
-		}
-
-		mainloop_add_fd(fd, EPOLLOUT, connect_callback, amp, NULL);
-
-		amp->phylink_fd = fd;
-		break;
-
-	default:
-		cmd_status(amp, BT_HCI_ERR_COMMAND_DISALLOWED,
-					BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC);
-		return;
-	}
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.phy_handle = amp->phy_handle;
-
-	cmd_complete(amp, BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC, &rsp, sizeof(rsp));
-
-	if (amp->phy_mode == PHY_MODE_INITIATOR) {
-		struct bt_hci_evt_channel_selected evt;
-
-		evt.phy_handle = amp->phy_handle;
-
-		send_event(amp, BT_HCI_EVT_CHANNEL_SELECTED, &evt, sizeof(evt));
-	}
-}
-
-static const struct {
-	uint16_t opcode;
-	void (*func) (struct bt_amp *amp, const void *data, uint8_t size);
-	uint8_t size;
-	bool fixed;
-} cmd_table[] = {
-	{ BT_HCI_CMD_SET_EVENT_MASK,       cmd_set_event_mask,      8, true },
-	{ BT_HCI_CMD_RESET,                cmd_reset,               0, true },
-	{ BT_HCI_CMD_READ_LOCAL_VERSION,   cmd_read_local_version,  0, true },
-	{ BT_HCI_CMD_READ_LOCAL_COMMANDS,  cmd_read_local_commands, 0, true },
-	{ BT_HCI_CMD_READ_LOCAL_FEATURES,  cmd_read_local_features, 0, true },
-	{ BT_HCI_CMD_READ_BUFFER_SIZE,     cmd_read_buffer_size,    0, true },
-
-	{ BT_HCI_CMD_CREATE_PHY_LINK,
-				cmd_create_phy_link, 3, false },
-	{ BT_HCI_CMD_ACCEPT_PHY_LINK,
-				cmd_accept_phy_link, 3, false },
-	{ BT_HCI_CMD_DISCONN_PHY_LINK,
-				cmd_disconn_phy_link, 2, true },
-	{ BT_HCI_CMD_CREATE_LOGIC_LINK,
-				cmd_create_logic_link, 33, true },
-	{ BT_HCI_CMD_ACCEPT_LOGIC_LINK,
-				cmd_accept_logic_link, 33, true },
-	{ BT_HCI_CMD_DISCONN_LOGIC_LINK,
-				cmd_disconn_logic_link, 2, true },
-	{ BT_HCI_CMD_LOGIC_LINK_CANCEL,
-				cmd_logic_link_cancel, 2, true },
-	{ BT_HCI_CMD_SET_EVENT_MASK_PAGE2,
-				cmd_set_event_mask_page2, 8, true },
-	{ BT_HCI_CMD_READ_LOCATION_DATA,
-				cmd_read_location_data, 0, true },
-	{ BT_HCI_CMD_WRITE_LOCATION_DATA,
-				cmd_write_location_data, 5, true },
-	{ BT_HCI_CMD_READ_FLOW_CONTROL_MODE,
-				cmd_read_flow_control_mode, 0, true },
-	{ BT_HCI_CMD_WRITE_FLOW_CONTROL_MODE,
-				cmd_write_flow_control_mode, 1, true },
-	{ BT_HCI_CMD_READ_DATA_BLOCK_SIZE,
-				cmd_read_data_block_size, 0, true },
-	{ BT_HCI_CMD_READ_LOCAL_AMP_INFO,
-				cmd_read_local_amp_info, 0, true },
-	{ BT_HCI_CMD_READ_LOCAL_AMP_ASSOC,
-				cmd_read_local_amp_assoc, 5, true },
-	{ BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC,
-				cmd_write_remote_amp_assoc, 6, false },
-	{ }
-};
-
-static void process_command(struct bt_amp *amp, const void *data, size_t size)
-{
-	const struct bt_hci_cmd_hdr *hdr = data;
-	uint16_t opcode;
-	unsigned int i;
-
-	if (size < sizeof(*hdr))
-		return;
-
-	data += sizeof(*hdr);
-	size -= sizeof(*hdr);
-
-	opcode = le16_to_cpu(hdr->opcode);
-
-	if (hdr->plen != size) {
-		cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS, opcode);
-		return;
-	}
-
-	for (i = 0; cmd_table[i].func; i++) {
-		if (cmd_table[i].opcode != opcode)
-			continue;
-
-		if ((cmd_table[i].fixed && size != cmd_table[i].size) ||
-						size < cmd_table[i].size) {
-			cmd_status(amp, BT_HCI_ERR_INVALID_PARAMETERS, opcode);
-			return;
-		}
-
-		cmd_table[i].func(amp, data, size);
-		return;
-	}
-
-	cmd_status(amp, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
-}
-
-static void vhci_read_callback(int fd, uint32_t events, void *user_data)
-{
-	struct bt_amp *amp = user_data;
-	unsigned char buf[4096];
-	ssize_t len;
-
-	if (events & (EPOLLERR | EPOLLHUP))
-		return;
-
-	len = read(amp->vhci_fd, buf, sizeof(buf));
-	if (len < 1)
-		return;
-
-	switch (buf[0]) {
-	case BT_H4_CMD_PKT:
-		process_command(amp, buf + 1, len - 1);
-		break;
-	}
-}
-
-struct bt_amp *bt_amp_new(void)
-{
-	unsigned char setup_cmd[2];
-	struct bt_amp *amp;
-
-	amp = calloc(1, sizeof(*amp));
-	if (!amp)
-		return NULL;
-
-	reset_defaults(amp);
-
-	amp->vhci_fd = open("/dev/vhci", O_RDWR);
-	if (amp->vhci_fd < 0) {
-		free(amp);
-		return NULL;
-	}
-
-	setup_cmd[0] = HCI_VENDOR_PKT;
-	setup_cmd[1] = HCI_AMP;
-
-	if (write(amp->vhci_fd, setup_cmd, sizeof(setup_cmd)) < 0) {
-		close(amp->vhci_fd);
-		free(amp);
-		return NULL;
-	}
-
-	mainloop_add_fd(amp->vhci_fd, EPOLLIN, vhci_read_callback, amp, NULL);
-
-	return bt_amp_ref(amp);
-}
-
-struct bt_amp *bt_amp_ref(struct bt_amp *amp)
-{
-	if (!amp)
-		return NULL;
-
-	__sync_fetch_and_add(&amp->ref_count, 1);
-
-	return amp;
-}
-
-void bt_amp_unref(struct bt_amp *amp)
-{
-	if (!amp)
-		return;
-
-	if (__sync_sub_and_fetch(&amp->ref_count, 1))
-		return;
-
-	mainloop_remove_fd(amp->vhci_fd);
-
-	close(amp->vhci_fd);
-
-	free(amp);
-}
diff --git a/emulator/amp.h b/emulator/amp.h
deleted file mode 100644
index cee360c44e0f..000000000000
--- a/emulator/amp.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: LGPL-2.1-or-later */
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- */
-
-#include <stdbool.h>
-
-struct bt_amp;
-
-struct bt_amp *bt_amp_new(void);
-
-struct bt_amp *bt_amp_ref(struct bt_amp *amp);
-void bt_amp_unref(struct bt_amp *amp);
diff --git a/emulator/main.c b/emulator/main.c
index bd9831449767..92858825413c 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -26,7 +26,6 @@
 #include "server.h"
 #include "btdev.h"
 #include "vhci.h"
-#include "amp.h"
 #include "le.h"
 
 static void signal_callback(int signum, void *user_data)
@@ -66,7 +65,6 @@ static const struct option main_options[] = {
 	{ "bredr",   no_argument,       NULL, 'B' },
 	{ "amp",     no_argument,       NULL, 'A' },
 	{ "letest",  optional_argument, NULL, 'U' },
-	{ "amptest", optional_argument, NULL, 'T' },
 	{ "version", no_argument,	NULL, 'v' },
 	{ "help",    no_argument,	NULL, 'h' },
 	{ }
@@ -90,7 +88,6 @@ int main(int argc, char *argv[])
 	bool server_enabled = false;
 	bool serial_enabled = false;
 	int letest_count = 0;
-	int amptest_count = 0;
 	int vhci_count = 0;
 	enum btdev_type type = BTDEV_TYPE_BREDRLE52;
 	int i;
@@ -136,12 +133,6 @@ int main(int argc, char *argv[])
 			else
 				letest_count = 1;
 			break;
-		case 'T':
-			if (optarg)
-				amptest_count = atoi(optarg);
-			else
-				amptest_count = 1;
-			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
@@ -153,8 +144,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (letest_count < 1 && amptest_count < 1 &&
-			vhci_count < 1 && !server_enabled && !serial_enabled) {
+	if (letest_count < 1 && vhci_count < 1 && !server_enabled &&
+						!serial_enabled) {
 		fprintf(stderr, "No emulator specified\n");
 		return EXIT_FAILURE;
 	}
@@ -171,16 +162,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	for (i = 0; i < amptest_count; i++) {
-		struct bt_amp *amp;
-
-		amp = bt_amp_new();
-		if (!amp) {
-			fprintf(stderr, "Failed to create AMP controller\n");
-			return EXIT_FAILURE;
-		}
-	}
-
 	for (i = 0; i < vhci_count; i++) {
 		struct vhci *vhci;
 
diff --git a/lib/a2mp.h b/lib/a2mp.h
deleted file mode 100644
index 556b342f706b..000000000000
--- a/lib/a2mp.h
+++ /dev/null
@@ -1,136 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Intel Corporation. All rights reserved.
- *  Copyright (c) 2012  Code Aurora Forum. All rights reserved.
- *
- */
-
-#ifndef __A2MP_H
-#define __A2MP_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/* A2MP Protocol */
-
-/* A2MP command codes */
-
-#define A2MP_COMMAND_REJ	0x01
-#define A2MP_DISCOVER_REQ	0x02
-#define A2MP_DISCOVER_RSP	0x03
-#define A2MP_CHANGE_NOTIFY	0x04
-#define A2MP_CHANGE_RSP		0x05
-#define A2MP_INFO_REQ		0x06
-#define A2MP_INFO_RSP		0x07
-#define A2MP_ASSOC_REQ		0x08
-#define A2MP_ASSOC_RSP		0x09
-#define A2MP_CREATE_REQ		0x0a
-#define A2MP_CREATE_RSP		0x0b
-#define A2MP_DISCONN_REQ	0x0c
-#define A2MP_DISCONN_RSP	0x0d
-
-struct a2mp_hdr {
-	uint8_t		code;
-	uint8_t		ident;
-	uint16_t	len;
-} __attribute__ ((packed));
-#define A2MP_HDR_SIZE 4
-
-struct a2mp_command_rej {
-	uint16_t	reason;
-} __attribute__ ((packed));
-
-struct a2mp_discover_req {
-	uint16_t	mtu;
-	uint16_t	mask;
-} __attribute__ ((packed));
-
-struct a2mp_ctrl {
-	uint8_t		id;
-	uint8_t		type;
-	uint8_t		status;
-} __attribute__ ((packed));
-
-struct a2mp_discover_rsp {
-	uint16_t	mtu;
-	uint16_t	mask;
-	struct a2mp_ctrl ctrl_list[0];
-} __attribute__ ((packed));
-
-struct a2mp_info_req {
-	uint8_t		id;
-} __attribute__ ((packed));
-
-struct a2mp_info_rsp {
-	uint8_t		id;
-	uint8_t		status;
-	uint32_t	total_bw;
-	uint32_t	max_bw;
-	uint32_t	min_latency;
-	uint16_t	pal_caps;
-	uint16_t	assoc_size;
-} __attribute__ ((packed));
-
-struct a2mp_assoc_req {
-	uint8_t		id;
-} __attribute__ ((packed));
-
-struct a2mp_assoc_rsp {
-	uint8_t		id;
-	uint8_t		status;
-	uint8_t		assoc_data[0];
-} __attribute__ ((packed));
-
-struct a2mp_create_req {
-	uint8_t		local_id;
-	uint8_t		remote_id;
-	uint8_t		assoc_data[0];
-} __attribute__ ((packed));
-
-struct a2mp_create_rsp {
-	uint8_t		local_id;
-	uint8_t		remote_id;
-	uint8_t		status;
-} __attribute__ ((packed));
-
-struct a2mp_disconn_req {
-	uint8_t		local_id;
-	uint8_t		remote_id;
-} __attribute__ ((packed));
-
-struct a2mp_disconn_rsp {
-	uint8_t		local_id;
-	uint8_t		remote_id;
-	uint8_t		status;
-} __attribute__ ((packed));
-
-#define A2MP_COMMAND_NOT_RECOGNIZED 0x0000
-
-/* AMP controller status */
-#define AMP_CTRL_POWERED_DOWN		0x00
-#define AMP_CTRL_BLUETOOTH_ONLY		0x01
-#define AMP_CTRL_NO_CAPACITY		0x02
-#define AMP_CTRL_LOW_CAPACITY		0x03
-#define AMP_CTRL_MEDIUM_CAPACITY	0x04
-#define AMP_CTRL_HIGH_CAPACITY		0x05
-#define AMP_CTRL_FULL_CAPACITY		0x06
-
-/* A2MP response status */
-#define A2MP_STATUS_SUCCESS				0x00
-#define A2MP_STATUS_INVALID_CTRL_ID			0x01
-#define A2MP_STATUS_UNABLE_START_LINK_CREATION		0x02
-#define A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS		0x02
-#define A2MP_STATUS_COLLISION_OCCURED			0x03
-#define A2MP_STATUS_DISCONN_REQ_RECVD			0x04
-#define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
-#define A2MP_STATUS_SECURITY_VIOLATION			0x06
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __A2MP_H */
diff --git a/lib/amp.h b/lib/amp.h
deleted file mode 100644
index 8acb5ab40fc7..000000000000
--- a/lib/amp.h
+++ /dev/null
@@ -1,164 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *
- *	BlueZ - Bluetooth protocol stack for Linux
- *
- *	Copyright (C) 2010-2011 Code Aurora Forum.  All rights reserved.
- *	Copyright (C) 2012 Intel Corporation.
- *
- */
-
-#ifndef __AMP_H
-#define __AMP_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#define AMP_MGR_CID 0x03
-
-/* AMP manager codes */
-#define AMP_COMMAND_REJ		0x01
-#define AMP_DISCOVER_REQ	0x02
-#define AMP_DISCOVER_RSP	0x03
-#define AMP_CHANGE_NOTIFY	0x04
-#define AMP_CHANGE_RSP		0x05
-#define AMP_INFO_REQ		0x06
-#define AMP_INFO_RSP		0x07
-#define AMP_ASSOC_REQ		0x08
-#define AMP_ASSOC_RSP		0x09
-#define AMP_LINK_REQ		0x0a
-#define AMP_LINK_RSP		0x0b
-#define AMP_DISCONN_REQ		0x0c
-#define AMP_DISCONN_RSP		0x0d
-
-typedef struct {
-	uint8_t		code;
-	uint8_t		ident;
-	uint16_t	len;
-} __attribute__ ((packed)) amp_mgr_hdr;
-#define AMP_MGR_HDR_SIZE 4
-
-/* AMP ASSOC structure */
-typedef struct {
-	uint8_t		type_id;
-	uint16_t	len;
-	uint8_t		data[0];
-} __attribute__ ((packed)) amp_assoc_tlv;
-
-typedef struct {
-	uint16_t	reason;
-} __attribute__ ((packed)) amp_cmd_rej_parms;
-
-typedef struct {
-	uint16_t	mtu;
-	uint16_t	mask;
-} __attribute__ ((packed)) amp_discover_req_parms;
-
-typedef struct {
-	uint16_t	mtu;
-	uint16_t	mask;
-	uint8_t		controller_list[0];
-} __attribute__ ((packed)) amp_discover_rsp_parms;
-
-typedef struct {
-	uint8_t		id;
-} __attribute__ ((packed)) amp_info_req_parms;
-
-typedef struct {
-	uint8_t		id;
-	uint8_t		status;
-	uint32_t	total_bandwidth;
-	uint32_t	max_bandwidth;
-	uint32_t	min_latency;
-	uint16_t	pal_caps;
-	uint16_t	assoc_size;
-} __attribute__ ((packed)) amp_info_rsp_parms;
-
-typedef struct {
-	uint8_t		id;
-	uint8_t		status;
-	amp_assoc_tlv	assoc;
-} __attribute__ ((packed)) amp_assoc_rsp_parms;
-
-typedef struct {
-	uint8_t		local_id;
-	uint8_t		remote_id;
-	amp_assoc_tlv	assoc;
-} __attribute__ ((packed)) amp_link_req_parms;
-
-typedef struct {
-	uint8_t		local_id;
-	uint8_t		remote_id;
-	uint8_t		status;
-} __attribute__ ((packed)) amp_link_rsp_parms;
-
-typedef struct {
-	uint8_t		local_id;
-	uint8_t		remote_id;
-} __attribute__ ((packed)) amp_disconn_req_parms;
-
-#define A2MP_MAC_ADDR_TYPE		1
-#define A2MP_PREF_CHANLIST_TYPE		2
-#define A2MP_CONNECTED_CHAN		3
-#define A2MP_PAL_CAP_TYPE		4
-#define A2MP_PAL_VER_INFO		5
-
-struct amp_tlv {
-	uint8_t type;
-	uint16_t len;
-	uint8_t val[0];
-} __attribute__ ((packed));
-
-struct amp_pal_ver {
-	uint8_t ver;
-	uint16_t company_id;
-	uint16_t sub_ver;
-} __attribute__ ((packed));
-
-struct amp_country_triplet {
-	union {
-		struct {
-			uint8_t first_channel;
-			uint8_t num_channels;
-			int8_t max_power;
-		} __attribute__ ((packed)) chans;
-		struct {
-			uint8_t reg_extension_id;
-			uint8_t reg_class;
-			uint8_t coverage_class;
-		} __attribute__ ((packed)) ext;
-	};
-} __attribute__ ((packed));
-
-struct amp_chan_list {
-	uint8_t country_code[3];
-	struct amp_country_triplet triplets[0];
-} __attribute__ ((packed));
-
-#define AMP_COMMAND_NOT_RECOGNIZED 0x0000
-
-/* AMP controller status */
-#define AMP_CT_POWERED_DOWN		0x00
-#define AMP_CT_BLUETOOTH_ONLY		0x01
-#define AMP_CT_NO_CAPACITY		0x02
-#define AMP_CT_LOW_CAPACITY		0x03
-#define AMP_CT_MEDIUM_CAPACITY		0x04
-#define AMP_CT_HIGH_CAPACITY		0x05
-#define AMP_CT_FULL_CAPACITY		0x06
-
-/* AMP response status */
-#define AMP_STATUS_SUCCESS				0x00
-#define AMP_STATUS_INVALID_CTRL_ID			0x01
-#define AMP_STATUS_UNABLE_START_LINK_CREATION		0x02
-#define AMP_STATUS_NO_PHYSICAL_LINK_EXISTS		0x02
-#define AMP_STATUS_COLLISION_OCCURED			0x03
-#define AMP_STATUS_DISCONN_REQ_RECVD			0x04
-#define AMP_STATUS_PHYS_LINK_EXISTS			0x05
-#define AMP_STATUS_SECURITY_VIOLATION			0x06
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __AMP_H */
diff --git a/tools/amptest.c b/tools/amptest.c
deleted file mode 100644
index 193cadd25351..000000000000
--- a/tools/amptest.c
+++ /dev/null
@@ -1,655 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <alloca.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <poll.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
-
-#include "lib/bluetooth.h"
-#include "lib/hci.h"
-#include "lib/hci_lib.h"
-
-static int activate_amp_controller(int dev_id)
-{
-	struct hci_dev_info di;
-	struct hci_filter flt;
-	int fd;
-
-	printf("hci%d: Activating controller\n", dev_id);
-
-	fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (fd < 0) {
-		perror("Failed to open raw HCI socket");
-		return -1;
-	}
-
-	di.dev_id = dev_id;
-
-	if (ioctl(fd, HCIGETDEVINFO, (void *) &di) < 0) {
-		perror("Failed to get HCI device info");
-		close(fd);
-		return -1;
-	}
-
-	if (!hci_test_bit(HCI_UP, &di.flags)) {
-		if (ioctl(fd, HCIDEVUP, dev_id) < 0) {
-			if (errno != EALREADY) {
-				perror("Failed to bring up HCI device");
-				close(fd);
-				return -1;
-			}
-		}
-	}
-
-	close(fd);
-
-	fd = hci_open_dev(dev_id);
-	if (fd < 0) {
-		perror("Failed to open HCI device");
-		return -1;
-	}
-
-	hci_filter_clear(&flt);
-	hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
-	hci_filter_set_event(EVT_CHANNEL_SELECTED, &flt);
-	hci_filter_set_event(EVT_PHYSICAL_LINK_COMPLETE, &flt);
-	hci_filter_set_event(EVT_DISCONNECT_PHYSICAL_LINK_COMPLETE, &flt);
-
-	if (setsockopt(fd, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
-		perror("Failed to setup HCI device filter");
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
-static bool read_local_amp_info(int dev_id, uint16_t *max_assoc_len)
-{
-	read_local_amp_info_rp rp;
-	struct hci_request rq;
-	int fd;
-
-	printf("hci%d: Reading local AMP information\n", dev_id);
-
-	fd = hci_open_dev(dev_id);
-	if (fd < 0) {
-		perror("Failed to open HCI device");
-		return false;
-	}
-
-	memset(&rp, 0, sizeof(rp));
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_STATUS_PARAM;
-	rq.ocf    = OCF_READ_LOCAL_AMP_INFO;
-	rq.rparam = &rp;
-	rq.rlen   = READ_LOCAL_AMP_INFO_RP_SIZE;
-
-	if (hci_send_req(fd, &rq, 1000) < 0) {
-		perror("Failed sending HCI request");
-		hci_close_dev(fd);
-		return false;
-	}
-
-	if (rp.status) {
-		fprintf(stderr, "Failed HCI command: 0x%02x\n", rp.status);
-		hci_close_dev(fd);
-		return false;
-	}
-
-	printf("\tAMP status: 0x%02x\n", rp.amp_status);
-	printf("\tController type: 0x%02x\n", rp.controller_type);
-	printf("\tMax ASSOC length: %d\n", btohs(rp.max_amp_assoc_length));
-
-	*max_assoc_len = btohs(rp.max_amp_assoc_length);
-
-	hci_close_dev(fd);
-
-	return true;
-}
-
-static bool read_local_amp_assoc(int dev_id, uint8_t phy_handle,
-							uint16_t max_assoc_len,
-							uint8_t *assoc_data,
-							uint16_t *assoc_len)
-{
-	read_local_amp_assoc_cp cp;
-	read_local_amp_assoc_rp rp;
-	struct hci_request rq;
-	int fd;
-
-	printf("hci%d: Reading local AMP association\n", dev_id);
-
-	fd = hci_open_dev(dev_id);
-	if (fd < 0) {
-		perror("Failed to open HCI device");
-		return false;
-	}
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = phy_handle;
-	cp.length_so_far = htobs(0);
-	cp.assoc_length = htobs(max_assoc_len);
-	memset(&rp, 0, sizeof(rp));
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_STATUS_PARAM;
-	rq.ocf    = OCF_READ_LOCAL_AMP_ASSOC;
-	rq.cparam = &cp;
-	rq.clen   = READ_LOCAL_AMP_ASSOC_CP_SIZE;
-	rq.rparam = &rp;
-	rq.rlen   = READ_LOCAL_AMP_ASSOC_RP_SIZE;
-
-	if (hci_send_req(fd, &rq, 1000) < 0) {
-		perror("Failed sending HCI request");
-		hci_close_dev(fd);
-		return false;
-	}
-
-	if (rp.status) {
-		fprintf(stderr, "Failed HCI command: 0x%02x\n", rp.status);
-		hci_close_dev(fd);
-		return false;
-	}
-
-	printf("\tRemain ASSOC length: %d\n", btohs(rp.length));
-
-	*assoc_len = btohs(rp.length);
-	memcpy(assoc_data, rp.fragment, *assoc_len);
-
-	hci_close_dev(fd);
-
-	return true;
-}
-
-static bool write_remote_amp_assoc(int dev_id, uint8_t phy_handle,
-							uint8_t *assoc_data,
-							uint16_t assoc_len)
-{
-	write_remote_amp_assoc_cp cp;
-	write_remote_amp_assoc_rp rp;
-	struct hci_request rq;
-	int fd;
-
-	printf("hci%d: Writing remote AMP association\n", dev_id);
-
-	fd = hci_open_dev(dev_id);
-	if (fd < 0) {
-		perror("Failed to open HCI device");
-		return false;
-	}
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = phy_handle;
-	cp.length_so_far = htobs(0);
-	cp.remaining_length = htobs(assoc_len);
-	memcpy(cp.fragment, assoc_data, assoc_len);
-	memset(&rp, 0, sizeof(rp));
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_STATUS_PARAM;
-	rq.ocf    = OCF_WRITE_REMOTE_AMP_ASSOC;
-	rq.cparam = &cp;
-	rq.clen   = 5 + assoc_len;
-	rq.rparam = &rp;
-	rq.rlen   = WRITE_REMOTE_AMP_ASSOC_RP_SIZE;
-
-	if (hci_send_req(fd, &rq, 1000) < 0) {
-		perror("Failed sending HCI request");
-		hci_close_dev(fd);
-		return false;
-	}
-
-	if (rp.status) {
-		fprintf(stderr, "Failed HCI command: 0x%02x\n", rp.status);
-		hci_close_dev(fd);
-		return false;
-	}
-
-	hci_close_dev(fd);
-
-	return true;
-}
-
-static bool channel_selected_event(int dev_id, int fd, uint8_t phy_handle)
-{
-	printf("hci%d: Waiting for channel selected event\n", dev_id);
-
-	while (1) {
-		uint8_t buf[HCI_MAX_EVENT_SIZE];
-		hci_event_hdr *hdr;
-		struct pollfd p;
-		int n, len;
-
-		p.fd = fd;
-		p.events = POLLIN;
-
-		n = poll(&p, 1, 10000);
-		if (n < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
-
-			perror("Failed to poll HCI device");
-			return false;
-		}
-
-		if (n == 0) {
-			fprintf(stderr, "Failure to receive event\n");
-			return false;
-		}
-
-		len = read(fd, buf, sizeof(buf));
-		if (len < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
-
-			perror("Failed to read from HCI device");
-			return false;
-		}
-
-		hdr = (void *) (buf + 1);
-
-		if (hdr->evt == EVT_CHANNEL_SELECTED)
-			break;
-	}
-
-	return true;
-}
-
-static bool create_physical_link(int dev_id, uint8_t phy_handle)
-{
-	create_physical_link_cp cp;
-	evt_cmd_status evt;
-	struct hci_request rq;
-	int i, fd;
-
-	printf("hci%d: Creating physical link\n", dev_id);
-
-	fd = hci_open_dev(dev_id);
-	if (fd < 0) {
-		perror("Failed to open HCI device");
-		return false;
-	}
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = phy_handle;
-	cp.key_length = 32;
-	cp.key_type = 0x03;
-	for (i = 0; i < cp.key_length; i++)
-		cp.key[i] = 0x23;
-	memset(&evt, 0, sizeof(evt));
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_CREATE_PHYSICAL_LINK;
-	rq.event  = EVT_CMD_STATUS;
-	rq.cparam = &cp;
-	rq.clen   = CREATE_PHYSICAL_LINK_CP_SIZE;
-	rq.rparam = &evt;
-	rq.rlen   = EVT_CMD_STATUS_SIZE;
-
-	if (hci_send_req(fd, &rq, 1000) < 0) {
-		perror("Failed sending HCI request");
-		hci_close_dev(fd);
-		return false;
-	}
-
-	if (evt.status) {
-		fprintf(stderr, "Failed HCI command: 0x%02x\n", evt.status);
-		hci_close_dev(fd);
-		return false;
-	}
-
-	hci_close_dev(fd);
-
-	return true;
-}
-
-static bool accept_physical_link(int dev_id, uint8_t phy_handle)
-{
-	accept_physical_link_cp cp;
-	evt_cmd_status evt;
-	struct hci_request rq;
-	int i, fd;
-
-	printf("hci%d: Accepting physical link\n", dev_id);
-
-	fd = hci_open_dev(dev_id);
-	if (fd < 0) {
-		perror("Failed to open HCI device");
-		return false;
-	}
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = phy_handle;
-	cp.key_length = 32;
-	cp.key_type = 0x03;
-	for (i = 0; i < cp.key_length; i++)
-		cp.key[i] = 0x23;
-	memset(&evt, 0, sizeof(evt));
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_ACCEPT_PHYSICAL_LINK;
-	rq.event  = EVT_CMD_STATUS;
-	rq.cparam = &cp;
-	rq.clen   = ACCEPT_PHYSICAL_LINK_CP_SIZE;
-	rq.rparam = &evt;
-	rq.rlen   = EVT_CMD_STATUS_SIZE;
-
-	if (hci_send_req(fd, &rq, 1000) < 0) {
-		perror("Failed sending HCI request");
-		hci_close_dev(fd);
-		return false;
-	}
-
-	if (evt.status) {
-		fprintf(stderr, "Failed HCI command: 0x%02x\n", evt.status);
-		hci_close_dev(fd);
-		return false;
-	}
-
-	hci_close_dev(fd);
-
-	return true;
-}
-
-static bool disconnect_physical_link(int dev_id, uint8_t phy_handle,
-							uint8_t reason)
-{
-	disconnect_physical_link_cp cp;
-	evt_cmd_status evt;
-	struct hci_request rq;
-	int fd;
-
-	printf("hci%d: Disconnecting physical link\n", dev_id);
-
-	fd = hci_open_dev(dev_id);
-	if (fd < 0) {
-		perror("Failed to open HCI device");
-		return false;
-	}
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = phy_handle;
-	cp.reason = reason;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_DISCONNECT_PHYSICAL_LINK;
-	rq.event  = EVT_CMD_STATUS;
-	rq.cparam = &cp;
-	rq.clen   = DISCONNECT_PHYSICAL_LINK_CP_SIZE;
-	rq.rparam = &evt;
-	rq.rlen   = EVT_CMD_STATUS_SIZE;
-
-	if (hci_send_req(fd, &rq, 1000) < 0) {
-		perror("Failed sending HCI request");
-		hci_close_dev(fd);
-		return false;
-	}
-
-	if (evt.status) {
-		fprintf(stderr, "Failed HCI command: 0x%02x\n", evt.status);
-		hci_close_dev(fd);
-		return false;
-	}
-
-	hci_close_dev(fd);
-
-	return true;
-}
-
-static bool physical_link_complete_event(int dev_id, int fd,
-							uint8_t phy_handle)
-{
-	printf("hci%d: Waiting for physical link complete event\n", dev_id);
-
-	while (1) {
-		uint8_t buf[HCI_MAX_EVENT_SIZE];
-		hci_event_hdr *hdr;
-		int len;
-
-		len = read(fd, buf, sizeof(buf));
-		if (len < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
-
-			perror("Failed to read from HCI device");
-			return false;
-		}
-
-		hdr = (void *) (buf + 1);
-
-		if (hdr->evt == EVT_PHYSICAL_LINK_COMPLETE)
-			break;
-	}
-
-	return true;
-}
-
-static bool disconnect_physical_link_complete_event(int dev_id, int fd,
-							uint8_t phy_handle)
-{
-	printf("hci%d: Waiting for physical link disconnect event\n", dev_id);
-
-	while (1) {
-		uint8_t buf[HCI_MAX_EVENT_SIZE];
-		hci_event_hdr *hdr;
-		int len;
-
-		len = read(fd, buf, sizeof(buf));
-		if (len < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
-
-			perror("Failed to read from HCI device");
-			return false;
-		}
-
-		hdr = (void *) (buf + 1);
-
-		if (hdr->evt == EVT_DISCONNECT_PHYSICAL_LINK_COMPLETE)
-			break;
-	}
-
-	return true;
-}
-
-static int amp1_dev_id = -1;
-static int amp2_dev_id = -1;
-
-static bool find_amp_controller(void)
-{
-	struct hci_dev_list_req *dl;
-	struct hci_dev_req *dr;
-	int fd, i;
-	bool result;
-
-	fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (fd < 0) {
-		perror("Failed to open raw HCI socket");
-		return false;
-	}
-
-	dl = malloc(HCI_MAX_DEV * sizeof(struct hci_dev_req) + sizeof(uint16_t));
-	if (!dl) {
-		perror("Failed allocate HCI device request memory");
-		close(fd);
-		return false;
-	}
-
-	dl->dev_num = HCI_MAX_DEV;
-	dr = dl->dev_req;
-
-	if (ioctl(fd, HCIGETDEVLIST, (void *) dl) < 0) {
-		perror("Failed to get HCI device list");
-		result = false;
-		goto done;
-	}
-
-	for (i = 0; i< dl->dev_num; i++) {
-		struct hci_dev_info di;
-
-		di.dev_id = (dr + i)->dev_id;
-
-		if (ioctl(fd, HCIGETDEVINFO, (void *) &di) < 0)
-			continue;
-
-		if (((di.type & 0x30) >> 4) != HCI_AMP)
-			continue;
-
-		if (amp1_dev_id < 0)
-			amp1_dev_id = di.dev_id;
-		else if (amp2_dev_id < 0) {
-			if (di.dev_id < amp1_dev_id) {
-				amp2_dev_id = amp1_dev_id;
-				amp1_dev_id = di.dev_id;
-			} else
-				amp2_dev_id = di.dev_id;
-		}
-	}
-
-	result = true;
-
-done:
-	free(dl);
-	close(fd);
-	return result;
-}
-
-int main(int argc ,char *argv[])
-{
-	int amp1_event_fd, amp2_event_fd;
-	uint16_t amp1_max_assoc_len, amp2_max_assoc_len;
-	uint8_t *amp1_assoc_data, *amp2_assoc_data;
-	uint16_t amp1_assoc_len, amp2_assoc_len;
-	uint8_t amp1_phy_handle, amp2_phy_handle;
-
-	if (!find_amp_controller())
-		return EXIT_FAILURE;
-
-	if (amp1_dev_id < 0 || amp2_dev_id < 0) {
-		fprintf(stderr, "Two AMP controllers are required\n");
-		return EXIT_FAILURE;
-	}
-
-	printf("hci%d: AMP initiator\n", amp1_dev_id);
-	printf("hci%d: AMP acceptor\n", amp2_dev_id);
-
-	amp1_event_fd = activate_amp_controller(amp1_dev_id);
-	if (amp1_event_fd < 0)
-		return EXIT_FAILURE;
-
-	amp2_event_fd = activate_amp_controller(amp2_dev_id);
-	if (amp2_event_fd < 0) {
-		hci_close_dev(amp1_event_fd);
-		return EXIT_FAILURE;
-	}
-
-	if (!read_local_amp_info(amp1_dev_id, &amp1_max_assoc_len))
-		return EXIT_FAILURE;
-
-	amp1_assoc_data = alloca(amp1_max_assoc_len);
-
-	printf("--> AMP_Get_Info_Request (Amp_ID B)\n");
-
-	if (!read_local_amp_info(amp2_dev_id, &amp2_max_assoc_len))
-		return EXIT_FAILURE;
-
-	amp2_assoc_data = alloca(amp2_max_assoc_len);
-
-	printf("<-- AMP_Get_Info_Response (Amp_ID B, Status)\n");
-
-	printf("--> AMP_Get_AMP_Assoc_Request (Amp_ID B)\n");
-
-	if (!read_local_amp_assoc(amp2_dev_id, 0x00, amp2_max_assoc_len,
-					amp2_assoc_data, &amp2_assoc_len))
-		return EXIT_FAILURE;
-
-	printf("<-- AMP_Get_AMP_Assoc_Response (Amp_ID B, AMP_Assoc B)\n");
-
-	amp1_phy_handle = 0x04;
-
-	if (!create_physical_link(amp1_dev_id, amp1_phy_handle))
-		return EXIT_FAILURE;
-
-	if (!write_remote_amp_assoc(amp1_dev_id, amp1_phy_handle,
-					amp2_assoc_data, amp2_assoc_len))
-		return EXIT_FAILURE;
-
-	printf("hci%d: Signal MAC to scan\n", amp1_dev_id);
-
-	printf("hci%d: Signal MAC to start\n", amp1_dev_id);
-
-	if (!channel_selected_event(amp1_dev_id, amp1_event_fd,
-							amp1_phy_handle))
-		return EXIT_FAILURE;
-
-	if (!read_local_amp_assoc(amp1_dev_id, amp1_phy_handle,
-					amp1_max_assoc_len,
-					amp1_assoc_data, &amp1_assoc_len))
-		return EXIT_FAILURE;
-
-	printf("--> AMP_Create_Physical_Link_Request (Remote-Amp-ID B, AMP_Assoc A)\n");
-
-	amp2_phy_handle = 0x05;
-
-	if (!accept_physical_link(amp2_dev_id, amp2_phy_handle))
-		return EXIT_FAILURE;
-
-	if (!write_remote_amp_assoc(amp2_dev_id, amp2_phy_handle,
-					amp1_assoc_data, amp1_assoc_len))
-		return EXIT_FAILURE;
-
-	printf("hci%d: Signal MAC to start\n", amp2_dev_id);
-
-	printf("<-- AMP_Create_Physical_Link_Response (Local-Amp-ID B, Status)\n");
-
-	if (!physical_link_complete_event(amp2_dev_id, amp2_event_fd,
-							amp2_phy_handle))
-		return EXIT_FAILURE;
-
-	if (!physical_link_complete_event(amp1_dev_id, amp1_event_fd,
-							amp1_phy_handle))
-		return EXIT_FAILURE;
-
-	/* physical link established */
-
-	if (!disconnect_physical_link(amp1_dev_id, amp1_phy_handle, 0x13))
-		return EXIT_FAILURE;
-
-	if (!disconnect_physical_link_complete_event(amp1_dev_id,
-							amp1_event_fd,
-							amp1_phy_handle))
-		return EXIT_FAILURE;
-
-	if (!disconnect_physical_link_complete_event(amp2_dev_id,
-							amp2_event_fd,
-							amp2_phy_handle))
-		return EXIT_FAILURE;
-
-	hci_close_dev(amp2_event_fd);
-	hci_close_dev(amp1_event_fd);
-
-	return EXIT_SUCCESS;
-}
diff --git a/tools/parser/amp.c b/tools/parser/amp.c
deleted file mode 100644
index 79753147079b..000000000000
--- a/tools/parser/amp.c
+++ /dev/null
@@ -1,114 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Intel Corporation.
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#define _GNU_SOURCE
-#include "parser.h"
-#include "lib/amp.h"
-
-static void amp_dump_chanlist(int level, struct amp_tlv *tlv, char *prefix)
-{
-	struct amp_chan_list *chan_list = (void *) tlv->val;
-	struct amp_country_triplet *triplet;
-	int i, num;
-
-	num = (tlv->len - sizeof(*chan_list)) / sizeof(*triplet);
-
-	printf("%s (number of triplets %d)\n", prefix, num);
-
-	p_indent(level+2, 0);
-
-	printf("Country code: %c%c%c\n", chan_list->country_code[0],
-		chan_list->country_code[1], chan_list->country_code[2]);
-
-	for (i = 0; i < num; i++) {
-		triplet = &chan_list->triplets[i];
-
-		p_indent(level+2, 0);
-
-		if (triplet->chans.first_channel >= 201) {
-			printf("Reg ext id %d reg class %d coverage class %d\n",
-						triplet->ext.reg_extension_id,
-						triplet->ext.reg_class,
-						triplet->ext.coverage_class);
-		} else {
-			if (triplet->chans.num_channels == 1)
-				printf("Channel %d max power %d\n",
-						triplet->chans.first_channel,
-						triplet->chans.max_power);
-			else
-				printf("Channels %d - %d max power %d\n",
-						triplet->chans.first_channel,
-						triplet->chans.first_channel +
-						triplet->chans.num_channels,
-						triplet->chans.max_power);
-		}
-	}
-}
-
-void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
-{
-	struct amp_tlv *tlv = (void *) assoc;
-
-	p_indent(level, 0);
-	printf("Assoc data [len %d]:\n", len);
-
-	while (len > sizeof(*tlv)) {
-		uint16_t tlvlen = btohs(tlv->len);
-		struct amp_pal_ver *ver;
-
-		p_indent(level+1, 0);
-
-		switch (tlv->type) {
-		case A2MP_MAC_ADDR_TYPE:
-			if (tlvlen != 6)
-				break;
-			printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
-					tlv->val[0], tlv->val[1], tlv->val[2],
-					tlv->val[3], tlv->val[4], tlv->val[5]);
-			break;
-
-		case A2MP_PREF_CHANLIST_TYPE:
-			amp_dump_chanlist(level, tlv, "Preferred Chan List");
-			break;
-
-		case A2MP_CONNECTED_CHAN:
-			amp_dump_chanlist(level, tlv, "Connected Chan List");
-			break;
-
-		case A2MP_PAL_CAP_TYPE:
-			if (tlvlen != 4)
-				break;
-			printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
-					tlv->val[0], tlv->val[1], tlv->val[2],
-					tlv->val[3]);
-			break;
-
-		case A2MP_PAL_VER_INFO:
-			if (tlvlen != 5)
-				break;
-			ver = (struct amp_pal_ver *) tlv->val;
-			printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
-					ver->ver, btohs(ver->company_id),
-					btohs(ver->sub_ver));
-			break;
-
-		default:
-			printf("Unrecognized type %d\n", tlv->type);
-			break;
-		}
-
-		len -= tlvlen + sizeof(*tlv);
-		assoc += tlvlen + sizeof(*tlv);
-		tlv = (struct amp_tlv *) assoc;
-	}
-}
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index db7d32c011b9..a1a639eba035 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -24,7 +24,6 @@
 #include "parser.h"
 #include "lib/hci.h"
 #include "lib/hci_lib.h"
-#include "lib/amp.h"
 
 static uint16_t manufacturer = DEFAULT_COMPID;
 
@@ -1658,18 +1657,6 @@ static inline void le_set_scan_enable_dump(int level, struct frame *frm)
 		(cp->filter_dup == 0x00 ? "disabled" : "enabled"));
 }
 
-static inline void write_remote_amp_assoc_cmd_dump(int level,
-							struct frame *frm)
-{
-	write_remote_amp_assoc_cp *cp = frm->ptr;
-
-	p_indent(level, frm);
-	printf("handle 0x%2.2x len_so_far %d remaining_len %d\n", cp->handle,
-				cp->length_so_far, cp->remaining_length);
-
-	amp_assoc_dump(level + 1, cp->fragment, frm->len - 5);
-}
-
 static inline void command_dump(int level, struct frame *frm)
 {
 	hci_command_hdr *hdr = frm->ptr;
@@ -1947,9 +1934,6 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_READ_CLOCK:
 			request_clock_dump(level + 1, frm);
 			return;
-		case OCF_WRITE_REMOTE_AMP_ASSOC:
-			write_remote_amp_assoc_cmd_dump(level + 1, frm);
-			return;
 		}
 		break;
 
@@ -2638,34 +2622,6 @@ static inline void read_local_amp_info_dump(int level, struct frame *frm)
 	}
 }
 
-static inline void read_local_amp_assoc_dump(int level, struct frame *frm)
-{
-	read_local_amp_assoc_rp *rp = frm->ptr;
-	uint16_t len = btohs(rp->length);
-
-	p_indent(level, frm);
-	printf("status 0x%2.2x handle 0x%2.2x remaining len %d\n",
-			rp->status, rp->handle, len);
-	if (rp->status > 0) {
-		p_indent(level, frm);
-		printf("Error: %s\n", status2str(rp->status));
-	} else {
-		amp_assoc_dump(level + 1, rp->fragment, len);
-	}
-}
-
-static inline void write_remote_amp_assoc_dump(int level, struct frame *frm)
-{
-	write_remote_amp_assoc_rp *rp = frm->ptr;
-
-	p_indent(level, frm);
-	printf("status 0x%2.2x handle 0x%2.2x\n", rp->status, rp->handle);
-	if (rp->status > 0) {
-		p_indent(level, frm);
-		printf("Error: %s\n", status2str(rp->status));
-	}
-}
-
 static inline void le_read_buffer_size_response_dump(int level, struct frame *frm)
 {
 	le_read_buffer_size_rp *rp = frm->ptr;
@@ -2934,15 +2890,6 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_READ_CLOCK:
 			read_clock_dump(level, frm);
 			return;
-		case OCF_READ_LOCAL_AMP_INFO:
-			read_local_amp_info_dump(level, frm);
-			return;
-		case OCF_READ_LOCAL_AMP_ASSOC:
-			read_local_amp_assoc_dump(level, frm);
-			return;
-		case OCF_WRITE_REMOTE_AMP_ASSOC:
-			write_remote_amp_assoc_dump(level, frm);
-			return;
 		}
 		break;
 
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index 562093ad0bf8..8675aa74191c 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -25,8 +25,6 @@
 #include "sdp.h"
 #include "l2cap.h"
 #include "lib/hci.h"
-#include "lib/a2mp.h"
-#include "lib/amp.h"
 
 typedef struct {
 	uint16_t handle;
@@ -259,16 +257,6 @@ static char *reason2str(uint16_t reason)
 	}
 }
 
-static char *a2mpreason2str(uint16_t reason)
-{
-	switch (reason) {
-	case A2MP_COMMAND_NOT_RECOGNIZED:
-		return "Command not recognized";
-	default:
-		return "Reserved";
-	}
-}
-
 static char *connresult2str(uint16_t result)
 {
 	switch (result) {
@@ -409,89 +397,6 @@ static char *supervisory2str(uint8_t supervisory)
 	}
 }
 
-static char *ampctrltype2str(uint8_t type)
-{
-	switch (type) {
-	case HCI_BREDR:
-		return "BR-EDR";
-	case HCI_AMP:
-		return "802.11 AMP";
-	default:
-		return "Reserved";
-	}
-}
-
-static char *ampctrlstatus2str(uint8_t status)
-{
-	switch (status) {
-	case AMP_CTRL_POWERED_DOWN:
-		return "Powered down";
-	case AMP_CTRL_BLUETOOTH_ONLY:
-		return "Bluetooth only";
-	case AMP_CTRL_NO_CAPACITY:
-		return "No capacity";
-	case AMP_CTRL_LOW_CAPACITY:
-		return "Low capacity";
-	case AMP_CTRL_MEDIUM_CAPACITY:
-		return "Medium capacity";
-	case AMP_CTRL_HIGH_CAPACITY:
-		return "High capacity";
-	case AMP_CTRL_FULL_CAPACITY:
-		return "Full capacity";
-	default:
-		return "Reserved";
-
-	}
-}
-
-static char *a2mpstatus2str(uint8_t status)
-{
-	switch (status) {
-	case A2MP_STATUS_SUCCESS:
-		return "Success";
-	case A2MP_STATUS_INVALID_CTRL_ID:
-		return "Invalid Controller ID";
-	default:
-		return "Reserved";
-	}
-}
-
-static char *a2mpcplstatus2str(uint8_t status)
-{
-	switch (status) {
-	case A2MP_STATUS_SUCCESS:
-		return "Success";
-	case A2MP_STATUS_INVALID_CTRL_ID:
-		return "Invalid Controller ID";
-	case A2MP_STATUS_UNABLE_START_LINK_CREATION:
-		return "Failed - Unable to start link creation";
-	case A2MP_STATUS_COLLISION_OCCURED:
-		return "Failed - Collision occured";
-	case A2MP_STATUS_DISCONN_REQ_RECVD:
-		return "Failed - Disconnect physical link received";
-	case A2MP_STATUS_PHYS_LINK_EXISTS:
-		return "Failed - Physical link already exists";
-	case A2MP_STATUS_SECURITY_VIOLATION:
-		return "Failed - Security violation";
-	default:
-		return "Reserved";
-	}
-}
-
-static char *a2mpdplstatus2str(uint8_t status)
-{
-	switch (status) {
-	case A2MP_STATUS_SUCCESS:
-		return "Success";
-	case A2MP_STATUS_INVALID_CTRL_ID:
-		return "Invalid Controller ID";
-	case A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS:
-		return "Failed - No Physical Link exists";
-	default:
-		return "Reserved";
-	}
-}
-
 static inline void command_rej(int level, struct frame *frm)
 {
 	l2cap_cmd_rej *h = frm->ptr;
@@ -1025,180 +930,6 @@ static inline void move_cfm_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm
 	printf("Move chan cfm rsp: icid 0x%4.4x\n", icid);
 }
 
-static inline void a2mp_command_rej(int level, struct frame *frm)
-{
-	struct a2mp_command_rej *h = frm->ptr;
-	uint16_t reason = btohs(h->reason);
-
-	printf("Command Reject: reason %d\n", reason);
-	p_indent(level + 1, 0);
-	printf("%s\n", a2mpreason2str(reason));
-}
-
-static inline void a2mp_discover_req(int level, struct frame *frm, uint16_t len)
-{
-	struct a2mp_discover_req *h = frm->ptr;
-	uint16_t mtu = btohs(h->mtu);
-	uint8_t	 *octet = (uint8_t *)&(h->mask);
-	uint16_t mask;
-	uint8_t  extension;
-
-	printf("Discover req: mtu/mps %d ", mtu);
-	len -= 2;
-
-	printf("mask:");
-
-	do {
-		len -= 2;
-		mask = get_le16(octet);
-		printf(" 0x%4.4x", mask);
-
-		extension = octet[1] & 0x80;
-		octet += 2;
-	} while ((extension != 0) && (len >= 2));
-
-	printf("\n");
-}
-
-static inline void a2mp_ctrl_list_dump(int level, struct a2mp_ctrl *list, uint16_t len)
-{
-	p_indent(level, 0);
-	printf("Controller list:\n");
-
-	while (len >= 3) {
-		p_indent(level + 1, 0);
-		printf("id %d type %d (%s) status 0x%2.2x (%s)\n",
-			   list->id, list->type, ampctrltype2str(list->type), list->status, ampctrlstatus2str(list->status));
-		list++;
-		len -= 3;
-	}
-
-}
-
-static inline void a2mp_discover_rsp(int level, struct frame *frm, uint16_t len)
-{
-	struct a2mp_discover_rsp *h = frm->ptr;
-	uint16_t mtu = btohs(h->mtu);
-	uint8_t	 *octet = (uint8_t *)&(h->mask);
-	uint16_t mask;
-	uint8_t  extension;
-
-	printf("Discover rsp: mtu/mps %d ", mtu);
-	len -= 2;
-
-	printf("mask:");
-
-	do {
-		len -= 2;
-		mask = get_le16(octet);
-		printf(" 0x%4.4x", mask);
-
-		extension = octet[1] & 0x80;
-		octet += 2;
-	} while ((extension != 0) && (len >= 2));
-
-	printf("\n");
-
-	if (len >= 3) {
-		a2mp_ctrl_list_dump(level + 1, (struct a2mp_ctrl *) octet, len);
-	}
-}
-
-static inline void a2mp_change_notify(int level, struct frame *frm, uint16_t len)
-{
-	struct a2mp_ctrl *list = frm->ptr;
-
-	printf("Change Notify\n");
-
-	if (len >= 3) {
-		a2mp_ctrl_list_dump(level + 1, list, len);
-	}
-}
-
-static inline void a2mp_change_rsp(int level, struct frame *frm)
-{
-	printf("Change Response\n");
-}
-
-static inline void a2mp_info_req(int level, struct frame *frm)
-{
-	struct a2mp_info_req *h = frm->ptr;
-
-	printf("Get Info req: id %d\n", h->id);
-}
-
-static inline void a2mp_info_rsp(int level, struct frame *frm)
-{
-	struct a2mp_info_rsp *h = frm->ptr;
-
-	printf("Get Info rsp: id %d status %d (%s)\n",
-		   h->id, h->status, a2mpstatus2str(h->status));
-
-	p_indent(level + 1, 0);
-	printf("Total bandwidth %d\n", btohl(h->total_bw));
-	p_indent(level + 1, 0);
-	printf("Max guaranteed bandwidth %d\n", btohl(h->max_bw));
-	p_indent(level + 1, 0);
-	printf("Min latency %d\n", btohl(h->min_latency));
-	p_indent(level + 1, 0);
-	printf("Pal capabilities 0x%4.4x\n", btohs(h->pal_caps));
-	p_indent(level + 1, 0);
-	printf("Assoc size %d\n", btohs(h->assoc_size));
-}
-
-static inline void a2mp_assoc_req(int level, struct frame *frm)
-{
-	struct a2mp_assoc_req *h = frm->ptr;
-
-	printf("Get AMP Assoc req: id %d\n", h->id);
-}
-
-static inline void a2mp_assoc_rsp(int level, struct frame *frm, uint16_t len)
-{
-	struct a2mp_assoc_rsp *h = frm->ptr;
-
-	printf("Get AMP Assoc rsp: id %d status (%d) %s\n",
-			h->id, h->status, a2mpstatus2str(h->status));
-	amp_assoc_dump(level + 1, h->assoc_data, len - sizeof(*h));
-}
-
-static inline void a2mp_create_req(int level, struct frame *frm, uint16_t len)
-{
-	struct a2mp_create_req *h = frm->ptr;
-
-	printf("Create Physical Link req: local id %d remote id %d\n",
-		   h->local_id, h->remote_id);
-	amp_assoc_dump(level + 1, h->assoc_data, len - sizeof(*h));
-}
-
-static inline void a2mp_create_rsp(int level, struct frame *frm)
-{
-	struct a2mp_create_rsp *h = frm->ptr;
-
-	printf("Create Physical Link rsp: local id %d remote id %d status %d\n",
-		   h->local_id, h->remote_id, h->status);
-	p_indent(level+1, 0);
-	printf("%s\n", a2mpcplstatus2str(h->status));
-}
-
-static inline void a2mp_disconn_req(int level, struct frame *frm)
-{
-	struct a2mp_disconn_req *h = frm->ptr;
-
-	printf("Disconnect Physical Link req: local id %d remote id %d\n",
-		   h->local_id, h->remote_id);
-}
-
-static inline void a2mp_disconn_rsp(int level, struct frame *frm)
-{
-	struct a2mp_disconn_rsp *h = frm->ptr;
-
-	printf("Disconnect Physical Link rsp: local id %d remote id %d status %d\n",
-		   h->local_id, h->remote_id, h->status);
-	p_indent(level+1, 0);
-	printf("%s\n", a2mpdplstatus2str(h->status));
-}
-
 static void l2cap_parse(int level, struct frame *frm)
 {
 	l2cap_hdr *hdr = (void *)frm->ptr;
@@ -1319,76 +1050,6 @@ static void l2cap_parse(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("L2CAP(c): len %d psm %d\n", dlen, psm);
 		raw_dump(level, frm);
-	} else if (cid == 0x3) {
-		/* AMP Manager channel */
-
-		if (p_filter(FILT_A2MP))
-			return;
-
-		/* Adjust for ERTM control bytes */
-		frm->ptr += 2;
-		frm->len -= 2;
-
-		while (frm->len >= A2MP_HDR_SIZE) {
-			struct a2mp_hdr *hdr = frm->ptr;
-
-			frm->ptr += A2MP_HDR_SIZE;
-			frm->len -= A2MP_HDR_SIZE;
-
-			p_indent(level, frm);
-			printf("A2MP: ");
-
-			switch (hdr->code) {
-			case A2MP_COMMAND_REJ:
-				a2mp_command_rej(level, frm);
-				break;
-			case A2MP_DISCOVER_REQ:
-				a2mp_discover_req(level, frm, btohs(hdr->len));
-				break;
-			case A2MP_DISCOVER_RSP:
-				a2mp_discover_rsp(level, frm, btohs(hdr->len));
-				break;
-			case A2MP_CHANGE_NOTIFY:
-				a2mp_change_notify(level, frm, btohs(hdr->len));
-				break;
-			case A2MP_CHANGE_RSP:
-				a2mp_change_rsp(level, frm);
-				break;
-			case A2MP_INFO_REQ:
-				a2mp_info_req(level, frm);
-				break;
-			case A2MP_INFO_RSP:
-				a2mp_info_rsp(level, frm);
-				break;
-			case A2MP_ASSOC_REQ:
-				a2mp_assoc_req(level, frm);
-				break;
-			case A2MP_ASSOC_RSP:
-				a2mp_assoc_rsp(level, frm, btohs(hdr->len));
-				break;
-			case A2MP_CREATE_REQ:
-				a2mp_create_req(level, frm, btohs(hdr->len));
-				break;
-			case A2MP_CREATE_RSP:
-				a2mp_create_rsp(level, frm);
-				break;
-			case A2MP_DISCONN_REQ:
-				a2mp_disconn_req(level, frm);
-				break;
-			case A2MP_DISCONN_RSP:
-				a2mp_disconn_rsp(level, frm);
-				break;
-			default:
-				printf("code 0x%2.2x ident %d len %d\n",
-					   hdr->code, hdr->ident, btohs(hdr->len));
-				raw_dump(level, frm);
-			}
-			if (frm->len > btohs(hdr->len)) {
-				frm->len -= btohs(hdr->len);
-				frm->ptr += btohs(hdr->len);
-			} else
-				frm->len = 0;
-		}
 	} else if (cid == 0x04) {
 		if (!p_filter(FILT_ATT))
 			att_dump(level, frm);
-- 
2.48.1

