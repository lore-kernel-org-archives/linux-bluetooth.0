Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBC8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860CA2075E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J67vyKvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgHUGQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGQ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:16:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A246DC061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:16:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so380166pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDwu5BrtHT0GUTjSCVzrISlqfRedLF7fjEJej4jrdw0=;
        b=J67vyKvQKaqoVBADWghS2x0hYbNL+miW3jRTs4563mo9NevCpvLYzrWuxL5zAPYPz0
         XEgSH2G6rC6QGzYRLHgNQ0LFkkdx7mSUr5t52REDy/0VWWiRig3ow+9JZldOm6EA0whJ
         ydr5go4g14bLkCR/gJJ352iomAksNNDmw1UJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDwu5BrtHT0GUTjSCVzrISlqfRedLF7fjEJej4jrdw0=;
        b=CKlzqAVcbs6sT62/gE+Lnvs4TQYZu/apuPZ7JpeAwkWQg525LCZTK+dlhSPpllrqcM
         cAV8p/sj49U0N6f9wk/1dxOScF0brvvyfhgy7SnHhGZZd1/vHFJO0JsIDCtYHTzNDTZ2
         kTK8+sQUhjhGLZodKxxtLkypYArMgdydWWNg5S0/ASM+qcCEOhLsElR45INgDQ4IaO8B
         Us+v2PiUuPq0+sJ0pq5IY5Xjm67yNMkvGx1aytZD6BC9s7mnrZlTtIH7nEDB32RaAVRs
         nhACksbUt1l1CM4s4bNr41Vw+xnB7mNY8epwJtCZsDaVGwt+zPkwBJiw1wK/TIghK6wL
         V5Kw==
X-Gm-Message-State: AOAM5334JS1gE/GNwXbMil7UxYQKcQNKu+y7QK9laE1NMks88dBkZOrg
        DDHl/PR0tm5OMQnzQf+u2fnXD7v5RvTzmg==
X-Google-Smtp-Source: ABdhPJz42FHgF+9Bli7lNnvQN69Wi60wbJ37qV2Pw9Xd++UNMA6KL+xYDuYauHUvRkev3trHCXTgIw==
X-Received: by 2002:a17:902:fe0d:: with SMTP id g13mr1140105plj.287.1597990616558;
        Thu, 20 Aug 2020 23:16:56 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id h1sm927356pgs.77.2020.08.20.23.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 23:16:55 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Joseph Hwang <josephsih@chromium.org>
Subject: [PATCH BlueZ 1/2] gatt: StartNotify is not allowed when device is disconnecting
Date:   Thu, 20 Aug 2020 23:16:42 -0700
Message-Id: <20200821061643.16278-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

This patch fixed a bluetoothd crash in register_notify_cb(). The
crash is incurred by an exception that under some situation, a
characteristic may be freed when register_notify_cb() is invoked.

When a device is disconnecting, the device interface would hold valid
for a while until the disconnection procedure between the client and
the server is completed. If another process happens to request to start
notification of a characteristic on the disconnecting device, it may
incur a problem. In this case, the client would still send the
StartNotify request since the characteristic object is still valid.
However, the characteristic may be freed soon and become invalid
when the corresponding callback function is invoked later. This
leads to the bluetoothd crash due to the segmentation fault.

To handle the exception, if another process requests to start
notification when the device is disconnecting, it should reject the
request.

Tested on Chrome OS that this patch fixes bluetoothd crash in
register_notify_cb().

---
 src/gatt-client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 20c3fbec2..c706307c7 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1545,6 +1545,12 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	const char *sender = dbus_message_get_sender(msg);
 	struct async_dbus_op *op;
 	struct notify_client *client;
+	struct btd_device *device = chrc->service->client->device;
+
+	if (device_is_disconnecting(device)) {
+		error("Device is disconnecting. StartNotify is not allowed.");
+		return btd_error_not_connected(msg);
+	}
 
 	if (chrc->notify_io)
 		return btd_error_not_permitted(msg, "Notify acquired");
-- 
2.26.2

