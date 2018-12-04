Return-Path: <SRS0=McSj=ON=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1CEC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 19:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066152081C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 19:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9ZfNgzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066152081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeLDTog (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:44:36 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:41145 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeLDTog (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 14:44:36 -0500
Received: by mail-qt1-f179.google.com with SMTP id d18so19502654qto.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Dec 2018 11:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=idBowez7C6lWqcS5fIWF4Gtw1r71zRkH+tDiCXUGTAc=;
        b=j9ZfNgzKGAtzzbQQLg7uhv7jzpetNoyXK5b4n5IwNIAu7GWTZ9TyMpXeArZjAUkL5N
         VTGaNqjoB6Xfj7Kfq6wBirtBgrzN5ShBzPovSHZivzWrKmhyFXM2B47iBz4luG7UfWmG
         UouAdOj8O03CewlQzdx/jJnptCV882jipjKBi/WfT5iFej4dIt3/0QQObrbfv1PEtNm3
         vFIUQJ6XjCdEPw4oTsbMFUHYA5iWSZXs6GdhCh/daWWXDemMOu/Xbf8Qy3GnYUSy3ngt
         KzugwamNqK56CYmqcQwGX2QwgsirUW4qJRGVNpOk8cI+WY80hFklCTq30vsKdbxg0ddz
         3AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=idBowez7C6lWqcS5fIWF4Gtw1r71zRkH+tDiCXUGTAc=;
        b=DPUmXLh60gUr7fXT31+Vfc6CZHJlvzAZUTq3/l8vU5KaVw6kGY06+ulBnVLNnUF0jr
         uTGpNfl+RZETsj25X5CUtvas4vx0wS3IpTuPNgHaBwUm6jy0Z+OpMMeTskGprA3C3FrC
         bke86v9ynPIAw9/ezrrax1efiSZM94Jzz9pgSEWexFfeYFFoBiTFZDQv8iZGj9AKQC10
         TVmZo5TMS2EkncdkkiaJ/C/JZGpEr7zOVIVsgKinFaQb/nXnu4V7y7cBi2dp4LCNyraz
         eXjFyQynzwcdNTQa10ZrVEUVUXUo8gToFFSJhKkPC5Fm+vh7uhnyveKN4aftQlCeqN8R
         njlQ==
X-Gm-Message-State: AA+aEWbjdxwUqaps3P9uqCcQ+hDXkbuBawxz1J0xfMJovNh6wU+ciEYV
        bMKRdgyDPOWRoP1NjIa46Xk5PJSyT8Q=
X-Google-Smtp-Source: AFSGD/VDnO4nYa/8NmLp1lAdEQV2VHKAzWMXEX7HIZs+B0ygsFDvr/7gsLQCRkiLtbxg2weKpcnGDg==
X-Received: by 2002:a0c:eaca:: with SMTP id y10mr20782599qvp.176.1543952675480;
        Tue, 04 Dec 2018 11:44:35 -0800 (PST)
Received: from localhost.localdomain (177.207.73.66.dynamic.adsl.gvt.net.br. [177.207.73.66])
        by smtp.gmail.com with ESMTPSA id r16sm12556736qkh.71.2018.12.04.11.44.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:44:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Register GATT and GAP services as SDP records
Date:   Tue,  4 Dec 2018 16:44:29 -0300
Message-Id: <20181204194429.13829-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ensures that GATT and GAP services can be discover over SDP as well
as over GATT.
---
 src/gatt-database.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index c31afa0e9..2c2f035b1 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -847,6 +847,8 @@ static void populate_gap_service(struct btd_gatt_database *database)
 							NULL, database);
 
 	gatt_db_service_set_active(service, true);
+
+	database_add_record(database, service);
 }
 
 static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
@@ -1071,6 +1073,8 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 									NULL);
 
 	gatt_db_service_set_active(service, true);
+
+	database_add_record(database, service);
 }
 
 static void register_core_services(struct btd_gatt_database *database)
-- 
2.17.2

