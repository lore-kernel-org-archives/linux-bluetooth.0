Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487DFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2974963215
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhKOJbY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbhKOJbF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:31:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C67C061208
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:28:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w132-20020a25c78a000000b005c27f083240so25632746ybe.16
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WOluhswfgIpnIOxltiea7SEHIW1MQWv5mZlgiYCI4Ys=;
        b=EeGuN2kvK66to4+SBcRBRlKz56ZzgbGlE6cRLRFBFj/kxj1bLKXCJ4KCIOeWaNRNyX
         JnKucOtvkDOrDHiIIa7FLScX+yxG/ifRSKiJWd8enuWu5OkrpGfHtiC2WaJdNXN4GICo
         5YjJ7NpZ04T8XsgZfvNtrr85NS4Da+Yu11Y/oYh28Oar8yY8RDryOrwds8IgaTvMirno
         mDKy5TanrzruvFLZTTIiFmV6rGwp7oynn/hglNxFXtBv18KsAISO/pZyiiwmu5JK7TPy
         7L6WOBnEuYxX1I4tgZlF2ca0YBkkHxbQqqcpKJx1EizAvIvXL8j72yRaEQKyiuQIegq+
         ujpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WOluhswfgIpnIOxltiea7SEHIW1MQWv5mZlgiYCI4Ys=;
        b=tXecBvBPYIcbM7ldSzLAy8pdcmiFHiqVE68BlMQl+t5/Z9iTF57ma4x2KPH/0HBZCk
         MbLpbp2R8oRtn4QYaFr4UIoPmjl1XHxeP0UvIhFT+5x3GOSv0EcvRHQD/9999dJvup0/
         u4g71s6lQ/Swo4j7AdPRdR0zxaa/UJluyC6Ni1cdARgC4S5henWOS3c2vXZTYi6F5okl
         dATsEamBdbMgBFgS5PdWfNxBDX73EeFSUEL0icgk4+oJ1Sq00nP6O9WiRJbhTUvVjXso
         YQkIqUgry97COHblZzrgRYflXcuzaR2QmrQJci4wTJROLvtEqEo9+j7IP6OdX0X9EYYd
         h7Pg==
X-Gm-Message-State: AOAM531EWsKc6Q6gq1Kkinlp9j/rbVeYW8Czzz0He+901MJMyhPlimTL
        GMec9OgzTAMcwQcDPzwqySdqd3KGQcUFSFFCq4bfvn0DBauBCLmzjE9rbZIxOX152Aqskgb1vS4
        9LbWWOVCK2BpB3boOIMmTaUuPSiL9Fqxk3dZYZ2ughjObENyJYXYWwy26y22MVRBqj/H7i7ZRIv
        z9
X-Google-Smtp-Source: ABdhPJwpC2fcLjmWCaQOmrIYG/A+cuRUwlf58jvIh69cme43l1eS62XOy+EJUjD+W3Z1nHKAaYvwaBB2Laa/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5c8f:7191:e5ca:14fb])
 (user=apusaka job=sendgmr) by 2002:a25:acd4:: with SMTP id
 x20mr41251167ybd.416.1636968482765; Mon, 15 Nov 2021 01:28:02 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:27:45 +0800
In-Reply-To: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Message-Id: <20211115172714.Bluez.v3.3.I29367ca288fc8f4fcc3b4063425b791501c6534c@changeid>
Mime-Version: 1.0
References: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [Bluez PATCH v3 3/3] doc: Add Name Request Fail flag in device found event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Userspace should use this new flag to decide whether to do the remote
name resolving or not.
---

Changes in v3:
* Update the flag name to be more inlined with the spec.

Changes in v2:
* Update docs to reflect not sending DONT_CARE flag behavior.

 doc/mgmt-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 97d33e30a1..845031b017 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4089,6 +4089,7 @@ Device Connected Event
 		1	Legacy Pairing
 		2	Reserved (not in use)
 		3	Initiated Connection
+		4	Reserved (not in use)
 
 
 Device Disconnected Event
@@ -4263,6 +4264,7 @@ Device Found Event
 		1	Legacy Pairing
 		2	Not Connectable
 		3	Reserved (not in use)
+		4	Name Request Failed
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
@@ -4285,6 +4287,11 @@ Device Found Event
 	accept any connections. This can be indicated by Low Energy
 	devices that are in broadcaster role.
 
+	The Name Request Failed flag indicates that name resolving
+	procedure has ended with failure for this device. The user space
+	should use this information to determine when is a good time to
+	retry the name resolving procedure.
+
 
 Discovering Event
 =================
-- 
2.34.0.rc1.387.gb447b232ab-goog

