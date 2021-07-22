Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995EEC63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEC26120C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhGVFTH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:07 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48038 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhGVFTG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:06 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210722055941epoutp01e09889a6a81be821ebc976f67474c463~UB3joKRr41867818678epoutp011
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210722055941epoutp01e09889a6a81be821ebc976f67474c463~UB3joKRr41867818678epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933581;
        bh=EUChzWKcOMrlauR7u+IEDeWBTjjDHcEGJ3f050q2Uec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRb9t1l1TJfpxNT6d4jPMO3QMpVWsJUhPpI8+iQzb7MDGJMurZk2jHWiCZQ/0bZW8
         Laq6xZkzJbhg9kavDEwuOikeECp7U1ac/EwNZ7LWLtO4esU5qJ3UXJ7CkCl4VeICtH
         BKn0qPmsWwau/n+gFK+Y77D5n3gx8XVc9waXv/6I=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210722055940epcas5p381c52bf95fdff4d4a527cd150ad8b150~UB3jSubBH0717107171epcas5p3E;
        Thu, 22 Jul 2021 05:59:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.6A.09595.C4909F06; Thu, 22 Jul 2021 14:59:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210722052743epcas5p34af6f55c11db2e8909c2730fae7e1cac~UBbpl7Orb1662316623epcas5p33;
        Thu, 22 Jul 2021 05:27:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722052743epsmtrp2c71eef4f0532502dc569bb90005b1be6~UBbplNlk70094500945epsmtrp2F;
        Thu, 22 Jul 2021 05:27:43 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-40-60f9094cd075
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.91.08394.EC109F06; Thu, 22 Jul 2021 14:27:42 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052742epsmtip2238d96986118fbf5fb0810618db16aee~UBbo2sDSM0837808378epsmtip2W;
        Thu, 22 Jul 2021 05:27:42 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 6/7] client: Add support for get/set PHY configuration
 in bluetoothctl
Date:   Thu, 22 Jul 2021 10:56:39 +0530
Message-Id: <20210722052640.5863-7-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmhq4P588Egx/PFC3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mro2JxSME+morVpKXsD42vxLkZODgkB
        E4nur51sXYxcHEICuxkldm9+yQjhfGKU+PNmO1TmG6PEs8YZzDAt387cZYJI7GWUmP5wEStc
        y6U/RxhBqtgENCVef/zCBGKLCChLPNt3GMxmFtCVOPN+HRuILSwQJ9E2fzOYzSKgKtH5bDU7
        iM0rYCXx++UOqG3yEqs3HACzOQWsJWb0vmEGWSYh0M8usejEdnaIIheJx4tmsUHYwhKvjm+B
        iktJfH63lw2ioZlRYsfmjewQTg+jxIMf3VAd9hLnmp4B/cABdJ6mxPpd+hBhWYmpp9ZBXc0n
        0fv7CRNEnFdixzwYW0Viw6pOuGUfjy2EutpDYsWJx+yQYOljlFg+fyLzBEa5WQgrFjAyrmKU
        TC0ozk1PLTYtMMpLLdcrTswtLs1L10vOz93ECI5nLa8djA8ffNA7xMjEwXiIUYKDWUmEV6Xo
        a4IQb0piZVVqUX58UWlOavEhRmkOFiVxXvZ4oJRAemJJanZqakFqEUyWiYNTqoFJc/ovxoB9
        VqfsG9NKIlekJ38rc4558ehgX3XoPNfjh56K+u/ePdvCaJPu2rbUlLDdRzlnGH8XKkv13LYi
        6pbhpdeNIv8qsmT3nvp7RE6n+aygWL1z3+zwQNWGCXMD+R5UtZn+TuPYd3+d4vb5G7VmcN84
        uu5FsP7KD7N93i0rfqnFn8XRmn2XxUbkit3cyRk6lqKp3P19E65NtPV5V5pb/1a568LsbY7r
        JMPPcjB80WbYednS6snhnWVPlPPcv7ZNiJZ59/hLzifmgMSeU+trDnos/2qqf6d319IG2dnq
        3FkFAqqm74sZjnGFaga8Obe9rl90HxMvg1f8apcj/1RsuJ7yfFhkK29XZRjRP1+JpTgj0VCL
        uag4EQDuGO81VgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSvO45xp8JBt9mmlvcWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJXRsTmlYJ5MRWvTUvYGxtfiXYycHBIC
        JhLfztxl6mLk4hAS2M0o0XHwMJDDAZSQkni8TAeiRlhi5b/n7BA1Hxgljp5YwgiSYBPQlHj9
        8QsTiC0ioCzxbN9hMJtZQF/i6YXrYDXCAjESUx89BouzCKhKdD5bzQ5i8wpYSfx+uYMZYoG8
        xOoNB8BsTgFriRm9b8BsIaCapV/2sk1g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10v
        OT93EyM4VLQ0dzBuX/VB7xAjEwfjIUYJDmYlEV6Voq8JQrwpiZVVqUX58UWlOanFhxilOViU
        xHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTBdMP7RUcb6bPFkr02ia6ZHzj24qK61dOabeYV3
        NIumLT11vWnf/Pm7Dim7rdeyZj7t8fD9QtV5i2ZuqZvs6/DV0ny25q8L/u+mfNiWnz71Hvee
        l9O4jjVd91d2awiTPn4t7toL5vlFP49InNu8yzzlYb/76vcTtoT7mS+s3pwe3GBQuyzHwYfp
        EnMFS7hllihzm0li9YfSK93uC4676/Cmy2vF113vLVI6kMMpLRkukSLxOoehOidd8GvMjnnn
        Xrtel40qiDv3XnDdp199AvdvxcW6XJ58WvaNd9hjeZfmh4+fPf7y2brKW+bPhPTOfc+E911Z
        eGOJXUDuL9El19Pn7S8IYJpivKH8kYl4ra+QEktxRqKhFnNRcSIA5BPu4YQCAAA=
