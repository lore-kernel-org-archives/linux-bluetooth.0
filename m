Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 15:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhKTPc6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhKTPc6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 10:32:58 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB890C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:29:54 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id lj10-20020a17090b344a00b001a653d07ad8so8559332pjb.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CYpmfPbN3C/XAnsKeNyp26vn7Ku9902if6kiPcHTnMA=;
        b=laFLdRc24VNgngtSgCx1BZGvpOkmcudjOBDl4DMu2aTmKNYpl706EjrvwP0fFOTH/8
         23YgPRyg0WTF8SApYM5Nl/HuQHguqBnBzftDU/g/wJnr3f0hZ16mpVXk32k8eMlcVY7K
         xY59qDTS3blyo6EqB1pVapuVftZQ9ZT4IEFC/3l+iKtWSnlf7q510Bb9q8Tunh2exoCW
         Z6YebxUYubiRp39HFQwt5HJhbpf6g4y3/nrkGPT0K3xu5O378imcY3C/5aTw33fISKuO
         zQ5jFB8RunucWao3TLNPK+VLeK4ScVUqMRZJyCSLlGioRV6zVwsiIwIA+MwAgxsZb4A4
         xqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CYpmfPbN3C/XAnsKeNyp26vn7Ku9902if6kiPcHTnMA=;
        b=ogOQKHtBO81S4eFiBBrcjKjNRmfb8FTxtrjlzfW6szKoBYT1WC8tu26vcbt/NLz4IS
         5LqHYCEH2juYF6NZr0+JDK4fVkQx8Lf4llooAKiPvUlfqogy6+dJi/Ivz0qtThhjAjxt
         V+IN3TGop96D/d6QBzEomLc6VUHPfytFmzLBi8FxucOZKD3m58/dow9jpEAx1Xv97hZQ
         z7jEpTgk2Vbak/RqdBq0yTUiCYwpcp5biNUUlgKd2OWMjym7VmQf7y3T7u4uch300VHS
         /ZBZ6pUpGpa0R5shtF+yL6+5QQ/rFG6c5z4Tm0X1lrhXnf6rSb3pe5Fo7USUX/ZxMaQi
         hBnQ==
X-Gm-Message-State: AOAM530hPIrQ1Q05MkDuwN5ViHffQNyg1FP4uyY5H9FvvQSWDXNDs01C
        enWCGa083YRlek5F2yjuY1JQD7djG+reOA==
X-Google-Smtp-Source: ABdhPJwUY0pSz5rpdjZoj8hR7cz/xueqe/jDsfk8JbhAUoBBzgeRP5+A7/qOT8DrDWRaljAZn5MPF3q47sqUCw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8437:70f3:c03b:1c71])
 (user=mmandlik job=sendgmr) by 2002:a65:50c6:: with SMTP id
 s6mr23074422pgp.352.1637422194400; Sat, 20 Nov 2021 07:29:54 -0800 (PST)
Date:   Sat, 20 Nov 2021 07:29:36 -0800
Message-Id: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [BlueZ PATCH v6 1/6] doc: Introduce the Adv Monitor Device Found/Lost events
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

(no changes since v5)

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
2.34.0.rc2.393.gf8c9666880-goog

