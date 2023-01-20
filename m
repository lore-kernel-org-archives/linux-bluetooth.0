Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49833C38159
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 19:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjATTrw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjATTru (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Jan 2023 14:47:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C29D95758
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lp10so3156135pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLkq6q/okt0GkgsTj5xp39MSMsYIl9kNLVja+aNu/yM=;
        b=HjzVcHgVHCvhnIOfg0iMwYWPTheo7Q8brcfJzzTzSbSji2ufAZZYuW6dGNBruO6Xav
         GMDXfv2RiwzGWHhdaHjTGfs6zkKXtdWFb5kOya8mVoFb0c+ulRSHgzo04RldS2JP682/
         BnEyv0zNPes0YNwlhzgEyIgWKHdgAuwRXfmWpGAbhIc6V8ITz3nyR3m0g8JUwuWtT647
         dWC8L94kljgsjOatEQCIS+bL4gWPtHG5xm6Lb93X6Mda94RggY3EwRekJCsS9HvWpsXJ
         /pVHjHMA5OFiBHFYi7y8awWfha51jKp1Ypy41/Rp+7xBhzxzgDQ6gj2usO5cev05Yu5l
         21VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLkq6q/okt0GkgsTj5xp39MSMsYIl9kNLVja+aNu/yM=;
        b=s0YyS/FwyKGLOqREXrubfnCM7Bs5hqFW97ndmKUAdH6feOnc4oXfQkphBw5f8UdE3w
         x8qbcI8O5JyYSCW8b1HTm5H9ZHBygbHN9kAZ1uD/czPa8g09VsCcrnlEoyNkPdRX4OPY
         8RPS7znxC+TAXhRyWgKEu10UFPrFgmIeCPY+kKKwZUiciX0GlwmzYJuF8H1LBbEZs/IS
         moyeZyQseX2wY8/CnShamIH4MC0z1Vqu5B/xah2Z+SwFa+cjpg7JLJuCFYERVigT9E7I
         8YhfIizXBjql3isIE4HYHKxwVbTMXoQnoUZhTHFwSBYmyPvIFFBJJqXqoYDgBbUjNdPB
         wMyA==
X-Gm-Message-State: AFqh2kqPqMRfTmLagGQ/W5sCZF80vlkIi8hpIRgZroCVg8goUbi7r++9
        82jqcZA+p/WRCXzyx2SSctINFbPrt915dg==
X-Google-Smtp-Source: AMrXdXsjCFKjNblCIshfOcTSwJIbaPLWfT6m+V/tnKfWqkoD/pz2djRUihg9YGIpXA5RwezUgPRrsQ==
X-Received: by 2002:a17:903:11d1:b0:195:e2cc:6f35 with SMTP id q17-20020a17090311d100b00195e2cc6f35mr4917815plh.59.1674244066650;
        Fri, 20 Jan 2023 11:47:46 -0800 (PST)
Received: from fedora.. (174-21-24-126.tukw.qwest.net. [174.21.24.126])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm5149967plg.134.2023.01.20.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:47:46 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2 11/11] mesh: Switch beaconing net key
Date:   Fri, 20 Jan 2023 11:47:31 -0800
Message-Id: <20230120194731.90065-12-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120194731.90065-1-brian.gix@gmail.com>
References: <20230120194731.90065-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

When transitioning from Phase 1 to Phase 2 of a network key and we are
beaconing, we need to halt the beaconing on the old key version, and
begin beaconing on the new key version.
---
 mesh/net.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index 81f1e57ee..05ca48326 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2625,6 +2625,13 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	if (subnet->kr_phase == KEY_REFRESH_PHASE_TWO)
 		return MESH_STATUS_SUCCESS;
 
+	/* Stop beaconing on old key */
+	if (net->snb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, false);
+
+	if (net->mpb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, true);
+
 	subnet->key_refresh = 1;
 	subnet->net_key_tx = subnet->net_key_upd;
 	/*
@@ -2632,6 +2639,15 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	 * it hears beacons from all the nodes
 	 */
 	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
+
+	/* Start beaconing on new key */
+	if (net->snb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, false, 0);
+
+	if (net->mpb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, true,
+							net->mpb_period);
+
 	refresh_beacon(subnet, net);
 	queue_friend_update(net);
 
-- 
2.39.0

