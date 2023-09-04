Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CEC71153
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbjIDWML (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbjIDWMJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A97A9
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-501be2d45e0so30366e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865523; x=1694470323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYo3dq3VK96vstXSFrFSQooJJuj3c4z/z/PjKdvJaEQ=;
        b=MN6ABb25xKNcMu+0lza8J4u3BdgeBRaC6sdDtvbB7FUsImIIE0/i0ViJbF+mCRdWVo
         Aho8Wqyu2bu84/YAxrGDoEN8bw7QvJCJff/NlIPncWrRtC9s06+oxMk2hCj6lsWko4Jm
         pyw58+i6d7OisLTkm9uR0ulyl+ws+HT0p7sn4zPRdBu83KgTQBIRdUWuDtaC0VtZzetK
         hr82Fm42ytbQq1ixRVphE6NFtz6271n2QxnCU6NlrhxVi0zHXtGnEB96fB2jwcM9lFVq
         S8/VP+7yFjXZxyzL1ECCRFfXZvGMKPc/hm4PfAVQZxtIK9g6uR9dPhhQbtzWAJSmycH2
         Iz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865523; x=1694470323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYo3dq3VK96vstXSFrFSQooJJuj3c4z/z/PjKdvJaEQ=;
        b=iszIZ00gDqrcIxqe8QYUWY/t+74Vdbbyv0qFIKfDySrc9uWBxQ0A4hvxbo73LTEQyI
         LsVO+U1XPN7nQRagTWhfajp+K74xwM3qJcBOYkzYZYvZ0J8d+u74LVd4n6vYQMnr+lFX
         IwrICwlwKzTCU6mE9TdoTWUIL0jIjSs9hdm6OxM+wmVtaas8mBWDVyQsvVREN/RhVIHt
         j3IBZY8U9mC/azpBwVLrRT+O2a8V7+g++dyX8xwYMY8sZZ0mtewUPOcKaRhqJDQ+dM16
         Dy4C79vzaOhdqA1G4rPXGYHYgdCmrIL/R+YIkWfbKkyYoU9nnrGvs4wWgZlhVAiUNHvd
         B4Ng==
X-Gm-Message-State: AOJu0Yy8xQhGid3whdycg45WMFIMoTHpAQU544XM8/OjGPqfy0LJ299/
        GYb5M50FC3VpGtyMI6goYhlH3g==
X-Google-Smtp-Source: AGHT+IGWpcMIj9ryFTm84vfGakvVZw7X7Rz6JS5V+2fQaa3kiE//kN9E1jcd5aVC4tZ5XaUUqKgwTQ==
X-Received: by 2002:a05:6512:2114:b0:4fd:d213:dfd4 with SMTP id q20-20020a056512211400b004fdd213dfd4mr6872963lfr.20.1693865523609;
        Mon, 04 Sep 2023 15:12:03 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:12:03 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH 5/7] Bluetooth: introduce hci_conn_free() for better structure
Date:   Tue,  5 Sep 2023 00:11:56 +0200
Message-Id: <20230904221158.35425-6-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904221158.35425-1-olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The bluetooth subsystem uses different sources for different layers or
objects. In particular, the "hci_conn.c" source regroups the handling
of the "struct hci_conn" objects, amongst other things. "hci_conn.c"
contains "hci_conn_add()" to allocate the "struct hci_conn",
"hci_conn_del()" to delete them etc.

One function is lacking: a "hci_conn_free()" to free the "struct
hci_conn". The "kfree()" is in the "bt_link_release()" [1], in
"hci_sysfs.c". "bt_link_release()" is the callback called when
the "struct device" reference count reaches 0. It makes sense that
"bt_link_release()" is in "hci_sysfs.c", with the other functions
related to "struct device" and sysfs, but to respect the structure of
the bluetooth subsystem, "bt_link_release()" should not directly call
"kfree()" on the "struct hci_conn" object. It should call a freeing
function located in "hci_conn.c", so that "hci_conn.c" contains both
the allocation and free of "struct hci_conn" objects.

This improved structure becomes necessary if we want to do more than
just calling "kfree()" in "bt_link_release()". We want to access the
"struct l2cap_conn" associated to the "struct hci_conn", we can do
this in "hci_conn.c", which includes "l2cap.h", while we can't do this
in "hci_sysfs.c", for which "struct l2cap_conn" is opaque.

For those structural reasons:

 1. We create a new "hci_conn_free()" function in "hci_conn.c", whose
    purpose is to free the "struct hci_conn".
 2. We export it by declaring it in
    "include/net/bluetooth/hci_core.h".
 3. Instead of freeing the "struct hci_conn" in "bt_link_release()",
    we call "hci_conn_free()" where we have moved the content of
    "bt_link_release()".

References:
- [1] "bt_link_release"
      <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/hci_sysfs.c#L13>

Signed-off-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_conn.c         | 7 +++++++
 net/bluetooth/hci_sysfs.c        | 4 ++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d8badb2a28cd..d5a9ef8909d4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1328,6 +1328,7 @@ int hci_le_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
+void hci_conn_free(struct hci_conn *conn);
 void hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 23e635600717..755125403331 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1134,6 +1134,13 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	conn->link = NULL;
 }
 
+void hci_conn_free(struct hci_conn *conn)
+{
+	BT_DBG("kfree(conn %p)", conn);
+
+	kfree(conn);
+}
+
 void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index fc297b651881..b0d841dcf860 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -14,9 +14,9 @@ static void bt_link_release(struct device *dev)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
 
-	BT_DBG("kfree(conn %p)", conn);
+	BT_DBG("dev %p conn %p", dev, conn);
 
-	kfree(conn);
+	hci_conn_free(conn);
 }
 
 static const struct device_type bt_link = {
-- 
2.39.2

