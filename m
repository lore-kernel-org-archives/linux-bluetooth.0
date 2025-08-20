Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEB2D480E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722493; cv=none; b=S8lvr9OvpYdmf2zg6luyBK1a+0St8oU0V/WJb75n3bknTdyYwzlrUKPd74S7bbAyXNkSoTOrMcXrHW+UeKXyhybLqpGGLb4vjx49bYsz6FJLA3mAs0pheFo5B0t/Sq6LYiSzQsES1G9X2jugTMfT4aG1TbA0Mf1olKQ8ULImawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722493; c=relaxed/simple;
	bh=COX6gTdyWtCq2gzzVPxW4ty3KkWtpPLfTE6z7nFs+KA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWLM6rzNi7dhbURSQUoeTqmK45H1Byh8oU3wjsOjE6hFAUarruMzuKzLKERdrY2ogthVODKoQ6wqO8NEklzt6DzlNZhGwOIDpz7MPjM6fXAczZid+xSTM7PN1Kzg72ew3aBBI50cboD2y6rqwHBpt4m/OMNixatuA0ynoGl9KKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFR24eJK; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFR24eJK"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53b174c9c78so303082e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755722490; x=1756327290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7yMqOILJ6dM2utR8CvgFUHTfTLowug8MFMuBVNYYog=;
        b=LFR24eJKeobAP7kchuh/bI62GybA1Lr7+5N525CIJW0x8eR/cgN6Tdv6pPoq+EInwE
         wNoKnMkq6ZNsvBuHHeyl86sZnLzecl0hI206OvND5b3IYkZjLzUZaAtdRbMbbvWnYN4v
         uqqMx8Jw8rWwzj6n7TzmnrEpFzB95GBUJ3V0skMvL4B//d3FHykyR6Tyacz5SC2zwOff
         WSa2NVnDxQaLHeuf03vDQsfCcXcSu/Nfff51KWbT1LDAdSK6pnAVhxUmfkWiHJ0f61mx
         7b2FvQCh00gQp1FIC6o8bqgLprBUdgelq2rlZHEp+PKaXHL8HGXGZ4+/kqOOgAikmITx
         VmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755722490; x=1756327290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7yMqOILJ6dM2utR8CvgFUHTfTLowug8MFMuBVNYYog=;
        b=vaMar9XrXxE29FGTRlN9epk1s5fKSV+Np5htEiYp0r7qPrK4DItEeGyqFoib2iSSsZ
         TIgPzYoA+N6US2gWzD/01jzLHvNwvAVKG5whr8yAmkytRQwYwnBDfeEom6jkrewvfwVp
         BIjs6Llj4hMgUfJe/2vxB51D1tWAR9P59sZt4117mEzfZyJWIc4bpR74ocDT75a3c4Y6
         xK3Tc+EdxyRe+KINB1pcbsns/ftWLvNfEO0I5Y/hNH42NfdgsU/FnoGDbZWI8dnuQjE6
         6YHlSu2XXMsC5Ucjuvyuj3AmDhB2SOBqs0knpGcfuvDXWHkWjQ79HWIgjMEVHgW8kCxK
         suew==
X-Gm-Message-State: AOJu0YwnvSxwRPdf4PknK2lzx2iX6WBOteN0/2X8fffp3IxM1hASzrKG
	mTWvxPTkqKbQngkZeDZcklBy4AOcXetMqk4C4Omzwzjch4lRw1gsWLzbgZgorQ==
X-Gm-Gg: ASbGncvghxvzhk9Pxm0vJu+MtCj+nSzIHAaRAKlxYCpoHqJd6BJh1G64JUaFyuRb/YO
	7cgNyUm8r6/ZUoj3+ZmrZePy/lTFeWG1EPNN0kzd19ZbEDJVZMvlwHiu6mfBKrHa6iZR6Z2o6Iv
	fTy8/5optN4fg2J1gPRIe5yOFclLrDiQSGO4lTlc3NcQOGdusbI3+Hkp66x7nJuHroEL9hLM5Fm
	C3yyzBt/KNRxF1bo6DeaVgIwDBtK/jl4G0HSUZXQpt/ZoX0B6PvH4diYgAZ45TCR19xaPkEEBCA
	hvXYf2QKs2LYFTS+wZqSvwJQJRzxSWkpmnH9gmO3bsu/0EgJ0JH/0wb+nTu8N2dfXVt/243uCJ9
	o+DjFyiqc5XtzmkImNglmuDptzXQ5gD8n24b/7bVofWf5XhvXYJBbX0EA8tL8IrKf/o6nZeqv/a
	E=
X-Google-Smtp-Source: AGHT+IHLRSy1USmDLam79zOY+OR4vzZD0jtSmWTLA6omq8RqxRkgroVtbZQd2ANxFWSCkPcjCwK5BQ==
X-Received: by 2002:a05:6122:8c06:b0:53c:6d68:1d2f with SMTP id 71dfb90a1353d-53c6d682667mr1557051e0c.13.1755722489955;
        Wed, 20 Aug 2025 13:41:29 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bed9fd5sm3358051e0c.18.2025.08.20.13.41.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:41:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Add support for -K/--kernel
Date: Wed, 20 Aug 2025 16:41:17 -0400
Message-ID: <20250820204117.1905780-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820204117.1905780-1-luiz.dentz@gmail.com>
References: <20250820204117.1905780-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for -K/--kernel that open /proc/kmsg and attempts
to print messages starting with 'Bluetooth:':

