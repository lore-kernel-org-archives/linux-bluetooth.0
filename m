Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002CDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7BA600CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhI0USt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhI0USt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:18:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4560C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a251182000000b005a027223ed9so17549560ybr.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cXX3iSCnNkg1qWcmh4C8N+aEjrcE5o7s94vdqDBfYsE=;
        b=fuApOPepuodiJbdCIZNvv6UPBRrg9gAv5l0EXksNp30i5ZrvJr8hfl94qfO4JtYFbJ
         mzJveLmKIJHOOQ5CranZMjkjpmigAUjpEOEode03MMQ4STlv3an+CCFF4SF1+We+X+3m
         nyct3qWihhPYZui5hixGi4s0SMuxsR54uqzX0lDFiiNV2GTSSaaNwLiNCmb3DsMOZRmF
         8br0PDUB29tA0fvksulwTUNy9ew34jQZGCBZLWT4YQ5DkJtzULJQQdsxLY0spaRaI3Lr
         NSF5nm0f3+dtyIvxne0ujW2xESkDiiVZi9GEfVhSs3JTpbDvJbmB0ZCrmJLGLj7qe7tv
         IubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cXX3iSCnNkg1qWcmh4C8N+aEjrcE5o7s94vdqDBfYsE=;
        b=Syqy+3L26WldLAltKBG9rPeQVkTxYWnkNdFXx6/tjFrZ6H7+v+hwICuFc8Axc1KRWK
         nn0ofzmnqXz0sMJpYvpqIJF8ASxTPWKpCzjMoIIo5P+WrgvR3H7GZ6RXUO291UHWUl97
         jZR+h2pYl1/H2+rBAtrcWF/rv/cW+CjNnRBZ89VGDZVQX0jMMgpstLl0p7Z/t5xWX+8x
         X9PXcOK5dgHikjlgK9KLubLfYb5E/ZciC4IVp4q+/O5tW2soFl7SSfmgFc7JtcutXVMJ
         cWSQo9uHmAfcRa7TL3n1+nS2w79Xd98ol9CwY+tJCfWaGXTq6+8xfDVL/L2tQztfc3JA
         Lu8A==
X-Gm-Message-State: AOAM530e+tsfxAhd34+F+GZeIy/82QR60v42oVeBMq+geWWzAhlUsPyf
        ART84VGCpYJBcoXGOarN4lO6lCnDN1o0tQ==
X-Google-Smtp-Source: ABdhPJx/YcAh7wk3KuiiJOGEiD/mhJ8E2aGwQdQnX0BAr7V7Pi1o/16BcbcGGjzfyGGT2TLJUDd0Dx40r9yOmQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8f29:89eb:dfbc:3b00])
 (user=mmandlik job=sendgmr) by 2002:a25:1c86:: with SMTP id
 c128mr2065372ybc.83.1632773830022; Mon, 27 Sep 2021 13:17:10 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:16:55 -0700
In-Reply-To: <20210927201657.593569-1-mmandlik@google.com>
Message-Id: <20210927131456.BlueZ.v1.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Mime-Version: 1.0
References: <20210927201657.593569-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [BlueZ PATCH v1 1/3] doc: Add Advertisement Monitor Device Tracking event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the Advertisement Monitor Device Traching event. This
event indicates that the controller has stated/stopped tracking a
particular device matching one of the already added Advertisement
Monitor.

Reviewed-by: Miao-chen Chou <mcchou@google.com>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

 doc/mgmt-api.txt | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb0..06df3e914 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
 Device Flags command, Set Device Flags command, Device Flags Changed event,
 Read Advertisement Monitor Features command, Add Advertisement Patterns
 Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
-Added event and Advertisement Monitor Removed event.
+Added event, Advertisement Monitor Removed event and Advertisement Monitor
+Device Tracking event.
 
 
 Example
@@ -4910,3 +4911,27 @@ Controller Resume Event
 	Address_Type. Otherwise, Address and Address_Type will both be zero.
 
 	This event will be sent to all management sockets.
+
+
+Advertisement Monitor Device Tracking Event
+===========================================
+
+	Event code:		0x002f
+	Controller Index:	<controller_id>
+	Event Parameters:	Monitor_Handle (2 octets)
+				Monitor_State (1 octet)
+				Address (6 octets)
+				Address_Type (1 octet)
+
+	This event indicates that the controller has started/stopped tracking
+	a particular device matching the Advertisement Monitor with handle
+	Monitor_Handle.
+
+	Possible values for the Monitor_State parameter:
+		0	The controller has stopped tracking a device
+		1	The controller has started tracking a device
+
+	The address of the device being tracked will be shared in Address and
+	Address_Type.
+
+	This event will be sent to all management sockets.
-- 
2.33.0.685.g46640cef36-goog