X-CMS-MailID: 20210722052743epcas5p34af6f55c11db2e8909c2730fae7e1cac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052743epcas5p34af6f55c11db2e8909c2730fae7e1cac
References: <20210722052640.5863-1-ayush.garg@samsung.com>
        <CGME20210722052743epcas5p34af6f55c11db2e8909c2730fae7e1cac@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Verification logs based on BT 5.0 controller
==============================================
[bluetooth] default-phy LE1MTX LE2MTX LE1MRX LE2MRX LECODEDTX LECODEDRX
[bluetooth]
Changing PHY Configuration succeeded
Controller D6:C9:16:E8:6A:D9 PhyConfiguration: LE1MTX
Controller D6:C9:16:E8:6A:D9 PhyConfiguration: LE1MRX
Controller D6:C9:16:E8:6A:D9 PhyConfiguration: LE2MTX
Controller D6:C9:16:E8:6A:D9 PhyConfiguration: LE2MRX
Controller D6:C9:16:E8:6A:D9 PhyConfiguration: LECODEDTX
Controller D6:C9:16:E8:6A:D9 PhyConfiguration: LECODEDRX

Verification logs based on BT 4.0 controller
=============================================
[bluetooth]# default-phy
	Supported phys: BR1M1SLOT
	Supported phys: BR1M3SLOT
	Supported phys: BR1M5SLOT
	Supported phys: EDR2M1SLOT
	Supported phys: EDR2M3SLOT
	Supported phys: EDR2M5SLOT
	Supported phys: EDR3M1SLOT
	Supported phys: EDR3M3SLOT
	Supported phys: EDR3M5SLOT
	Supported phys: LE1MTX
	Supported phys: LE1MRX
	Selected phys: BR1M1SLOT
	Selected phys: LE1MTX
	Selected phys: LE1MRX
[bluetooth]# default-phy BR1M1SLOT LE1MTX LE1MRX BR1M3SLOT
Changing PHY Configuration succeeded
[CHG] Controller 00:1A:7D:DA:71:14 PhyConfiguration: BR1M1SLOT
[CHG] Controller 00:1A:7D:DA:71:14 PhyConfiguration: BR1M3SLOT
[CHG] Controller 00:1A:7D:DA:71:14 PhyConfiguration: LE1MTX
[CHG] Controller 00:1A:7D:DA:71:14 PhyConfiguration: LE1MRX

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 client/main.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/client/main.c b/client/main.c
index c1a62edb7..ab925769b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -934,6 +934,8 @@ static void cmd_show(int argc, char *argv[])
 	print_property(adapter->proxy, "Modalias");
 	print_property(adapter->proxy, "Discovering");
 	print_property(adapter->proxy, "Roles");
+	print_property(adapter->proxy, "SupportedPhyConfiguration");
+	print_property(adapter->proxy, "PhyConfiguration");
 
 	if (adapter->ad_proxy) {
 		bt_shell_printf("Advertising Features:\n");
@@ -2038,6 +2040,37 @@ static void cmd_disconn(int argc, char *argv[])
 						proxy_address(proxy));
 }
 
+static void get_phy_configuration(void)
+{
+	print_property_with_label(default_ctrl->proxy,
+					"SupportedPhyConfiguration", "Supported phys");
+
+	print_property_with_label(default_ctrl->proxy, "PhyConfiguration",
+					"Selected phys");
+}
+
+static void cmd_phy_configuration(int argc, char *argv[])
+{
+	char **phys = NULL;
+	size_t phys_len = 0;
+
+	if (check_default_ctrl() == FALSE)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc < 2 || !strlen(argv[1]))
+		return get_phy_configuration();
+
+	phys = g_strdupv(&argv[1]);
+	phys_len = g_strv_length(phys);
+
+	g_dbus_proxy_set_property_array(default_ctrl->proxy,
+					"PhyConfiguration", DBUS_TYPE_STRING, phys,
+					phys_len, generic_callback, "PHY Configuration",
+					NULL);
+
+	g_strfreev(phys);
+}
+
 static void cmd_list_attributes(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -3033,6 +3066,12 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
 							dev_generator },
+	{ "default-phy",	"[LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] "
+				"[LECODEDTX] [LECODEDRX] "
+				"[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT] "
+				"[EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT] "
+				"[EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",
+		cmd_phy_configuration,		"Get/Set PHY Configuration" },
 	{ } },
 };
 
-- 
2.17.1

