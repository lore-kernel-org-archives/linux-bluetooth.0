Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C00231C9A
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883361; cv=none; b=uicmfQcfHOM/2epIDGlq7gY93fXA4L/iEkwdNEpEIw+ocCGncKjf/oIx0VR/2dyiiM2FnzhU+w4+5wO+SWlhs9BvwlJ1JfWYsxwZ34J0KE8lsVc3GJUndEIjW5QQxGkJ6PBeUYPCF6S+sAp/1S5fWIGUtAU4YxjILAtRuDwsyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883361; c=relaxed/simple;
	bh=faK6XWq8mtyX5B6ULPT7a+PZyqj05h2pVIOwz15J7RE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=FOep5DVb9iJQ+N91oMABQ1mSE25dKRUa8//jZg7i4w/4lVMnYYtHu872IRwnoe4gVyxJcT8fKe8ViVnJNay3An5szXR6Fd3Q47a50j6WNATgkogRLr7d/9keQSWlq1kfWaG1KHwaBKr6MLnfweoljoRZEBy7gcTxWiwRYHAG1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJwvo/xa; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJwvo/xa"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7170d0edab6so1878825a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 22:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728883359; x=1729488159; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRx3IC4NYZcXkgJI8J3F4oa+SBfBLkFGe9LUx01FzGc=;
        b=EJwvo/xa2BEm89hvltLY1ohqk+GTbTTFCag5AHCyQx/EjHLWdnt1c3xAb+h5wDs/TQ
         BwIhFI6vMlBl5qdp77FNBk27xcFrDfhRZ5wKNDqSLLQP3brcrlsOsHr3nmc/D1wB08sa
         0UjRCXHNDMmaRq2jwQAXMM/+7ioFsEMrhLPr49CPR3GKZgikqhiYyxSaaUYqVmn2tFPN
         9I1t3KhAFChnlDuKA6g0O6/xO2HQAKiMXD6kJv4ImRziR9bnkWPE81XkQg3tlbmXxgkI
         JICLkcby7m1JT52oj1vNtrCP/I3DvkQf8BNS1TJzF7io8NFQWDTIYOxAhJRAzZxCtYND
         Dsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728883359; x=1729488159;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRx3IC4NYZcXkgJI8J3F4oa+SBfBLkFGe9LUx01FzGc=;
        b=JapyOAyuS9aFL3dzLz4oTWF4rp8K6JF2NgRGcjKo08oYfm4sjxUgRPw1hS1IR4Lt6F
         /pkzFGB+7+aD55gmz5pVran7gc81ZJHLJQjtvHzIDNHK0xBOEfDHC/jqaMk0M6npi4We
         jnpT5z6xb9xXBCS7z7TffaluICvgkKtyBG/pVFLpW0+HJrIcCVoUaJTBJj+PDUstmQMd
         VUVn+RGVa71/9MT/9c1cTIe7Blk3qQ62dta5OlxPnzjkUssNduBXurIpDZ9rzq2sAFrd
         92bSmvL8UEElr9JXpxNyuagemFRUdtERlIq2odYPcESnGSRZ9UuwQaFYOBFo9lAg8119
         t77w==
X-Gm-Message-State: AOJu0YwDDC4n1371Fd+HQv0lg+2nEaOn6VRE4vu3SvaSlOdOzxM3aBu2
	qpi6EXQ6VOAGw12vNQRe25A+OhnOByQKTLDB+1vBwRJ5ZfcgxHsq+sAJjw==
X-Google-Smtp-Source: AGHT+IGV8ukpe4nxWiL7WIMGbWs7d4asRCQBB+XSFCUVWtyTPjZdqedzGt+g8+AoWWcOKlaHpOJ7sQ==
X-Received: by 2002:a05:6359:4c9b:b0:1ba:5118:ebee with SMTP id e5c5f4694b2df-1c32ba41305mr271471155d.8.1728883358808;
        Sun, 13 Oct 2024 22:22:38 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e56e0d9f9sm2921660b3a.79.2024.10.13.22.22.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 22:22:38 -0700 (PDT)
