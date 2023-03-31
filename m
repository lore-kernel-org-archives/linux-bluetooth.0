Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA8C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 20:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCaUEY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCaUEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 16:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A46D135
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680293013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WYRnyyP1W+RH173PgjIZVlWMjOpzFoyhJXdOYaTRWw8=;
        b=aVWs5zBXj5GBiAJKzXzhhQ6bKZtfHsj/ce9ORmN3WLdpLQdHJKugECWGaziDH5Lb24eGY/
        xo3WQxURmMBT3T9dzETzkjiQRU7ip7OqGcFS+Jia+8I6NKExnpluoyhvoHvMentwD9ndT+
        9A3osgjmU4FFwhDqXCoDOl8zVcDSOMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-Kngzb6EdPn2HTGdlJqLixw-1; Fri, 31 Mar 2023 16:03:31 -0400
X-MC-Unique: Kngzb6EdPn2HTGdlJqLixw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA8F0884EC4;
        Fri, 31 Mar 2023 20:03:30 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61172140EBF4;
        Fri, 31 Mar 2023 20:03:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH BlueZ v2] adapter: Use regular discovery for filters which only have discoverable set
Date:   Fri, 31 Mar 2023 22:03:29 +0200
Message-Id: <20230331200329.461355-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

discovery_filter_to_mgmt_cp() does not add discovery_filter.discoverable
to the created mgmt_cp_start_service_discovery struct.

Instead update_discovery_filter() separately checks
client->discovery_filter->discoverable for all clients.

This means that for discovery-filters which only have the discoverable
flag set, to put the adapter in discoverable mode while discovering,
the created mgmt_cp_start_service_discovery struct is empty.

This empty mgmt_cp_start_service_discovery struct then gets sent
to the kernel as part of a MGMT_OP_START_SERVICE_DISCOVERY msg
by start_discovery_timeout().

This use of an empty filter with MGMT_OP_START_SERVICE_DISCOVERY
causes some bluetooth devices to not get seen with some (most?)
Broadcom bluetooth adapters. This problem has been observed with
the following Broadcom models: BCM4343A0, BCM43430A1, BCM43341B0 .

On these models the following 2 devices were not being discovered
when starting a scan with a filter with just discoverable set
in the filter (as gnome-bluetooth does):

Device 09:02:01:03:0F:87 (public)
        Name: Bluetooth 3.0 Keyboard
        Alias: Bluetooth 3.0 Keyboard
        Class: 0x00000540
        Icon: input-keyboard
        Paired: yes
        Bonded: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        WakeAllowed: yes
        LegacyPairing: yes
        UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        Modalias: bluetooth:v05ACp022Cd011B

Device 00:60:D1:00:00:34 (public)
        Name: Bluetooth Mouse
        Alias: Bluetooth Mouse
        Class: 0x00002580
        Icon: input-mouse
        Paired: yes
        Bonded: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        WakeAllowed: yes
        LegacyPairing: no
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v0103p0204d001E

Since setting the discoverable flag on a filter only is a way to
automatically put the adapter in discoverable mode itself while
it is discovering; and since this does not any device filtering
at all; modify merge_discovery_filters() to treat discovery with
such filters as regular unfiltered discovery.

This results in start_discovery_timeout() starting regular
discovery through a MGMT_OP_START_DISCOVERY message and this
fixes these 2 example devices not getting discovered by the
mentioned Broadcom BT adapter models.

Link: https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/merge_requests/163
Reviewed-by: Bastien Nocera <hadess@hadess.net>
---
Note the same argument can be made for the pattern and duplicate part of
the filters which also get handled outside of the kernel filter.
But I prefer to keep the first patch small and targetted at solving things
not working with the gnome-bluetooth filter settings.

Also I'm not familiar enough with the code to say with certainty that
filters with just a pattern or the duplicate flag set (or a combination)
should also be treated as unfiltered discovery.
---
Changes in v2:
- Fix a couple of typos / grammar errors in the commit message
- Replace hard-tabs in commit message with spaces
- Add Bastien's Reviewed-by tag
---
 src/adapter.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7947160a6..cc7f891d9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2192,6 +2192,7 @@ static int merge_discovery_filters(struct btd_adapter *adapter, int *rssi,
 	bool empty_uuid = false;
 	bool has_regular_discovery = false;
 	bool has_filtered_discovery = false;
+	uint8_t adapter_scan_type = get_scan_type(adapter);
 
 	for (l = adapter->discovery_list; l != NULL; l = g_slist_next(l)) {
 		struct discovery_client *client = l->data;
@@ -2202,6 +2203,20 @@ static int merge_discovery_filters(struct btd_adapter *adapter, int *rssi,
 			continue;
 		}
 
+		/*
+		 * Detect empty filter with only discoverable
+		 * (which does not require a kernel filter) set.
+		 */
+		if (item->uuids == NULL &&
+		    item->pathloss == DISTANCE_VAL_INVALID &&
+		    item->rssi == DISTANCE_VAL_INVALID &&
+		    item->type == adapter_scan_type &&
+		    item->duplicate == false &&
+		    item->pattern == NULL) {
+			has_regular_discovery = true;
+			continue;
+		}
+
 		has_filtered_discovery = true;
 
 		*transport |= item->type;
@@ -2251,7 +2266,7 @@ static int merge_discovery_filters(struct btd_adapter *adapter, int *rssi,
 		 * It there is both regular and filtered scan running, then
 		 * clear whole fitler to report all devices.
 		 */
-		*transport = get_scan_type(adapter);
+		*transport = adapter_scan_type;
 		*rssi = HCI_RSSI_INVALID;
 		g_slist_free(*uuids);
 		*uuids = NULL;
-- 
2.39.1

