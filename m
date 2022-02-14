Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA29C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 13:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiBNNPD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:15:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiBNNPD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 08:15:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C24E39C
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 05:14:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso10827453wme.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 05:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8lL/qgkoeKd0RpLoet6fAyIv3SYfORQUrLJn1sZkfY=;
        b=dWQbzXRGETOqRZbHGsu1qCdqim8zIc08sboFtUy+w+mACbcR/tfdbX/eUqTiT3XWH0
         WIn0NnLUlZ0KMZw8mAOL8J2Tz117bjIa9WUyGAyQntNO17hqZLFC3HEaE/DNZ7mTSrd0
         8exhUCatOESr+i8tM7gUzHTXx9qslTvswyjuuGZlPOnDETG1GJua9pocEEjvAhCeB5Pf
         E8OHlUuLe/pwmr1IBGeym5JHIOgGyP0WmKfiP1rUN0C3nDWnjVzTVZJEHcpo3zFNaaPd
         I92z19tzKmnzBMDLxukeXS2fuJ9yeYdtfk8RPFes7oL79CweyZOdTSVh019vitD7rdbQ
         4Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8lL/qgkoeKd0RpLoet6fAyIv3SYfORQUrLJn1sZkfY=;
        b=0Nmo7OvDLeA0CAINCYH1HwREQxJqTjRRN/7p2iwDcrbROd50usmxp0v7VeEuC9ZYRt
         CfO+dwEDCLv+WKoLWkO3+brwQbTUAO4/gA7z8i6JcTplLCkhgU62uNJUf9jaZ3+hMoHf
         4BLAhE0Bl8vhblAHYIbQzm1DCPIj0aI2ZSY209Kor0jkWfvitVDLRcHFiRJTBdy0edOQ
         SEyQbTGFp4uHk8bcuZHhHwrrJ62w3U2qdRw9Pq6OuHVKiY276HuMh/2NdW/kGw56UGJu
         /6rGDp44uzER0G5YBVYqrwl6GkJWFCm1DwtiPUJHs28Nk7bll1VBVnL7nn/zl68d8phZ
         Dy5g==
X-Gm-Message-State: AOAM533dQ9i48Y6JJQvjDuKRBcRJ/SJbTNWWuvW2Y0ZWJ7T4auc8Aas9
        Dd0tnSqpVkbJyQZzEkUCbKWfc32sXcc=
X-Google-Smtp-Source: ABdhPJz3f3BNx2hTyHeJzceOhe5t6K9qzUTJScBlvoxJoaGciSihPg61wctGeYGO3KVmeKmYjjwe4w==
X-Received: by 2002:a05:600c:301:: with SMTP id q1mr11304485wmd.129.1644844489044;
        Mon, 14 Feb 2022 05:14:49 -0800 (PST)
Received: from kali.home (2a01cb088e0b5b002be75de2a1caa253.ipv6.abo.wanadoo.fr. [2a01:cb08:8e0b:5b00:2be7:5de2:a1ca:a253])
        by smtp.gmail.com with ESMTPSA id l15sm11759839wmi.29.2022.02.14.05.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:14:48 -0800 (PST)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH BlueZ] fix build with glibc < 2.25
Date:   Mon, 14 Feb 2022 14:14:51 +0100
Message-Id: <20220214131451.2397549-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

getrandom and sys/random.h are only available since glibc 2.25:
https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002eh.html
resulting in the following build failures since version 5.63 and
https://git.kernel.org/pub/scm/bluetooth/bluez.git/log/?qt=grep&q=getrandom
so put back rand() as a fallback:

plugins/autopair.c:20:24: fatal error: sys/random.h: No such file or directory
 #include <sys/random.h>
                        ^

Fixes:
 - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c49416c1dc0e2

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 configure.ac           |  2 ++
 emulator/le.c          |  7 +++++++
 emulator/phy.c         |  7 +++++++
 peripheral/main.c      | 10 ++++++++++
 plugins/autopair.c     |  6 ++++++
 profiles/health/hdp.c  | 11 +++++++++++
 profiles/health/mcap.c | 10 ++++++++++
 tools/btgatt-server.c  |  6 ++++++
 8 files changed, 59 insertions(+)

