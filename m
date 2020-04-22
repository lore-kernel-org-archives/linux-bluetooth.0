Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D67C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 01:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C101206B9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 01:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DC5EyCiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgDVBCT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbgDVBCS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 21:02:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15550C0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 18:02:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so129356pje.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgwhZFS0Rs1DmjjLWXYIXNbCEvvD1OpfDu4g1IJLmNw=;
        b=DC5EyCiKVt3wvnqQTrN7RcJhdcaxucmTkiZTDIhuXcD0lDnK8k/eEd9pEAlCuDLbO4
         +WbI5UK+eqwS1wpCzEm/BiGkwHC9pfAUAItd/hzm/oYelvmfjW4RkWlKE+OBgMNl5J8a
         v0GOvk8RWAbVkUtjlC6IHQhM8lefXKfiTXDaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgwhZFS0Rs1DmjjLWXYIXNbCEvvD1OpfDu4g1IJLmNw=;
        b=BQMkiNB37QbdpXnSIpltFNEXszl3O0NXx5Ovq1lp/uZ3hCM8Sw0Nj7vkX32opUe9DD
         sR3s/LrmxfDNiXd2+8rTbfO6bUzRJ96JIHUXono5IOb5xNybqQ+as8cpmqvJhXhJI+Yj
         o7uw5IFnxnslgLC1AY1aL99oWcIehWnKmV/ARabNCwd9uyL+pgMjlGE9VZcTMz0wWLwA
         g1vz1f/QBCH7TE5nx0czpNOR5AprK0Hq3D4B8VNvwMPY7qYHYs6p0T0EkXUlGa3gI+KC
         wL0ZZBnsYLYZxXybpN0TdzgQ6SNkZ2kFSI/b9WI64qhzoPVcP7Uo42zHMiQRDtqp7Sb5
         mYpQ==
X-Gm-Message-State: AGi0PuZVYkrHatFRgd+bmmRFO+OO+uO9VbII65Ir6PwGbZFtRixEi+ec
        crgHf+GqmMKh32s1Obqp+JHyQSHrqu8=
X-Google-Smtp-Source: APiQypIS7RM4b7iEYNaIPx12MJ2BwlbwuIISAVlPe7oF6ajJbbAD+s8knwxZmrMYkDYV9qDPTX/zAA==
X-Received: by 2002:a17:90a:db53:: with SMTP id u19mr8851367pjx.41.1587517337006;
        Tue, 21 Apr 2020 18:02:17 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id u2sm3547400pjn.20.2020.04.21.18.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 18:02:16 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2] doc: Describe the new Advertisement Monitor support
Date:   Tue, 21 Apr 2020 18:02:11 -0700
Message-Id: <20200421180155.BlueZ.v2.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This describes the following commands.
- Add Advertisement Patterns Monitor
- Remove Advertisement Monitors
Note that the content of a monitor can differ based on its type. For now we
introduce only pattern-based monitor, so you may find that unlike the
command of removing monitor(s), the Add command is tied to a specific type.
---

Changes in v2:
- Combine commands to remove one monitor and remove all monitors. The
refined command takes multiple handles and an extra field to indicate
whether to remove all monitors.

 doc/mgmt-api.txt | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456..d5d402361 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3138,6 +3138,89 @@ Read Security Information Command
 				Invalid Index
 
 
+Add Advertisement Patterns Monitor Command
+=========================================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:	Pattern_count (1 Octets)
+				Pattern1 {
+					AD_Data_Type (1 Octet)
+					Offset (1 Octet)
+					Length (1 Octet)
+					Value (variable length)
+				}
+				Pattern2 { }
+				...
+	Return Parameters:	Monitor_Handle (8 Octets)
+
+	This command is used to add an advertisement monitor whose filtering
+	conditions are patterns. The kernel would track the number of registered
+	monitors to determine whether to perform LE scanning while there is
+	ongoing LE scanning for other intentions, such as auto-reconnection and
+	discovery session. If the controller supports Microsoft HCI extension,
+	the kernel would offload the content filtering to the controller in
+	order to reduce power consumption; otherwise the kernel ignore the
+	content of the monitor. Note that if the there are more than one
+	patterns, OR logic would applied among patterns during filtering. In
+	other words, any advertisement matching at least one pattern in a given
+	monitor would be considered as a match.
+
+	A pattern contain the following fields.
+		AD_Data_Type	Advertising Data Type. The possible values are
+				defined in Core Specification Supplement.
+		Offset		The start index where pattern matching shall be
+				performed with in the AD data.
+		Length		The length of the pattern value in bytes.
+		Value		The value of the pattern in bytes.
+
+	Here is an example of a pattern.
+		{
+			0x16, // Service Data - 16-bit UUID
+			0x02, // Skip the UUID part.
+			0x04,
+			{0x11, 0x22, 0x33, 0x44},
+		}
+
+	Possible errors:	Failed
+				Busy
+				Invalid Parameters
+
+
+Remove Advertisement Monitors Command
+=====================================
+
+	Command Code:		0x004A
+	Controller Index:	<controller id>
+	Command Parameters:	Remove_All (1 Octet)
+				Monitor_Count (2 Octets)
+				Monitor_Handle[i] (8 Octets)
+	Return Parameters:	Removed_Monitor_Count (2 Octets)
+				Removed_Monitor_Handle[i] (8 Octets)
+
+	This command is used to remove advertisement monitor(s). The kernel
+	would remove the monitor(s) with Monitor_Index and update the LE
+	scanning. If the controller supports Microsoft HCI extension and the
+	monitor(s) has been offloaded, the kernel would cancel the offloading;
+	otherwise the kernel takes no further actions other than removing the
+	monitor(s) from the list.
+
+	Remove_All can be the following values.
+		Value		Operation
+		-------------------------
+		0x00		Removes only the monitors with handles specified
+				in Monitor_Handle[i], so there must be at least
+				one handle.
+		0x01		Removes all existing monitor(s), so
+				Monitor_Count must be 0, and Monitor_Handle
+				must be empty.
+
+	Possible errors:	Failed
+				Busy
+				Invalid Index
+				Invalid Parameters
+
+
 Command Complete Event
 ======================
 
-- 
2.24.1

