Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E8295526
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010314; cv=none; b=TFc6svNCKZ5fEgMjqaiXmr7qxtdpUzMiSF6H8GkKdtOzyAJVaagjT8IAtB8dsMoMQVxx4hOhpaaz/0k+QnYAayXUpRbLRuR9B/zuZ7jncIdBYQClPkF9S6bqXoBsh2LKdASrlDMx1itWYUL6y8EVm1RYOd3KRlq8zFItS4uJ7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010314; c=relaxed/simple;
	bh=0zfn4PR/Y5CMobKW+1V/z3/4kbKC0j5legYS79Kj5Uo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hdhg5ePCao/WUHmziXkIbHukXMqCNirJIo8cCsPx+FyyKUQ6wdoUJbiuiXQ+4Q065GW4GSfTDFMISMTlCz4Rv0G/ztzr+hTVyaHEf6Te51SeLqZNjMn1oLXNfna7gTdXzOdKX6p1DAMxp82q8fQJHpkce5ajCZnFmaAg+kIWOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx9UOnzd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx9UOnzd"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c922169051so547681585a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748010311; x=1748615111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTX9XGekTSoAvyl2aY5CMKiQTOBRj8sVZ1WkC7YfVoc=;
        b=Dx9UOnzdipWeRkJDfk4RgJTE7pQ/UKdewTZufGaqKvktYrdoPxNpICzXFfnimq+KeV
         sYavs4+q+XpLVHZIXRL5RxX+kuBOLam0b8pfOZqG7LheE1to7JMba4jMBykmN8QG9sKa
         rAVNgkH4aWZ0fV3jWJKgZr7k+fsc+DxVivMeYVvQ/EipE2d7ncpBngExnXvXS9CWcmQ+
         zKW1Q7HCpb43R0cPrLf3+M4wy7ilyQa6wvSRHAhlCjdkvZ/5huPjQQqZUcwXBeCRyTK/
         j6yVsPtuS+iQKJCXcGpeEQhvqUDdCKncIfMiNiN5AUd1yKDTwc8eG9p0K2AaZcf+snya
         49Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010311; x=1748615111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTX9XGekTSoAvyl2aY5CMKiQTOBRj8sVZ1WkC7YfVoc=;
        b=Nf927KfnGlRKZ2UT9D9HYO/axK1IsgRSpQyd0RLrkIdnLBdeWyr56zLKd1ml3saR/k
         QgpnwrAiQbMEmOTU+uviQfwzOJHT00Nd7L8qQE8IazuTwwJjWBZKj3gXY/jM24MPvv4i
         CHaKdCQc5/EmN0kyAoJL1n/wLl6kEGJ/xP9/zHHoXQPmPaqriWod0wH8xFzW3TO4YEWo
         en8tsXTEhdFhohQIHv+xoMJOGdj5DJNxrc0DTNc+uq4JLide28JSp0nNDEr2abqzhG2d
         IR1up51Nw1MnwEf20BSgcV+Nqo6Qs8dvK2CUe+xS9CmUu4t/8FKMu4KkRoEMfsOdp3X3
         U55A==
X-Gm-Message-State: AOJu0YwAH0OtvEtbgJJmzvWmPBB3ES0iuXjRXv6vyHF0oSZtw2/kd/97
	EJgUOgRW1mnnLkMtJGsWEGqnuFzXuckmzdBsacgUq2sajA0Rs+/jei7QykC6yHZc
X-Gm-Gg: ASbGncv1OfrFHhbDL4XFYvW0y4V1P2hcGJ9bdiCRJIPZNtL4oVDfSfo4GiQ6a8kY167
	I06EhVxX24p0Aq90wRd2YfWdkO79/ucxCml7jXmd0giJbndT5dETeEWAM3DuGj0hnWLyKJGCVCc
	FyfJmGCK5P4fXmoMI44MFXCJhRADg98yEsPiVoTIMefCAdM9XlzvUd78K0Cgz8MHlnHcBibj62h
	QnlSRB1iC1mf3dw+NrB43FjbXB/RtytPFVyLxTX1vhfA8xAFeL6NOiq6dgNXAcSjQqHSn5SLN2n
	2Bp+JY4PAb1kUiGUYIu2k9Lsi2ptueaTj4et5YEUdEBPdlUsMW+EDQuzHU/B4BGx99ovs9x0RSD
	Bpa90aSHAeu3VrhHIc5k+
