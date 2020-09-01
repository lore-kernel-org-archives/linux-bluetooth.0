Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D774DC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7922D207D3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dptechnics.com header.i=daan@dptechnics.com header.b="dMZh9U0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIANCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:02:37 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17101 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgIALzA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 07:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598961275; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NHOprI/StTQi0D0aNa96kDcalZLnX2cKYp74nndDLQRG74Y5S1MM42VPRRg2XHiJPJgIqWY12w/B9ciLMIqB1iOadomEAugOEjNnLvvhVCl3Qlxeu/fikbRSF5mVVPIdvj0I46AF2t8pJqNgtSwEL3yM1yRW/efxZnRScXlkzLo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1598961275; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=lRDbOVyWTCk7HLMsMU0bFp+2XW5GTAjfDlZ82+nrDas=; 
        b=Oa5fjTkgq/kwoda5VenSRo1Pd+6q6asw1SFDxJS4DwiTbvDcYeii12sgrnqFwRuZQhv/KMeX+z+0P1i/pp/YkOo78bBkLAwMPsN6jy6tpbROQJKIkMieuzWDxjwtGv9hki7KzDlgMjm6oZ5EbQstBoMxyaeizW9u1Zxw7wyn6Lo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=daan@dptechnics.com;
        dmarc=pass header.from=<daan@dptechnics.com> header.from=<daan@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1598961275;
        s=zoho; d=dptechnics.com; i=daan@dptechnics.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=lRDbOVyWTCk7HLMsMU0bFp+2XW5GTAjfDlZ82+nrDas=;
        b=dMZh9U0JsGGFVquVdkoMw+CFpn6bDrHXIrDy+l3iQjFTswYqxdZHpZi/HTUSCwl/
        i4rwHzUpWDCw7KzZgvyCJWcd2M+DAj06EBQY0JRum5MGt/YBZzCnlTA6FQkFBHLp1bz
        +KQxhqNHXm0XigJ5fQSRTgMnXJootErWM06actDQ=
Received: from daan-devbox.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1598961273662400.6309226412743; Tue, 1 Sep 2020 04:54:33 -0700 (PDT)
From:   Daan Pape <daan@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daan Pape <daan@dptechnics.com>
Message-ID: <20200901115418.82056-2-daan@dptechnics.com>
Subject: [PATCH BlueZ 1/1] Mesh: make SIG model header file locations more consistent
Date:   Tue,  1 Sep 2020 13:54:18 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901115418.82056-1-daan@dptechnics.com>
References: <20200901115418.82056-1-daan@dptechnics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-gatt/onoff-model.c |  2 +-
 tools/mesh-gatt/onoff-model.h | 33 ---------------------------------
 tools/meshctl.c               |  2 +-
 3 files changed, 2 insertions(+), 35 deletions(-)
 delete mode 100644 tools/mesh-gatt/onoff-model.h

diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index be519c969..140dddb79 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -47,7 +47,7 @@
 #include "tools/mesh-gatt/node.h"
 #include "tools/mesh-gatt/prov-db.h"
 #include "tools/mesh-gatt/util.h"
-#include "tools/mesh-gatt/onoff-model.h"
+#include "tools/mesh/generic-onoff-model.h"
=20
 static uint8_t trans_id;
 static uint16_t onoff_app_idx =3D APP_IDX_INVALID;
diff --git a/tools/mesh-gatt/onoff-model.h b/tools/mesh-gatt/onoff-model.h
deleted file mode 100644
index 31599056d..000000000
--- a/tools/mesh-gatt/onoff-model.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2017  Intel Corporation. All rights reserved.
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#define GENERIC_ONOFF_SERVER_MODEL_ID=090x1000
-#define GENERIC_ONOFF_CLIENT_MODEL_ID=090x1001
-
-#define OP_GENERIC_ONOFF_GET=09=09=090x8201
-#define OP_GENERIC_ONOFF_SET=09=09=090x8202
-#define OP_GENERIC_ONOFF_SET_UNACK=09=090x8203
-#define OP_GENERIC_ONOFF_STATUS=09=09=090x8204
-
-void onoff_set_node(const char *args);
-bool onoff_client_init(uint8_t ele);
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 57998fded..e8eafff01 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -50,6 +50,7 @@
=20
 #include "mesh/agent.h"
 #include "mesh/config-model.h"
+#include "mesh/generic-onoff-model.h"
=20
 #include "mesh-gatt/mesh-net.h"
 #include "mesh-gatt/gatt.h"
@@ -60,7 +61,6 @@
 #include "mesh-gatt/prov.h"
 #include "mesh-gatt/util.h"
 #include "mesh-gatt/prov-db.h"
-#include "mesh-gatt/onoff-model.h"
=20
 /* String display constants */
 #define COLORED_NEW=09COLOR_GREEN "NEW" COLOR_OFF
--=20
2.25.1


