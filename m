Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9118E20
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420838; cv=none; b=Nihe+hdAuvfV3QXF9eqI68YTQ9y2oiZccugyBGXGve6ytOTF4EImmbULZ5wh+35WUCrdbXi1ohyLc3hHTEWe5RUeGfhYCG3oNcX4BwYqLHoA+/QJ/rds1d3lOIFFMAIf1E7SlO1Qc06Ti0uD/1JtaJ65JX+b9VcSGIP87zW44YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420838; c=relaxed/simple;
	bh=0VycfRxjzpsUKbRxcXrS/f59L0pTBiZoS/c5FsU/MeU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CyhOuyGTsmC/D5hza2ii7Ik+/LPQcJ3HkPeb/dW9ZoMkzQaPQIfrn6q+nNCeb6uk4aZvhI8GLz7+25V+5y2eyQTIQxMcs9SjtQPO6Hn8UsxzvXwJROElaCadGgRR3jUbTzGyRvc0yEopvgJIQT3xexrudbHwcru8shqIpLMipxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftnUAlMM; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftnUAlMM"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d41547dc1dso446842e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710420834; x=1711025634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BFiBlcMDCZLtjf4LGfypHiPzExz4Vqh036TGMbgQ1Y=;
        b=ftnUAlMMKhn8q30AIrp1M4pnKRE5wBPNNGFHuC5rm9LwCvQPxyEuN5LGaVs3NyGiYM
         gVSn84RrD10sSSncFUCaYocFy0o2bTN4e5Uz7qRk9Gyyy/AAZLOGBEapOR9c6PskkK+P
         D0OKJSWiaANP6l6OKfekg41fXWrWuID4dbJIs3WA37wn6Mv9LW5cjk+Zj5mD0QTg7Pcv
         Frln33XbYBK2RL/uAq7qGaw43v0IWkIqfN4qpxLaT8H8PsybrKEd2lpcjCzr+ljPvogz
         bfnxhAfQS6qyYCGDDf6QxBtKPBIKa9EBaAQ1dkvKXALxVLTfX3oCx3yyK9ytCU+cutrs
         slJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710420834; x=1711025634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BFiBlcMDCZLtjf4LGfypHiPzExz4Vqh036TGMbgQ1Y=;
        b=ihWapEWeiIRk0YCDaQS+n8CxF1DYQOu3wXKSgCF3IrUyO6eaRe37thoF0PvpFoD+4A
         CFpFLfLdpUrX6PleUsTu5pVNX7H8hXt2/0iT/m9BINbFV+4wZksUkrrfBzVCSnDuHQnz
         mjYyHLLLBQTIdzyhYKNBL1JbhLFsqiE8N9dKPzfCmawnF+b5DH1C555Mt48sgFceeWif
         vLug0pX3wjlt6NyGHTyAZXmPdvwCjlc1wHJqifhAz3KM21r3WPi3RqDOt88ZN2mkPe8Y
         R3AdZPa7rWb8R6txEr1a3SotR4JL+GRQgTBa2SOyTSHIjV4V+Lr6zlkVDkTqcvDXwfgO
         /cMA==
X-Gm-Message-State: AOJu0YyJrNIVqityA/9tvqN5XypYUJNSsdxRMJFzlSP+zWBXzANKky3+
	xbGTjcJCnl0DkAAemDNSkrQDHAfSIqmRndgTJxqE0Y87d9vfLMP0PnzzTwbe
X-Google-Smtp-Source: AGHT+IGcyH3xIJ64urGoaJhfnNkMIe8P/XiKt9bJs/HougY134fLTTY8KBVfhpOa0QK3suI8mbq2BA==
X-Received: by 2002:a05:6122:98b:b0:4cb:56c5:580e with SMTP id g11-20020a056122098b00b004cb56c5580emr2130372vkd.11.1710420834292;
        Thu, 14 Mar 2024 05:53:54 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id y127-20020a1f7d85000000b004d41ded4a4asm74796vkc.15.2024.03.14.05.53.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:53:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] input/device: Force UHID_DESTROY on error
