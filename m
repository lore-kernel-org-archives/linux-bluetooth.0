Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDBBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 23:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350819AbhLFXnq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 18:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbhLFXnp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 18:43:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F70C061746
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 15:40:14 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so49334788eda.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Dec 2021 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Y4kAmadlvfJRSwT+6WKAFkUiUMsfjWHGSKYhfYU0trs=;
        b=qKj2w4oZ/m51YMz3nLCzhDzDKonl77/snA7L/Tgybm3YnS/QKc9jsosz/MBzB2thWO
         /9DjcWtGt4dFwyx+mGho0we1PF610UC7iP1k3Y+lNTIBDB23kbcreGxj8NBItsWDKP6o
         8eYRNAunKEf1wP1iyT84CA9oigQo+5AHS+Jx+NR+e90GCaZK+grCEFEwo5GtSqgUyfuU
         gSOpmnS2tt4B7ZVIBI8FGC28KcCq3HwlQVHyVmlcj8lQTITVIxNd1z7dTqZ2yqt0s21c
         F8xrzDgsPfmoATXECpX1Qx7ETnae79mxvrRnD2fA4SqET2jDriRZpDfif2/Gi6m6Iasr
         P9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y4kAmadlvfJRSwT+6WKAFkUiUMsfjWHGSKYhfYU0trs=;
        b=yz2SaCNOS/9umiswNawNLibv6J30E0BKC+OQRmsIyVwgiRGA5Y3Xe9QzYu3rLtMb0B
         Ay1JrSrzMpwNjU07LE5o6t1gF/PxN+GsQJbmLYlbQ7mxcCJchDckF1nVOOu/JQNdcv/j
         SUIorMcLQkThRZKYEXkRJuS8NMmGdALZeQFlr64cv1vnQKxNL+mLSXcJB4T13E535Awh
         wY450rdCjE/WCbUvFXIBPSpkebfWDS8O7lGMBpux6UAbsTpGlsRAramSa7uE+8PqDYGN
         04Axst4HSU5N5y5T0gw/cRDKNPKBOedBwCru+qE7V7qzNmPT+dnfaskdHpSk5VOqxDkx
         tHzA==
X-Gm-Message-State: AOAM533+S5fGKHaMItRQ52ymBWPysjK0NsoBCUBPbCdpRkVhT87u4WBG
        0R1iEjUCe7re0VSTQk0UjTU4z1cv6GSe6SuQ
X-Google-Smtp-Source: ABdhPJyUTUDmL4HvqMekCXTxAJ0lpi7oDNWgHYnKFAgEvYgdPhh+aP4Ni5evkUunUHB9PEj/eyKG6Q==
X-Received: by 2002:a50:fd16:: with SMTP id i22mr3424878eds.224.1638834013226;
        Mon, 06 Dec 2021 15:40:13 -0800 (PST)
Received: from NB-MED-CH-0326.hamilton.ch (mob-194-230-145-57.cgn.sunrise.net. [194.230.145.57])
        by smtp.gmail.com with ESMTPSA id hs20sm7200870ejc.26.2021.12.06.15.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:40:12 -0800 (PST)
From:   Ulisses Costa <ulissesaraujocosta@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ulisses Costa <ulissesaraujocosta@gmail.com>
Subject: [PATCH BlueZ] client/gatt: Fix property_change in WriteValue for desc
Date:   Tue,  7 Dec 2021 00:40:01 +0100
Message-Id: <20211206234001.4248-1-ulissesaraujocosta@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 client/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/gatt.c b/client/gatt.c
index 9c991c2ac..11f70dc4f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -2749,7 +2749,7 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s (%s) written",
 			desc->path, bt_uuidstr_to_str(desc->uuid));
 
-	g_dbus_emit_property_changed(conn, desc->path, CHRC_INTERFACE, "Value");
+	g_dbus_emit_property_changed(conn, desc->path, DESC_INTERFACE, "Value");
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
-- 
2.17.1

