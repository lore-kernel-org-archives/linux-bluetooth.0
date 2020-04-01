Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E68C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958132082F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IKzZK0Pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgDAL5k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:57:40 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:22353 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbgDAL5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 07:57:39 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200401115737epoutp038a7cae020fa77b5895a0213ec127b1cb~BsC5u13yN0165801658epoutp03Q
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2020 11:57:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200401115737epoutp038a7cae020fa77b5895a0213ec127b1cb~BsC5u13yN0165801658epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585742257;
        bh=WrrAaOarRnUmvpLOKCN98pyYFm7egDQj0LyYdBvOBpk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IKzZK0PtdtIR2/jas1xmXX77xgscsq5q6w1VdzzhfO1a4ow05W/2i+ZAFWgua/btE
         U/gzM6rvP3bcSjxEZIe9cSPAYQZ4xMG+rKoHdcS7J6o3kF8TGbIarSP2xgzU3J40CS
         A0v9da9wSiEjXsFksrzUxyCRWvKSo2c6rze+u62E=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200401115736epcas5p3a91ad2015d6fc68f341dd10b3e68fb11~BsC5ZchLc1109611096epcas5p3D;
        Wed,  1 Apr 2020 11:57:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.BA.04736.0B1848E5; Wed,  1 Apr 2020 20:57:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200401110619epcas5p12cbae623138736720177166c1f18a403~BrWHGCaSi0590005900epcas5p18;
        Wed,  1 Apr 2020 11:06:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200401110619epsmtrp16f5a435926e9ee4cbcc4389a820fe28a~BrWHFa5qH2076720767epsmtrp1D;
        Wed,  1 Apr 2020 11:06:19 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-30-5e8481b0ef88
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.47.04158.BA5748E5; Wed,  1 Apr 2020 20:06:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.92.161]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200401110618epsmtip18ffd5212c2e8784304c829ad747e5b03~BrWGC8NYY0718307183epsmtip1A;
        Wed,  1 Apr 2020 11:06:17 +0000 (GMT)
From:   Anupam Roy <anupam.r@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amit.jaiswal@samsung.com, nitin.j@samsung.com,
        semun.lee@samsung.com, dh79.pyun@samsung.com
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Fix SIGSEGV
Date:   Wed,  1 Apr 2020 16:36:15 +0530
Message-Id: <1585739175-28700-1-git-send-email-anupam.r@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCmpu6GxpY4g4eHTC3edU1ns1jy/SOb
        xZxrfcwW29a1M1sc2/SUyYHVo2/LKkaPz5vkApiiuGxSUnMyy1KL9O0SuDJ2tIsVbJWsOHu5
        namB8ZxYFyMnh4SAicSyHXuYuxi5OIQEdjNKLHvazQrhfGKU2HTxJguE841RYu//jUwwLc/v
        TASzhQT2MkqceRQBUfSFUeJNywFmkASbgLrEr4c7WEBsEQFliWf7DoM1MAskSryatoixi5GD
        Q1jAQmLqfVOQMIuAqsTcuQ/YQWxeAReJLbMWs0LskpO4ea4T7DwJgZusEk2Pe9kgEi4Sxzcd
        Z4SwhSVeHd/CDmFLSbzsb2OHaOhmlOh8+BmqYQqjxP/rphC2vcS5pmesIEcwC2hKrN+lDxGW
        lZh6ah3UnXwSvb+fQD3MK7FjHoytJLH1+nyo4yQk+jbvgop7SPx7/ogREiixEn8ffGObwCg7
        C2HDAkbGVYySqQXFuempxaYFxnmp5XrFibnFpXnpesn5uZsYwVGs5b2DcdM5n0OMAhyMSjy8
        CmktcUKsiWXFlbmHGCU4mJVEeGe7AIV4UxIrq1KL8uOLSnNSiw8xSnOwKInzTmK9GiMkkJ5Y
        kpqdmlqQWgSTZeLglGpgbEgTvSe48PSd/0q24pHudto2PQGn47g0mPaUC+04+UPEaY/r02W3
        SuXclmz//lZ9u3yZaJXwZeUzJ5dXtqoU38/5/Vr++nObo1myLT0KEzm+f+QNTN5r9fDHpPmz
        PeMeztfu5/w2Q/301OiZqQv277R4KcPZV3cj63fP1ejCtDt6NQcuPTePVmIpzkg01GIuKk4E
        AEGN3HLeAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSnO7q0pY4gz1zuC3edU1ns1jy/SOb
        xZxrfcwW29a1M1sc2/SUyYHVo2/LKkaPz5vkApiiuGxSUnMyy1KL9O0SuDJ2tIsVbJWsOHu5
        namB8ZxYFyMnh4SAicTzOxOZuhi5OIQEdjNK3Gx7wQqRkJA4M/ktlC0ssfLfc3aIok+MEr/O
        7GMBSbAJqEv8ergDzBYRUJZ4tu8w0CQODmaBVImDc3lBTGEBC4mp901BKlgEVCXmzn3ADmLz
        CrhIbJm1GGq8nMTNc53MExh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA4H
        La0djCdOxB9iFOBgVOLhVUhriRNiTSwrrsw9xCjBwawkwjvbBSjEm5JYWZValB9fVJqTWnyI
        UZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBsezM0VXeK+LKHyu1HehhP8Uoqp2191yC
        78KJBgs5iy4s9DPMm1XpdrX0x8LE/yZCzh0JzSJKHxp3GnPunMRWwvr3V+gK7zkJm891r5zL
        m2TwoCn6abGkngeTxnpnu78vVjzaJlHcmaPwgDVM5meapc0VhoIk12XLZzlUqlyLWi/RsN87
        pHyOEktxRqKhFnNRcSIAG1nrIwMCAAA=