X-Google-Smtp-Source: AGHT+IEGQGewZAQQOj0iPgnU1lm9ZVAdXLzK0st4wqEZ8Xp0+lIpHX0RNEb1dr43292MKDIqo9mWDg==
X-Received: by 2002:a05:620a:2488:b0:7c5:5670:bd77 with SMTP id af79cd13be357-7cee3280ee3mr485366085a.55.1748010311062;
        Fri, 23 May 2025 07:25:11 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec027524sm12246308241.0.2025.05.23.07.25.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:25:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] client: Add scan.auto-connect command
Date: Fri, 23 May 2025 10:25:04 -0400
Message-ID: <20250523142505.3476436-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523142505.3476436-1-luiz.dentz@gmail.com>
References: <20250523142505.3476436-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[bluetoothctl]> scan.auto-connect --help
Set/Get auto-connect filter
Usage:
	 auto-connect [on/off]
---
 client/main.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 5d53a7be11e4..46687c6dd944 100644
--- a/client/main.c
+++ b/client/main.c
@@ -161,6 +161,7 @@ static struct set_discovery_filter_args {
 	size_t uuids_len;
 	dbus_bool_t duplicate;
 	dbus_bool_t discoverable;
+	dbus_bool_t auto_connect;
 	bool set;
 	bool active;
 	unsigned int timeout;
@@ -1253,9 +1254,14 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 						DBUS_TYPE_BOOLEAN,
 						&args->discoverable);
 
-	if (args->pattern != NULL)
+	if (args->pattern != NULL) {
 		g_dbus_dict_append_entry(&dict, "Pattern", DBUS_TYPE_STRING,
 						&args->pattern);
+		if (args->auto_connect)
+			g_dbus_dict_append_entry(&dict, "AutoConnect",
+						DBUS_TYPE_BOOLEAN,
+						&args->auto_connect);
+	}
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -1492,6 +1498,29 @@ static void cmd_scan_filter_pattern(int argc, char *argv[])
 		set_discovery_filter(false);
 }
 
+static void cmd_scan_filter_auto_connect(int argc, char *argv[])
+{
+	if (argc < 2 || !strlen(argv[1])) {
+		bt_shell_printf("AutoConnect: %s\n",
+				filter.auto_connect ? "on" : "off");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (!strcmp(argv[1], "on"))
+		filter.auto_connect = true;
+	else if (!strcmp(argv[1], "off"))
+		filter.auto_connect = false;
+	else {
+		bt_shell_printf("Invalid option: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter(false);
+}
+
 static void filter_clear_uuids(void)
 {
 	g_strfreev(filter.uuids);
@@ -1531,6 +1560,11 @@ static void filter_clear_pattern(void)
 	filter.pattern = NULL;
 }
 
+static void filter_auto_connect(void)
+{
+	filter.auto_connect = false;
+}
+
 struct clear_entry {
 	const char *name;
 	void (*clear) (void);
@@ -1544,6 +1578,7 @@ static const struct clear_entry filter_clear[] = {
 	{ "duplicate-data", filter_clear_duplicate },
 	{ "discoverable", filter_clear_discoverable },
 	{ "pattern", filter_clear_pattern },
+	{ "auto-connect", filter_auto_connect },
 	{}
 };
 
@@ -3219,6 +3254,9 @@ static const struct bt_shell_menu scan_menu = {
 	{ "pattern", "[value]", cmd_scan_filter_pattern,
 				"Set/Get pattern filter",
 				NULL },
+	{ "auto-connect", "[on/off]", cmd_scan_filter_auto_connect,
+				"Set/Get auto-connect filter",
+				NULL },
 	{ "clear",
 	"[uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]",
 				cmd_scan_filter_clear,
-- 
2.49.0