Date: Thu, 14 Mar 2024 08:53:52 -0400
Message-ID: <20240314125352.15243-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If we cannot sent a message back to the device destroy the UHID device
since it is likely that the driver is trying to reach the remote device
which is no longer connected.

Fixes: https://github.com/bluez/bluez/issues/777
---
 profiles/input/device.c | 65 +++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index c4f75c7442e8..1b28cdc174b1 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -105,7 +105,6 @@ bool input_get_classic_bonded_only(void)
 
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
-static int uhid_disconnect(struct input_device *idev);
 
 static bool input_device_bonded(struct input_device *idev)
 {
@@ -314,6 +313,28 @@ static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
 	return true;
 }
 
+static int uhid_disconnect(struct input_device *idev, bool force)
+{
+	int err;
+
+	if (!bt_uhid_created(idev->uhid))
+		return 0;
+
+	/* Only destroy the node if virtual cable unplug flag has been set */
+	if (!idev->virtual_cable_unplug && !force)
+		return 0;
+
+	bt_uhid_unregister_all(idev->uhid);
+
+	err = bt_uhid_destroy(idev->uhid);
+	if (err < 0) {
+		error("bt_uhid_destroy: %s", strerror(-err));
+		return err;
+	}
+
+	return err;
+}
+
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
@@ -356,8 +377,7 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 		virtual_cable_unplug(idev);
 
 	/* If connection abruptly ended, uhid might be not yet disconnected */
-	if (bt_uhid_created(idev->uhid))
-		uhid_disconnect(idev);
+	uhid_disconnect(idev, false);
 
 	return FALSE;
 }
@@ -610,11 +630,14 @@ static void hidp_send_output(struct uhid_event *ev, void *user_data)
 {
 	struct input_device *idev = user_data;
 	uint8_t hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUTPUT;
+	bool sent;
 
 	DBG("");
 
-	hidp_send_intr_message(idev, hdr, ev->u.output.data,
+	sent = hidp_send_intr_message(idev, hdr, ev->u.output.data,
 						ev->u.output.size);
+	if (!sent)
+		uhid_disconnect(idev, true);
 }
 
 static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
@@ -654,8 +677,11 @@ static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
 			timeout_add_seconds(REPORT_REQ_TIMEOUT,
 					hidp_report_req_timeout, idev, NULL);
 		idev->report_rsp_id = ev->u.set_report.id;
-	} else
+	} else {
 		uhid_send_set_report_reply(idev, ev->u.set_report.id, EIO);
+		/* Force UHID_DESTROY on error */
+		uhid_disconnect(idev, true);
+	}
 }
 
 static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
@@ -698,9 +724,12 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
 						hidp_report_req_timeout, idev,
 						NULL);
 		idev->report_rsp_id = ev->u.get_report.id;
-	} else
+	} else {
 		uhid_send_get_report_reply(idev, NULL, 0, ev->u.get_report.id,
 									EIO);
+		/* Force UHID_DESTROY on error */
+		uhid_disconnect(idev, true);
+	}
 }
 
 static void epox_endian_quirk(unsigned char *data, int size)
@@ -934,28 +963,6 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 	return err;
 }
 
-static int uhid_disconnect(struct input_device *idev)
-{
-	int err;
-
-	if (!bt_uhid_created(idev->uhid))
-		return 0;
-
-	/* Only destroy the node if virtual cable unplug flag has been set */
-	if (!idev->virtual_cable_unplug)
-		return 0;
-
-	bt_uhid_unregister_all(idev->uhid);
-
-	err = bt_uhid_destroy(idev->uhid);
-	if (err < 0) {
-		error("bt_uhid_destroy: %s", strerror(-err));
-		return err;
-	}
-
-	return err;
-}
-
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
@@ -1087,7 +1094,7 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 		idev->virtual_cable_unplug = true;
 
 	if (idev->uhid)
-		return uhid_disconnect(idev);
+		return uhid_disconnect(idev, false);
 	else
 		return ioctl_disconnect(idev, flags);
 }
-- 
2.44.0

