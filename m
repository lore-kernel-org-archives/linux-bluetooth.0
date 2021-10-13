Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD8E610F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhJMTCz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbhJMTCx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BFC061760
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so4201393yba.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N148upwECZuKBuXLljfToEWTP54GXh5i1JTO1D8BPxM=;
        b=Tj26+t4WNcTMaDPYA9J9gHQlwhoNG4cMrFQO701c/6F8ylMsHCn77Sw3hqb81WXS/r
         O/r1YkZqmVLRSUcwAcArPUAacUPKS1C8uD4H+200sH34wjuHsboYGXr3aN8PKK7tLbG8
         OkW5Qhjk6f744ZdZU+DkgZBNKM4j6/bEieaGvHfyeuIfVB2sKnchGKmWEl1Jq1u58xnz
         fJmBd7wj0TfgtNb3Q4Y9/LXNYzJhLFuzUI7lMrspoizQa4Uc1RV+sa959+AVqLhrmysF
         iMcOqgJd6OsbG6ttF537UZcwKzHq/la5235mPuA7ForIx7OsKlgx4XUgWVZ2OMZdYsbL
         SaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N148upwECZuKBuXLljfToEWTP54GXh5i1JTO1D8BPxM=;
        b=1XokugDYg5BIH8FbvZIwF7cYW7wrRPTU+r9ovmFZHWZ+r/LmVInP4iZoaH18RsNwge
         JqwG9B4QerUwB7S1rqOaJDXBw6ahyAdd1qMEZTR4CswyVv0/a0rm1WeCNgbpMdBTP9or
         b4holCqaSTqsqant5zl1GY3dNV49mO7raxVRjNYM2G+vnOHDzpPeypHPCREY+wnzz39e
         fNzPwW/bheod9hce7tgKnFvAfHAvWnhjmrsduYIZdi+gJdGoIIXaiXJwpHPHZekfZNaN
         BHVgPSgCBG36tF+dlT/fNFLLYIVUpQC+6N4/oI+EJDS3UVXQGa/P4zv44Cb3NQvSdQ+p
         PvpQ==
X-Gm-Message-State: AOAM532sNZGIDgK99L/Uo1jhX3Um9nM4cwys3NCwr2NBqdZdmSscAlCC
        3USksgbY/u1msQAeYoJiI0fbxBn2JaOxYA==
X-Google-Smtp-Source: ABdhPJzcYQum4L1OOWyjQqwYyrkJ3TMH0GiDVssLGSUmkh3GJ7KPdzecJDmtFRYZOdnsVWUOnyqjRxMbjxW4AA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:9910:f10f:1467:c3f])
 (user=mmandlik job=sendgmr) by 2002:a25:2202:: with SMTP id
 i2mr1216735ybi.223.1634151646527; Wed, 13 Oct 2021 12:00:46 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:00:33 -0700
In-Reply-To: <20211013190035.1876237-1-mmandlik@google.com>
Message-Id: <20211013115927.BlueZ.v3.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Mime-Version: 1.0
References: <20211013190035.1876237-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v3 1/3] doc: Introduce the Adv Monitor Device Lost event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a new event 'Adv Monitor Device Lost' to indicate that the
controller has stopped tracking a particular device.

---

Changes in v3:
- Discard changes to the Device Found event and notify bluetoothd only
  when the controller stops monitoring the device via new Device Lost
  event.

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.

 doc/mgmt-api.txt | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb0..712bb362d 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
 Device Flags command, Set Device Flags command, Device Flags Changed event,
 Read Advertisement Monitor Features command, Add Advertisement Patterns
 Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
-Added event and Advertisement Monitor Removed event.
+Added event, Advertisement Monitor Removed event and Advertisement Monitor
+Device Lost event.
 
 
 Example
@@ -4910,3 +4911,26 @@ Controller Resume Event
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

