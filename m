Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF4254AFF
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991799; cv=none; b=WyFY2T6hVNErtFAvW5roQknYDZPYp7tzqVMGTSR6g1OJU567/7CMtpJk9JJEfGH0r3di84UCeyJCj1raNHwuFycyX4Wxk81FPov7Fb+VEY9J/TACjwgOKL7Wf5rQAxajeVEx6a7VJfDXvSc1e0UVxngauN69OUgobzqiga5dwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991799; c=relaxed/simple;
	bh=FO/YeMuLggdT+ku/vxVx4IQ0wKJq8Dcsa6Wuv3nCmuU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rwYRUY8fFDl/p9HwTCdvjpVj40A4ooaHrq5PdiJtM9mNawVbKOd8WfqBhCtW0txF3le66mUt+3ocHpqE0YNmK/k5iq0Hu1yzB7kc/6mU9oJPBVrA1WU7Aqi4/P3k3S4fuDcRHKisW+VGRSvlpmR+GCHdUJbXAbojmOi+OVRp4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVePzo5h; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVePzo5h"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so897893241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753991796; x=1754596596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=45+EwdFYE2Bxn8iNwAkLpn7bblzKayRQfUGIEWUxlOk=;
        b=JVePzo5hj+XQPRORNeFnwym6W62uW3p7/KFQSsj47QnfYIifSAmBvzv/UEZ1gEmsQj
         kMCZcx4/xDEHPdzusIhLgQ4xraBHFzRRKGmmOml8Cdb16yUc1IrpJQdWXXbc2Kq4MjeR
         i38ev2b8WaltBD8O/giV2ylDSDwCHr0EO2NsjfzeO3lk///xr9Q25q3zdbpttAS/q4LV
         NVmreEs/PiEuErAzVB7wqwx7wg6DioWtCkpzysXfkaz32D6g0tRFJ3s7czDNbcWqRf3e
         NmDW2/WdBS0cJQDHDED6bNYHT8n2yczYz95b8CZoldiWLZN39qjwb1nvvTSPHqHv9lWN
         wvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753991796; x=1754596596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45+EwdFYE2Bxn8iNwAkLpn7bblzKayRQfUGIEWUxlOk=;
        b=G3xYjEALTxFVp4qH42NVzB/0QJ91vBLYeLETVMprKU/qutuiPD1EiuCT9/8VhyvQ85
         VEHhGg73d25QnJNQ9W8dE/U46N92b+7JL7swK2pBUfay5NCbCkkr895pQJDkKvA7ugPc
         LE47maIb7qcHnSxQq4d473p5U6aVxtrjHDzUVBhPCrAPr8gk3hLRSaoAYmCBWkyjOUIo
         HH27VA1zGCDL8O4i1hgAGgSzyxUIz60l73iC9yIi1Y9yP7PGuNOHvWqR9uGnHOamXhuX
         AcVocbqmAbI6T/sd9OXuPeUrZWABHGwrOHx0725vb7Uf/mwHb/Lm7jfOReBwlk8uNgwl
         5v3g==
X-Gm-Message-State: AOJu0YzqhuE4DGMDOy0i1CkQBBo6Q4q43dFULCfSfNS4DB5/ZLgbZFOJ
	2+0wCnUfAIECpVh0c0wuFRhR42HtPodg94TmIYk6+EFwrRloWZ7nCN9mUS3KDL8o
