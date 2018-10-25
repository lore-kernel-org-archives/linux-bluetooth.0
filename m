Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6544ECDE46
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 00:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CF8204FD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 00:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+tm8+l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CF8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeJYJMf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:12:35 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52209 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeJYJMf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 05:12:35 -0400
Received: by mail-qk1-f201.google.com with SMTP id 67so1588382qkj.18
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Oct 2018 17:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Pqsfkn1uwLwC3/7gkIkMn1lnKmNBvWyLPIdgVXnQuG8=;
        b=u+tm8+l5LvYSU9jagfqBeIq7epNyQGLLIhyPZNAVYz8KG7lp9C692dTem/pdcs0Vpa
         WzXtb85NmtAnB/2UTp7ISqRUBTJ5JWTBoThqW4OcGAUNxTtrtC6Pd01T9tBhN45rS34L
         agxPxNAjswV2FWici+Z24AFD60KneZaU+g43qabCYpETIkfvtCMakvt7sVomELIfA4tV
         Mi0ViZVvuns7vUJVFxAhZTYihLVlVeHuk6IRduqIdYllPA/mwfBEkH0PzOzguElZoJSG
         lWryQAs5minu0BjqB4Y/UY8Xks3Xour2TBDU2db4Uxg28BlFZfN02EJresfb8y+E8FWg
         oU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Pqsfkn1uwLwC3/7gkIkMn1lnKmNBvWyLPIdgVXnQuG8=;
        b=GZrgRw+9MspRRu+22w6R/wmV81c+EXrhxuaYpvI2DDzDRr0xG328o5pXlRXU5Kg/TB
         Qz09Um9ERltCKa3csDXD8aYkppYE3kI1AXaSOj6B3IHEDxBSaGI3Pazwsm30bnvVob5D
         /IhYRJM1LtnV/WC9MhpRH0nvD8W1ZnnVCFG1vZerOFcQNUYfcP95/gj/xrdIo+Znwc3X
         HQNbNgvxbLQbSxPTowAq1kpeXe1nMgqxuugmfwVLXwShNCYNF4Xfpa210k9/mvZxLIj5
         0FjIRxOKowYXT4Vb3izU/pYnfx6qbbqeNHEr++1e75TD18zT5sIntCb3N9qCggXTkRX/
         sprA==
X-Gm-Message-State: AGRZ1gKuNVn9UBIAub9mtUx3CjV+rBTtqBTzDNIuFD764TbXfTj2JRMA
        YSw9w5VqY0EqB8IpOgl0M8dUcwCQcbW924N3/yYpn7+qbTLGIASBxrHVwE1iNzNaiWmMLgu8PsJ
        EA0itskgMBoLeQBT/x1lylOBrAECzYDSlGw7BcfqN0skFTUen30PGHueTz2NwY0s4Kzzgn2rfWY
        y8
X-Google-Smtp-Source: AJdET5eHpTedRiChQVRS5JRgGp0Cgn3oj1nq2TkjcgKi6+BhZHxjPskfG8LIQMMAGD8apIRw3dRNMJH+yRrm
X-Received: by 2002:a37:110d:: with SMTP id b13mr3958490qkh.15.1540428134272;
 Wed, 24 Oct 2018 17:42:14 -0700 (PDT)
Date:   Wed, 24 Oct 2018 17:42:10 -0700
Message-Id: <20181025004210.177441-1-yunhanw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH] gatt: Fix double att_disconnected issue on disconnection
From:   yunhanw <yunhanw@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     yunhanw <yunhanw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When BLE disconnection happens, att_disconnect is triggered from two locati=
ons, the new added location is gatt_server_cleanup, it would cause several =
blueetoothd crashes. This bus is introduced from commit 634f0a6e1125af8d595=
9bff119d9336a8d81c028, where gatt fix, gatt subscriptions are not cleared a=
fter disconnection from a temporary device with private/random address. In =
order to workaround this issue, btd_gatt_database_att_disconnected can only=
 be triggered when address type is random, and for others, it can continue =
to use original disconnect code path.

    crash 1
    Program received signal SIGSEGV, Segmentation fault.
    queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555872a40) at /rep=
o/src/shared/queue.c:256
    256     for (entry =3D queue->head, prev =3D NULL; entry;
    (gdb) backtrace
        at /bluez/repo/src/gatt-database.c:350
        at bluez/repo/src/shared/queue.c:220
        at bluez/repo/src/shared/att.c:592
        at bluez/repo/src/shared/io-glib.c:170

    crash 2
        at bluez/repo/src/shared/queue.c:220
        at bluez/repo/src/shared/att.c:592
        at bluez/repo/src/shared/io-glib.c:170

    (gdb) print state->db->adapter
    Cannot access memory at address 0x61672f6269727474
---
 src/gatt-database.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 783b692d5..2f0eb83b5 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3365,6 +3365,8 @@ void btd_gatt_database_att_disconnected(struct btd_ga=
tt_database *database,
=20
 	addr =3D device_get_address(device);
 	type =3D btd_device_get_bdaddr_type(device);
+    if (type !=3D BDADDR_LE_RANDOM)
+        return;
=20
 	state =3D find_device_state(database, addr, type);
 	if (!state)
--=20
2.19.1.568.g152ad8e336-goog

