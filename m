Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BB3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbiESUXE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiESUXD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 16:23:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82396A2046
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:23:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q4so5715299plr.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=13pldd5OTfzjWLAHB/vAOf+bXFLdU7Z3DWFPM4KGVr8=;
        b=Nefy6zyVrp9ESKoFuCTrgzIXiFW26fBDLdbdLb8p30JE7/f/is3WOwyCd3kOSnp0dD
         VTQV+255OU2h+7hiyX5bxKI79E3eBYH9YBBYkj3YaVZqIg5Zv/SYQNJhwTjxVas9SEeK
         14NpaJq+z5ieIp2uQ9feUBk0k+i8XYB42ey3PNx4DEPjxKLSPh0Mi+h3u/8WL4xGw+GT
         FnFMhE9oBD+1+G3OQU21yrzKsrMUEg73P75JooB8Iy2fy3dp9boL2oRTCnjzPFXHtYax
         YFFuPC08y5baqPmt1qL5IVNPDwCrVo2lhX7EMGE8OLGmI2zMqQpCt/fiVKn89IUSbycl
         zcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13pldd5OTfzjWLAHB/vAOf+bXFLdU7Z3DWFPM4KGVr8=;
        b=DYsgpJ7/6T25pdyLutqFlahGU0vcYwfZrHtvhQDRvtpS5/ItKjVf7WbsQUSUhf/qgp
         6USHZmR7cuI4gny1tpXkamRlJPM0LdMGYNi5e1UQbYTVol5xlgQfLwP37XjiuhHC1uSK
         fyzviYbyTgd4H2rgosBGMDOs4dXNnge3+Vlw1xxaywodlkAF2Za2RG/cS05qminP1OKu
         y231J42W0IC1OJpjOf47DPZGQTRIHZnBEtW5OYJ5enPVX4wfImID744Lh6+U/En7Xxak
         9/EwF5W5Zw2W4/5oBW1jn+CAJNrIQC0qYqgVbKNXbpIo+u2k2brByXJDxIIoIwjN/2u7
         Lxrg==
X-Gm-Message-State: AOAM531ev/7LCkdrBdkx6LhUwm/QDvYIxwq+5nGcs1GBeXP+JeyS0jns
        bEYuTvl8uMwTZnnMQrQJLxdd+HWll78=
X-Google-Smtp-Source: ABdhPJxv7Kg3VMlWUH88ucR3OJ6ZUBCcxndAMNfW0XMEfPNZakW4rIyi3dMKlOoZCTL1igzNNVX6QQ==
X-Received: by 2002:a17:902:f607:b0:161:5f47:b213 with SMTP id n7-20020a170902f60700b001615f47b213mr6208566plg.4.1652991781460;
        Thu, 19 May 2022 13:23:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i6-20020a62c106000000b0050dc762816csm98003pfg.70.2022.05.19.13.23.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:23:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: Use bt_status to convert from errno
Date:   Thu, 19 May 2022 13:22:58 -0700
Message-Id: <20220519202258.2459530-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220519202258.2459530-1-luiz.dentz@gmail.com>
References: <20220519202258.2459530-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command cannot be sent or there is a internal error an errno maybe
set instead of a command status.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ac06c9724c7f..a36297368c58 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -947,7 +947,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (conn != hci_lookup_le_connect(hdev))
 		goto done;
 
-	hci_conn_failed(conn, err);
+	hci_conn_failed(conn, bt_status(err));
 
 done:
 	hci_dev_unlock(hdev);
-- 
2.35.1

