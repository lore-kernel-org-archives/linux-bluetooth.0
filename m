Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA09C63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BD161287
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGVFUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:41 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45799 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhGVFUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:39 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210722060111epoutp04237ac041883adb6ca3bdb999c36df179~UB43TmS9i0789207892epoutp04B
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:01:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210722060111epoutp04237ac041883adb6ca3bdb999c36df179~UB43TmS9i0789207892epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933671;
        bh=mUwTXKrcEYy5ptthGIZBEt/suYaU5Fcxf0wxeN6gvVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhRLCduBOUtbYWpVScnxl/wT3jMVESyn+9GsjNz1quZSqBtBDaoWml90vD6wrvtcR
         U9z9CGYRXNA/WW8G6k/v2CErV46Ap7wg1gXoahG8xfEynSzf+066jjxijfArLShxDc
         /qIey/q7Z/lhE0Rmxnm7bOlPke9ScvQy0QajIhf4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210722060110epcas5p19bbd51bce3a0074159772f4faa018e33~UB42SyHT42847228472epcas5p1g;
        Thu, 22 Jul 2021 06:01:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.9B.11627.4A909F06; Thu, 22 Jul 2021 15:01:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722055015epcas5p4db389aa15f16f1577a74ba5ce446919b~UBvUZk_xC2757927579epcas5p4F;
        Thu, 22 Jul 2021 05:50:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722055015epsmtrp19b3b498bfac8771fc53b7707533c4ecc~UBvUYaHEb3133731337epsmtrp1C;
        Thu, 22 Jul 2021 05:50:15 +0000 (GMT)
X-AuditID: b6c32a4b-acdff70000022d6b-94-60f909a4042f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.6B.08289.61709F06; Thu, 22 Jul 2021 14:50:14 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055014epsmtip180ff11a70d4b5665b05179845d9c0856~UBvTdfJtV1278012780epsmtip1D;
        Thu, 22 Jul 2021 05:50:13 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 6/8] client: Add support for LE get/set device PHY in
 bluetoothctl
Date:   Thu, 22 Jul 2021 11:19:49 +0530
Message-Id: <20210722054951.8291-7-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCmpu4Szp8JBuc/y1vcWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJWx7udFpoK/whU3N61kbWDcJ9DFyMkh
        IWAicf7lFKYuRi4OIYHdjBKTtkxmh3A+MUq83bUfyvnMKLFoXgMzTMvOj3ehErsYJbYsvMAE
        1/J5/xJWkCo2AU2J1x+/MIHYIgLKEs/2HQazmQV0Jc68X8cGYgsLREksOPuZEcRmEVCVWHrx
        E5jNK2AlseJXNxPENnmJ1RsOgG3mFLCWOPDoJthmCYHJ7BL/3r9ngShykTj19hOULSzx6vgW
        dghbSuJlfxtUQzOjxI7NG6GcHkaJBz+62SCq7CXONT0DOpsD6DxNifW79CHCshJTT62DuppP
        ovf3E6iLeCV2zIOxVSQ2rOqEW/bx2EJoGHlI3Fs8mxkSLH2MEj8ftjFPYJSbhbBiASPjKkbJ
        1ILi3PTUYtMC47zUcr3ixNzi0rx0veT83E2M4IjW8t7B+OjBB71DjEwcjIcYJTiYlUR4VYq+
        JgjxpiRWVqUW5ccXleakFh9ilOZgURLnZY8HSgmkJ5akZqemFqQWwWSZODilGph2cd97upkz
        +Lxc56Ufv1r4sx4YLfO1Cudzdlj06HyJwEIrq4AX8ouKLtdpTnWddJQnXDXjIOuL/NN5pScz
        lzYUp3id7968oCRtqt+SnYf3rk/Zenl34+uvm5MPNqlKPvqyJi+z+n/ZNq+O/kkx5xSaguq+
        HJI6ouTxRiTde4015z6WDfu/hOt9fhc2v0yqeYO1uPumKelsCf3KzXv0pz9TWbPP5vT7rBP3
        9q1NzJrLnpm+5/eMX2px+zZ9E6tpfJH9VEL4kdOCzctnLYksYF+nsfnXft+bN90Dj0szb6yJ
        fybeI+b6VyWnit8w/t/i4t096tn7pStWsUy/HmikGTld4lX+zZcy5TvqOcPfHWZVYinOSDTU
        Yi4qTgQAZgIh8lcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsWy7bCSnK4Y+88Eg+kzbCzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MpY9/MiU8Ff4Yqbm1ayNjDuE+hi5OSQ
        EDCR2PnxLnsXIxeHkMAORom9Vz6ydTFyACWkJB4v04GoEZZY+e85VM0HRonDD86wgSTYBDQl
        Xn/8wgRiiwgoSzzbdxjMZhbQl3h64TojiC0sECGx/+QGdhCbRUBVYunFT2BxXgEriRW/upkg
        FshLrN5wgBnE5hSwljjw6CZYvRBQzb3XW5gnMPItYGRYxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHCxaWjsY96z6oHeIkYmD8RCjBAezkgivStHXBCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYzKYwvpl2g6c0PnmxjFDNR1erpV56NcUr
        XqonvHg868BrP1Gx8HOGMzaGtl3flsQu62x0jFd5em3WzLwSheM/yjacri7p7XeecKz9dLHF
        nnUbfacHfSpcfqyu5kpy5aQw80Pm7M47FutzRTH6XjmZd8fswAtp52Pvf938J7N6VbznUXGu
        eFZpreSjUZsPr69es8VrlXm87otFPE0LNXU+3tiToNUl4fSin/3qxR1uJ9c/buxzPOZg3bzX
        q2+fzsSJKZ6CoeUr2bczB3KLibOfnPFdRndj04kFFTpxxo9Lv67aYeKRPeNuvAnv7v/xWjIX
        fZSiP75eNn/rb9eUVMEoT6utV2Kb55XP9uxXPXtbiaU4I9FQi7moOBEAsonInYUCAAA=
