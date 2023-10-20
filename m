Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D2CDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 14:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377542AbjJTONu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377535AbjJTONt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 10:13:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E6D5A
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697811227; x=1729347227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=djb+3OFt+//850NJe6tJIgHp8zlYEwTlsouldHOC21A=;
  b=NO6gTAmY6UKp2fz421KiEpi2lZE/rbKfo9TWeMD61+FOiIYjPFz1p1oX
   CpLnPzzZulsznl2ls3DJ/qIny+QMjrJYyXXv6uENd1jYmNG97HRPIBSj5
   flfSuC9kq/1fLE5m94lxmfJWoXmwJQ2QYhHryaA5jrMXfAU7uF8ODjYJb
   oRrQZEbKG19BPZkGx4Fy+e7fVXzev8GJl37gkQRDb623lkd/8r+Fcdy8A
   ex2LN+KXskOnCRCj8+jgmfN+GV/HECvCb+mDKwehoEdFB2bocTO3VmACd
   OPxUkEhIBgI3MzaPp19YFC6s4tkbi5mPXpLQoFtnFRtadi742NST646eK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="365840907"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="365840907"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 07:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088756514"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088756514"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2023 07:13:45 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 5/5] media: Parse conext and supported context
Date:   Fri, 20 Oct 2023 19:55:54 +0530
Message-Id: <20231020142554.486629-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020142554.486629-1-kiran.k@intel.com>
References: <20231020142554.486629-1-kiran.k@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow clients to register available context and supported context for
bap endpoint.
---
 profiles/audio/media.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index d0520d3216c9..69f77a80c8ea 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1613,6 +1613,15 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_UINT32)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->location);
+		} else if (strcasecmp(key, "Context") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->context);
+		} else if (strcasecmp(key, "SupportedContext") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value,
+						    &qos->supported_context);
 		}
 
 		dbus_message_iter_next(props);
@@ -2810,6 +2819,20 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_basic(&iter, &qos.location);
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "Context", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.context);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "SupportedContext", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.supported_context);
+	}
+
 	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
 						delay_reporting, codec,
 						vendor.cid, vendor.vid, &qos,
-- 
2.34.1

