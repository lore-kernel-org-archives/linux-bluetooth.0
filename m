Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A50BC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCA820659
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm7uEnR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCA820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeK0DoE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:44:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41465 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeK0DoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 22:44:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so19681133wrs.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AytsAq41V2IZ7XF5w+IbdOuys0ags5g204W4kRwnGjA=;
        b=hm7uEnR8U+mISfYQc86bPCDBEYHSFV7yRx7+zkK4FZ5qOtlWcviSRXepIrJydU+rT2
         wOT5+AG9aPHM/7P5aSY1UDkNVhqoXd+wwx+UOHklxbhfGVmtd6nnfh5OUtZh7b8dkWJE
         w98gMEHodtfdfJLOWq7IzrfokrJTIHHwzOzr6EERw8o1IuTdDrGoMzIeqYmyKhmjR+aj
         Qx+3IYCshkY2qaRePtKbE1ImnFrMCtOmHuKXKFg2dNWSLIwmnEA30PvdiK1wJFJ2hU0Q
         KbzNxrU9CvbmkibataORFXt5JC73oBvj/qKnn0VbfHK6AG5ZCQ52ziNvQt3pwCswJcDs
         mCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AytsAq41V2IZ7XF5w+IbdOuys0ags5g204W4kRwnGjA=;
        b=hxnK3SysQ76MDDaPfx5lU5ak/I4zHV068s10z/dYuTEejSaxuEQF4AiSaWmTqv4r7+
         bdhMMyzg1htGwa8EpQspYZgQLd3x0WDTZFPSK8JAJYLzb1nkN06x/bEwHqPLMoN0E8SN
         jNJjyxV2hH5QJINzDCDMNjzbnaw/r6rd+AOVGJQjqyGtKZCeUvwcqr/g8mQ5FXZBJZXJ
         veedXC2AKrsh38m3R6/KepELAnfHTEmK4TYtt2IuPzbeoZ3e+HkonIZzi6fn2uOaYhtb
         fWz86Sj6FfN/LafRr3oSB387MiMmMbAqX0qeuzXAlmN2/jZELdOtzZLOqpD1/O+MRiZ4
         n98w==
X-Gm-Message-State: AA+aEWavs8SjRsI4hdgI8XGEmfy4EVsfMccfv/Nm6aMF1w9pMktQ8LsV
        0mrqUEouGrvbVpb9YCT2I/VsDv6W
X-Google-Smtp-Source: AFSGD/Wv6ffyfu4w/+VWSSJ5rv9d5JoAUAaATFQuYkF6OqS5oyMBJ7RPJG2Uk1mD2FQJn0ia12/glg==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr26393687wru.245.1543250962868;
        Mon, 26 Nov 2018 08:49:22 -0800 (PST)
Received: from Buero.fritz.box ([2001:a62:15c7:f600:d580:4377:eac4:b277])
        by smtp.gmail.com with ESMTPSA id q9sm1245736wrp.0.2018.11.26.08.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:49:22 -0800 (PST)
From:   Christian Zimmermann <zimmermach@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Christian Zimmermann <zimmermach@gmail.com>
Subject: [PATCH BlueZ 2/2] Removed obsolete conversion functions, since the conversion is now done once during install
Date:   Mon, 26 Nov 2018 17:49:07 +0100
Message-Id: <20181126164907.15659-2-zimmermach@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181126164907.15659-1-zimmermach@gmail.com>
References: <20181126164907.15659-1-zimmermach@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c |  51 ---------------------------
 src/storage.c | 110 ----------------------------------------------------------
 src/storage.h |   4 ---
 3 files changed, 165 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c24432125..ff8f64300 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -423,18 +423,6 @@ void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 	set_dev_class(adapter);
 }
 
-static uint8_t get_mode(const char *mode)
-{
-	if (strcasecmp("off", mode) == 0)
-		return MODE_OFF;
-	else if (strcasecmp("connectable", mode) == 0)
-		return MODE_CONNECTABLE;
-	else if (strcasecmp("discoverable", mode) == 0)
-		return MODE_DISCOVERABLE;
-	else
-		return MODE_UNKNOWN;
-}
-
 const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter)
 {
 	static char dir[25];
@@ -5639,44 +5627,6 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	textfile_foreach(filename, convert_proximity_entry, address);
 }
 