X-CMS-MailID: 20200401110619epcas5p12cbae623138736720177166c1f18a403
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200401110619epcas5p12cbae623138736720177166c1f18a403
References: <CGME20200401110619epcas5p12cbae623138736720177166c1f18a403@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch addresses the following crash:

[mesh-cfgclient]#
Program received signal SIGSEGV, Segmentation fault.
strlen () at ../sysdeps/x86_64/strlen.S:106
106     ../sysdeps/x86_64/strlen.S: No such file or directory.
(gdb) bt
0  strlen () at ../sysdeps/x86_64/strlen.S:106
1  0x00000000004235d6 in l_dbus_interface_method (interface=interface@entry=0x66d900, name=name@entry=0x42bbad "ScanResult", flags=flags@entry=0,
    cb=cb@entry=0x404940 <scan_result_call>, return_sig=return_sig@entry=0x42f7ca "", param_sig=param_sig@entry=0x42bba4 "naya{sv}") at ell/dbus-service.c:320
2  0x000000000040433d in setup_prov_iface (iface=0x66d900) at tools/mesh-cfgclient.c:1695
3  0x00000000004249b1 in _dbus_object_tree_register_interface (tree=0x65b770, interface=interface@entry=0x42baa8 "org.bluez.mesh.Provisioner1",
    setup_func=setup_func@entry=0x404310 <setup_prov_iface>, destroy=destroy@entry=0x0, old_style_properties=old_style_properties@entry=false)
    at ell/dbus-service.c:1385
4  0x000000000041cffa in l_dbus_register_interface (dbus=<optimized out>, interface=interface@entry=0x42baa8 "org.bluez.mesh.Provisioner1",
    setup_func=setup_func@entry=0x404310 <setup_prov_iface>, destroy=destroy@entry=0x0, handle_old_style_properties=handle_old_style_properties@entry=false)
    at ell/dbus.c:1455
5  0x0000000000403f4e in register_app () at tools/mesh-cfgclient.c:1770
6  client_ready (client=<optimized out>, user_data=<optimized out>) at tools/mesh-cfgclient.c:1815
7  0x0000000000425ed2 in get_managed_objects_reply (message=<optimized out>, user_data=0x66ab50) at ell/dbus-client.c:572
8  0x000000000041bc25 in handle_error (message=0x66c0c0, dbus=<optimized out>) at ell/dbus.c:236
9  0x000000000041cdcc in message_read_handler (io=<optimized out>, user_data=0x6653f0) at ell/dbus.c:276
10 0x0000000000418763 in io_callback (fd=<optimized out>, events=1, user_data=0x6664e0) at ell/io.c:126
11 0x000000000041957a in l_main_iterate (timeout=<optimized out>) at ell/main.c:473
12 0x000000000041964c in l_main_run () at ell/main.c:520
13 0x000000000041986b in l_main_run_with_signal (callback=callback@entry=0x4153a0 <l_sig_func>, user_data=user_data@entry=0x0) at ell/main.c:642
14 0x0000000000415471 in mainloop_run_with_signal (func=func@entry=0x4139a0 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-ell.c:87
15 0x0000000000414b6f in bt_shell_run () at src/shared/shell.c:1177
16 0x00000000004039ed in main (argc=<optimized out>, argv=<optimized out>) at tools/mesh-cfgclient.c:1999
---
 tools/mesh-cfgclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index d1c6731..57a2607 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1693,7 +1693,7 @@ static struct l_dbus_message *add_node_fail_call(struct l_dbus *dbus,
 static void setup_prov_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "ScanResult", 0, scan_result_call, "",
-						"naya{sv}", "rssi", "data");
+						"naya{sv}", "rssi", "data", "options");
 
 	l_dbus_interface_method(iface, "RequestProvData", 0, req_prov_call,
 				"qq", "y", "net_index", "unicast", "count");
-- 
2.7.4

