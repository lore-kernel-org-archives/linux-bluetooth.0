Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C5BC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A624C61283
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhGVFUT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:19 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49426 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhGVFUS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:18 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210722060053epoutp01cea9b5e15ddac7cf04aa5073b1c2dc23~UB4m3AULM1956619566epoutp01F
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:00:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210722060053epoutp01cea9b5e15ddac7cf04aa5073b1c2dc23~UB4m3AULM1956619566epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933653;
        bh=+bXCDXMPBYaySU8ZeO2ssuv752TOfXMu8pPFE7teVSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZW6qmZz/hrIY7PkidUQFnUUPx60wKey+txTyYTInDkcEXbUP5/PhDkd9Q5RxXS8ET
         2m5X8sHeeT6F4oEn96+rbSauR1RUfnruPKmq5tNNnM9j7yjmyR4uMiBsYeTQa4Ro57
         QJnEZUSX0CJa9RVoT9gnhhfPTcI3doi7oFw50miw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210722060048epcas5p1e782dfef9f2df6439e509b1508d32f3c~UB4iY0efb2845628456epcas5p1T;
        Thu, 22 Jul 2021 06:00:48 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.13.55882.F8909F06; Thu, 22 Jul 2021 15:00:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055011epcas5p15299bfe8f8b8dd58e1354364071608e3~UBvRPlD9b1427914279epcas5p1A;
        Thu, 22 Jul 2021 05:50:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722055011epsmtrp2d6032a963bdec05754de1312b722d9b8~UBvRPF0gE1175011750epsmtrp26;
        Thu, 22 Jul 2021 05:50:11 +0000 (GMT)
X-AuditID: b6c32a49-f65ff7000001da4a-c3-60f9098fea23
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.14.08394.31709F06; Thu, 22 Jul 2021 14:50:11 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055010epsmtip1a7fe1e5b4d68aa21b5c4301eccf2831c~UBvQLqhZT1275612756epsmtip1C;
        Thu, 22 Jul 2021 05:50:10 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 3/8] btio: Add BT_IO_PHY option to set le phy options
Date:   Thu, 22 Jul 2021 11:19:46 +0530
Message-Id: <20210722054951.8291-4-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmhm4/588Eg1uT5CzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MqYci+p4LdExZyb/9gbGF8IdzFyckgI
        mEjMWDOdpYuRi0NIYDejxI2dHxghnE+MEmdut7BDON8YJXb9esgG09J+8QBUYi+jxPkJe1jg
        WnrXbmUFqWIT0JR4/fELE4gtIqAs8WzfYTCbWUBX4sz7dUCTODiEBbwlVvaBhVkEVCVunnnE
        DmLzClhJ/Fj5lgVimbzE6g0HmEFsTgFriQOPboItlhCYzC5xds5+dpA5EgIuEvsWB0HUC0u8
        Or6FHcKWkvj8bi8bRH0zo8SOzRuhmnsYJR786IZ6x17iXNMzVpBBzEBHr9+lDxGWlZh6ah3U
        zXwSvb+fMEHEeSV2zIOxVSQ2rOqEW/bx2EJmCNtDon/eHSZIoPQxSjR232WcwCg3C2HFAkbG
        VYySqQXFuempxaYFhnmp5XrFibnFpXnpesn5uZsYwbGs5bmD8e6DD3qHGJk4GA8xSnAwK4nw
        qhR9TRDiTUmsrEotyo8vKs1JLT7EKM3BoiTOyx4PlBJITyxJzU5NLUgtgskycXBKNTBFh7Pv
        5vjZffr+tDmaZY/U7SJv+3euEOR8tG81982+ShOXzI49R2ratgg5dNsK8U75Ol++5tgW3esa
        Kew7l38+ZrVGnaHDdPfDeiO3kKz41LdugXGRj3XzZsiffLUpaDFz9925N2SevDsUFTsrvtVL
        1M1fRPbkftHiv+dL04/Gf8+3CH3x7szGdL+z5lfrF8lb5B/dc3X1y+lviurcj9zVN1dd4nX7
        5xY2Nqmd8xeruioziOtubj+Qx5H2xfHY/NrOyYf5JOPr/rQXN2285bu660XV/peJHlxfVkj+
        ad8/tWVBoYAAE8vuetf7a/tmLb0/38z0YrL/Fb4LfL7fc7Z+K8j/mjbL4sbUe4nc3TeVWIoz
        Eg21mIuKEwHdVB0kVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSnK4w+88Eg/MvFS3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MqYci+p4LdExZyb/9gbGF8IdzFyckgI
        mEi0XzzA3sXIxSEksJtRYt6Bl8xdjBxACSmJx8t0IGqEJVb+ew5V84FR4vqCu2wgCTYBTYnX
        H78wgdgiAsoSz/YdBrOZBfQlnl64zggyR1jAW2JlH1iYRUBV4uaZR+wgNq+AlcSPlW9ZIObL
        S6zecIAZxOYUsJY48OgmWI0QUM2911uYJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqX
        rpecn7uJERwoWpo7GLev+qB3iJGJg/EQowQHs5IIr0rR1wQh3pTEyqrUovz4otKc1OJDjNIc
        LErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamFofbBCTXbJGYpODtg2nqsg3o6Pzf/lkzp/U
        sf/4/E08Mc+93t55srwxru7N7kN6HS7HpL1n+k5dJC6iECcSVP72luuu66lz/vn6Tb7+MdJV
        9tP8OmHNBffKXk5PEPr1LKl2RwdP7w136cdTrcwWrj7vwOGxfK2/Zt2jI3qBae8vcjTb7pFf
        s7aUT+/nNqV/1zV+OSwU2KGUsWtD2xV+/QeLZgexir2Ta7x+92hJHOfq3VZRO19X/ClU+8NR
        2Ka5Len3j8avCYcNFZa5cS3NSdWsvNF6oqvp4c5MQ2ttnl27O5fLZexQ3dZwT4Bv84bT3hP2
        PHTcUcsR2rhWf8N6e6VXrfdOPeYMMJ4lXv1zdpMSS3FGoqEWc1FxIgA0wTy1gwIAAA==
