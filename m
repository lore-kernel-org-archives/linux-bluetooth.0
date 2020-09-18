Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B03C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2210821734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjS+4Zps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIRWOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRWOK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24AC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k3so7020914ybp.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bkV98mI6HTRBlveAwJJOx4rOMskQp0RNxjsBtvixoqs=;
        b=UjS+4Zpss152SNoNBSO32DHFsLojPtyJw3i+GuvleOYCi8hQ9rlM0ItVrh0W+MMFX4
         D3YV+Ur+Rum2j6f6pVeJTflJV9uP7BNwJMZ8A/d6coeg0/0TI3HGh7vHtJ6A5fFPNvlO
         Y1PUWDjYIDflwyEOI9b6YjU6zhFEsas6lS2pYFakM5RD1+dxiPY+lRcvar8YS7xq+P6h
         BcZaxAdbTqniefdQJQOOQb9aNFW8nNIkzqob6TQBuDmtkaWJoF73eRFR/Neqwx0qQ7uz
         oP0nwEPkN2v2rqtiyK6uaAk3t3+OZbcO5GIujEHcXwnTANO/bL/aCTLs5GZ15y9I0Uiq
         FWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bkV98mI6HTRBlveAwJJOx4rOMskQp0RNxjsBtvixoqs=;
        b=oiCuZpR8RKrQhTY29Cmy099mGavG2rbEv9gKw8AheLqxrGXU/dr7U366wDMyNzzT7f
         GnahM+ht2LnlIEB0PVBxbcwyTeh3X3/a9mfBlkVmbmfKHwes8KoqN9fYO3xL+Zw/USqv
         /rQFZUBxCSsRb5U8q9ZbMvNckKAdk3xh81qCgty0IJVRMJdxG/q5zho3/NU4jWp0RduV
         ZtYlvamxJ3sPonK2q1MDQzHK6BWoWLKwfeOkJo1UF6mwXsuVa5hKs1f6LNy5z4Oyz922
         9UmRhfzKhUTy/2duxWAnzqsMhj+PiZGYSro4okr3E4hbs6OW8dH2jQMxpWOYGiOhlUag
         zYMg==
X-Gm-Message-State: AOAM532m8QOINr7LphH3/ZC9JKnytTvOsx/wf8XD8ghy3hBy7l4q9hZ1
        ahP8cFo+IO/caCnKlRBR5cKDqmFAP8TsFPOQBb7C
X-Google-Smtp-Source: ABdhPJyNpbteRCiREnsaR7X6D0/wXYQ3N25hOoH+i+QUENmMweBb9oKlq1/2WVyF/e+oULjZwxv+X9vt7ZMqUH4Vz6/l
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:6e87:: with SMTP id
 j129mr35630636ybc.424.1600467248869; Fri, 18 Sep 2020 15:14:08 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:48 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 01/10] doc/advertising-api: update API with new interface
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates the advertising documentation to include the following
features:

LE Advertising Manager:
- New SupportedCapabilities property

LE Advertisement:
- New min/max interval properties
- New tx power property

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2: None

 doc/advertising-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..3215a52f7 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -138,6 +138,33 @@ Properties	string Type
 					"2M"
 					"Coded"
 
+		uint32 MinInterval
+
+			Minimum advertising interval to be used by the
+			advertising set, in .625 millisecond slots.
+			Time = N * .625 ms, where N has range
+			[0x000020, 0xFFFFFF]. If the provided MinInterval is
+			larger than the provided MaxInterval, the registration
+			will return failure.
+
+		uint32 MaxInterval
+
+			Maximum advertising interval to be used by the
+			advertising set, in .625 millisecond slots.
+			Time = N * .625 ms, where N has range
+			[0x000020, 0xFFFFFF]. If the provided MinInterval is
+			larger than the provided MaxInterval, the registration
+			will return failure.
+
+		int16 TxPower
+
+			Requested transmission power of this advertising set.
+			The provided value is used only if the "CanSetTxPower"
+			feature is enabled on the Advertising Manager. The
+			provided value must be in range [-127 to +20], where
+			units are in dBm.
+
+
 LE Advertising Manager hierarchy
 ================================
 
@@ -209,3 +236,26 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		dict SupportedCapabilities
+
+			Enumerates Advertising-related controller capabilities
+			useful to the client.
+
+			Possible Values:
+
+				byte MaxAdvLen
+
+					Max advertising data length
+
+				byte MaxScnRspLen
+
+					Max advertising scan response length
+
+				int16 MinTxPower
+
+					Min advertising tx power (dBm)
+
+				int16 MaxTxPower
+
+					Max advertising tx power (dBm)
-- 
2.28.0.681.g6f77f65b4e-goog