X-Gm-Gg: ASbGncuB+Ytn+6uRFNMTSOjFt1WTlgg3Q+j896qqZbyaHk+k7uzgyzj6/1rIm6KYqOw
	8e1mY07M/jawkhMlCByFVHN9OSesns/SKGDSQSWfgNVwyGATtjTqAT+rwXf7mpHhSFAB7vD7o+X
	/3zefat3HWYOr0RprhwL/iBXtCcrf+81lU9IqwsNgbj5NI6QeGW8uwy19OsBEKgTwbOgJnhYgzm
	poWTmpYdAXixzy9oqo5S9SEpbSjU/DRAMToLTTuc8rhXMTV0NCwuiCgGWckVXwuDOCNmy2UBWjF
	74Cz31hUKMky+Y7eVaBq3kkV7vBPWkN2NqzPdxf2DNQxB1VIUjBUcK58dvEo2pE2id6aDu8O5xa
	Z38y6YAr/XDxhOFJoJmhOX1XzgxisC8O3lP+JeSXdvAEQtFEd/DOu2QBum2OIkvDO
X-Google-Smtp-Source: AGHT+IEJgfhkitzLiqXExIO1CpEZ7ErJ/ED/PoG4kj3X1ac5N7BjbNYIA5jy5XaY8lUiPaB0rpmvaQ==
X-Received: by 2002:a05:6102:f92:b0:4f3:36bc:554f with SMTP id ada2fe7eead31-4fbe7ee75e8mr5217069137.4.1753991795393;
        Thu, 31 Jul 2025 12:56:35 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936b718e2sm609612e0c.10.2025.07.31.12.56.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 12:56:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH RFC v1] monitor: Add support for logging host packets
Date: Thu, 31 Jul 2025 15:56:24 -0400
Message-ID: <20250731195624.684876-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for logging host packets so their timing is
visible in the logs:

l2cap-tester[41]: < HOST Data TX: len 12                 [hci0] 15:50:02.974141
l2cap-tester[41]: < ACL Data T.. flags 0x00 dlen 12  #83 [hci0] 15:50:02.974199
      Channel: 64 len 8 [PSM 4097 mode Basic (0x00)] {chan 0}
        01 02 03 04 05 06 07 08                          ........

> ACL Data RX: Handle 42 flags 0x02 dlen 12         #170 [hci0] 15:51:43.269961
      Channel: 64 len 8 [PSM 4097 mode Basic (0x00)] {chan 0}
        01 02 03 04 05 06 07 08                          ........
[45]: > HOST Data RX: len 8                              [hci0] 15:51:43.269976
---
 monitor/display.h    |  1 +
 monitor/main.c       |  7 ++++++-
 monitor/packet.c     | 29 +++++++++++++++++++++++++++++
 monitor/packet.h     |  3 +++
 src/shared/btsnoop.h |  2 ++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/monitor/display.h b/monitor/display.h
index ee076448cc31..189c518a0ce7 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -29,6 +29,7 @@ void set_monitor_color(enum monitor_color);
 #define COLOR_WHITE_BG	"\x1B[0;47;30m"
 #define COLOR_HIGHLIGHT	"\x1B[1;39m"
 
+#define COLOR_GRAY_BOLD		"\x1B[1;30m"
 #define COLOR_RED_BOLD		"\x1B[1;31m"
 #define COLOR_GREEN_BOLD	"\x1B[1;32m"
 #define COLOR_BLUE_BOLD		"\x1B[1;34m"
diff --git a/monitor/main.c b/monitor/main.c
index fa56fcb29f38..11d6c9cd1655 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -66,6 +66,7 @@ static void usage(void)
 		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-A, --a2dp             Dump A2DP stream traffic\n"
 		"\t-I, --iso              Dump ISO traffic\n"
+		"\t-H, --host             Dump HOST traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
 		"\t-P, --no-pager         Disable pager usage\n"
 		"\t-J  --jlink <device>,[<serialno>],[<interface>],[<speed>]\n"
