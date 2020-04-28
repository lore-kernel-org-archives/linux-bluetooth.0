Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98056C83008
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAED20757
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="RQFy+vMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgD1RwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:52:20 -0400
Received: from vern.gendns.com ([98.142.107.122]:60664 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgD1RwU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 13:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f0R4VBXhG00iRCTNKU5rfxSTUew8qyZojpFpvIc0vC0=; b=RQFy+vMnq3cSL0329WWbCyqAUg
        gl0n84n1OhblmpCjlkBZSsQI3VjG5LOCQZQBrSEExw4CksjWB2yCNdzNJPGgDtrwznWKAo0J5SWsb
        o9fOo7Gpq8hH1+ndkv2IZV7Gmgy//rst9PRq3wRM5ioR5mCvLYhW86UtRgpO3qyD7HTDvjN/apycL
        xRDN/JCA8lAhVDAijXM0EVSLTtc2rFpnsJKq5AD1Qg7CYuvt1BucGl2kVBDFZcD8P585ffyicVrTm
        GHkU7AlP4LJCgwZT5stHVpwIGXx/k3neoSOG8O+Yz1BBPHpNKkLx3nfXQ0gTlV2+hGXwbecN0WeW5
        Se6i9P+w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39964 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1jTUP3-0008Uf-Oe; Tue, 28 Apr 2020 13:52:17 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>
Subject: [PATCH BlueZ] src/gatt-client: allow "command" even when property not set
Date:   Tue, 28 Apr 2020 12:51:49 -0500
Message-Id: <20200428175149.1784-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modifies the GATT client characteristic WriteValue D-Bus method to
not check that the characteristic supports the requested type of
write when the "type" option is set to "command".

Before this change, if the "type" option was used and it was set to
"reliable" or "request", then BlueZ would attempt the write even if the
characteristic does not support that write type. On the other hand, if
"type" was set to "command" or was not specified, the method would
return a org.bluez.Error.NotSupported error without attempting to write.

After this change, the WriteValue method will consistently always
ignore the characteristic properties and attempt to write when the
"type" option is used instead of having a different behavior for the
"command" type.
---

Related discussion:
https://lore.kernel.org/linux-bluetooth/685ddf1b-c824-9c45-298f-97b70cbf975f@lechnology.com


 src/gatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index a9bfc2802..20c3fbec2 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1050,8 +1050,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 			return NULL;
 	}
 
-	if ((type && strcasecmp(type, "command")) || offset ||
-			!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
+	if ((type && strcasecmp(type, "command")) || offset || (!type &&
+			!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)))
 		goto fail;
 
 	supported = true;
-- 
2.17.1

