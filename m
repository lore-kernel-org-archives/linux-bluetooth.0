Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99659C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323A720838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNjemyS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJ2VXs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VXr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:23:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F1C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:47 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x85so2632602qka.14
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=txKoRgXFpX5OkMoNQV35XeQq+co/kJjUR3niRDei33Q=;
        b=PNjemyS6pu+tgo4jjlNOk6+DABURU5fkxZ/HA/21CRZr+BqeQNEImZN+eWwKEpq2zk
         qKkIT+PCVjm49sTgdOJUrdfkegN8g/EiKhYgnuwFaAvgYwzEAl02QQnK/jJL4eZZxqQf
         O9gz7S5sydefKcuz78ERv6BU6BsEsZ/zy7/7mPNYs0NoWihVl42DHMWe/ydjg4TuWphZ
         BN53T/zMf/PqRXhOhXgww0uEOzIvIQF61lOz/DG+YK9wccL/RYiWdPmxwVPQc18mG2qk
         iS/Xdt/BV5lD/MwjbSrkAltu1COr474a6RSgkQ42fgfahK0QezzQA2f4wJzqBIOJRz9U
         N8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=txKoRgXFpX5OkMoNQV35XeQq+co/kJjUR3niRDei33Q=;
        b=r/4AHMtRGIa03WL8XbkKH9/Dny1Y+CDgFQT06PTAiK5shuTqeLmo+goVmXRkHKH/8y
         t1BG0SpUU2AlfgdRtvb01wmPq88JSMOspSv0VbwpxFnbFCAHMJ2woHzf5GqMexLlD2Sb
         kFa/RoFBjZ/zRqUFuB6JtUTG/7ScJvMGSSnTsV5a9bZUPLHF7WyQc1CCe4nc6LdBl0j1
         9Uo+WCXNSbDnJnPI0e8HSDIpOm1Bvby7RMlN1zmOHt4RshLmWPvQOolJo0TcN5XnIBcO
         aEzHqUu1mXWd7KO7K4pKgAL5+rSPgULvP2/0Nwn+FaNNcN3HbC7LxK4OXyvHOXRrstR7
         uoWA==
X-Gm-Message-State: AOAM533akoh3sRKKfAPfO2ePeF/JcQv5UTFWvP6aB/6u6dmIvSEdbnkk
        rYqlQDpecTspmY/ILsrmy6b399w8XCAPmWyz1w8T
X-Google-Smtp-Source: ABdhPJxWUj090iNAeJmqRNWcSY/dGZq4v/0KPg5SwBkxAfJXllUhjcbtQxN48aWHXPhcMeOxATg6QMSZgwclRYKrM6Ft
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:cb02:: with SMTP id
 o2mr6342760qvk.8.1604006626942; Thu, 29 Oct 2020 14:23:46 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:26 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 01/10] doc/advertising-api: update API with new interface
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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

Changes in v5:
- Changed interval API from jiffies to milliseconds for clarity
- Changed new dbus endpoints to be experimental

Changes in v4: None
Changes in v3: None
Changes in v2: None

 doc/advertising-api.txt | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..541c57004 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -138,6 +138,31 @@ Properties	string Type
 					"2M"
 					"Coded"
 
+		uint32 MinInterval [Experimental]
+
+			Minimum advertising interval to be used by the
+			advertising set, in milliseconds. Acceptable values
+			are in the range [20ms, 10,485s]. If the provided
+			MinInterval is larger than the provided MaxInterval,
+			the registration will return failure.
+
+		uint32 MaxInterval [Experimental]
+
+			Maximum advertising interval to be used by the
+			advertising set, in milliseconds. Acceptable values
+			are in the range [20ms, 10,485s]. If the provided
+			MinInterval is larger than the provided MaxInterval,
+			the registration will return failure.
+
+		int16 TxPower [Experimental]
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
 
@@ -209,3 +234,26 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		dict SupportedCapabilities [Experimental]
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
2.29.1.341.ge80a0c044ae-goog

