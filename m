Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FB0C3404D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F2B2173E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix71fk6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgBSAgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:36:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42587 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgBSAgV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 19:36:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so11547756pfz.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 16:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZjHaeiv7PtAZatXJnomiWi3pVfqwNeZCImTARyOK0Xo=;
        b=Ix71fk6ujxY8j1j++eOKOWS70ho2kZ1tB0+LcxFxUuY1dm/EVYDy39NqA8C+8s8C0p
         jPwCM4Nsp/cApMOgm7wN7SunR1bSofL6s9EV4y5zqwtH5/QKzc4+YVjlzGOMxxaA//F9
         3YpkEUhBBI7a7mCeTb+sdQVYhr+5zrr3SBkuRj7hmaXM7jJ8qncmfDX13Feh2AB1rHLH
         LAXj6BKuzqQFSvkTN7nom74ADUOLwxv6r4j5+Aszqmyra9zMMyPh5PX8VG6JnQtqOw0R
         jIrKmSv+G0gK6Rb1lG/PS/laiUl9fXDLK6dIwEsG6UgFIMWZgq7CrJYzCoV7uosbU8Nk
         +ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjHaeiv7PtAZatXJnomiWi3pVfqwNeZCImTARyOK0Xo=;
        b=H7qaaIcfIkFzzXyi1bw6VM4f2Mm/yVlsGMrbOSdpYltqI03X6xzeZ0WUUex7HQjeVe
         oM7gBZ2y2RDyDpntZAlt3Vwsvo98CiPavTVchtHzGqedg5ma2wSV/wq8wOvzTe7zI8SO
         JwjzO0nZEmKoDg5c4GyFVyty/kYgDntADs1sWzrVBY89nOAie+mseRCrUp8VyypXkeZM
         PWOgdjlZZgu1jmTnrKCLnxB+pR2QmLExeISFEyAcS/CIe9N7nuXTjdgZBI4Lbhlnp0tW
         GTTSkmo5zspJvDT9ouWRr/mdcyULtn8wHdLr4AflXD+GRrhFMTHcQ9TQPiWxSiciklVy
         1wSg==
X-Gm-Message-State: APjAAAUYLjxDokkYINM7O2ZKBQGcNWsk9qEVhhLcayqKxn3wVZovKJX+
        sEse2QGVuMgx4qezSoYeWXDh3tc/ngo=
X-Google-Smtp-Source: APXvYqyqWnKcmtgTMjBzxa3Q91hOVW8u8vxdbx8IDZh5Yx957rPNGa5dLBPfKx0h05ep4XlANiDfMA==
X-Received: by 2002:a62:870e:: with SMTP id i14mr6148337pfe.192.1582072580080;
        Tue, 18 Feb 2020 16:36:20 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.42])
        by smtp.gmail.com with ESMTPSA id v184sm180569pfc.67.2020.02.18.16.36.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:36:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] l2test: Add support to BT_PHY
Date:   Tue, 18 Feb 2020 16:36:11 -0800
Message-Id: <20200219003612.14599-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219003612.14599-1-luiz.dentz@gmail.com>
References: <20200219003612.14599-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes l2test attempt to read BT_PHY socket option and print out
the supported packet types/PHY:

l2test[7282]: Connected to XX:XX:XX:XX:XX:XX (bredr, psm 4113, dcid 64)
l2test[7282]: Local device XX:XX:XX:XX:XX:XX (bredr, psm 4113, scid 64)
l2test[7282]: Options [imtu 672, omtu 672, flush_to 65535, mode 0, handle 256, class 0x000000, priority 0, rcvbuf 212992]
l2test[7282]: Supported PHY: 0x000001ff
          BR1M1SLOT
          BR1M3SLOT
          BR1M5SLOT
          EDR2M1SLOT
          EDR2M3SLOT
          EDR2M5SLOT
          EDR3M1SLOT
          EDR3M3SLOT
          EDR3M5SLOT
---
 tools/l2test.c | 209 +++++++++++++++++++++++--------------------------
 1 file changed, 96 insertions(+), 113 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index e787c2ce2..8c6e08646 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -49,6 +49,7 @@
 #include "lib/l2cap.h"
 
 #include "src/shared/util.h"
+#include "monitor/display.h"
 
 #define NIBBLE_TO_ASCII(c)  ((c) < 0x0a ? (c) + 0x30 : (c) + 0x57)
 
@@ -306,14 +307,105 @@ static int setopts(int sk, struct l2cap_options *opts)
 							sizeof(opts->imtu));
 }
 
