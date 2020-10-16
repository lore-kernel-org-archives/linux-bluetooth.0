Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F87C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F307D2065D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="gwhDZMwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbgJPWJe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbgJPWJe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 18:09:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C8C061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:09:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hk7so2249502pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=n1+giSsolW0YEWNRCDDe69POzBrY4Vg661V09byvQ1M=;
        b=gwhDZMwhkvBD1mpqF9lT0hEJgN7e1RoMkyYGvcX8xMH/qKU/jnReOh86d82s8/tKil
         Zzw8qxn+e0Edfi14Hr4FN+Q5tqBqZzsIaa3dDESNVoZQsaYY4ZfcZRLKLBG2blH4tpiI
         a1FTn/4cpkWkaXd2wPQrVDFncaL7xA3e24oKnGQU1B7FdQUO/E+1wVhofbWwvcl/CGxX
         OiaqMSYc77Lc0mAVIrhQk5kor0i/GqING+s4EIqQklmmH2pp8a6tS77jvBADg5h9ioIz
         iyqY0okw5DVWgjfl/htMpv3kdCIuSve0KxhgiMePMTm/C7A59E3Fv11gOJ8XnHTP46lP
         rwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=n1+giSsolW0YEWNRCDDe69POzBrY4Vg661V09byvQ1M=;
        b=L8hm0cZrTBY5k9abtgy8OxpsbDo1eBVbAo3rwJ4ew7i41rei8/sZNg9Dg3A+Y18gZA
         AyBpTuJn7SPKm5SA5pJPSewPrRvdxsiCQZ62o/LyVkHKmsK++udPdhxssOYNQau62cwr
         J/oyynqdmWyn/9RMW0dFCUTUdGNqN3GuQ6yuLcY4i3M4vhPCcDXxqT7Fp1YktGaosU0E
         5TBBw7uX3LGJYgVTsucfsEE+VSElPkrPgXI77EMNxx7vCfzQZh9CFEdvzW7VzSADZRFX
         vv429EDScY/OuXTB17P/PXGRuk20G4W3OLaPMjJ28PsWaITE9wyUlX2u7lo6pxGIS7JH
         2i4w==
X-Gm-Message-State: AOAM532keU6o6alJc2OU73xMrldAiGXFOvUe0ibbM+YhxdCeMbaPFARr
        lWCp5CB/yG+v9EG/zwDK8en1KBgItgR3wqEE
X-Google-Smtp-Source: ABdhPJx3m2gdq/oHubGKAGvyLOgNrR+OM7K4jaCDkoKgAwRuqOlE6ORNIWrywQ5BCiLiYBQ8lXKcQg==
X-Received: by 2002:a17:902:8348:b029:d3:781a:5857 with SMTP id z8-20020a1709028348b02900d3781a5857mr5940234pln.2.1602886173218;
        Fri, 16 Oct 2020 15:09:33 -0700 (PDT)
Received: from [192.168.2.14] (216-19-182-159.dyn.novuscom.net. [216.19.182.159])
        by smtp.gmail.com with ESMTPSA id z18sm3780604pfn.158.2020.10.16.15.09.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 15:09:32 -0700 (PDT)
From:   Peter Mullen <omaolaip@tcd.ie>
Subject: [PATCH BlueZ 1/3] profile: Add Vendor/Product ID profile matching
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <efec3d63-119b-6956-5345-c9b19c71cbd5@tcd.ie>
Date:   Fri, 16 Oct 2020 15:09:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Extend the process for matching profiles to devices by adding vid/pid
fields to btd_profile. If no remote_uuid is supplied, attempt to match
based on the new fields. If only vid field is set, ignore pid during
matching.
---
  src/device.c  | 37 ++++++++++++++++++++++++++-----------
  src/profile.h |  3 +++
  2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index a5ef46730..2cb2ceb2e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -329,7 +329,8 @@ static GSList *find_service_with_uuid(GSList *list, 
char *uuid)
  		struct btd_service *service = l->data;
  		struct btd_profile *profile = btd_service_get_profile(service);
  -		if (bt_uuid_strcmp(profile->remote_uuid, uuid) == 0)
+		if (profile->remote_uuid &&
+				bt_uuid_strcmp(profile->remote_uuid, uuid) == 0)
  			return l;
  	}
  @@ -1901,11 +1902,19 @@ static struct btd_service 
*find_connectable_service(struct btd_device *dev,
  		struct btd_service *service = l->data;
  		struct btd_profile *p = btd_service_get_profile(service);
  -		if (!p->connect || !p->remote_uuid)
+		if (!p->connect)
  			continue;
  -		if (strcasecmp(uuid, p->remote_uuid) == 0)
+		if (p->remote_uuid && strcasecmp(uuid, p->remote_uuid) == 0)
  			return service;
+
+		if (p->vendor_id && p->vendor_id ==
+						btd_device_get_vendor(dev)) {
+			if (p->product_id && p->product_id !=
+						btd_device_get_product(dev))
+				continue;
+			return service;
+		}
  	}
   	return NULL;
@@ -3800,14 +3809,18 @@ static bool device_match_profile(struct 
btd_device *device,
  					struct btd_profile *profile,
  					GSList *uuids)
  {
-	if (profile->remote_uuid == NULL)
-		return false;
-
-	if (g_slist_find_custom(uuids, profile->remote_uuid,
-							bt_uuid_strcmp) == NULL)
-		return false;
+	if (profile->remote_uuid && g_slist_find_custom(uuids,
+				profile->remote_uuid, bt_uuid_strcmp) != NULL)
+		return true;
  -	return true;
+	if (profile->vendor_id && profile->vendor_id ==
+						btd_device_get_vendor(device)) {
+		if (profile->product_id && profile->product_id !=
+						btd_device_get_product(device))
+			return false;
+		return true;
+	}
+	return false;
  }
   static void add_gatt_service(struct gatt_db_attribute *attr, void 
*user_data)
@@ -6729,6 +6742,8 @@ void btd_device_set_record(struct btd_device 
*device, const char *uuid,
  const sdp_record_t *btd_device_get_record(struct btd_device *device,
  							const char *uuid)
  {
+	if (uuid == NULL)
+		return NULL;
  	/* Load records from storage if there is nothing in cache */
  	if (!device->tmp_records) {
  		device->tmp_records = read_device_records(device);
@@ -6881,7 +6896,7 @@ struct btd_service *btd_device_get_service(struct 
btd_device *dev,
  		struct btd_service *service = l->data;
  		struct btd_profile *p = btd_service_get_profile(service);
  -		if (g_str_equal(p->remote_uuid, remote_uuid))
+		if (p->remote_uuid && g_str_equal(p->remote_uuid, remote_uuid))
  			return service;
  	}
  diff --git a/src/profile.h b/src/profile.h
index 6827f8481..fe882a843 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -21,6 +21,9 @@ struct btd_profile {
  	const char *local_uuid;
  	const char *remote_uuid;
  +	uint16_t vendor_id;
+	uint16_t product_id;
+
  	bool auto_connect;
  	/* Some profiles are considered safe to be handled internally and also
  	 * be exposed in the GATT API. This flag give such profiles exception
-- 
2.28.0


