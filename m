Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD36CC43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664BE2075A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJVxsJcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgIKRD5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIKRD1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 13:03:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A2C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:03:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n14so7835205pff.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=qRtDh97ORt4HovJLKdTF3WD92y4b2IDBRblpYLEE9bs=;
        b=dJVxsJcX8QwG1cCd9nM0kqLVfSwuDe4APIAa8BtNHYsyMYxCBw/p1N7EcZeTKxdpe7
         cS4veSRiTv6M4LDyxP7mtZ6iQo0YvYef4Kdh/7oPYjo+cKFv0BsACj+S7oXqn69EISpt
         8NQxsdKS26ru+HxYdjZyNsxGvxZgnuK4jl1Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=qRtDh97ORt4HovJLKdTF3WD92y4b2IDBRblpYLEE9bs=;
        b=Vl+NcX74+X9/rwMGPmOEGEugnnialN7QTlugpszEGZR5b547jqFYZbJl8zfs0KBqYZ
         9FeA+RtmSyG2eEnNStPUiXhsvzvG/QygySmxl9XYOJKPRZyil5IAEE+DmH81SNRVH2Ju
         S3gcFTK/d1MD4BzMW+f7PWrf2PwBuj+PGLlknz8AO5WNoo+Pep/9wKELlA9RkBZxf0Zk
         /Dy+zqjEkQVZUtiDm8ow40tGGgdr8faBUukZE9/2MSj/62l56aeKGlvbmLekICWCvIzq
         M0PfljfOONoGX6VaflG+zR+PYPSy+sT/esY0sIKhmKsQ2zzOWHJW1GH4bL3Px8SJTDh3
         7+1A==
X-Gm-Message-State: AOAM530DYIynr6vxcloEoaksdY7HKRbeKi62aK+WmCyT2rrBUXwg8DgW
        KVJ+7/diK3qq2szge0+DJkhnPg==
X-Google-Smtp-Source: ABdhPJw7sDOAisikq+F/mVJQrRg8pbzocfSBl45sp+09hdh3wWhJ9hDo4+UdBQZMAetb42PEHKjHIw==
X-Received: by 2002:a63:f1d:: with SMTP id e29mr2319480pgl.358.1599843805452;
        Fri, 11 Sep 2020 10:03:25 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id q16sm3103738pfj.117.2020.09.11.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:03:24 -0700 (PDT)
Message-ID: <5f5baddc.1c69fb81.8c960.760a@mx.google.com>
X-Google-Original-Message-ID: <20200911100258.RESEND Bluez.v2.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [RESEND Bluez PATCH v2] doc: Add Suspend and Resume events
Date:   Fri, 11 Sep 2020 10:03:17 -0700
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add Controller Suspend Event and Controller Resume Event to identify
suspend or resume of the Bluetooth stack has occurred.

Also update Device Disconnected Event to indicate a new disconnect
reason: "Connection terminated by local host for suspend"

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Re-sending along with kernel changes.

Changes in v2:
- Moved Wake_Reason to first value
- Reduced Wake_Reason to not Bluetooth, unexpected event and remote wake

 doc/mgmt-api.txt | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ca0d38469..e7a713824 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3834,6 +3834,7 @@ Device Disconnected Event
 		2	Connection terminated by local host
 		3	Connection terminated by remote host
 		4	Connection terminated due to authentication failure
+		5	Connection terminated by local host for suspend
 
 	Note that the local/remote distinction just determines which side
 	terminated the low-level connection, regardless of the
@@ -4577,3 +4578,50 @@ Advertisement Monitor Removed Event
 
 	The event will only be sent to management sockets other than the
 	one through which the command was sent.
+
+
+Controller Suspend Event
+========================
+
+	Event code:		0x002d
+	Controller Index:	<controller_id>
+	Event Parameters:	Suspend_State (1 octet)
+
+	This event indicates that the controller is suspended for host suspend.
+
+	Possible values for the Suspend_State parameter:
+		0	Running (not disconnected)
+		1	Disconnected and not scanning
+		2	Page scanning and/or passive scanning.
+
+	The value 0 is used for the running state and may be sent if the
+	controller could not be configured to suspend properly.
+
+	This event will be sent to all management sockets.
+
+
+Controller Resume Event
+=======================
+
+	Event code:		0x002e
+	Controller Index:	<controller_id>
+	Event Parameters:	Wake_Reason (1 octet)
+				Address (6 octets)
+				Address_Type (1 octet)
+
+	This event indicates that the controller has resumed from suspend.
+
+	Possible values for the Wake_Reason parameter:
+		0	Resume from non-Bluetooth wake source
+		1	Wake due to unexpected event
+		2	Remote wake due to peer device connection
+
+	Currently, we expect that only peer reconnections should wake us from
+	the suspended state. Any other events that occurred while the system
+	should have been suspended results in wake due to unexpected event.
+
+	If the Wake_Reason is Remote wake due to connection, the address of the
+	peer device that caused the event will be shared in Address and
+	Address_Type. Otherwise, Address and Address_Type will both be zero.
+
+	This event will be sent to all management sockets.
-- 
2.28.0.618.gf4bc123cb7-goog

