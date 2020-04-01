Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211BC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EE320678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jd43wBMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbgDAWOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:14:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36236 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAWOo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 18:14:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so544705plo.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JWLeu2ewrcSvh4PqznXWmXhhzRoB0+IxpZ8RyL6tFc=;
        b=Jd43wBMz9NnsFai2iNyUpJEL6+DvooaCLotABtQeR7urSv5AFblQgjF0/+yC5ECRpT
         o4wVe1Q5/2Maym0ryNj2bYwEExS1qxfCUqPpfdmBsqPoiu+JqaSMy4In4zD2UJrPsXlB
         2RPSp02ZKzTTrIlZi++BkCRxJpSOyayZSMH2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JWLeu2ewrcSvh4PqznXWmXhhzRoB0+IxpZ8RyL6tFc=;
        b=Xg67An6WchFTEOHRgzcdgIeeDqc8lCaKgCexmyjhR0Ee6JFwS5KSlrYRD2GwOryhLB
         roGJtYpDO5eKphN5hN7UUlhd8u3u4nxyRvRkGULXJ1c2wbjF2eUjnPQQKeeu8x0v5F/X
         DDm/5KNFGu2ZhHYERZk7hSC/J0b1VBWaPQ8VU34q667Hh4BsVpqjQ+suWnyigxR0EDDy
         zxBjE3WgJBdBrILvAYhWClg4G6nKK+Zypo7KaYWrCW5zYze9kWerh7LragQJdp//osTF
         gljf9INf1Q3Ht859C5TcgwZYVJpv5JmMqan5epg4N+nf6tt4UztneThOfkVK8Tu1DM3I
         ZhXg==
X-Gm-Message-State: AGi0PuYBkpHSBmMRFCg1gHyzyRyehwzoRQPQVTmR+Hji1T2ZVUP2JqHZ
        kq9kKVonRrndyBEfCTbCCDssgI4Aq2A=
X-Google-Smtp-Source: APiQypKRyJa6LiHGJhvH0pwMuJyLRi2XKhlZp84/usIMYhFQH8oOr91HHxh0phjiBvcwdNjtvfngyA==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr51605pll.88.1585779281797;
        Wed, 01 Apr 2020 15:14:41 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id z6sm2394666pjt.42.2020.04.01.15.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:14:41 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Rahul Chaturvedi <rkc@google.com>
Subject: [PATCH 1/5] D-Bus API changes for managing SDP records
Date:   Wed,  1 Apr 2020 15:14:30 -0700
Message-Id: <20200401221434.12185-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Rahul Chaturvedi <rkc@google.com>

This defines the DBus API that we'll use with BlueZ to create, remove
and get service records.
---
 doc/adapter-api.txt | 46 +++++++++++++++++++++++++++++++++++++++++++++
 doc/device-api.txt  | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index acae032d9..6e4c37fc9 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -204,6 +204,52 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		uint32 CreateServiceRecord(dict record)
+
+			This method creates an entry with the local SDP server
+			for this adapter for the specified record. This method
+			will only create the SDP record and not start listening
+			on any ports. It is up to the caller of the method to
+			ensure the validity of the service record. This record
+			will not be parsed for any validation but will instead
+			directly be inserted into the local SDP server’s
+			records.
+
+			The return value from this method will be the 32 bit
+			handle for the created service record.
+
+			The record dictionary will have dictionary entries of
+			the format: {id : (type, size, value)}, where,
+
+			uint16 id:	The 16 bit attribute ID for an
+					attribute.
+			uint8 type:	This will contain the type of the
+					attribute value. Attribute type values
+					are defined in the Bluetooth spec in
+					Volume 3, Part B, 3.2.
+			uint32 size:	This is the size of the attribute
+					value.
+			variant value:	This will contain the attribute value
+					for a given attribute_id. This variant
+					can either contain a primitive type, or
+					if type is SEQUENCE, an array of struct
+					of the signature (type, size, value).
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.AlreadyExists
+					 org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
+
+		void RemoveServiceRecord(uint32 handle)
+
+			This method removes the SDP record with the given
+			handle from the local SDP server.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.DoesNotExist
+					 org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
diff --git a/doc/device-api.txt b/doc/device-api.txt
index ceb68d2f6..e8f2c670d 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -120,6 +120,43 @@ Methods		void Connect()
 			Possible errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.Failed
 
+		array{array{dict}} GetServiceRecords()
+
+			This method returns the complete service records of all
+			discovered BR/EDR services of the connected device till
+			now. The return value will be an array of an array of
+			dictionary entries. Each nested array of dictionary
+			entries will contain one service record. Each pair in
+			the returned dictionary entries will represent an
+			attribute in the service record.
+
+			The dictionary entries in the returned array of entries
+			will be of the format: {id : (type, size, value)} where,
+
+			uint16 id:	The 16 bit attribute ID for an
+					attribute.
+			uint8 type:	This will contain the type of the
+					attribute value. Attribute type values
+					are defined in the Bluetooth spec in
+					Volume 3, Part B, 3.2.
+			uint32 size:	This is the size of the attribute
+					value.
+			variant value:	This will contain the attribute value
+					for a given attribute_id. This variant
+					can either contain a primitive type, or
+					if type is SEQUENCE, an array of struct
+					of the signature (type, size, value).
+
+			Since the service record contains the service UUID and
+			name, these fields do not need to be given separately.
+			This method should be called after the ServiceResolved
+			property for this object has been set to true otherwise
+			it may return a partial or stale cached list.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.NotConnected
+					 org.bluez.Error.Failed
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
-- 
2.24.1

