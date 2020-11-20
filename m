Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEFC63798
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F0E223B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A0Rv/vzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgKTU54 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbgKTU54 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:57:56 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95AC061A04
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:57:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q34so8319169pgb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0Qq2sYLrS9nSFZm0GxpqC4URBSc44bQyop3TPKEwQw=;
        b=A0Rv/vzbf9yQIGL0Egni9w3z8IQ+PUfqkXzWFyn2/zSX+J84HwWBtLl4KkbIlBiSGm
         Ym/2DInKgHCnNmQSdIBjbq9/3x66HXkPTsM5tNi9hWq2/96b6M0sr9jcfUSViWP0JpdM
         FLI4tSEZDu/PGNP6jufrusOkWVINeBMxvZ5as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0Qq2sYLrS9nSFZm0GxpqC4URBSc44bQyop3TPKEwQw=;
        b=RbxbDiC33tcl3bfkOzsK8Z7jNV2//9LRfhyupUplgFKIWdk523bnvH7lF3dmK2uW25
         us4AJBJOULj4NT99FkXyk0bWlPq+YGL2dsDapedjL03UWP3K0we/nFzIT2iKaEBBFDCv
         z+rBUpy773omAlwGPiQoATTH9OFa4W9DwnsUaJz85R7gxQaT3Tnvogf5S55HYRZ8QGW7
         BWTpiyyN2r7cF1lY+tkMHMNgo3OqhMboAAsP7VHQywWUFymmWnzbsdM+VfLyHz04iadS
         15V/VDLg4pS58rL4WyfBn1ug9bq+HPUcO1JL0k1lKui9NqAsai1T+jnYPpZm3MRVVgGU
         m+lA==
X-Gm-Message-State: AOAM532y97Bc62jMWNofAjqk6vCvmM+bb+BXuFmkN96vp782izGNKtFJ
        PN1JiZrIGZDEK/SBh3EcZu68BcQzWQb9TQ==
X-Google-Smtp-Source: ABdhPJxcKafVBK+Snhy0ARq2TiEEkfAEk6datOF+Pr9lYgRvn71FIKWqoJ1pzI0kyG4aaiQtvPe/AA==
X-Received: by 2002:a17:90b:ec6:: with SMTP id gz6mr10394868pjb.142.1605905874182;
        Fri, 20 Nov 2020 12:57:54 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id a67sm3232080pfa.77.2020.11.20.12.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:57:53 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v3 4/7] doc: Add Battery Provider API doc
Date:   Fri, 20 Nov 2020 12:57:25 -0800
Message-Id: <20201120205728.339325-4-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120205728.339325-1-sonnysasaka@chromium.org>
References: <20201120205728.339325-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch add the documentation of the Battery Provider which lets
external clients feed battery information to BlueZ if they are able to
decode battery reporting via any profile. BlueZ UI clients can then use
the org.bluez.Battery1 API as a single source of battery information
coming from many different profiles.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
Changes in v3:
* Remove doc duplication in BatteryProvider1 and mention that it's the
  same as Battery1 instead.
* Suggest profile UUID in Source property.

 doc/battery-api.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
index dc7dbeda2..b5c9a7be1 100644
--- a/doc/battery-api.txt
+++ b/doc/battery-api.txt
@@ -12,3 +12,52 @@ Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 Properties	byte Percentage [readonly]
 
 			The percentage of battery left as an unsigned 8-bit integer.
+
+		string Source [readonly, optional, experimental]
+
+			Describes where the battery information comes from
+			This property is informational only and may be useful
+			for debugging purposes.
+			Providers from BatteryProvider1 may make use of this
+			property to indicate where the battery report comes from
+			(e.g. "HFP 1.7", "HID", or the profile UUID).
+
+
+Battery Provider Manager hierarchy
+==================================
+A battery provider starts by registering itself as a battery provider with the
+RegisterBatteryProvider method passing an object path as the provider ID. Then,
+it can start exposing org.bluez.BatteryProvider1 objects having the path
+starting with the given provider ID. It can also remove objects at any time.
+The objects and their properties exposed by battery providers will be reflected
+on org.bluez.Battery1 interface.
+
+BlueZ will stop monitoring these exposed and removed objects after
+UnregisterBatteryProvider is called for that provider ID.
+
+Service		org.bluez
+Interface	org.bluez.BatteryProviderManager1 [experimental]
+Object path	/org/bluez/{hci0,hci1,...}
+
+Methods		void RegisterBatteryProvider(object provider)
+
+			This registers a battery provider. A registered
+			battery provider can then expose objects with
+			org.bluez.BatteryProvider1 interface described below.
+
+		void UnregisterBatteryProvider(object provider)
+
+			This unregisters a battery provider. After
+			unregistration, the BatteryProvider1 objects provided
+			by this client are ignored by BlueZ.
+
+
+Battery Provider hierarchy
+==========================
+
+Service		<client D-Bus address>
+Interface	org.bluez.BatteryProvider1 [experimental]
+Object path	{provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties	Objects provided on this interface contain the same properties
+		as org.bluez.Battery1 interface.
-- 
2.26.2

