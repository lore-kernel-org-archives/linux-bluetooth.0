Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E161384BF
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892478; cv=none; b=jos04GA8Pzb3kwOKJB06cqu0pXdgH7HGIeEXI6whhCjzPn2f/rmf6jnvhhyEMKX1z7p3wYk4awN77VZDyo+jEAKoRhAxvVcBxiFYH+gS3focUsM0eVieu0EU/hQrpmJYYqsHYolhpNjkFiXvWvahUNL7P5qu6ZLjs1Fo7065o6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892478; c=relaxed/simple;
	bh=faK6XWq8mtyX5B6ULPT7a+PZyqj05h2pVIOwz15J7RE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=D1cngT49ueQNvZoCbI/fKCHGsQM3F9qPdLqAAZqy1vE7RwPgEEXe0vR8mlmkHG2N4baf6+NySaAHLD1fm7MtGydpQx5dp1OiuR1KRx5h5rsuvsdRxN8M6QerJqrJhEMpeoiHb6x2z3cm9fF2nDLjL19TZ6457uAaI2I6SdauUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE3k/doj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE3k/doj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ceb8bd22fso4961015ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728892476; x=1729497276; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRx3IC4NYZcXkgJI8J3F4oa+SBfBLkFGe9LUx01FzGc=;
        b=PE3k/dojAiycHoFGu25yzHcqrZeVKxsyhADmDf4i3srK7wDRoIm00wr2ys85cOcBU6
         dHOK1PDncTj2ggwG2yg/wRxJu4h3aE1gJFlP2+IoWNVwruv2KpudrtcMcoKPqx00Lvvl
         F9B+Um0HxCaWtpfur39fuIJdA9Ijy4RUTK/H8tyTl3yuJlRuIcc+MI0lhpenqDwUXrE7
         3+/qUewK8SximV92r0IB+dhn7Tk9y44AU93F0wi0p9vWY5seDz2BRIIASuaMgYxny7+g
         9nGfvXPUp9bU3kLQEYgaWUJHUH7wnIX/Rtf9mGbh3VOi9/jQYlAVWmNvjsVIJm1oLaAx
         ewwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892476; x=1729497276;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRx3IC4NYZcXkgJI8J3F4oa+SBfBLkFGe9LUx01FzGc=;
        b=my0KVtajHmF+JJBqQok7mI08bXOCCh/Dw8d5j5PD1zbKUMLxK9lDb3vgy7WSV52t1c
         YbMfOKf5X8GxfqlaaMXKwBRPiodPJTxY1ATyNoxCw7bNBwXSBqGMXB3UkZANW4SMW+nc
         5eohUlk7oMfU63FDuSF4NJfo1c94stwLmC+LFXPjRaz05HHQ2whvQ2v0upvJNyd+yobx
         kMnJ8R9Htnr9hDdWlavntmctIRKceDy8DH1c+NDa2XLf96t5j9I9IDlFmkr+FTNC5XTD
         zGZTRyhs4okRpeBVbW5NIo3rvqV5FO9R+y6JQ8DIJSVRKzekCMT7ir07asn2c7KAhezK
         3SxQ==
X-Gm-Message-State: AOJu0YyYCSbj2x0+N29SW6W7yITfiLOTqEUliWZesz2vX9kq/NfT6N6a
	lY3vLNk10gBj9YQBy8tD+R8kvDbm5y4nimqQBK0lT3OKKz/aWrsInwmh1w==
X-Google-Smtp-Source: AGHT+IHeQOr9DTw/BiLC5AieNL2LS9ObZ76MOvxV6GS8dRbNzS6ltjRNElpAje878PhfjHxfnYjhBA==
X-Received: by 2002:a17:903:22d1:b0:20c:79f1:fee9 with SMTP id d9443c01a7336-20cbb183470mr141789125ad.11.1728892475542;
        Mon, 14 Oct 2024 00:54:35 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496735dsm6333796a12.84.2024.10.14.00.54.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:54:35 -0700 (PDT)
Message-ID: <670cce3b.630a0220.81d6b.2ce4@mx.google.com>
X-Google-Original-Message-ID: <ZwzOOJrogzxMU2Hj@JUNHO-NEOSTACK.>
Date: Mon, 14 Oct 2024 16:54:32 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/4] mesh: Add mesh conf for SAR Transmitter and
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