Message-ID: <670caa9e.050a0220.1d90eb.58b8@mx.google.com>
X-Google-Original-Message-ID: <ZwyqnEBU6RWNvCdn@JUNHO-NEOSTACK.>
Date: Mon, 14 Oct 2024 14:22:36 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] mesh: Add mesh conf for SAR Transmitter and
 Receiver
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This allows you to set the SAR Transitter state and SAR Receiver state
in the mesh conf file.
---
 mesh/mesh-main.conf | 107 ++++++++++++++++++++++++++++++++++++++++++++
 mesh/mesh.c         |  80 ++++++++++++++++++++++++++++++---
 2 files changed, 181 insertions(+), 6 deletions(-)

diff --git a/mesh/mesh-main.conf b/mesh/mesh-main.conf
index aca9e6fa5..01f4c3d23 100644
--- a/mesh/mesh-main.conf
+++ b/mesh/mesh-main.conf
@@ -41,3 +41,110 @@
 # Setting this value to zero means there's no timeout.
 # Defaults to 60.
 #ProvTimeout = 60
+
+
+[SARTransmitter]
+
+# Transmission interval step between segments of a message.
+# Interval is measured in milliseconds and calculated using the following
+# formula:
+#
+#   (SegIntervalStep + 1) * 10 ms.
+#
+# Valid range 0-15.
+# Defaults to 5.
+#SegIntervalStep = 5
+
+# Maximum number of retransmissions of segments to a unicast destination.
+# Valid range 0-15.
+# Defaults to 2.
+#UnicastRetransCount = 2
+
+# Maximum number of retransmissions of segments to a unicast destination when no
+# acknowledgment is newly received during the retransmission interval.
+# This value sould be set to greater than AckRetransCount on a peer node.
+# Valid range 0-15.
+# Defaults to 2.
+#UnicastRetransWithoutProgressCount = 2
+
+# Retransmission interval step between segments of a meesage to a unicast
+# destination.
+# Interval is measured in milliseconds and calculated using the following
+# formula:
+#
+#   (UnicastRetransIntervalStep + 1) * 25 ms
+#
+# Valid range 0-15.
+# Defaults to 7.
+#UnicastRetransIntervalStep = 7
+
+# Interval step between segments of a message to a unicast destination that
+# increases proportionally to (ttl - 1) when ttl is over 0.
+# Increment is measured in milliseconds and calculated using the following
+# formula:
+#
+#   (UnicastRetransIntervalIncrement + 1) * 25 ms
+#
+# Valid range 0-15.
+# Defaults to 1.
+#UnicastRetransIntervalIncrement = 1
+
+# Maximum number of retransmissions of segments to a multicast destination.
+# Valid range 0-15.
+# Defaults to 2.
+#MulticastRetransCount = 2
+
+# Retransmission interval step between segments of a meesage to a multicast
+# destination.
+# Interval is measured in milliseconds and calculated using the following
+# formula:
+#
+#   (MulticastRetransIntervalStep + 1) * 25 ms
+#
+# Valid range 0-15.
+# Defaults to 8.
+#MulticastRetransIntervalStep = 8
+
+[SARReceiver]
+
+# Threshold number of segments in a message to retransmit acknowledgment
+# messages. If the number of segments in a message exceeds SegmentsThreshold,
+# retransmit the Acknowledgment message by AckRetransCount.
+# Valid range 0-31.
+# Defaults to 3
+#SegmentsThreshold = 3
+
+# Interval increment between acknowledgment messages.
+# Increment is measured in segments and calculated using the following formula:
+#
+#   AckDelayIncrement + 1.5
+#
+# Valid range 0-7
+# Defaults to 1
+#AckDelayIncrement = 1
+
+# Maximum number of retransmissions of acknowledgment messages.
+# Valid range 0-3
+# Defaults to 0
+#AckRetransCount = 0
+
+# Timeout to discard a segmented message when no more new segments of the
+# message are coming in.
+# Timeout is measured in seconds and calculated using the following formula:
+#
+#   (DiscardTimeout + 1) * 5 sec
+#
+# Valid range 0-15
+# Defaults to 1
+#DiscardTimeout = 1
+
+# Interval between received segments of a message. This is used to control rate
+# of transmission of acknowledgment messages.
+# Increment is measured in milliseconds and calculated using the following
+# formula:
+#
+#   (ReceiverSegIntervalStep + 1) * 10 ms
+#
+# Valid range 0-15
+# Defaults to 5
+#ReceiverSegIntervalStep = 5
diff --git a/mesh/mesh.c b/mesh/mesh.c
index f89230b6c..17236c110 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -248,16 +248,11 @@ void mesh_get_sar_receiver(void *sar_rxr)
 	memcpy(sar_rxr, &mesh_sar_rxr, sizeof(struct mesh_sar_receiver));
 }
 