X-CMS-MailID: 20210722055011epcas5p15299bfe8f8b8dd58e1354364071608e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055011epcas5p15299bfe8f8b8dd58e1354364071608e3
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055011epcas5p15299bfe8f8b8dd58e1354364071608e3@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for the BT_IO_PHY socket
option through BtIO. This can be used to set preference
for LE TX & RX PHYs for a particular connection.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 btio/btio.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 1f1c374bc..6805ac438 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -66,6 +66,7 @@ struct set_opts {
 	int flushable;
 	uint32_t priority;
 	uint16_t voice;
+	uint32_t phy;
 };
 
 struct connect {
@@ -569,6 +570,14 @@ static int set_priority(int sock, uint32_t prio)
 	return 0;
 }
 
+static int l2cap_set_le_phy(int sock, uint32_t phy)
+{
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_PHY, &phy, sizeof(phy)) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static gboolean get_key_size(int sock, int *size, GError **err)
 {
 	struct bt_security sec;
@@ -657,7 +666,7 @@ static gboolean set_le_mode(int sock, uint8_t mode, GError **err)
 static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 				uint16_t imtu, uint16_t omtu, uint8_t mode,
 				int master, int flushable, uint32_t priority,
-				GError **err)
+				uint32_t phy, GError **err)
 {
 	if (imtu || omtu || mode) {
 		gboolean ret = FALSE;
@@ -694,6 +703,11 @@ static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 	if (sec_level && !set_sec_level(sock, BT_IO_L2CAP, sec_level, err))
 		return FALSE;
 
+	if (phy > 0 && l2cap_set_le_phy(sock, phy) < 0) {
+		ERROR_FAILED(err, "l2cap_set_le_phy", errno);
+		return FALSE;
+	}
+
 	return TRUE;
 }
 
@@ -834,6 +848,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	opts->priority = 0;
 	opts->src_type = BDADDR_BREDR;
 	opts->dst_type = BDADDR_BREDR;
+	opts->phy = 0;
 
 	while (opt != BT_IO_OPT_INVALID) {
 		switch (opt) {
@@ -904,13 +919,15 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_VOICE:
 			opts->voice = va_arg(args, int);
 			break;
+		case BT_IO_OPT_PHY:
+			opts->phy = va_arg(args, int);
+			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_KEY_SIZE:
 		case BT_IO_OPT_SOURCE_CHANNEL:
 		case BT_IO_OPT_DEST_CHANNEL:
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
-		case BT_IO_OPT_PHY:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1579,7 +1596,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	case BT_IO_L2CAP:
 		return l2cap_set(sock, opts.src_type, opts.sec_level, opts.imtu,
 					opts.omtu, opts.mode, opts.master,
-					opts.flushable, opts.priority, err);
+					opts.flushable, opts.priority, opts.phy, err);
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.master, err);
 	case BT_IO_SCO:
@@ -1629,7 +1646,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		if (!l2cap_set(sock, opts->src_type, opts->sec_level,
 				opts->imtu, opts->omtu, opts->mode,
 				opts->master, opts->flushable, opts->priority,
-				err))
+				opts->phy, err))
 			goto failed;
 		break;
 	case BT_IO_RFCOMM:
-- 
2.17.1

