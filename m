Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B031CC433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Feb 2021 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852B064E28
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Feb 2021 18:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBSSHm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:07:42 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17847 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBSSHi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Feb 2021 13:07:38 -0500
X-Greylist: delayed 992 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2021 13:07:38 EST
ARC-Seal: i=1; a=rsa-sha256; t=1613757019; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JaT6a5WDladEi+mz4ROxnwGR5X12xcg5c5x1KcpKBHTt9JKic9JQEEpgaD6diDfh5O3UW7j/hV1MHfzAmCf4BBSV47X//qYNFM/meiVYpaRpsaY69EnP4iHfbVo24w60OinCY7wSGCPbEYJjKmCtWTl4jOwaqir2NYrrC63o1zQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1613757019; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8G/SnBL4KTdVBuYbYXFvYdWJaUwHYKER4M4yy6KxfD0=; 
        b=k+bP8clvUmkqkgQWr3/W+bJiDlvkxEAtlqHQmUJ0uGoXEMHeg17UMxgPMYnwA0M1X2W9TgkES0v9uWysLbK3oMARh2yBTsB54R3NP27+Bnnc5F6hQCz5JULFhvlfgKCQNzQl2vfSbJuJy6yOrVguEGhV6wkpQ0AYSA+W5EAFTq0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=maves.io;
        spf=pass  smtp.mailfrom=curtis@maves.io;
        dmarc=pass header.from=<curtis@maves.io> header.from=<curtis@maves.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613757019;
        s=dkim; d=maves.io; i=curtis@maves.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=8G/SnBL4KTdVBuYbYXFvYdWJaUwHYKER4M4yy6KxfD0=;
        b=Pkt2X5ovg1sGKSJBkQEZH/2Z42uVJzzIkp9pmoZmxwHfdW7HZT7VprnBYBZwbPgh
        URf/GS2ZeQNRlrZxnW7fto+xMmXaerQ0Dm7l8ptp1PZQiKl4n6wMKkZA2G3gDIJwR+I
        +Gl95bdo2nQ5s45vD1Un9w3uqiwC/SVWvhPy90RA=
Received: from localhost.localdomain (87.101.92.171 [87.101.92.171]) by mx.zohomail.com
        with SMTPS id 1613757016499791.914327155336; Fri, 19 Feb 2021 09:50:16 -0800 (PST)
From:   Curtis <curtis@maves.io>
To:     linux-bluetooth@vger.kernel.org
Cc:     Curtis <curtis@maves.io>
Message-ID: <20210219174946.599144-1-curtis@maves.io>
Subject: [PATCH BlueZ] gatt-database: Fix notifying on indicatable attr
Date:   Fri, 19 Feb 2021 12:49:46 -0500
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a local GATT characteristic has both the indicate and notify
properties, notifications will not be send to clients requesting them.
This change fixes this, allowing for notifications to be sent.

Also simplifies logic about when notifications/indications should
be sent.
---
 src/gatt-database.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index d635c3214..bd5864bcd 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1344,10 +1344,7 @@ static void send_notification_to_device(void *data, =
void *user_data)
 =09}
=20
 =09ccc =3D find_ccc_state(device_state, notify->ccc_handle);
-=09if (!ccc)
-=09=09return;
-
-=09if (!ccc->value || (notify->conf && !(ccc->value & 0x0002)))
+=09if (!ccc || !(ccc->value & 0x0003))
 =09=09return;
=20
 =09device =3D btd_adapter_find_device(notify->database->adapter,
@@ -1374,7 +1371,7 @@ static void send_notification_to_device(void *data, v=
oid *user_data)
 =09 * TODO: If the device is not connected but bonded, send the
 =09 * notification/indication when it becomes connected.
 =09 */
-=09if (!notify->conf) {
+=09if (!(ccc->value & 0x0002)) {
 =09=09DBG("GATT server sending notification");
 =09=09bt_gatt_server_send_notification(server,
 =09=09=09=09=09notify->handle, notify->value,
@@ -2415,8 +2412,8 @@ static bool sock_io_read(struct io *io, void *user_da=
ta)
 =09=09=09=09gatt_db_attribute_get_handle(chrc->attrib),
 =09=09=09=09buf, bytes_read,
 =09=09=09=09gatt_db_attribute_get_handle(chrc->ccc),
-=09=09=09=09chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
-=09=09=09=09conf_cb : NULL, chrc->proxy);
+=09=09=09=09conf_cb,
+=09=09=09=09chrc->proxy);
=20
 =09return true;
 }
@@ -2725,8 +2722,8 @@ static void property_changed_cb(GDBusProxy *proxy, co=
nst char *name,
 =09=09=09=09gatt_db_attribute_get_handle(chrc->attrib),
 =09=09=09=09value, len,
 =09=09=09=09gatt_db_attribute_get_handle(chrc->ccc),
-=09=09=09=09chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
-=09=09=09=09conf_cb : NULL, proxy);
+=09=09=09=09conf_cb,
+=09=09=09=09proxy);
 }
=20
 static bool database_add_ccc(struct external_service *service,
--=20
2.30.1


