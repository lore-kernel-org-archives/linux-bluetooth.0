Return-Path: <SRS0=F5zp=UL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D82C31E46
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jun 2019 21:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B039208C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jun 2019 21:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ0vagWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfFLVAz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jun 2019 17:00:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37677 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbfFLVAy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jun 2019 17:00:54 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so14191413iok.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2019 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8Z50PCYi7BpYPOGOES2ISDGkR9G8GR1+pGaM6ck4I2c=;
        b=iZ0vagWudsIhuwdGUtW3p7V4ZcTxg3Odz4y4KmdbJI1B1Pbrift9Wrf0nza3Y11cNW
         Ee+8/Ag+OpZ+l6erz3zq3CU6dPinWxRWClLDdLBDmiG3o/DCssj4pxhsOb5ybvhdkEtt
         8vuBtO50JSDOSoH4ylOhhN6bSZf22HrZTuFeCtqfRtThf8Y3CGwnrz9cjWnzbaD+hN/i
         BBhItQJKIIdJYj3+Ff6TB4wbjDSYbBv3CLqo1cknAkrhzpL9G7IUx+39Eg5YqcODMnfL
         5+ikDa9vUb4PNyvVkJhB38jFCQTfAdTLZsaYgCHaph0+UXD17tYdqq9nngXQaNv+btr3
         GMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8Z50PCYi7BpYPOGOES2ISDGkR9G8GR1+pGaM6ck4I2c=;
        b=QvSJHaFy34mxSKe9/QriEfFPncnDhMVVOBLpdmGs7EuX1Xu7y06EhEpxa3BLndTjgX
         IToq8jpi7QgqB4VIoegkyqgTSUi9e0lHZ2ZfhHrGclKq6cyBkNOypkHG+X9cAwey9GXz
         wq31m1w9TGVJ86tSg3A+RsE2uRp8wF8WM2XYf3XHLhBkojTXACnyDBdjr9m1qGra2iV0
         1RriKWF35vtbF/U/Aqg4MfXA3QwxnXJvPgUo4gk1zl7vRJwV5fqM1Y9oa2SwjuTQvaIn
         XyCFtMVjpMAxYRPbaC16Sij9gNTMdtWAVxhoWN0r9YswxPn3W4hh/IxjSQJus/6UZBg+
         Xk0Q==
X-Gm-Message-State: APjAAAVRnYRF7ggajAJfybGmdLke5bOKBgBb/O4lfWwZgk7GKEfo/fFY
        dbquF0ZDb9eEBLgbweiTWfA2p/Ro
X-Google-Smtp-Source: APXvYqyJp1mzIQ++HUTaZk2yXrQ91UBugRgRU2Mv2jSbw3AlZ1EyGXMlmXSH0JTIYIaOrc9664mp3A==
X-Received: by 2002:a6b:e608:: with SMTP id g8mr8474849ioh.88.1560373254029;
        Wed, 12 Jun 2019 14:00:54 -0700 (PDT)
Received: from [192.168.0.125] ([8.39.228.178])
        by smtp.gmail.com with ESMTPSA id p10sm373340iob.54.2019.06.12.14.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 14:00:53 -0700 (PDT)
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   csonsino <csonsino@gmail.com>
Subject: [PATCH 1/1] bluetooth: validate BLE connection interval updates
Message-ID: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
Date:   Wed, 12 Jun 2019 15:00:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Problem: The Linux bluetooth stack yields complete control over the BLE
connection interval to the remote device.

The Linux bluetooth stack provides access to the BLE connection interval
min and max values through /sys/kernel/debug/bluetooth/hci0/
conn_min_interval and /sys/kernel/debug/bluetooth/hci0/conn_max_interval.
These values are used for initial BLE connections, but the remote device
has the ability to request a connection parameter update. In the event
that the remote side requests to change the connection interval, the Linux
kernel currently only validates that the desired value is within the
acceptable range in the bluetooth specification (6 - 3200, corresponding to
7.5ms - 4000ms). There is currently no validation that the desired value
requested by the remote device is within the min/max limits specified in
the conn_min_interval/conn_max_interval configurations. This essentially
leads to Linux yielding complete control over the connection interval to
the remote device.

The proposed patch adds a verification step to the connection parameter
update mechanism, ensuring that the desired value is within the min/max
bounds of the current connection. If the desired value is outside of the
current connection min/max values, then the connection parameter update
request is rejected and the negative response is returned to the remote
device. Recall that the initial connection is established using the local
conn_min_interval/conn_max_interval values, so this allows the Linux
administrator to retain control over the BLE connection interval.

The one downside that I see is that the current default Linux values for
conn_min_interval and conn_max_interval typically correspond to 30ms and
50ms respectively. If this change were accepted, then it is feasible that
some devices would no longer be able to negotiate to their desired
connection interval values. This might be remedied by setting the default
Linux conn_min_interval and conn_max_interval values to the widest
supported range (6 - 3200 / 7.5ms - 4000ms). This could lead to the same
behavior as the current implementation, where the remote device could
request to change the connection interval value to any value that is
permitted by the bluetooth specification, and Linux would accept the
desired value.

Signed-off-by: Carey Sonsino <csonsino@gmail.com>

---

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef9928d7b4fb..e5d69ae5eda1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5576,6 +5576,11 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
+	if (min < hcon->le_conn_min_interval ||
+	    max > hcon->le_conn_max_interval)
+		return send_conn_param_neg_reply(hdev, handle,
+						 HCI_ERROR_INVALID_LL_PARAMS);
+
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2146e0f3b6f8..1cea68108dba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5246,7 +5246,14 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (min < hcon->le_conn_min_interval ||
+	    max > hcon->le_conn_max_interval) {
+		BT_DBG("requested connection interval exceeds current bounds.");
+		err = -EINVAL;
+	} else {
+		err = hci_check_conn_params(min, max, latency, to_multiplier);
+	}
+
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