+bool use_color(void)
+{
+	return false;
+}
+
+static const struct bitfield_data phy_table[] = {
+	{  0, "BR1M1SLOT" },
+	{  1, "BR1M3SLOT" },
+	{  2, "BR1M5SLOT" },
+	{  3, "EDR2M1SLOT" },
+	{  4, "EDR2M3SLOT" },
+	{  5, "EDR2M5SLOT" },
+	{  6, "EDR3M1SLOT" },
+	{  7, "EDR3M3SLOT" },
+	{  8, "EDR3M5SLOT" },
+	{  9, "LE1MTX" },
+	{ 10, "LE1MRX" },
+	{ 11, "LE2MTX" },
+	{ 12, "LE2MRX" },
+	{ 13, "LECODEDTX" },
+	{ 14, "LECODEDRX" },
+	{},
+};
+
+static int print_info(int sk, struct l2cap_options *opts)
+{
+	struct sockaddr_l2 addr;
+	socklen_t optlen;
+	struct l2cap_conninfo conn;
+	int prio, phy;
+	char ba[18];
+
+	/* Get connection information */
+	memset(&conn, 0, sizeof(conn));
+	optlen = sizeof(conn);
+
+	if (getsockopt(sk, SOL_L2CAP, L2CAP_CONNINFO, &conn, &optlen) < 0) {
+		syslog(LOG_ERR, "Can't get L2CAP connection information: "
+				"%s (%d)", strerror(errno), errno);
+		return -errno;
+	}
+
+	if (getsockopt(sk, SOL_SOCKET, SO_PRIORITY, &prio, &optlen) < 0) {
+		syslog(LOG_ERR, "Can't get socket priority: %s (%d)",
+							strerror(errno), errno);
+		return -errno;
+	}
+
+	/* Check for remote address */
+	memset(&addr, 0, sizeof(addr));
+	optlen = sizeof(addr);
+
+	if (getpeername(sk, (struct sockaddr *) &addr, &optlen) < 0) {
+		syslog(LOG_ERR, "Can't get socket name: %s (%d)",
+							strerror(errno), errno);
+		return -errno;
+	}
+
+	ba2str(&addr.l2_bdaddr, ba);
+	syslog(LOG_INFO, "Connected to %s (%s, psm %d, dcid %d)", ba,
+		get_lookup_str(bdaddr_types, addr.l2_bdaddr_type),
+		addr.l2_psm, addr.l2_cid);
+
+	/* Check for socket address */
+	memset(&addr, 0, sizeof(addr));
+	optlen = sizeof(addr);
+
+	if (getsockname(sk, (struct sockaddr *) &addr, &optlen) < 0) {
+		syslog(LOG_ERR, "Can't get socket name: %s (%d)",
+							strerror(errno), errno);
+		return -errno;
+	}
+
+	ba2str(&addr.l2_bdaddr, ba);
+	syslog(LOG_INFO, "Local device %s (%s, psm %d, scid %d)", ba,
+		get_lookup_str(bdaddr_types, addr.l2_bdaddr_type),
+		addr.l2_psm, addr.l2_cid);
+
+	syslog(LOG_INFO, "Options [imtu %d, omtu %d, flush_to %d, mode %d, "
+		"handle %d, class 0x%02x%02x%02x, priority %d, rcvbuf %d]",
+		opts->imtu, opts->omtu, opts->flush_to, opts->mode,
+		conn.hci_handle, conn.dev_class[2], conn.dev_class[1],
+		conn.dev_class[0], prio, rcvbuf);
+
+
+	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy, &optlen)) {
+		syslog(LOG_INFO, "Supported PHY: 0x%08x", phy);
+		print_bitfield(2, phy, phy_table);
+	}
+
+	return 0;
+}
+
 static int do_connect(char *svr)
 {
 	struct sockaddr_l2 addr;
 	struct l2cap_options opts;
-	struct l2cap_conninfo conn;
 	socklen_t optlen;
 	int sk, opt;
-	char ba[18];
 
 	/* Create socket */
 	sk = socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP);
