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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD35C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6648F20874
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbkcq4yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbgJPWsm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgJPWsm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 18:48:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133EBC061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:48:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id fy5so1022335pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VXgzPNulEsQBNft+ypZ4coVNMfppdo+f7V++LChSpDM=;
        b=pbkcq4yEOdRdnUMFteDjYSMVRX6qMOpA1WPe4FYcCjxbYSt9NEgKJzSU3La8EMEfV4
         7t+ILOcBI7byMXe89DhIJ0X+jgnJkEn5e8EATT+0huezmj1YFSF8XxFWgDGlLYI13AXn
         SZfzgty34ZANEiXYLD/Wr2Fi/DcjAKGmI6unRMPOUA2TNMIgJ2CfaksFczDBQCH9l4uQ
         fpnSOlHLeqwlkKOp7V/m7r8Z5R9zEnxYk4L3zBdZU6mS1Pa22ewgm4Ll2k6lhd9PM8XV
         u8xQbzdcMCxinOXSIJ6wDfQJjVnvUDaIC2LrohyBtnQlRfKIPov6DRRM99WCwM+c1GC5
         Pj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VXgzPNulEsQBNft+ypZ4coVNMfppdo+f7V++LChSpDM=;
        b=YlQx80S2D1LVExO7yjgag+jsJRYIhkhMn8I4ZunzWlClJPELmOr9LY6SJzfGR95EIZ
         Lq8HugoWdw6/W0kqdBNja8PUhHSg2mS8wvz5xLqomXlqVTP4UPgmqqIJGkmDSsIHbsEF
         fgsD9kxYRqvJSf91+umpPyCMRHy1guJmGsmikxlafAH6kbJxym0SadyaqzVfePxeqV0W
         1UUaudER+ibXwQ+UCoFWdHv1QFHp7FHRllvEI1F9BQwFPb/ZADfK/1MMYihYw1DzSdBt
         uSvQtPI/Mzr5lEabupaTsSKtiYXQUXW8emSa6Tzvkfh8wa1AfzmbeIFcyYz3J+ZWZLSh
         1lVQ==
X-Gm-Message-State: AOAM532QE1t5Hg3Je4gTwWNSSTM2WbC7KuL1tPqFiiVMfMGyL+8zMAP4
        ezoRxBpIKsUezIJyKbMbPVCxmdFQqndfTpegxHCp
X-Google-Smtp-Source: ABdhPJzREy7RidZFUcNPS+vkRjMsH1dewGxHe+hiaGU54x381SYFQqGNvoRyEkTPoWQ4LKqAe1nrIUYnj+MLXQVELErd
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a17:90a:62c4:: with SMTP id
 k4mr6195251pjs.174.1602888519343; Fri, 16 Oct 2020 15:48:39 -0700 (PDT)
Date:   Fri, 16 Oct 2020 15:48:25 -0700
Message-Id: <20201016154739.Bluez.1.Ida2ffbf34e18b5a810dffd2abd2bb9e431df3ae4@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [Bluez PATCH] doc/advertising-api: Enable new data sections in adv
 data / scan response
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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

