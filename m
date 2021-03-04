Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF45C433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D548B64F51
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhCDUZ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCDUZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 15:25:44 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E15C061760
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 12:25:03 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id b15so13343473qvz.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 12:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=B4e7SmHOZkqh/Hs71+KSM2Oz1ObvmdMgmfIEeDwkkGs=;
        b=uP9WBDwTr7fvhGYU/6XmcCNGc9DWsqPxZk8IOdsFXCTjeeywppawb7h/rEUQzsi7My
         8beW924VmkYCCNnmiH0wm9HmBKHYbgeEX9A0M7W5SIdKfP9rqLZ+OgwXQ9ZYkV0BOFMJ
         l+SLWdaDrykded/R+v/4ARKRRoIShL+SDPY3Z/t2tUejJuk+Yca+XhZCdEyJsf/V6hda
         h6npmiEoTYIuEubOAKA8HXbnpxqp6jzxsOoaTW8xf41Wz/ZvjMQfmA6dlthAEIpvHQ1E
         b6EmBy2/8E8/Y8T1hsifS+A578qC3/yZsL3UnpP3fQIqxJh9nYLdE7y+NocvokT7MxTc
         9sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B4e7SmHOZkqh/Hs71+KSM2Oz1ObvmdMgmfIEeDwkkGs=;
        b=APd3Q9p2Hgtz2hV9x8tZEWzfAXZD3GPkCgz6T0j/zB1PAL4V5FfX7W05/I+PCtDbSO
         NS/Mk4W+It7oiVr7RjKVXHxXQzdxLEF3TC/uSgGWTvH1CngEZyQ9tZTmilmNVKRJqjfV
         PKq0ePhacucow1ddRp0/hEH5Ppq+IPLoaBZmdduo8S/Q0/DuE1dcSKikLoaAZBZHv2yP
         ODovzwm0E3UamzKDa5XGARY+hTlUxxV+TVTnzdyrw9ngmMn98GwnboIoH/xSDd6FcVyN
         E2GGq66PZ18/3QfXzfozXnoP2A5nIBlaVMyGbiEw3Mg+ndz0DQdGCh8948Etp8N1P5YY
         6tYg==
X-Gm-Message-State: AOAM532MlfKKv4fXKkq7YNOTYDyThbEFH1fwIpeURnqBjI1orYqTWhHb
        tbIIftAoV0zhxY3UEtWwIH/OD6WD7w+mI9GgvYGjXRF/lQJ2+SOz6i/rBONRaq0yx7V2tUrQ4mH
        7T78Nq3Fl69eSx3WWuU7V29SGQ9ph9LUGz/aP0DdzxdVchii6gaTlwccicYZaDQcjY91uNu8NYl
        DJewACSwZjovyEta5k
X-Google-Smtp-Source: ABdhPJzLD8n5jhWune5wnbXjkex1ptGEQJE/WSaTSOueIGpWj3ni1lYy5Df5VLllWscE2mfX8y1hwMYHHYXYNVSWtfGk
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:a873:4408:c731:b8f2])
 (user=danielwinkler job=sendgmr) by 2002:ad4:4ab0:: with SMTP id
 i16mr5520768qvx.1.1614889502952; Thu, 04 Mar 2021 12:25:02 -0800 (PST)
Date:   Thu,  4 Mar 2021 12:24:51 -0800
In-Reply-To: <20210304202452.1998022-1-danielwinkler@google.com>
Message-Id: <20210304122005.Bluez.v2.2.I45b896f4512038309cbeab7a01f51e503141edab@changeid>
Mime-Version: 1.0
References: <20210304202452.1998022-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v2 2/3] advertising: Create and use scannable adv param flag
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In order for the advertising parameters hci request to indicate that an
advertising set uses a scannable PDU, we pass a scannable flag along
with the initial parameters MGMT request.

Without this patch, a broadcast advertisement with a scan response will
either be rejected by the controller, or will ignore the requested scan
response. The patch is tested by performing the above and confirming
that the scan response is retrievable from a peer as expected.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

Changes in v2:
- Check kernel supports flag before setting it

 lib/mgmt.h        | 1 +
 src/advertising.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 76a03c9c2..7b1b9ab54 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -507,6 +507,7 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
 #define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
 #define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
+#define MGMT_ADV_PARAM_SCAN_RSP		(1 << 16)
 
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
diff --git a/src/advertising.c b/src/advertising.c
index f3dc357a1..cdf06154d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -945,7 +945,13 @@ static int refresh_extended_adv(struct btd_adv_client *client,
 		return -EINVAL;
 	}
 
-	cp.flags = htobl(flags);
+	/* Indicate that this instance will be configured as scannable */
+	if (client->scan_rsp_len &&
+		client->manager->supported_flags & MGMT_ADV_PARAM_SCAN_RSP) {
+		flags |= MGMT_ADV_PARAM_SCAN_RSP;
+	}
+
+	cp.flags = cpu_to_le32(flags);
 
 	mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
 			client->manager->mgmt_index, sizeof(cp), &cp,
-- 
2.30.1.766.gb4fecdf3b7-goog