> monitor/btmon -K
= Note: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
= Note: Bluetooth: BNEP filters: protocol multicast
= Note: Bluetooth: BNEP socket layer initialized
= Note: Bluetooth: MGMT ver 1.23
= Note: Bluetooth: RFCOMM TTY layer initialized
= Note: Bluetooth: RFCOMM socket layer initialized
= Note: Bluetooth: RFCOMM ver 1.11
---
 monitor/btmon.rst |  2 ++
 monitor/control.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 monitor/main.c    |  7 +++++-
 monitor/packet.h  |  1 +
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/monitor/btmon.rst b/monitor/btmon.rst
index eb5e25182f0f..39c185fd5e41 100644
--- a/monitor/btmon.rst
+++ b/monitor/btmon.rst
@@ -77,6 +77,8 @@ OPTIONS
 
 -M, --mgmt                  Open channel for mgmt events.
 
+-K, --kernel                Open kmsg for kernel messages.
+
 -t, --time                  Show a time instead of time offset.
 
 -T, --date                  Show a time and date information instead of
diff --git a/monitor/control.c b/monitor/control.c
index cb8e9fe731fb..83347d5dbc3e 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1081,6 +1081,62 @@ static int open_channel(uint16_t channel)
 	return 0;
 }
 
+static void kmsg_callback(int fd, uint32_t events, void *user_data)
+{
+	char buf[1024], *msg;
+	ssize_t len;
+	struct timeval tv;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(fd);
+		return;
+	}
+
+	memset(buf, 0, sizeof(buf));
+
+	len = read(fd, buf, sizeof(buf));
+	if (len < 0)
+		return;
+
+	/* Check if the kernel message is from Bluetooth */
+	msg = strcasestr(buf, "Bluetooth:");
+	if (!msg)
+		return;
+
+	/* Replace Bluetooth with Kernel to avoid possible confusions */
+	msg += 3;
+	memcpy(msg, "Kernel", 6);
+
+	/* Adjust the actual length since part of the message is skipped and
+	 * replace the \n with \0 at the end.
+	 */
+	len = len - (msg - buf);
+	msg[len - 1] = '\0';
+
+	gettimeofday(&tv, NULL);
+
+	btsnoop_write_hci(btsnoop_file, &tv, HCI_DEV_NONE,
+				BTSNOOP_OPCODE_SYSTEM_NOTE, 0, msg, len);
+	packet_monitor(&tv, NULL, HCI_DEV_NONE,
+				BTSNOOP_OPCODE_SYSTEM_NOTE, msg, len);
+}
+
+static int open_kmsg(void)
+{
+	int fd;
+
+	fd = open("/dev/kmsg", O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	if (mainloop_add_fd(fd, EPOLLIN, kmsg_callback, NULL, NULL) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return 0;
+}
+
 static void client_callback(int fd, uint32_t events, void *user_data)
 {
 	struct control_data *data = user_data;
@@ -1556,6 +1612,9 @@ int control_tracing(void)
 	if (packet_has_filter(PACKET_FILTER_SHOW_MGMT_SOCKET))
 		open_channel(HCI_CHANNEL_CONTROL);
 
+	if (packet_has_filter(PACKET_FILTER_SHOW_KMSG))
+		open_kmsg();
+
 	return 0;
 }
 
diff --git a/monitor/main.c b/monitor/main.c
index fa56fcb29f38..cc947af1ffc4 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -61,6 +61,7 @@ static void usage(void)
 		"\t-B, --tty-speed <rate> Set TTY speed (default 115200)\n"
 		"\t-V, --vendor <compid>  Set default company identifier\n"
 		"\t-M, --mgmt             Open channel for mgmt events\n"
+		"\t-K, --kernel           Open kmsg for kernel messages\n"
 		"\t-t, --time             Show time instead of time offset\n"
 		"\t-T, --date             Show time and date information\n"
 		"\t-S, --sco              Dump SCO traffic\n"
@@ -88,6 +89,7 @@ static const struct option main_options[] = {
 	{ "tty-speed", required_argument, NULL, 'B' },
 	{ "vendor",    required_argument, NULL, 'V' },
 	{ "mgmt",      no_argument,       NULL, 'M' },
+	{ "kernel",    no_argument,       NULL, 'K' },
 	{ "no-time",   no_argument,       NULL, 'N' },
 	{ "time",      no_argument,       NULL, 't' },
 	{ "date",      no_argument,       NULL, 'T' },
@@ -131,7 +133,7 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-				"r:w:a:s:p:i:d:B:V:MNtTSAIE:PJ:R:C:c:vh",
+				"r:w:a:s:p:i:d:B:V:MKNtTSAIE:PJ:R:C:c:vh",
 				main_options, NULL);
 		if (opt < 0)
 			break;
@@ -184,6 +186,9 @@ int main(int argc, char *argv[])
 		case 'M':
 			filter_mask |= PACKET_FILTER_SHOW_MGMT_SOCKET;
 			break;
+		case 'K':
+			filter_mask |= PACKET_FILTER_SHOW_KMSG;
+			break;
 		case 'N':
 			filter_mask &= ~PACKET_FILTER_SHOW_TIME_OFFSET;
 			break;
diff --git a/monitor/packet.h b/monitor/packet.h
index 964b9a7219fa..154a08efacc5 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -23,6 +23,7 @@
 #define PACKET_FILTER_SHOW_A2DP_STREAM	(1 << 6)
 #define PACKET_FILTER_SHOW_MGMT_SOCKET	(1 << 7)
 #define PACKET_FILTER_SHOW_ISO_DATA	(1 << 8)
+#define PACKET_FILTER_SHOW_KMSG		(1 << 9)
 #define TV_MSEC(_tv) (long long)((_tv).tv_sec * 1000 + (_tv).tv_usec / 1000)
 
 struct packet_latency {
-- 
2.50.1

