Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3A1862
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027149; cv=none; b=YDKVoclBZpCuFnY00dcYSrc5IjPXX5fyIwnepad2czENErnUqxsOV2Qi9MoY2kzZekvuTyFpV/oX0384qVyswM7DyM9vNkVLkTbtte+rvF3y34Cslg7tdWgUy8kU4t66WvN1LT4mK32ag32WUjTqZ7A6W28yMEGo5bvTOKkkvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027149; c=relaxed/simple;
	bh=faK6XWq8mtyX5B6ULPT7a+PZyqj05h2pVIOwz15J7RE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=bDP95ZTjE7Y2Yxq3gkxhzMlsUIzuYfgQHfVzHvGKV3T+z6kmEBkpOzjXfqiLWCKlcjWF0ZFRh3A6rpDS0zjeXbrfydrR2iuk+SvclRnnk+DW8uHPIQFFyEOMrhBhwH1HcLGloMfQWs8YXZLgee3v9J626+ZEOEra4oqv9VnW4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnvjxS7U; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnvjxS7U"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e6b738acd5so577966a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728027147; x=1728631947; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRx3IC4NYZcXkgJI8J3F4oa+SBfBLkFGe9LUx01FzGc=;
        b=WnvjxS7URaRZ5VNo1bJ+qT9CgeImbNH5JA6xEEypYxpsAd2mYrt40Iek8W9UWZG7Ig
         nXpVvVCCVvLISjdRg2uEw6lL0Z3OGHKI6OV+vdIZVYopIb/qzEBNWp2KJ30URRmnH8xv
         Kvr1Zl9GwKDXe1P2mnDtrRlS9anHtEEdjelwc2WklIiZ3dQP/cufffybUWRLrxagcbkG
         iAkdRpgOgSo31Bp/r+LkNpQvfmCqktJJ2s4ii4LnUk7D65KwLzJirG12UcDy9GL1IgCK
         //32lu3clNYmQ4flr0XBqGNDjeqpyWvuZkfxcjOy7VMsdrLfee5xZcFIxGJ+NtxKRq4B
         NI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728027147; x=1728631947;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRx3IC4NYZcXkgJI8J3F4oa+SBfBLkFGe9LUx01FzGc=;
        b=be+UTi0B5+XE7/3zW7zbyserf1K2nZgg40guoGYXB7RS1Jj+RQkbqyVmopd/Oq3HWc
         apcOfSX7KaFnvHCsJLekjkDTb5Y03lMvrCwakoJVUiwnv9I3ebjzPbgShCkKAKdx5QNC
         HbKB56DVpbJR1iqOAmm0WmySZzRZ1uokvHCY2/An+p2/dCGC28TGDpifcyf/pNulXqT6
         20O5GB03W3ku5N4zl0ip/qo19vm0rb15kq8PCfGuYLyGDygmqzIcqLcv5cGIbUR34si7
         cB8i1ATm6olhDO/IELNi+K4iC7dp7Id69j5Z5uwcJXDrEAlsemGIp+q/aO31kpY61tac
         jYAQ==
X-Gm-Message-State: AOJu0YxCLxdkZnpyN5LnfdmiNnVF7XVXJEzGjBiHAnTR0/v/zUOQDR+M
	wUsyQnA9QVcfoQWaruGZn/VljgryIBAyNkBDMYO4kBlPoXxbeKur3L1E3w==
X-Google-Smtp-Source: AGHT+IGX7kAXD4ZDSA2YkqNKVDpEBmLwT1DlADiP/KiIoIo7Q4H3FEtV4aGU5XpmMmqaNIgRY4hVmQ==
X-Received: by 2002:a05:6a20:9f07:b0:1d2:eaca:4fa8 with SMTP id adf61e73a8af0-1d6dfabace8mr3496466637.35.1728027146531;
        Fri, 04 Oct 2024 00:32:26 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e47fsm2583317b3a.61.2024.10.04.00.32.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:32:26 -0700 (PDT)
Message-ID: <66ff9a0a.a70a0220.30ffa9.b64a@mx.google.com>
X-Google-Original-Message-ID: <Zv+aBy9pdCDK5JjT@JUNHO-NEOSTACK.>
Date: Fri, 4 Oct 2024 16:32:23 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] mesh: Add mesh conf for SAR Transmitter and
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