@@ -451,64 +543,8 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
-	/* Get connection information */
-	memset(&conn, 0, sizeof(conn));
-	optlen = sizeof(conn);
-
-	if (getsockopt(sk, SOL_L2CAP, L2CAP_CONNINFO, &conn, &optlen) < 0) {
-		syslog(LOG_ERR, "Can't get L2CAP connection information: %s (%d)",
-							strerror(errno), errno);
-		goto error;
-	}
-
-	if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY, &priority,
-						sizeof(priority)) < 0) {
-		syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
-							strerror(errno), errno);
-		goto error;
-	}
-
-	if (getsockopt(sk, SOL_SOCKET, SO_PRIORITY, &opt, &optlen) < 0) {
-		syslog(LOG_ERR, "Can't get socket priority: %s (%d)",
-							strerror(errno), errno);
-		goto error;
-	}
-
-	/* Check for remote address */
-	memset(&addr, 0, sizeof(addr));
-	optlen = sizeof(addr);
-
-	if (getpeername(sk, (struct sockaddr *) &addr, &optlen) < 0) {
-		syslog(LOG_ERR, "Can't get socket name: %s (%d)",
-							strerror(errno), errno);
-		goto error;
-	}
-
-	ba2str(&addr.l2_bdaddr, ba);
-	syslog(LOG_INFO, "Connected to %s (%s, psm %d, scid %d)", ba,
-		get_lookup_str(bdaddr_types, addr.l2_bdaddr_type),
-		addr.l2_psm, addr.l2_cid);
-
-	/* Check for socket address */
-	memset(&addr, 0, sizeof(addr));
-	optlen = sizeof(addr);
-
-	if (getsockname(sk, (struct sockaddr *) &addr, &optlen) < 0) {
-		syslog(LOG_ERR, "Can't get socket name: %s (%d)",
-							strerror(errno), errno);
+	if (print_info(sk, &opts) < 0)
 		goto error;
-	}
-
-	ba2str(&addr.l2_bdaddr, ba);
-	syslog(LOG_INFO, "Local device %s (%s, psm %d, scid %d)", ba,
-		get_lookup_str(bdaddr_types, addr.l2_bdaddr_type),
-		addr.l2_psm, addr.l2_cid);
-
-	syslog(LOG_INFO, "Options [imtu %d, omtu %d, flush_to %d, "
-		"mode %d, handle %d, class 0x%02x%02x%02x, priority %d, rcvbuf %d]",
-		opts.imtu, opts.omtu, opts.flush_to, opts.mode, conn.hci_handle,
-		conn.dev_class[2], conn.dev_class[1], conn.dev_class[0], opt,
-		rcvbuf);
 
 	omtu = (opts.omtu > buffer_size) ? buffer_size : opts.omtu;
 	imtu = (opts.imtu > buffer_size) ? buffer_size : opts.imtu;
@@ -524,10 +560,8 @@ static void do_listen(void (*handler)(int sk))
 {
 	struct sockaddr_l2 addr;
 	struct l2cap_options opts;
-	struct l2cap_conninfo conn;
 	socklen_t optlen;
 	int sk, nsk, opt;
-	char ba[18];
 
 	/* Create socket */
 	sk = socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP);
@@ -677,62 +711,11 @@ static void do_listen(void (*handler)(int sk))
 			}
 		}
 
-		/* Get connection information */
-		memset(&conn, 0, sizeof(conn));
-		optlen = sizeof(conn);
-
-		if (getsockopt(nsk, SOL_L2CAP, L2CAP_CONNINFO, &conn, &optlen) < 0) {
-			syslog(LOG_ERR, "Can't get L2CAP connection information: %s (%d)",
-							strerror(errno), errno);
-			if (!defer_setup) {
-				close(nsk);
-				goto error;
-			}
-		}
-
-		if (priority > 0 && setsockopt(nsk, SOL_SOCKET, SO_PRIORITY,
-					&priority, sizeof(priority)) < 0) {
-			syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
-						strerror(errno), errno);
+		if (print_info(nsk, &opts) < 0) {
 			close(nsk);
 			goto error;
 		}
 
-		optlen = sizeof(priority);
-		if (getsockopt(nsk, SOL_SOCKET, SO_PRIORITY, &opt, &optlen) < 0) {
-			syslog(LOG_ERR, "Can't get socket priority: %s (%d)",
-							strerror(errno), errno);
-			goto error;
-		}
-
-		ba2str(&addr.l2_bdaddr, ba);
-		syslog(LOG_INFO, "Connect from %s (%s, psm %d, dcid %d)", ba,
-				get_lookup_str(bdaddr_types, addr.l2_bdaddr_type),
-				addr.l2_psm, addr.l2_cid);
-
-		/* Check for socket address */
-		memset(&addr, 0, sizeof(addr));
-		optlen = sizeof(addr);
-
-		if (getsockname(nsk, (struct sockaddr *) &addr, &optlen) < 0) {
-			syslog(LOG_ERR, "Can't get socket name: %s (%d)",
-							strerror(errno), errno);
-			goto error;
-		}
-
-		ba2str(&addr.l2_bdaddr, ba);
-		syslog(LOG_INFO, "Local device %s (%s, psm %d, scid %d)", ba,
-				get_lookup_str(bdaddr_types, addr.l2_bdaddr_type),
-				addr.l2_psm, addr.l2_cid);
-
-		syslog(LOG_INFO, "Options [imtu %d, omtu %d, "
-				"flush_to %d, mode %d, handle %d, "
-				"class 0x%02x%02x%02x, priority %d, rcvbuf %d]",
-				opts.imtu, opts.omtu, opts.flush_to,
-				opts.mode, conn.hci_handle, conn.dev_class[2],
-				conn.dev_class[1], conn.dev_class[0], opt,
-				rcvbuf);
-
 		omtu = (opts.omtu > buffer_size) ? buffer_size : opts.omtu;
 		imtu = (opts.imtu > buffer_size) ? buffer_size : opts.imtu;
 
-- 
2.21.1

