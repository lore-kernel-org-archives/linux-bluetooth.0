Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDDEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C154F61359
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 22:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhJUWjT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJUWjS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 18:39:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3DC061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 15:37:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso1642491pjw.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yd3fnT+fgHjpGI16Yt4KWjsYb1gMhzaZAJVfETkq580=;
        b=Q+83ESBCCzPF19Ro2L2ozwyuSx7nY5kNojZWOI4c0iBt4N9aIPEe7cU1QuSJ5mDmXW
         oHegih9oUiWiRgvo0U66wKfrurDB8McbE0FOeFK4G09CDNjmdSZ4ppHxAUGfhgTa+eKL
         m+bOt8icerLxGnqhYvhyCTaM/FP7Q9uY3dPd3n4M2v7HSGgc3lvFZA91MfkYmhJ50m/7
         Ph3/mJKdTWKLLeQXqWItW9kAAtm3AMYk2EzBdx0hpU2C+BKvDqIM99tWdzES08efTUZT
         4D04he6VMBHNdwVgmJzs7RVXPiR00o+QENkteu4pUlrLQEO4TzX7DZZSTQ2khBnkFYXU
         xz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yd3fnT+fgHjpGI16Yt4KWjsYb1gMhzaZAJVfETkq580=;
        b=Ea7oJGbkDYLMUFcGUSLtHb/jXtMLWdCiXxR+CtjKFH0DhSSUNgeFK3fnhsdf9Oms1b
         oRpN+V9r8Dm9AdB+/9l+bFk7pvs4f9uz8XfThPdT79pjTvUCel5cG5QOhb4Oz6wn7QzP
         4o6bTPXdNSthKDbGbu2gMubvCaX3BWJWrQXcr6B8dlsUR6CqKjuWM+70+zOUC4/rtN0h
         Yek79iWFf8+L+B2ny8wfJl55WsMXaj7X9R8eTBNIkrzVkt5SdOtgUFZ53FdpYeDaXzFt
         k7QhHeJeJVFG+Pysa/JHbvyfiT2S6Yz4nnu7jTLNmUw9u2XtBjG0VdICiaUePcRXsvnK
         k01g==
X-Gm-Message-State: AOAM533csfHTPK+tXDG41kqImz6M1/CZUQGcXUbhnayu4i/RXsUikCFP
        FgiwsUTmN9nXZRDEtZkPSeMjyXki9+4=
X-Google-Smtp-Source: ABdhPJw0PxJHnZrsdfA8Ss076uEgDaWVdcqKkyseXkpTgN4OPy446eU3VqG+9C5DHIEjiqDAfaDX6A==
X-Received: by 2002:a17:90a:fe17:: with SMTP id ck23mr980777pjb.40.1634855821688;
        Thu, 21 Oct 2021 15:37:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w13sm10509035pjc.29.2021.10.21.15.37.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:37:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] btdev: Set Local RPA when own_addr_type is 0x03
Date:   Thu, 21 Oct 2021 15:36:59 -0700
Message-Id: <20211021223659.654744-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021223659.654744-1-luiz.dentz@gmail.com>
References: <20211021223659.654744-1-luiz.dentz@gmail.com>
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
 emulator/btdev.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 956dcee7f..03003d949 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5124,9 +5124,10 @@ static void le_ext_conn_complete(struct btdev *btdev,
 
 		ev.status = status;
 		ev.peer_addr_type = btdev->le_scan_own_addr_type;
-		if (ev.peer_addr_type == 0x01)
+		if (ev.peer_addr_type == 0x01 || ev.peer_addr_type == 0x03) {
+			ev.peer_addr_type = 0x01;
 			memcpy(ev.peer_addr, btdev->random_addr, 6);
-		else
+		} else
 			memcpy(ev.peer_addr, btdev->bdaddr, 6);
 
 		ev.role = 0x01;
@@ -5135,6 +5136,11 @@ static void le_ext_conn_complete(struct btdev *btdev,
 		ev.latency = lecc->latency;
 		ev.supv_timeout = lecc->supv_timeout;
 
+		/* Set Local RPA if an RPA was generated for the advertising */
+		if (ext_adv->rpa)
+			memcpy(ev.local_rpa, ext_adv->random_addr,
+					sizeof(ev.local_rpa));
+
 		le_meta_event(conn->link->dev,
 				BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 				sizeof(ev));
@@ -5148,10 +5154,13 @@ static void le_ext_conn_complete(struct btdev *btdev,
 	memcpy(ev.peer_addr, cmd->peer_addr, 6);
 	ev.role = 0x00;
 
-	/* Set Local RPA if an RPA was generated for the advertising */
-	if (ext_adv->rpa)
-		memcpy(ev.local_rpa, ext_adv->random_addr,
-					sizeof(ev.local_rpa));
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

