Return-Path: <SRS0=Qv9v=2X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C4C3276C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 23:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B3920866
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 23:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlgOoJCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgABXBH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:01:07 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:34729 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgABXBD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 18:01:03 -0500
Received: by mail-pj1-f51.google.com with SMTP id s94so2365507pjc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 15:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1tOm7/QQ4BdIINdv6+UL2D572iaC/AKl32SSZI2q6vM=;
        b=mlgOoJCWUke3ZuYXQ0TWhqjRqhgSYj1bpkoUEK1GZTmpks5SEzszC8LVnLfLUzFTWl
         4DInTEyxMlKQy1wopu0cMGkvOHZ/GePS1HJqW0GhSfD/zrRAN4AShZ/rI7ubaghORjCh
         SHn+MS+eVYKZXM5h2VI896RyfFtd+Cb4A92CyHFwdDFNWel5wSgNW883foR5R0/O6eAa
         Uk9wbhrHRCDAKdxmMEBy1YZYtxqa79qXR7qQCPX43AlhywVdFu3uTq6vzKnxsuH1d1t3
         hdMX7MyS3lAcSeDWD8si+QOlZCanAMysbJVTvbep4w6LcMUCHXZ571+uKVgwQ+8r6JOG
         Cddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tOm7/QQ4BdIINdv6+UL2D572iaC/AKl32SSZI2q6vM=;
        b=O5q9hZM2onvyrO6X+4Mc579S7OEyAvhK1vWBp6l79S/k7d29+WIK/KEr6CFY+NHxmW
         3SvBSMGW9fkNRUc3yxZ1UQc6JwI4L2y4Mlc6fdwPjrR6Zv3YZIwl+JGCgqAKQlwcj4rq
         WbgEeXxXP4b7dITQZfXswpDQ8HUE311JfeqFAtDhCj8jqYoaxvYRZQIlF2vNdNjTSOLw
         swNRiQq0xwfLdkJVgA98XBwTI6H1m2kT6Rkal3q7r6SUq/8WgZ8pV6a+3YryFawkKAkw
         mNu6ni6JAvTH+HCky3FaF1E30xfWQ2VzslGlJS5qdP/Lv+fncT3SasdX3z6kVsFt17sJ
         TVrg==
X-Gm-Message-State: APjAAAU8s9EJgy8SUZ5jHfkigAFl5ZC65ngtvtn+BCKiREivHQRydQ12
        chuY99rlSKeMjecNm6Y/DMZch/2QLkA=
X-Google-Smtp-Source: APXvYqzxh5tjYpPOF1aMmOJ5OunoL9dX3E2tkqS3SXxumkY5LVQOeYWNGh9MpH/53GmesOt5xoTHTw==
X-Received: by 2002:a17:90a:dc82:: with SMTP id j2mr23287834pjv.70.1578006062202;
        Thu, 02 Jan 2020 15:01:02 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id 83sm61468946pgh.12.2020.01.02.15.01.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:01:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 3/3] Bluetooth: Auto tune if input MTU is set to 0
Date:   Thu,  2 Jan 2020 15:00:57 -0800
Message-Id: <20200102230057.31326-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200102230057.31326-1-luiz.dentz@gmail.com>
References: <20200102230057.31326-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the code to set the input MTU using the underline link
packet types when set to 0, previously this would likely be rejected by
the remote peer since it would be bellow the minimal of 48 for BR/EDR
or 23 for LE, that way it shall be safe to use 0 without causing any
side effects.

This is convenient for the likes of A2DP transport, see:

https://habr.com/en/post/456182/

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 54 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a845786258a0..1bca608e0170 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1289,6 +1289,9 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 	if (test_and_set_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags))
 		return;
 
+	if (!chan->imtu)
+		chan->imtu = chan->conn->mtu;
+
 	l2cap_le_flowctl_init(chan, 0);
 
 	req.psm     = chan->psm;
@@ -3226,6 +3229,49 @@ static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
 	chan->ack_win = chan->tx_win;
 }
 
+static void l2cap_mtu_auto(struct l2cap_chan *chan)
+{
+	struct hci_conn *conn = chan->conn->hcon;
+
+	chan->imtu = L2CAP_DEFAULT_MIN_MTU;
+
+	/* The 2-DH1 packet has between 2 and 56 information bytes
+	 * (including the 2-byte payload header)
+	 */
+	if (!(conn->pkt_type & HCI_2DH1))
+		chan->imtu = 54;
+
+	/* The 3-DH1 packet has between 2 and 85 information bytes
+	 * (including the 2-byte payload header)
+	 */
+	if (!(conn->pkt_type & HCI_3DH1))
+		chan->imtu = 83;
+
+	/* The 2-DH3 packet has between 2 and 369 information bytes
+	 * (including the 2-byte payload header)
+	 */
+	if (!(conn->pkt_type & HCI_2DH3))
+		chan->imtu = 367;
+
+	/* The 3-DH3 packet has between 2 and 554 information bytes
+	 * (including the 2-byte payload header)
+	 */
+	if (!(conn->pkt_type & HCI_3DH3))
+		chan->imtu = 552;
+
+	/* The 2-DH5 packet has between 2 and 681 information bytes
+	 * (including the 2-byte payload header)
+	 */
+	if (!(conn->pkt_type & HCI_2DH5))
+		chan->imtu = 679;
+
+	/* The 3-DH5 packet has between 2 and 1023 information bytes
+	 * (including the 2-byte payload header)
+	 */
+	if (!(conn->pkt_type & HCI_3DH5))
+		chan->imtu = 1021;
+}
+
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data_size)
 {
 	struct l2cap_conf_req *req = data;
@@ -3255,8 +3301,12 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	}
 
 done:
-	if (chan->imtu != L2CAP_DEFAULT_MTU)
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu, endptr - ptr);
+	if (chan->imtu != L2CAP_DEFAULT_MTU) {
+		if (!chan->imtu)
+			l2cap_mtu_auto(chan);
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu,
+				   endptr - ptr);
+	}
 
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
-- 
2.21.0