X-CMS-MailID: 20210722055015epcas5p4db389aa15f16f1577a74ba5ce446919b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055015epcas5p4db389aa15f16f1577a74ba5ce446919b
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055015epcas5p4db389aa15f16f1577a74ba5ce446919b@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Verification logs based on BT 5.0 controller
==============================================
[S20] phy  45:18:F8:CF:23:7E
	Selected phys: LE1MTX
	Selected phys: LE1MRX
[S20] phy  45:18:F8:CF:23:7E LE2MTX LE2MRX
[S20]
Changing PHY succeeded
Device 45:18:F8:CF:23:7E Phy: LE2MTX
Device 45:18:F8:CF:23:7E Phy: LE2MRX

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 client/main.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/client/main.c b/client/main.c
index ab925769b..e7146ab6f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1705,6 +1705,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "TxPower");
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
+	print_property(proxy, "Phy");
 
 	battery_proxy = find_battery_by_path(battery_proxies,
 					g_dbus_proxy_get_path(proxy));
@@ -2071,6 +2072,47 @@ static void cmd_phy_configuration(int argc, char *argv[])
 	g_strfreev(phys);
 }
 
+static void get_phy(GDBusProxy *proxy)
+{
+	print_property_with_label(proxy, "Phy",
+				"Selected phys");
+}
+
+static void cmd_phy(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	char **phys = NULL;
+	size_t phys_len = 0;
+
+	if (check_default_ctrl() == FALSE)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc < 2 || !strlen(argv[1])) {
+		bt_shell_printf("Device address not given as input\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
+	if (!proxy) {
+		bt_shell_printf("Device %s not available\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc == 2)
+		return get_phy(proxy);
+
+	phys = g_strdupv(&argv[2]);
+	phys_len = g_strv_length(phys);
+
+	g_dbus_proxy_set_property_array(proxy,
+					"Phy", DBUS_TYPE_STRING, phys,
+					phys_len, generic_callback, "PHY",
+					NULL);
+
+	g_strfreev(phys);
+}
+
+
 static void cmd_list_attributes(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -3072,6 +3114,9 @@ static const struct bt_shell_menu main_menu = {
 				"[EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT] "
 				"[EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",
 		cmd_phy_configuration,		"Get/Set PHY Configuration" },
+	{ "phy",		"<dev> [LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] "
+				"[LECODEDTX] [LECODEDRX] [LECODEDS2] [LECODEDS8]",
+		cmd_phy,	"Get/Set LE PHY preferences for a connected device" },
 	{ } },
 };
 
-- 
2.17.1

