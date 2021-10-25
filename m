Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F03C43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF18610F8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhJYT3X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbhJYT1A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 15:27:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCEBC043182
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w5-20020a654105000000b002692534afceso6812923pgp.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GadM25GyCQsUcLWDoGrNQ7kgJjqimAr+mqriDFRUSME=;
        b=C0yS2882OBq7SwhFmxAiqnCDkwtQNbjVnzdwwzBcaRcaisaAUaAeW/jIistLO7HCOy
         Rh/dqASRA8yPDOgrPKW0cBW6to08F5cOp7EAzQozHrEGOdZFCTYT3p2MfVVY9kchnCkH
         Dx523kamjoDWn/jF5HLNcte8jVSbGiJFDBufi5SMpHgjM2qbhbtQPLjgUZY91DTUgIZd
         DsOKwAOt1I64g9SWcxZrPwQM6VQb6lcHs5OOcnQ38ABVIr1wO0DcgAy2CM3OzQqU2uKU
         5Y5crr67F2GOFk+H62Ymx0jtyvCvxVvNliXODxU5rzFEXCGwsJx8KMbWX2rFCuDr6Z8s
         TNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GadM25GyCQsUcLWDoGrNQ7kgJjqimAr+mqriDFRUSME=;
        b=mhNt1w7GhOXSaUbSYDXB9ZhMZSafSwgcAQ5u9e0MsvRvYI96BNFCO2cejJbBtpo3FM
         AnWba+H0xpv1FtW2I6puDQuWeVK3YmUdqv0qhJ4cx3juCmPAnOF6Igx4UbAo5rw0Xs6R
         OFQDwcARiDtPmYoL2FPHzmLVfT9Kp6sgwSELiI/T2SHppIhpiV0Mpc1iHZGSvENcbBr0
         2fL8I0PdphMxARUX7UBl2/z+9AKG681RoWwGEOCnL2vGF9VrZFHstGGN8gD7KR89amte
         BSWWHpA9VFimWpSnP+au3SJ3abuZKg0pfVfi2w/U3TFo0PCWmCp5PDjwmtRg+KKujeQW
         AZ3A==
X-Gm-Message-State: AOAM5326XhpXyQDwSCX4b2Sqtd5GPsvyDd/L2EzQZDgcqcJR/z8CpX/9
        /tE/+YihJbqnmK8mD6ln7IDWy+zbJsyUSQ==
X-Google-Smtp-Source: ABdhPJwB9FPeB/IN6eRA7FMc5jF9e5Pc3CdijHdYwXACBNWJzPUTgzaji/sgdUltc4YFhsToGc57bf5QHy5Hbg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e7c3:c740:ce43:5358])
 (user=mmandlik job=sendgmr) by 2002:a17:902:708a:b0:140:e30:a48b with SMTP id
 z10-20020a170902708a00b001400e30a48bmr17910858plk.54.1635189511507; Mon, 25
 Oct 2021 12:18:31 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:18:09 -0700
In-Reply-To: <20211025191811.3575708-1-mmandlik@google.com>
Message-Id: <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Mime-Version: 1.0
References: <20211025191811.3575708-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [BlueZ PATCH v4 1/3] doc: Introduce the Adv Monitor Device Found/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces new MGMT events to indicate that the controller
has started/stopped tracking a particular device matching one of the
already added Advertisement Monitor.

---

Changes in v4:
- Add Advertisement Monitor Device Found event, make Address_Type 0 as
  reserved.

Changes in v3:
- Discard changes to the Device Found event and notify bluetoothd only
  when the controller stops monitoring the device via new Device Lost
  event.

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.

 doc/mgmt-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb0..32dd8c0f2 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
 Device Flags command, Set Device Flags command, Device Flags Changed event,
 Read Advertisement Monitor Features command, Add Advertisement Patterns
 Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
-Added event and Advertisement Monitor Removed event.
+Added event, Advertisement Monitor Removed event, Advertisement Monitor Device
+Found event and Advertisement Monitor Device Lost event.
 
 
 Example
@@ -4910,3 +4911,50 @@ Controller Resume Event
 	Address_Type. Otherwise, Address and Address_Type will both be zero.
 
 	This event will be sent to all management sockets.
+
+
+Advertisement Monitor Device Found Event
+========================================
+
+	Event code:		0x002f
+	Controller Index:	<controller_id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+				Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This event indicates that the controller has started tracking a device
+	matching an Advertisement Monitor with handle Monitor_Handle.
+
+	The address of the device being tracked will be shared in Address and
+	Address_Type.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	This event will be sent to all management sockets.
+
+
+Advertisement Monitor Device Lost Event
+=======================================
+
+	Event code:		0x0030
+	Controller Index:	<controller_id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+				Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This event indicates that the controller has stopped tracking a device
+	that was being tracked by an Advertisement Monitor with handle
+	Monitor_Handle.
+
+	The address of the device being tracked will be shared in Address and
+	Address_Type.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	This event will be sent to all management sockets.
-- 
2.33.0.1079.g6e70778dc9-goog