-static void convert_config(struct btd_adapter *adapter, const char *filename,
-							GKeyFile *key_file)
-{
-	char address[18];
-	char str[MAX_NAME_LENGTH + 1];
-	char config_path[PATH_MAX];
-	int timeout;
-	uint8_t mode;
-	char *data;
-	gsize length = 0;
-
-	ba2str(&adapter->bdaddr, address);
-	snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
-
-	if (read_pairable_timeout(address, &timeout) == 0)
-		g_key_file_set_integer(key_file, "General",
-						"PairableTimeout", timeout);
-
-	if (read_discoverable_timeout(address, &timeout) == 0)
-		g_key_file_set_integer(key_file, "General",
-						"DiscoverableTimeout", timeout);
-
-	if (read_on_mode(address, str, sizeof(str)) == 0) {
-		mode = get_mode(str);
-		g_key_file_set_boolean(key_file, "General", "Discoverable",
-					mode == MODE_DISCOVERABLE);
-	}
-
-	if (read_local_name(&adapter->bdaddr, str) == 0)
-		g_key_file_set_string(key_file, "General", "Alias", str);
-
-	create_file(filename, S_IRUSR | S_IWUSR);
-
-	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
-	g_free(data);
-}
-
 static void fix_storage(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX];
@@ -5753,7 +5703,6 @@ static void load_config(struct btd_adapter *adapter)
 					btd_adapter_get_storage_dir(adapter));
 
 	if (stat(filename, &st) < 0) {
-		convert_config(adapter, filename, key_file);
 		convert_device_storage(adapter);
 	}
 
diff --git a/src/storage.c b/src/storage.c
index 734a9e08e..6317d7cf5 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -22,128 +22,18 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <ctype.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <time.h>
-#include <sys/file.h>
-#include <sys/stat.h>
 
 #include <glib.h>
 
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
-#include "lib/uuid.h"
 
 #include "textfile.h"
 #include "uuid-helper.h"
 #include "storage.h"
 
-/* When all services should trust a remote device */
-#define GLOBAL_TRUST "[all]"
-
-struct match {
-	GSList *keys;
-	char *pattern;
-};
-
-static inline int create_filename(char *buf, size_t size,
-				const bdaddr_t *bdaddr, const char *name)
-{
-	char addr[18];
-
-	ba2str(bdaddr, addr);
-
-	return create_name(buf, size, STORAGEDIR, addr, name);
-}
-
-int read_discoverable_timeout(const char *src, int *timeout)
-{
-	char filename[PATH_MAX], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
-
-	str = textfile_get(filename, "discovto");
-	if (!str)
-		return -ENOENT;
-
-	if (sscanf(str, "%d", timeout) != 1) {
-		free(str);
-		return -ENOENT;
-	}
-
-	free(str);
-
-	return 0;
-}
-
-int read_pairable_timeout(const char *src, int *timeout)
-{
-	char filename[PATH_MAX], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
-
-	str = textfile_get(filename, "pairto");
-	if (!str)
-		return -ENOENT;
-
-	if (sscanf(str, "%d", timeout) != 1) {
-		free(str);
-		return -ENOENT;
-	}
-
-	free(str);
-
-	return 0;
-}
-
-int read_on_mode(const char *src, char *mode, int length)
-{
-	char filename[PATH_MAX], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
-
-	str = textfile_get(filename, "onmode");
-	if (!str)
-		return -ENOENT;
-
-	strncpy(mode, str, length);
-	mode[length - 1] = '\0';
-
-	free(str);
-
-	return 0;
-}
-
-int read_local_name(const bdaddr_t *bdaddr, char *name)
-{
-	char filename[PATH_MAX], *str;
-	int len;
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	str = textfile_get(filename, "name");
-	if (!str)
-		return -ENOENT;
-
-	len = strlen(str);
-	if (len > HCI_MAX_NAME_LENGTH)
-		str[HCI_MAX_NAME_LENGTH] = '\0';
-	strcpy(name, str);
-
-	free(str);
-
-	return 0;
-}
-
 sdp_record_t *record_from_string(const char *str)
 {
 	sdp_record_t *rec;
diff --git a/src/storage.h b/src/storage.h
index 1c0ad57ec..8b7d9aa30 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -21,9 +21,5 @@
  *
  */
 
-int read_discoverable_timeout(const char *src, int *timeout);
-int read_pairable_timeout(const char *src, int *timeout);
-int read_on_mode(const char *src, char *mode, int length);
-int read_local_name(const bdaddr_t *bdaddr, char *name);
 sdp_record_t *record_from_string(const char *str);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
-- 
2.11.0