diff --git a/configure.ac b/configure.ac
index 07d068a4d..cdd693da3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,6 +54,8 @@ AC_ARG_ENABLE(threads, AS_HELP_STRING([--enable-threads],
 
 AC_CHECK_FUNCS(explicit_bzero)
 
+AC_CHECK_FUNCS(getrandom)
+
 AC_CHECK_FUNCS(rawmemchr)
 
 AC_CHECK_FUNC(signalfd, dummy=yes,
diff --git a/emulator/le.c b/emulator/le.c
index f8f313f2c..9ef0636d0 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -20,7 +20,9 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/uio.h>
+#ifdef HAVE_GETRANDOM
 #include <sys/random.h>
+#endif
 #include <time.h>
 
 #include "lib/bluetooth.h"
@@ -509,10 +511,15 @@ static unsigned int get_adv_delay(void)
 	/* The advertising delay is a pseudo-random value with a range
 	 * of 0 ms to 10 ms generated for each advertising event.
 	 */
+#ifdef HAVE_GETRANDOM
 	if (getrandom(&val, sizeof(val), 0) < 0) {
 		/* If it fails to get the random number, use a static value */
 		val = 5;
 	}
+#else
+	srand(time(NULL));
+	val = rand();
+#endif
 
 	return (val % 11);
 }
diff --git a/emulator/phy.c b/emulator/phy.c
index 44cace438..e41aaf9c2 100644
--- a/emulator/phy.c
+++ b/emulator/phy.c
@@ -19,7 +19,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/socket.h>
+#ifdef HAVE_GETRANDOM
 #include <sys/random.h>
+#endif
 #include <netinet/in.h>
 #include <netinet/ip.h>
 #include <time.h>
@@ -174,6 +176,7 @@ struct bt_phy *bt_phy_new(void)
 	mainloop_add_fd(phy->rx_fd, EPOLLIN, phy_rx_callback, phy, NULL);
 
 	if (!get_random_bytes(&phy->id, sizeof(phy->id))) {
+#ifdef GAVE_GETRANDOM
 		if (getrandom(&phy->id, sizeof(phy->id), 0) < 0) {
 			mainloop_remove_fd(phy->rx_fd);
 			close(phy->tx_fd);
@@ -181,6 +184,10 @@ struct bt_phy *bt_phy_new(void)
 			free(phy);
 			return NULL;
 		}
+#else
+		srandom(time(NULL));
+		phy->id = random();
+#endif
 	}
 
 	bt_phy_send(phy, BT_PHY_PKT_NULL, NULL, 0);
diff --git a/peripheral/main.c b/peripheral/main.c
index 91adb45fc..542adc330 100644
--- a/peripheral/main.c
+++ b/peripheral/main.c
@@ -25,7 +25,9 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/mount.h>
+#ifdef HAVE_GETRANDOM
 #include <sys/random.h>
+#endif
 
 #ifndef WAIT_ANY
 #define WAIT_ANY (-1)
@@ -192,10 +194,18 @@ int main(int argc, char *argv[])
 							addr, 6) < 0) {
 			printf("Generating new persistent static address\n");
 
+#ifdef HAVE_GETRANDOM
 			if (getrandom(addr, sizeof(addr), 0) < 0) {
 				perror("Failed to get random static address");
 				return EXIT_FAILURE;
 			}
+#else
+			addr[0] = rand();
+			addr[1] = rand();
+			addr[2] = rand();
+			addr[3] = 0x34;
+			addr[4] = 0x12;
+#endif
 			/* Overwrite the MSB to make it a static address */
 			addr[5] = 0xc0;
 
diff --git a/plugins/autopair.c b/plugins/autopair.c
index a75ecebe4..59d65807c 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -17,7 +17,9 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#ifdef HAVE_GETRANDOM
 #include <sys/random.h>
+#endif
 
 #include <glib.h>
 
@@ -131,10 +133,14 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 			if (attempt >= 4)
 				return 0;
 
+#ifdef HAVE_GETRANDOM
 			if (getrandom(&val, sizeof(val), 0) < 0) {
 				error("Failed to get a random pincode");
 				return 0;
 			}
+#else
+			val = rand();
+#endif
 			snprintf(pinstr, sizeof(pinstr), "%06u",
 						val % 1000000);
 			*display = true;
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 9d9d1e824..ca59be3e8 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -16,7 +16,9 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <unistd.h>
+#ifdef HAVE_GETRANDOM
 #include <sys/random.h>
+#endif
 
 #include <glib.h>
 
@@ -1485,15 +1487,24 @@ static void destroy_create_dc_data(gpointer data)
 static void *generate_echo_packet(void)
 {
 	uint8_t *buf;
+#ifndef HAVE_GETRANDOM
+	int i;
+#endif
 
 	buf = g_malloc(HDP_ECHO_LEN);
 	if (!buf)
 		return NULL;
 
+#ifdef HAVE_GETRANDOM
 	if (getrandom(buf, HDP_ECHO_LEN, 0) < 0) {
 		g_free(buf);
 		return NULL;
 	}
+#else
+	srand(time(NULL));
+	for(i = 0; i < HDP_ECHO_LEN; i++)
+		buf[i] = rand() % UINT8_MAX;
+#endif
 
 	return buf;
 }
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index aad0a08a3..9bd994fda 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -19,7 +19,9 @@
 #include <errno.h>
 #include <unistd.h>
 #include <time.h>
+#ifdef HAVE_GETRANDOM
 #include <sys/random.h>
+#endif
 
 #include <glib.h>
 
@@ -1905,11 +1907,15 @@ gboolean mcap_create_mcl(struct mcap_instance *mi,
 		mcl->state = MCL_IDLE;
 		bacpy(&mcl->addr, addr);
 		set_default_cb(mcl);
+#ifdef HAVE_GETRANDOM
 		if (getrandom(&val, sizeof(val), 0) < 0) {
 			mcap_instance_unref(mcl->mi);
 			g_free(mcl);
 			return FALSE;
 		}
+#else
+		val = rand();
+#endif
 		mcl->next_mdl = (val % MCAP_MDLID_FINAL) + 1;
 	}
 
@@ -2049,11 +2055,15 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 		mcl->mi = mcap_instance_ref(mi);
 		bacpy(&mcl->addr, &dst);
 		set_default_cb(mcl);
+#ifdef HAVE_GETRANDOM
 		if (getrandom(&val, sizeof(val), 0) < 0) {
 			mcap_instance_unref(mcl->mi);
 			g_free(mcl);
 			goto drop;
 		}
+#else
+		val = rand();
+#endif
 		mcl->next_mdl = (val % MCAP_MDLID_FINAL) + 1;
 	}
 
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 15d49a464..6367ccd9d 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -20,7 +20,9 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <errno.h>
+#ifdef HAVE_GETRANDOM
 #include <sys/random.h>
+#endif
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -287,8 +289,12 @@ static bool hr_msrmt_cb(void *user_data)
 	uint32_t cur_ee;
 	uint32_t val;
 
+#ifdef HAVE_GETRANDOM
 	if (getrandom(&val, sizeof(val), 0) < 0)
 		return false;
+#else
+	val = rand();
+#endif
 
 	pdu[0] = 0x06;
 	pdu[1] = 90 + (val % 40);
-- 
2.34.1