-static void parse_settings(const char *mesh_conf_fname)
+static void parse_mesh_general(const struct l_settings *settings)
 {
-	struct l_settings *settings;
 	char *str;
 	uint32_t value;
 
-	settings = l_settings_new();
-	if (!l_settings_load_from_file(settings, mesh_conf_fname))
-		goto done;
-
 	str = l_settings_get_string(settings, "General", "Beacon");
 	if (str) {
 		if (!strcasecmp(str, "true"))
@@ -290,6 +285,79 @@ static void parse_settings(const char *mesh_conf_fname)
 	if (l_settings_get_uint(settings, "General", "ProvTimeout", &value))
 		mesh.prov_timeout = value;
 
+}
+
+static void parse_mesh_sar(const struct l_settings *settings)
+{
+	uint32_t value;
+
+	if (l_settings_get_uint(settings, "SARTransmitter", "SegIntervalStep",
+							&value) && value <= 15)
+		mesh_sar_txr.seg_int_step = value;
+
+	if (l_settings_get_uint(settings, "SARTransmitter",
+							"UnicastRetransCount",
+							&value) && value <= 15)
+		mesh_sar_txr.unicast_rtx_cnt = value;
+
+	if (l_settings_get_uint(settings, "SARTransmitter",
+					"UnicastRetransWithoutProgressCount",
+							&value) && value <= 15)
+		mesh_sar_txr.unicast_rtx_without_prog_cnt = value;
+
+	if (l_settings_get_uint(settings, "SARTransmitter",
+						"UnicastRetransIntervalStep",
+							&value) && value <= 15)
+		mesh_sar_txr.unicast_rtx_int_step = value;
+
+	if (l_settings_get_uint(settings, "SARTransmitter",
+					"UnicastRetransIntervalIncrement",
+							&value) && value <= 15)
+		mesh_sar_txr.unicast_rtx_int_inc = value;
+
+	if (l_settings_get_uint(settings, "SARTransmitter",
+							"MulticastRetransCount",
+							&value) && value <= 15)
+		mesh_sar_txr.multicast_rtx_cnt = value;
+
+	if (l_settings_get_uint(settings, "SARTransmitter",
+						"MulticastRetransIntervalStep",
+							&value) && value <= 15)
+		mesh_sar_txr.multicast_rtx_int_step = value;
+
+	if (l_settings_get_uint(settings, "SARReceiver", "SegmentsThreshold",
+							&value) && value <= 31)
+		mesh_sar_rxr.seg_threshold = value;
+
+	if (l_settings_get_uint(settings, "SARReceiver", "AckDelayIncrement",
+							&value) && value <= 7)
+		mesh_sar_rxr.ack_delay_inc = value;
+
+	if (l_settings_get_uint(settings, "SARReceiver", "AckRetransCount",
+							&value) && value <= 3)
+		mesh_sar_rxr.ack_rtx_cnt = value;
+
+	if (l_settings_get_uint(settings, "SARReceiver", "DiscardTimeout",
+							&value) && value <= 15)
+		mesh_sar_rxr.discard_timeout = value;
+
+	if (l_settings_get_uint(settings, "SARReceiver",
+						"ReceiverSegIntervalStep",
+							&value) && value <= 15)
+		mesh_sar_rxr.receiver_seg_int_step = value;
+}
+
+static void parse_settings(const char *mesh_conf_fname)
+{
+	struct l_settings *settings;
+
+	settings = l_settings_new();
+	if (!l_settings_load_from_file(settings, mesh_conf_fname))
+		goto done;
+
+	parse_mesh_general(settings);
+	parse_mesh_sar(settings);
+
 done:
 	l_settings_free(settings);
 }
-- 
2.34.1