@@ -94,6 +95,7 @@ static const struct option main_options[] = {
 	{ "sco",       no_argument,       NULL, 'S' },
 	{ "a2dp",      no_argument,       NULL, 'A' },
 	{ "iso",       no_argument,       NULL, 'I' },
+	{ "host",      no_argument,       NULL, 'H' },
 	{ "ellisys",   required_argument, NULL, 'E' },
 	{ "no-pager",  no_argument,       NULL, 'P' },
 	{ "jlink",     required_argument, NULL, 'J' },
@@ -131,7 +133,7 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-				"r:w:a:s:p:i:d:B:V:MNtTSAIE:PJ:R:C:c:vh",
+				"r:w:a:s:p:i:d:B:V:MNtTSAIHE:PJ:R:C:c:vh",
 				main_options, NULL);
 		if (opt < 0)
 			break;
@@ -205,6 +207,9 @@ int main(int argc, char *argv[])
 		case 'I':
 			filter_mask |= PACKET_FILTER_SHOW_ISO_DATA;
 			break;
+		case 'H':
+			filter_mask |= PACKET_FILTER_SHOW_HOST_DATA;
+			break;
 		case 'E':
 			ellisys_server = optarg;
 			ellisys_port = 24352;
diff --git a/monitor/packet.c b/monitor/packet.c
index 90a82b1af4ff..288b7630c059 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -70,6 +70,7 @@
 #define COLOR_HCI_ACLDATA		COLOR_CYAN
 #define COLOR_HCI_SCODATA		COLOR_YELLOW
 #define COLOR_HCI_ISODATA		COLOR_YELLOW
+#define COLOR_HOSTDATA			COLOR_GRAY_BOLD
 
 #define COLOR_UNKNOWN_ERROR		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_FEATURE_BIT	COLOR_WHITE_BG
@@ -4316,6 +4317,12 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 	case BTSNOOP_OPCODE_ISO_RX_PKT:
 		packet_hci_isodata(tv, cred, index, true, data, size);
 		break;
+	case BTSNOOP_OPCODE_HOST_TX_PKT:
+		packet_host_data(tv, cred, index, false, data, size);
+		break;
+	case BTSNOOP_OPCODE_HOST_RX_PKT:
+		packet_host_data(tv, cred, index, true, data, size);
+		break;
 	case BTSNOOP_OPCODE_OPEN_INDEX:
 		if (index < MAX_INDEX)
 			addr2str(index_list[index].bdaddr, str);
@@ -14120,6 +14127,28 @@ malformed:
 	packet_hexdump(data, size);
 }
 
+void packet_host_data(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size)
+{
+	char str[10];
+
+	if (index >= MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
+	sprintf(str, "len %u", size);
+
+	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HOSTDATA,
+				in ? "HOST Data RX" : "HOST Data TX",
+				str, NULL);
+
+	if (filter_mask & PACKET_FILTER_SHOW_HOST_DATA)
+		packet_hexdump(data, size);
+
+	return;
+}
+
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size)
 {
diff --git a/monitor/packet.h b/monitor/packet.h
index 964b9a7219fa..d2a0b53aee78 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -23,6 +23,7 @@
 #define PACKET_FILTER_SHOW_A2DP_STREAM	(1 << 6)
 #define PACKET_FILTER_SHOW_MGMT_SOCKET	(1 << 7)
 #define PACKET_FILTER_SHOW_ISO_DATA	(1 << 8)
+#define PACKET_FILTER_SHOW_HOST_DATA	(1 << 9)
 #define TV_MSEC(_tv) (long long)((_tv).tv_sec * 1000 + (_tv).tv_usec / 1000)
 
 struct packet_latency {
@@ -120,6 +121,8 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
 void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
+void packet_host_data(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size);
 
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index c24755d56729..b54ebc50ded7 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -42,6 +42,8 @@
 #define BTSNOOP_OPCODE_CTRL_EVENT	17
 #define BTSNOOP_OPCODE_ISO_TX_PKT	18
 #define BTSNOOP_OPCODE_ISO_RX_PKT	19
+#define BTSNOOP_OPCODE_HOST_TX_PKT	22
+#define BTSNOOP_OPCODE_HOST_RX_PKT	23
 
 #define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
 
-- 
2.50.1

