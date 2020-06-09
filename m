Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35934C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D64620737
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lMtWXp9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgFIBDd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbgFIBDc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 21:03:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8335C03E969
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2020 18:03:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h95so614537pje.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2020 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/OtGkgijwqhoxGmYgZeXvHt4d+RHj/6sFOCvH4ycIM=;
        b=lMtWXp9DGWCUQFOspELPMlis7SVsKjr1nrp2SErWLxak6x55aJq94/ebs+dDX+sKjQ
         tckHfkVePP1/7VBI3G5CSME1WvipAQ+loYupGJBqmmFNtFEoLgj4Rxj6QXMW6H64pBZH
         R1DeFYAoebZscsPnm+7z/JNEtbDX1ffcsM48Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/OtGkgijwqhoxGmYgZeXvHt4d+RHj/6sFOCvH4ycIM=;
        b=SNKR2Sl6eTOjZpFOQCIKjLjgw56oADdwNrdF9gKM9BZTB27Kbj3O+NdVhL6Mc97+Fe
         LNpXak+QmvUK0gUlBLKs36vv9ma+eJP5yaxJTsWcdX4iwBzl7UBG1tvhrRd25U/8lQDa
         8HNpRFE/pne5potYWrLrv750Zc3roXzvmSKJrt0H1td6xM1G4WpltAWS5uJg1UppM3w5
         QWMWkJVoAF+MuqLNdYRFkVU8c+Yg0j7YBvxZkrI4aq258gpxU/+jp5lvRQeVqfcCIvet
         KKqytMCHkWTtJukXGllLZFCcBVsz5vkeiHfmv8mOcE2Fqlsa1QshXGpsmIpBMd58bNmm
         2mBg==
X-Gm-Message-State: AOAM530UJrdv47D1i2GImQxoZarfP1RVGl7IOCsSpDRlrZjOAqrXKMpG
        Cp9AT+DYDfPYcpF5VICwWi/rbtWZHnc=
X-Google-Smtp-Source: ABdhPJzZ/f/TLRAYswtiqgRxRnQ9CxDIDLe30jZGCRn7dIiO/l/OEVnSD1g8Jlb8k+bEAnF4XMEsFw==
X-Received: by 2002:a17:90a:1aaa:: with SMTP id p39mr2036161pjp.127.1591664610688;
        Mon, 08 Jun 2020 18:03:30 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id j8sm638646pji.3.2020.06.08.18.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 18:03:29 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [BlueZ PATCH v1] adapter: Fix the unref and reset of watch_client's members
Date:   Mon,  8 Jun 2020 18:02:59 -0700
Message-Id: <20200608180241.BlueZ.v1.1.Ibf8331f6c835d53fe7ca978de962f93981573d9a@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This properly handles the unref of client->msg in
stop_discovery_complete() and the reset of it. This also handles the unref
of client->msg, the reset of client->watch and the reset of client->msg in
start_discovery_complete().

The following test was performed:
(1) Intentionally changed the MGMT status other than MGMT_STATUS_SUCCESS
in stop_discovery_complete() and start_discovery_complete() and built
bluetoothd.
(2) In bluetoothctl console, issued scan on/scan off to invoke
StartDiscovery and verified that new discovery requests can be processed.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 src/adapter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 76acfea70..0857a3115 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1652,6 +1652,9 @@ fail:
 		reply = btd_error_busy(client->msg);
 		g_dbus_send_message(dbus_conn, reply);
 		g_dbus_remove_watch(dbus_conn, client->watch);
+		client->watch = 0;
+		dbus_message_unref(client->msg);
+		client->msg = NULL;
 		discovery_remove(client, false);
 		return;
 	}
@@ -1926,6 +1929,8 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 		if (client->msg) {
 			reply = btd_error_busy(client->msg);
 			g_dbus_send_message(dbus_conn, reply);
+			dbus_message_unref(client->msg);
+			client->msg = NULL;
 		}
 		goto done;
 	}
-- 
2.26.2

