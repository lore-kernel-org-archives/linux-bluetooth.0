Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9061AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiDRRwV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiDRRwT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 13:52:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D834668
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 10:49:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r12-20020a17090a690c00b001cb9bce2284so9015496pjj.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k2eFww3niLA0CxeY9esuVf7YNBzG2pFa3i1VnZXLtXg=;
        b=g4tVotcyXamASnNA1LrPzAu0mXfiopTyGi/jVZmiA3UnRnAoYv5DbcyK3IXAoN1fp+
         gsAR24yBBBKemxmFuv+JYrSjj+051deSrFIq71Vw4MCuxJVioRHmYdpTxlnFMI9Rfhyh
         cHdwmw3Qnbb8e0LrTj9sB/Ya8t39MLenOL4kUQ0TR4eaDOx8G2r2fnQrrIG1fhFs3Bgd
         XaHOWliY+ukKoV/Q4qegcWPgjh8OGlEk3J1oryDgxqS79B93Vn4whFhQcOvc2OBA9BsU
         cb7S8x8xFEg3YzZfrfOq/pc7A5gE7huGzOxoNftNDVYzFRmFXrOng34e23Oc2voVDr+p
         S9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k2eFww3niLA0CxeY9esuVf7YNBzG2pFa3i1VnZXLtXg=;
        b=nRe0Ikcp9nibMR3hsSJ1K4xt5aRt2JPe2zUIl7iqng030LamP6sQEQQIvCrbyQM7Mh
         kNA90Hj6A/08Rty1Cw3OoyfbqJbVQJMs6/VrHrNEvDGkiPDsGDq22yMZM47b923zmTSt
         0oxIzknjYWWZ2PxTc4zTtZ7h7PlThxPu6GWZrUFSCQNKAE/WjLqT1jZ62qy/ErFRkgXs
         iDYwCBY9Nbr2EyongziTvRtLq0xekBWr0dT/WNL3jjjRgALj0pMZgXlxTWQH11iM7KpA
         5umsg/Oy5U2OZJVQU0oVMqSOTb7d9jib268RIze9cO0r7q5uDeE5mnLNWKkxa7OqsnIa
         CnTg==
X-Gm-Message-State: AOAM530b2SM6Oc1GTTpbJtpsyvLdgQ/nHMu7Raq1OeMJU8N84TKnkAbG
        lD+5KAjDa8lhuPYsZU1KbqMEvRd94TVFMnvOS8xjAc015bE5X/0zKA2MVSFfA2Rnb0jObQ2C+Sb
        j4CCp4AO4HGpKZSgNWvhAZJ770Y+KXzhA68LXP202JajkV9zfyApneb3W89lWQ15lT+CEcP34w8
        tZ
X-Google-Smtp-Source: ABdhPJw4ZCaoYppZ3gLzmzwpkBn3qTdh6R4ouIrh7qSebP5sbhV/iJUSKgJNRSAu0hYM6rldO7FMRpJk+0tP
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:24c7:b0:50a:6720:2998 with SMTP
 id d7-20020a056a0024c700b0050a67202998mr8602537pfv.36.1650304179227; Mon, 18
 Apr 2022 10:49:39 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:49:28 +0000
In-Reply-To: <20220418174929.2777339-1-jiangzp@google.com>
Message-Id: <20220418174914.Bluez.v2.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
Mime-Version: 1.0
References: <20220418174929.2777339-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [Bluez PATCH v2 1/2] device: Add "Bonded" flag to dbus property
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add "Bonded" to dbus device property table. When setting the "Bonded
flag, check the status of the Bonded property first. If the Bonded
property is changed, send property changed signal.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v2:
- Move one variable declaration to the top following C90 standard

Changes in v1:
- Add "Bonded" to D-Bus interface
- Send property changed signal if the bonded flag is changed

 doc/device-api.txt |  4 ++++
 src/device.c       | 40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4e824d2dec17..6162755f954c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -171,6 +171,10 @@ Properties	string Address [readonly]
 
 			Indicates if the remote device is paired.
 
+		boolean Bonded [readonly]
+
+			Indicates if the remote device is bonded.
+
 		boolean Connected [readonly]
 
 			Indicates if the remote device is currently connected.
diff --git a/src/device.c b/src/device.c
index 8dc12d026827..868c41f025d9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1042,6 +1042,22 @@ static gboolean dev_property_get_paired(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_bonded(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	dbus_bool_t val;
+
+	if (dev->bredr_state.bonded || dev->le_state.bonded)
+		val = TRUE;
+	else
+		val = FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_legacy(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -3120,6 +3136,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Icon", "s", dev_property_get_icon, NULL,
 					dev_property_exists_icon },
 	{ "Paired", "b", dev_property_get_paired },
+	{ "Bonded", "b", dev_property_get_bonded },
 	{ "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
 	{ "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
 	{ "LegacyPairing", "b", dev_property_get_legacy },
@@ -6114,17 +6131,30 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
 
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
 {
+	struct bearer_state *state;
+
 	if (!device)
 		return;
 
-	DBG("");
+	state = get_state(device, bdaddr_type);
 
-	if (bdaddr_type == BDADDR_BREDR)
-		device->bredr_state.bonded = true;
-	else
-		device->le_state.bonded = true;
+	if (state->bonded)
+		return;
+
+	DBG("setting bonded for device to true");
+
+	state->bonded = true;
 
 	btd_device_set_temporary(device, false);
+
+	/* If the other bearer state was already true we don't need to
+	 * send any property signals.
+	 */
+	if (device->bredr_state.bonded == device->le_state.bonded)
+		return;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Bonded");
 }
 
 void device_set_legacy(struct btd_device *device, bool legacy)
-- 
2.36.0.rc0.470.gd361397f0d-goog

