Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF082EC55D
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784245; cv=none; b=MeYEgXw4AaiLIRoB6fspW4bKs5OzxpgDtlkYmW663BYKwnRXkiRiA/O9ofTmVtgmy20IB1Twe/kgHo0jdw4wEUindztaaSMAb3MH9AnZGdxiM3Lt58NhwlFw3CEGa0D5OMvj9nXjFbVpiAimwm0wPdQenoS1yVMFOd74c2L6p0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784245; c=relaxed/simple;
	bh=JvrMDRl7CnA0+NKgLvzuiGlgOvvpo1Omgm2KxhAVvqM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nwTIpaGHmsqRAnO2fEy0Su46SYfHTd3V/hWIFiDTca8HNxHVujRi/PhguCYUZbryZec0a8VwbJl6ZhwzUSKdeQmkAhXdJgE8zCgqWxxpuZULcd/3Nu3CYWjaizFVvLpkNcqQhcPHi9giCIlEOwFrBV7axFrOpc26o5RXyiY7l2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiXMnBea; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiXMnBea"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-890190f424dso214067241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755784242; x=1756389042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9lPR17e0VcLXWIPNTDHOR/mQELY7loobOtD8zzEWMU=;
        b=FiXMnBeaw+glV7qK6S8e7YDAfEBl2WT+FklB+F7MeBIFbHacx/R2n12r6/rdD3ZcOj
         d0SV4WmD6peWH4X8lnKkIWHpflqQJIebVgmpM030JMaVVyshgk5Pro+urknuidaHHkgr
         bpgfYFuDkrdLjKTRtSyARfZMkcfJugMbGRNiHv5hkl9YgtQskazSLU/X+7qe44n3HGs4
         FJux2Q83eSonNAyzkKAMxXav3WwXQbxIah46ET8Wc7oq+Vh9NkbSyEVPBoEh8Zq0LhsV
         BlODgcoBcTihjwUEq15Jn9mo55FPYnJg2lYMV1cyn8ky8LiiowIPZZMJY7CTGDZWh2Ud
         Ibjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784242; x=1756389042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9lPR17e0VcLXWIPNTDHOR/mQELY7loobOtD8zzEWMU=;
        b=DbYw5b1Z4OOP+aY35wC861Vn9hsC090wQZhbjMRowZk1cjPrxHGrge3DaHoK66e+Lg
         j/WO0N5/74AzKnOEcbu248rV9NpxYCLIF9ZqEhoaMzBTtzCLEVCJzCGBJjjOKJ0BxuUt
         zXNy5Wikxsdqaff7jkrol2KiLRmLO0aTM0SrBjpHg4Ou0cb0kyvprwapKwbPwAhgYSUk
         GvwbQAtVsnMfVZRpDxKyqh2kBSY8qi2u8BkdO6c2uCxdoFBQq7Mbsztm4ZZ3f8YMJ6D8
         wkeSr91aOz5kSd+HnGM+heuj0ly4A0FRqpnIW7zZzqO+tEM6S0pkvWz+HVCLfIX3KiDM
         2lSA==
X-Gm-Message-State: AOJu0YwrfBG+01k09ADhwnjERaA6VfImqg+9GXO0YNS12qPY2fFGpOHK
	+W4Tlqonou4dMX3AJxH2O9CeS+rLS6xmEjvFfVP6tXmigZm1A86cQxcSaHbiaZNr
X-Gm-Gg: ASbGncsxFVqKwvL/26HuLWPwSbK9hYc6nmaARVP6nc+xQw5Bzuu2K7kjXjYEWLcpuE6
	4wySvp/UtuihgYusE1LqAHiA0sV3ih/bEJifDEJba1M56sohT62JKB3vzcZsr5x0cSuA6mc3wtl
	5fw2ik6T3RUnFjdpiVg6UHcSQXXI/yY9jkUwxBu3ENIFl41+W5bff/oUMmeHeXgCsEFCSV6dmvz
	AxAcAfGGumsV/VvLB58QX2hx+umtDBZNph2o5GhuJKhFWS5b2g0A29Ot1idGc5+slAbENUgd7xp
	aDUQu+FRugN1GoUn4wLZC6JzmITeUOo1TTjAL47EP5T4o7tYyYGF5gxDZaS0o+MercsUJAZq+/Y
	h15TZdS6O569/JH1jXqiplgFSl1Uit1LzhSoJOLWIn1+JTcaRnUY9cUfjC0wTqC7x0FCOYBdC2x
	s=
X-Google-Smtp-Source: AGHT+IHXucr4Be7U02ILtGxnP1kJFAbtZyy0zB0sGeCSC6SvN3B5LU9ScMZMfj7pBKCosYGepJmvjQ==
X-Received: by 2002:a05:6102:6ce:b0:4e5:980a:d164 with SMTP id ada2fe7eead31-51bdbd73630mr724423137.0.1755784242280;
        Thu, 21 Aug 2025 06:50:42 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5127f80b512sm4006455137.16.2025.08.21.06.50.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:50:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] monitor: Add support for -K/--kernel
Date: Thu, 21 Aug 2025 09:50:31 -0400
Message-ID: <20250821135031.2033789-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for -K/--kernel that open /proc/kmsg and attempts
to print messages starting with 'Kernel:':

> monitor/btmon -K
= Note: Kernel: BNEP (Ethernet Emulation) ver 1.3
= Note: Kernel: BNEP filters: protocol multicast
= Note: Kernel: BNEP socket layer initialized
= Note: Kernel: MGMT ver 1.23
= Note: Kernel: RFCOMM TTY layer initialized
= Note: Kernel: RFCOMM socket layer initialized
= Note: Kernel: RFCOMM ver 1.11
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

