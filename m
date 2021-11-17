Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D86DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1FB61BB6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhKQTSD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhKQTSC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:18:02 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBCC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id bf17-20020a17090b0b1100b001a634dbd737so3610214pjb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VrXRhTozwaNZW5A6W1CImE5Asu5J3ezcqXz+ALKAH50=;
        b=YXHLvZrghlfDgXvwQ3urfQglCs2TLNuX/5oztqH9wuufiLGx0XhfL5WGbph2DMip8o
         2hW2XBZxasIlA87qxrc5xNJ7yL9HUbv/qrVmabz7Tf2VNYBtvFxQ17c/ckcn8ED2E3kH
         n829FJ45jjBWrVZyAGEjuC/EC8lIyfPZIUfuMyiGQ5S2mRPA9L2r90yju+VWuphdLBY0
         ga07eJMvUzG0VuPAPzaaWwQRR13j3ZZYaxRauzwSx23kb/roDTmd2/WO0OBjc2/TDGF9
         3DlvSwjV/Uf9E57WoLtdQjU+KmPMqCLkuGGm+FyjjEWjdaNTbck0W27nazjKkSCkYFsA
         ofJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VrXRhTozwaNZW5A6W1CImE5Asu5J3ezcqXz+ALKAH50=;
        b=Btjn3+AA9fz703MDMuTkb6b9/aTw8wWNrbxR9UpbFDc4470C5vxqrT/vpMpHvlCpKl
         TrSEgEcst/5XQ+bLhdbVqXH8yNyJ70PaKgKuBq9gx23tEPQnvy9vp9MB/2qJr/5aiEMh
         i0e3VuoEAuu4FoDYt8SMRN+UXJz5a2e+p2h9E703JqxzdXWO7LjxhAu+37znOllBlXK2
         nSdAIoEcvMTZ8Dr4yrGtay+F67pqO7zRjhdzkqRP3c8bnQs8EyR/Tow/WIGeEELBio5M
         LOnDfWpp41fUUitOLsHKZNZ1O1meUWcZodOLgDM3fJnWZfLpOPbPylmQtPjc0xelYTYo
         vi9w==
X-Gm-Message-State: AOAM532P1javavZYc7cjcyJBG4okePJ8d2OyvSIucZZLNQRDlk/Gs92r
        PajGkqNXfWYSFVYSZIhF7cU/L3UW1KQ8/Q==
X-Google-Smtp-Source: ABdhPJxsR439g3s9f8qCGSQqfqXCwlzcVIhyGVo6+PZLtZ/prb5Fb6mp3i3sWbXAMrP8DEwgXV9fJQgcU+h3mg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:b1b3:555c:d0fb:8921])
 (user=mmandlik job=sendgmr) by 2002:a17:902:7797:b0:143:88c3:7ff1 with SMTP
 id o23-20020a170902779700b0014388c37ff1mr57582250pll.22.1637176503549; Wed,
 17 Nov 2021 11:15:03 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:14:45 -0800
Message-Id: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [BlueZ PATCH v5 1/6] doc: Introduce the Adv Monitor Device Found/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces two new MGMT events
MGMT_EV_ADV_MONITOR_DEVICE_FOUND and MGMT_EV_ADV_MONITOR_DEVICE_LOST to
indicate that the controller has started/stopped tracking a particular
device matching one of the already added Advertisement Monitor.

If the controller offloading support is not available,
MGMT_EV_ADV_MONITOR_DEVICE_FOUND event is also used to report all
advertisements to perform software based filtering whenever we are not
active scanning.

Reviewed-by: Miao-chen Chou <mcchou@google.com>
---
Hello Bt-Maintainers,

Bluetooth Advertisement Monitor API was introduced to support background
scanning and proximity detection based on the application specified RSSI
thresholds and content filters on LE advertisement packets.

To optimize the power consumption, the API offloads the content
filtering and RSSI tracking to the controller if the controller
offloading support is available. However, this monitoring is not
completely offloaded as the bluetoothd also handles RSSI thresholds and
timeouts in order to fulfill high/low thresholds/timeouts filtering with
D-bus clients.

There is further room to achieve better power optimization by supporting
the controller event HCI_VS_MSFT_LE_Monitor_Device_Event to fulfill true
monitor offloading. This is currently not supported as it was originally
desired to minimize the changes to the MGMT interface and reuse the
existing MGMT_EV_DEVICE_FOUND event to pass advertisements to the
bluetoothd and let bluetoothd handle the RSSI thresholds and timeouts in
order to fulfill the D-bus API requirements for the client.

This patch series introduces MGMT events MGMT_EV_ADV_MONITOR_DEVICE_FOUND
and MGMT_EV_ADV_MONITOR_DEVICE_LOST to indicate that the controller has
started/stopped monitoring a particular device.

Please let me know what you think about this or if you have any further
questions.

Thanks,
Manish.

Changes in v5:
- Update the Adv Monitor Device Found event to include fields from the
  existing Device Found event.

Changes in v4:
- Add Advertisement Monitor Device Found event, make Address_Type 0 as
  reserved.

Changes in v3:
- Discard changes to the Device Found event and notify bluetoothd only
  when the controller stops monitoring the device via new Device Lost
  event.

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.

 doc/mgmt-api.txt | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 97d33e30a..8e7b5ef70 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4910,3 +4910,63 @@ Controller Resume Event
 	Address_Type. Otherwise, Address and Address_Type will both be zero.
 
 	This event will be sent to all management sockets.
+
+
+Advertisement Monitor Device Found Event
+========================================
+
+	Event code:		0x002f
+	Controller Index:	<controller_id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+				Address (6 Octets)
+				Address_Type (1 Octet)
+				RSSI (1 Octet)
+				Flags (4 Octets)
+				AD_Data_Length (2 Octets)
+				AD_Data (0-65535 Octets)
+
+	This event indicates that the controller has started tracking a device
+	matching an Advertisement Monitor with handle Monitor_Handle.
+
+	Monitor_Handle 0 indicates that we are not active scanning and this
+	is a subsequent advertisement report for already matched Advertisement
+	Monitor or the controller offloading support is not available so need
+	to report all advertisements for software based filtering.
+
+	The address of the device being tracked will be shared in Address and
+	Address_Type.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	For the RSSI field a value of 127 indicates that the RSSI is
+	not available. That can happen with Bluetooth 1.1 and earlier
+	controllers or with bad radio conditions.
+
+	This event will be sent to all management sockets.
+
+
+Advertisement Monitor Device Lost Event
+=======================================
+
+	Event code:		0x0030
+	Controller Index:	<controller_id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+				Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This event indicates that the controller has stopped tracking a device
+	that was being tracked by an Advertisement Monitor with the handle
+	Monitor_Handle.
+
+	The address of the device being tracked will be shared in Address and
+	Address_Type.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	This event will be sent to all management sockets.
-- 
2.34.0.rc1.387.gb447b232ab-goog

