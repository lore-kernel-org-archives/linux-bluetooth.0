Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACBEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A60610D0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhJMMpI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhJMMpD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 08:45:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462DBC061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:43:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so2908890ybk.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hSSFo//MURqtYxEZ8dRqQdSYUUGjXXrfvc2E2Lj7oc4=;
        b=FwFcHy6sslzGrxK14SL9welSPBLMCMGPHoQGXpwFpbwLw9cIkebkfmBC2ltupkVaPL
         fq1f06vMUB+mh6xPR0Jv0mBf1ThAS3nHbrxa0GvMGfQCIGue+w02DJVhAUWYLEo8biWQ
         Z+z7GB0RcpUYm/BFWpunv5oFQt9x5+RnDcXqbSuj2Lsh1nXqRoYWoZ995rrTkEp0+4UU
         nvMZIkvvOuxPDVoMx1zuKfAiSyJdbBInnq+l+cJcrBidU37FfcxM/HnD447SOuCiVvxJ
         yDPtFR2rOQDgaUWMhS+mK9FzgizdcuWrp6ImCtwkQDoHiuDcBTtHKOieT9NOFun+R6+H
         sZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hSSFo//MURqtYxEZ8dRqQdSYUUGjXXrfvc2E2Lj7oc4=;
        b=TytqCT35QsbcvlmfO+qym7K2TSm1eDROKByF92URpEvvRQPd6p4j/5k803lDBa0oHn
         6f2Qes5Qqyb51Y7SAa2eSUTNG2sI8oE6PN/ApgcYiqQw4LmozAQhyO8sTWqGtJDp3ga5
         nCo3HiH32eMyBInLAxYMw690RJO18qPRMHgMvLebbsTFb7HXLiVHsrXmrKsT3smaizY3
         rW3zMkU2OAtVDV3e26/WJH54L1WbzoDj7dq7aEmjy/w0J+pZ0yu2MaV2/ziQ2+INabtV
         idWReqcv3HJBUkDSp1iRk4ySmO0oexyw0vrO00b4H94booIJA3rGNhO2eyyjo0Y0cFSf
         jyYw==
X-Gm-Message-State: AOAM530ET9P/DPMOG2+nwrBQ7MFfrPbtLt8ZB/pyiOAq/+50fSVgPIFY
        0NMP6vwk+oZbYL9x4RmArE9YA2LS6G4NwQ==
X-Google-Smtp-Source: ABdhPJzc1NwwTE7P6Zv+NeFqqgvp9pZFWtz3endT1FlQwWd6t3dPu7B5b3yL1tw1VAVitJx0RYm+PKOsog8sQg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f8a0:57c1:fc2b:3837])
 (user=mmandlik job=sendgmr) by 2002:a25:5e06:: with SMTP id
 s6mr36266938ybb.175.1634128979527; Wed, 13 Oct 2021 05:42:59 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:42:08 -0700
In-Reply-To: <20211013124210.1454876-1-mmandlik@google.com>
Message-Id: <20211013053935.BlueZ.v2.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Mime-Version: 1.0
References: <20211013124210.1454876-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v2 1/3] doc: Introduce the Adv Monitor Device Lost event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a flag 'Device Tracked' to the existing 'Device Found' event to
indicate that the controller has started tracking the device matching
an Advertisement Monitor with handle 'Monitor_Handle'.

Add a new event 'Adv Monitor Device Lost' to indicate that the
controller has stopped tracking that particular device.

---

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.

 doc/mgmt-api.txt | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb0..0fd884ed0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
 Device Flags command, Set Device Flags command, Device Flags Changed event,
 Read Advertisement Monitor Features command, Add Advertisement Patterns
 Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
-Added event and Advertisement Monitor Removed event.
+Added event, Advertisement Monitor Removed event, Updated Device Found event
+and Added Advertisement Monitor Device Lost event.
 
 
 Example
@@ -4247,6 +4248,7 @@ Device Found Event
 				Address_Type (1 Octet)
 				RSSI (1 Octet)
 				Flags (4 Octets)
+				Monitor_Handle (2 Octets)
 				EIR_Data_Length (2 Octets)
 				EIR_Data (0-65535 Octets)
 
@@ -4263,6 +4265,7 @@ Device Found Event
 		1	Legacy Pairing
 		2	Not Connectable
 		3	Reserved (not in use)
+		4	Device Tracked
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
@@ -4285,6 +4288,10 @@ Device Found Event
 	accept any connections. This can be indicated by Low Energy
 	devices that are in broadcaster role.
 
+	The Device Tracked flag indicates that the controller has started
+	monitoring a particular device matching the Advertisement Monitor
+	with handle Monitor_Handle.
+
 
 Discovering Event
 =================
@@ -4910,3 +4917,26 @@ Controller Resume Event
 	Address_Type. Otherwise, Address and Address_Type will both be zero.
 
 	This event will be sent to all management sockets.
+
+
+Advertisement Monitor Device Lost Event
+=======================================
+
+	Event code:		0x002f
+	Controller Index:	<controller_id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+				Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This event indicates that the controller has stopped tracking the
+	device that was being tracked by monitor with handle Monitor_Handle.
+
+	The address of the device being tracked will be shared in Address and
+	Address_Type.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	This event will be sent to all management sockets.
-- 
2.33.0.882.g93a45727a2-goog

