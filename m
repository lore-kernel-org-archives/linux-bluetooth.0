Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 23:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D94E21655
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 23:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kA/P0q+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411429AbgJPXdn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411427AbgJPXdn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 19:33:43 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2B9C061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 16:34:15 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j185so2592630qkf.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=26kvfUG+FzCKJeLA8mA9gNOzSnYUPyps0JbQOWLrfXk=;
        b=kA/P0q+e1HwIRlIV0CsNkifcK4cVkHRxxB+iZqRnyrsnomqRd+sEYyEarj9uH13iC7
         0Ttn4lc8n1k9wQU5nsS58sTU5Un7wHGi6tMpMZBb4p50AP7OhCKlI9CbnMAMj6h8UVgt
         xvFYj6ZVPZ/cfvAI0eZ/h7Pf5OpsgDl3U0Oztfj9TiHHjvlCAAx45hT77NH6XiSkxzcu
         S/l2gpF39EqOZ3aN9wyEdCsC6zCBtRncK/uGEHPe0LaiScOGSKL2ox0xKCORxjT7R0e2
         gAjXszDcm8j7I6hAH+sRJ/KFRorw29cX4ILSP/kQT8jQ3wY9hW2IA5Bx2tkv9P1/HaMi
         s9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=26kvfUG+FzCKJeLA8mA9gNOzSnYUPyps0JbQOWLrfXk=;
        b=HYf0hHFyG+QYJmBuBV8FrUcJ0WOKWZGCGqLD36h14RbwGiZnztXTaAjCz8U/7BMR2x
         XSGmUkGxAzsW5eyxSI1VF6/l5lhB8bXQXs3OnVEtGRg5Tnt44aCFpGyAfMijKn2PTw+k
         q5x3lk+Fn3Zs9nKQrF1zlwMfCgz9m/I0sby29Wu5wPyhPIInGSKdiY0bhDQbYoWHD5xv
         thQ/UoyUth+qD/7CMBu+U3UfialDMrq8CxRfET/Bx7PIGxye/uLqI5/G9+MTXADMX9Be
         g6gk2BB7HkQAkMC287BTHIOEjaMwQ5bHtfQ/S/qGur0rqW+UBvQ+qIiKKXQ4MayvkHbA
         LuFQ==
X-Gm-Message-State: AOAM5333o4Hv1DPK1sY9jXMqLsAjtQKuQyC1dRosGw3yqU++cZJxKNt7
        ZHKhmW5gU2OxSP27UQ7TYO8Ge+8crqmDvSivgfNS
X-Google-Smtp-Source: ABdhPJzFbnxXwf5Fix0O6hWLOUb5sV+ZchUhDfrGxGub9gGZo3jPzfFT/cA6waJMwtraeLDzjORlXeGE51DvhOPGTcCe
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a05:6214:594:: with SMTP id
 bx20mr6478078qvb.2.1602891254169; Fri, 16 Oct 2020 16:34:14 -0700 (PDT)
Date:   Fri, 16 Oct 2020 16:34:08 -0700
Message-Id: <20201016163331.Bluez.v2.1.Ida2ffbf34e18b5a810dffd2abd2bb9e431df3ae4@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [Bluez PATCH v2] doc/advertising-api: Enable new data types in adv
 data / scan response
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change allows the advertising client to specify advertising data
and scan response for any AD section types that would otherwise be
settable via the other LEAdvertisement1 properties.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
Hello Maintainers,

We have a new advertising use case in which the client must be able to
specify some data fields, specifically Service UUIDs in the scan
response payload. With the current API, this is not possible, and in
addition the Data property limits the client to only setting 3
advertising section types.

This change proposes that we enable the setting of scan response, and
for both data/scan response enable the AD section types that are
already settable via the other advertisement properties. This should
minimize security concerns as it is not enabling any new advertising
types, while greatly improving client flexibility in defining their
advertising data and scan response contents.

Thank you in advance for your feedback.

Warm regards,
Daniel Winkler


Changes in v2:
- Shortened patch title to be <=72 chars

 doc/advertising-api.txt | 69 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..f60b22de6 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -63,12 +63,46 @@ Properties	string Type
 
 		dict Data [Experimental]
 
-			Advertising Type to include in the Advertising
-			Data. Key is the advertising type and value is the
-			data as byte array.
-
-			Note: Types already handled by other properties shall
-			not be used.
+			Data to be added into the Advertising Data payload.
+			Key is the advertising type and value is the data
+			as byte array.
+
+			"type" values supported:
+				0x02  Incomplete List of 16-bit Service UUIDs
+				0x03  Complete List of 16-bit Service UUIDs
+				0x04  Incomplete List of 32-bit Service UUIDs
+				0x05  Complete List of 32-bit Service UUIDs
+				0x06  Incomplete List of 128-bit Service UUIDs
+				0x07  Complete List of 128-bit Service UUIDs
+				0x08  Shortened Local Name
+				0x09  Complete Local Name
+				0x14  List of 16 bit Service Solicitation UUIDs
+				0x15  List of 128 bit Service Solicitation UUIDs
+				0x16  Service Data - 16 bit UUID
+				0x19  Appearance
+				0x1f  List of 32 bit Service Solicitation UUIDs
+				0x20  Service Data - 32 bit UUID
+				0x21  Service Data - 128 bit UUID
+				0x24  URI
+				0x25  Indoor Positioning
+				0x26  Transport Discovery Data
+				0xff  Manufacturer Specific Data
+
+			To ensure advertising contents maintain compliance to
+			the bluetooth specification, the provided type/data
+			sections will undergo the following validation:
+
+			- Repeated tag sections provided by Data property and
+			the other properties above will be merged together, if
+			possible.
+
+			- Misuse of Service UUID types, i.e. repeated UUID_ALL
+			sections, will result in a failed registration.
+
+			- The Appearance and Name section types may appear in
+			the Advertising data and Scan Response once in total.
+			Any redundant definitions of these tags will be
+			removed.
 
 			Possible values:
 				<type> <byte array>
@@ -78,6 +112,29 @@ Properties	string Type
 				<Transport Discovery> <Organization Flags...>
 				0x26                   0x01         0x01...
 
+		dict ScanResponseData
+
+			Data to be added into the Scan Response payload.
+			Key is the advertising type and value is the data
+			as byte array.
+
+			Note: By default, if the LocalName property is defined
+			or "local-name" is populated in the Include property,
+			the local name will be placed in the Scan Response
+			payload by default and merged with data provided in
+			ScanResponseData.
+
+			For allowed "type" values and their validation, see
+			"Data" property above.
+
+			Possible values:
+				<type> <byte array>
+				...
+
+			Example:
+				<Service Data UUID16> <HeartRate UUID  Data>
+				0x16                   0x0D 0x18       0x01...
+
 		bool Discoverable [Experimental]
 
 			Advertise as general discoverable. When present this
-- 
2.29.0.rc1.297.gfa9743e501-goog

