Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8DFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FED6135E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 21:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhJUVkt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhJUVks (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 17:40:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F83C061348
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 14:38:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso4176344pjm.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zBYAh8x6q+4hWRefICFgMMwREIi/GYDaFmX1YUM46Rc=;
        b=QcEOYBi4WyBGkg0Vr2AIuSaZOXVOjnIgxAgN/aguYyjwcDqaTd/Qu7P6Lp22bVW/cw
         VOaSZzgvv9gJnqxo711N8+1shRRCHSqm3WMqj6IujveHZPjSmWc22WUOwZgZqkweRtXw
         pR+X8wvAqakMr31HcDWSJ/pVOL7x+lsTqYCjk+mqxktWlT9Z/U7vTw/q0VnM/Ej9RNsH
         xfdnOnszQsidTlupMmHB0gLUpMii9VymYXPnIEXscie0x7ah7I9WEu7f2GpbRyuaY5m6
         aBME9MtB9yV2Kb3fJ0KhRHv7uEKLotHe3ht3nTNKby0ky5//aBrKT/OpGV63McNw419B
         w9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBYAh8x6q+4hWRefICFgMMwREIi/GYDaFmX1YUM46Rc=;
        b=blnGX7wLvc4/pyif+wEI1gEoqzav3csmy93QSuS6efzowJGrubVlziXzqiJB4S5+iy
         XWSSO5GlMXhaNmabNsmswF5qGM520FcXjxS6ODVhJGPjLsEXacXRxEEITtl7n/bhBd3R
         yTwrrOpL1WmtdXzDHiA7opFp73oBVG20Lg1i2cX3yq1YtV5OHULENRrm3Qr18QlJX9HX
         itLPx0K0/uh+zZRiZhWYt3HRVa+kocv4rx2oK2OaohTJiHY2hP3bsOqDtfykrEfIJVq1
         6nj0fpRMCo0aGdY82sATVahzX0YSPUo4cGcKv/rbmX+Gz+Nu00eplfNAKqfD4wvW3feC
         w0XQ==
X-Gm-Message-State: AOAM530YdF/2OFHJhNoxMAQbuSWxobBgLwwwNsum4ZWLB29/tYzHi5sb
        hxDvG5+UWr9fyHOm3A90fS6Slsr6POM=
X-Google-Smtp-Source: ABdhPJxBF32GQv9d7W2zx8midlPv0ml4B6IiyvEcw8sLUQdJcSe8eKQkrd7KPaV/BoTw2RWdc+Qk/Q==
X-Received: by 2002:a17:90a:1657:: with SMTP id x23mr9675820pje.148.1634852311404;
        Thu, 21 Oct 2021 14:38:31 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 66sm6818473pfu.185.2021.10.21.14.38.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:38:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] btdev: Set Local RPA when own_addr_type is 0x03
Date:   Thu, 21 Oct 2021 14:38:28 -0700
Message-Id: <20211021213828.640557-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021213828.640557-1-luiz.dentz@gmail.com>
References: <20211021213828.640557-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the emulator to properly emulate the generation of a Local
RPA so it always set the random_addr when Create Connection sets 0x03 as
own_addr_type 0x03:

< HCI Command: LE Extended.. (0x08|0x0043) plen 26
        Filter policy: Accept list is not used (0x00)
        Own address type: Random (0x03)
        Peer address type: Public (0x00)
        Peer address: 00:AA:01:01:00:00 (Intel Corporation)
        Initiating PHYs: 0x01
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 30.00 msec (0x0018)
          Max connection interval: 50.00 msec (0x0028)
          Connection latency: 0 (0x0000)
          Supervision timeout: 420 msec (0x002a)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4
      LE Extended Create Connection (0x08|0x0043) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 31
      LE Enhanced Connection Complete (0x0a)
        Status: Success (0x00)
        Handle: 42
        Role: Central (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:AA:01:01:00:00 (Intel Corporation)
        Local resolvable private address: 60:0C:C5:B9:10:5D (Resolvable)
        Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Central clock accuracy: 0x00
---
 emulator/btdev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 096ba2da4..a5f468447 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3545,7 +3545,7 @@ static void le_conn_complete(struct btdev *btdev,
 
 		cc.status = status;
 		cc.peer_addr_type = btdev->le_scan_own_addr_type;
-		if (cc.peer_addr_type == 0x01)
+		if (cc.peer_addr_type == 0x01 || cc.peer_addr_type == 0x03)
 			memcpy(cc.peer_addr, btdev->random_addr, 6);
 		else
 			memcpy(cc.peer_addr, btdev->bdaddr, 6);
@@ -5149,7 +5149,7 @@ static void le_ext_conn_complete(struct btdev *btdev,
 
 		ev.status = status;
 		ev.peer_addr_type = btdev->le_scan_own_addr_type;
-		if (ev.peer_addr_type == 0x01)
+		if (ev.peer_addr_type == 0x01 || ev.peer_addr_type == 0x03)
 			memcpy(ev.peer_addr, btdev->random_addr, 6);
 		else
 			memcpy(ev.peer_addr, btdev->bdaddr, 6);
@@ -5178,7 +5178,13 @@ static void le_ext_conn_complete(struct btdev *btdev,
 	memcpy(ev.peer_addr, cmd->peer_addr, 6);
 	ev.role = 0x00;
 
-	memset(ev.local_rpa, 0, sizeof(ev.local_rpa));
+	/* Use random address as Local RPA if Create Connection own_addr_type
+	 * is 0x03 since that expects the controller to generate the RPA.
+	 */
+	if (btdev->le_scan_own_addr_type == 0x03)
+		memcpy(ev.local_rpa, btdev->random_addr, 6);
+	else
+		memset(ev.local_rpa, 0, sizeof(ev.local_rpa));
 
 	le_meta_event(btdev, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 						sizeof(ev));
-- 
2.31.1

