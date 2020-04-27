Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7A4C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 15:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A241F206BF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 15:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Jdcghy7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgD0PCK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:02:10 -0400
Received: from vern.gendns.com ([98.142.107.122]:48464 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgD0PCJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 11:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LfI3ZGYWM24P6FDACjxA7OpUVBsAc7Gt9G4fHxOBUzs=; b=Jdcghy7s6y/+IqZaN0ScggF5CU
        yDThdJP8Ocvwl3sUeUhGu9TnOABjN6MbnC5F7pRUI+QdnJdotoxIyRs+FcJ5uUm5hcTf+ruL6f5FS
        nFi0YVfEVdUWMcwx1bGjzA9MJ9l3fH0PFC7Tkt7pJYhyEHZQq888FD7JCeFwa8Akauh6VUhQtHaEf
        TZRKH/JrG0cBLTMw//XTNyvoiKDWLFyjvQHekW/8IZ/0GL/JIS3wuys32HInqAlVIOiZJ/F5LpzP8
        sdSSCDFFGVysyAEyFHH9VHr+o2cmengqwhyTnyNuyY7a37JL5zaPelHfSX330h2lKGdJtewt4Jono
        IiniUvWg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51718 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1jT5Go-0005qM-OH; Mon, 27 Apr 2020 11:02:06 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>
Subject: [PATCH BlueZ v2] src/gatt-client: always check properties in WriteValue
Date:   Mon, 27 Apr 2020 10:01:53 -0500
Message-Id: <20200427150153.17055-1-david@lechnology.com>
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
always check that the characteristic supports the requested type of
write by checking for the corresponding property before attempting to
write.

Before this change, if the "type" option was used and it was set to
"reliable" or "request", then BlueZ would attempt the write even if the
characteristic does not support that write type. On the other hand, if
"type" was set to "command" or was not specified, the method would
return a org.bluez.Error.NotSupported error without attempting to write.

After this change, the WriteValue method will consistently return
org.bluez.Error.NotSupported if the corresponding property flag is not
set for all types of writes.
---

v2 changes:
- remove extra check of test variable not NULL
- fix one line over 80 chars

 src/gatt-client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index a9bfc2802..f80742fbb 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1016,8 +1016,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	 *     - If value is larger than MTU - 3: long-write
 	 *   * "write-without-response" property set -> write command.
 	 */
-	if ((!type && (chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE))
-			|| (type && !strcasecmp(type, "reliable"))) {
+	if ((!type || !strcasecmp(type, "reliable")) &&	chrc->ext_props &
+				BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) {
 		supported = true;
 		chrc->write_op = start_long_write(msg, chrc->value_handle, gatt,
 						true, value, value_len, offset,
@@ -1026,8 +1026,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 			return NULL;
 	}
 
-	if ((!type && chrc->props & BT_GATT_CHRC_PROP_WRITE) ||
-			(type && !strcasecmp(type, "request"))) {
+	if ((!type || !strcasecmp(type, "request")) && chrc->props &
+						BT_GATT_CHRC_PROP_WRITE) {
 		uint16_t mtu;
 
 		supported = true;
-- 
2.17.1

