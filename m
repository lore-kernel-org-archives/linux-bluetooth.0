Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF42BC10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 11:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423321D56
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 11:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LmnVmjp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgCKLPF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:15:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30289 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKLPE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 07:15:04 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200311111502epoutp02a7828c678d47d63ddb02c938683430f6~7O6udHd5P1810918109epoutp02X
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 11:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200311111502epoutp02a7828c678d47d63ddb02c938683430f6~7O6udHd5P1810918109epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583925302;
        bh=PMv2gTSimJViPIcVG3pe39pengGevm9e0/AQ1EMtn8I=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LmnVmjp0I9Ite0McQf8TKdHL5Uurv3FOUlVgrcpj/f187d/ZGYYGBrM4PEUXIJNdG
         lAmEfRpemib23TUHrDID6aaul76VtrqU+QAT59OcMdnGLpsUKLbKODRTwd/l9u1THq
         8KcPjD5JrFKvNl1+7Z6nv9KrK9Hlhx5vNh5Vs6jQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200311111501epcas5p3ff1187881943b9f3528d67df86b77949~7O6twjI0P2292022920epcas5p3x;
        Wed, 11 Mar 2020 11:15:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.CD.19629.538C86E5; Wed, 11 Mar 2020 20:15:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200306083906epcas5p15ca9216ebcdbeccd5f3a9ad4c98032eb~5qkKGeC8K0373103731epcas5p1B;
        Fri,  6 Mar 2020 08:39:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200306083906epsmtrp27197a3cfb729a4b39acf087c2a085b5c~5qkKFJMwg1943319433epsmtrp2c;
        Fri,  6 Mar 2020 08:39:06 +0000 (GMT)
X-AuditID: b6c32a4b-345ff70000014cad-c6-5e68c8356886
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.6C.10238.A2C026E5; Fri,  6 Mar 2020 17:39:06 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.92.161]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200306083905epsmtip1286532ed5dfa796ba349fd38318bc8df~5qkJBX3LO1758917589epsmtip1O;
        Fri,  6 Mar 2020 08:39:05 +0000 (GMT)
From:   Anupam Roy <anupam.r@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     nitin.j@samsung.com, amit.jaiswal@samsung.com,
        semun.lee@samsung.com, dh79.pyun@samsung.com
Subject: [PATCH] tools/mesh-cfgclient: Add support for Static OOB key
Date:   Fri,  6 Mar 2020 14:09:02 +0530
Message-Id: <1583483942-2641-1-git-send-email-anupam.r@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCmpq7piYw4gysfJS3edU1ns1jy/SOb
        xZxrfcwW29a1M1sc2/SUyYHVo2/LKkaPz5vkApiiuGxSUnMyy1KL9O0SuDIOLfzKXnBKrKJ1
        9nLGBsYTQl2MnBwSAiYSn55PZOli5OIQEtjNKDGxYwITSEJI4BOjxOM12hCJb4wSn/pvscJ0
        /Ji3hw0isZdR4sTHecwQHV8YJVbfTAGx2QTUJX493MECYosIKEs823cYbCqzQKLEoulv2LsY
        OTiEBVwlNnVwgIRZBFQlpp1ZDFbOK+As8f77PXaIXXISN891MoPskhB4yCrxeuVmJoiEi8S9
        mX3MELawxKvjW6AapCQ+v9vLBtHQzSjR+fAzG0RiCqPE/+umELa9xLmmZ6wgRzALaEqs36UP
        EZaVmHpqHdSdfBK9v59A7eKV2DEPxlaS2Hp9PjQgJCT6Nu+CintIfHjxhxESDrESF9p/sk9g
        lJ2FsGEBI+MqRsnUguLc9NRi0wLjvNRyveLE3OLSvHS95PzcTYzgKNby3sG46ZzPIUYBDkYl
        Ht4XdelxQqyJZcWVuYcYJTiYlUR44+WBQrwpiZVVqUX58UWlOanFhxilOViUxHknsV6NERJI
        TyxJzU5NLUgtgskycXBKNTBOOCPBFCGWn/I2UyeG1doh8+ERzZ71safrnmfbzI7+4Xqqnavj
        esUzu8h7HHLz9s/uMeJvussZP/nM15mabE6NTiu+mf6/wSrGtOqp11x7RY8zim6/zQUvSUsn
        T5W+492xnDHHlI3N6qTfi71WziqRvXoTLCysvXTW170yfclSLXDOW65JR4mlOCPRUIu5qDgR
        AIjP1V7eAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSnK4WT1KcwexWZYt3XdPZLJZ8/8hm
        MedaH7PFtnXtzBbHNj1lcmD16NuyitHj8ya5AKYoLpuU1JzMstQifbsEroxDC7+yF5wSq2id
        vZyxgfGEUBcjJ4eEgInEj3l72LoYuTiEBHYzSiw6spENIiEhcWbyW1YIW1hi5b/n7CC2kMAn
        RolpMxJBbDYBdYlfD3ewgNgiAsoSz/YdZgKxmQVSJV682MnYxcjBISzgKrGpgwMkzCKgKjHt
        zGKwcl4BZ4n33++xQ4yXk7h5rpN5AiPPAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
        uZsYwQGhpbmD8fKS+EOMAhyMSjy8Cp8T4oRYE8uKK3MPMUpwMCuJ8AqbxscJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwGjwQX1mtN2euKtqPH9iCsLL
        pnl5+0m29ky22u32NEjE8dSVl2tusK8ML8w/YG826et/xQdZKbb+l6X87y1vys+5fdCjSThZ
        WHjmy537Wi3mPu3tW1pb2pRt7/3KYxLD1TW6/1tbvXb/bArI914XojyFobMlhodrbt/U4BCx
        xULLvt7bej+/R4mlOCPRUIu5qDgRAMG8EXkEAgAA
X-CMS-MailID: 20200306083906epcas5p15ca9216ebcdbeccd5f3a9ad4c98032eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200306083906epcas5p15ca9216ebcdbeccd5f3a9ad4c98032eb
References: <CGME20200306083906epcas5p15ca9216ebcdbeccd5f3a9ad4c98032eb@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch accepts 16 octet hex key for static OOB authentication

[mesh-cfgclient]# provision F24B3F329DF200000000000000000000
Provisioning started
Request hexadecimal key (hex 16 octets)
[[mesh-agent]# ] Enter key (hex number): 0a0b0a0b0a0b0a0b0a0b0a0b0a0b0a0b
Assign addresses for 4 elements
Provisioning done:
Mesh node:
    UUID = F24B3F329DF200000000000000000000
    primary = 00aa
    elements = 4
---
 tools/mesh-cfgclient.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index b4d76de..a1fd72a 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -373,14 +373,26 @@ static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
 	struct l_dbus_message_builder *builder;
 	uint32_t val_u32;
 	uint8_t ascii[16];
+	uint8_t hex_key[MAX_HEXADECIMAL_OOB_LEN];
 
 	switch (type) {
 	case NONE:
 	case OUTPUT:
 	case HEXADECIMAL:
-	default:
-		break;
+		bt_shell_printf("Hex key length [%d]\n", len);
+		if (len > MAX_HEXADECIMAL_OOB_LEN) {
+			bt_shell_printf("Bad input length\n");
+			break;
+		}
 
+		memset(hex_key, 0, MAX_HEXADECIMAL_OOB_LEN);
+		memcpy(hex_key, buf, len);
+		reply = l_dbus_message_new_method_return(msg);
+		builder = l_dbus_message_builder_new(reply);
+		append_byte_array(builder, hex_key, len);
+		l_dbus_message_builder_finalize(builder);
+		l_dbus_message_builder_destroy(builder);
+		break;
 	case ASCII:
 		if (len > 8) {
 			bt_shell_printf("Bad input length\n");
@@ -406,6 +418,8 @@ static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
 		reply = l_dbus_message_new_method_return(msg);
 		l_dbus_message_set_arguments(reply, "u", val_u32);
 		break;
+	default:
+		break;
 	}
 
 	if (!reply)
@@ -539,13 +553,22 @@ static struct l_dbus_message *prompt_static_call(struct l_dbus *dbus,
 		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
 	}
 
-	if (!strcmp(str, "in-alpha") && !strcmp(str, "out-alpha"))
-		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
+	if ((strcmp(str, "in-alpha") != 0) && (strcmp(str, "out-alpha") != 0)
+			&& (strcmp(str, "static-oob") != 0))
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
 
 	l_dbus_message_ref(msg);
-	agent_input_request(ASCII, 8, "Enter displayed Ascii code",
-							agent_input_done, msg);
 
+	if (strcmp(str, "static-oob") != 0) {
+		if (!agent_input_request(ASCII, 8, "Enter displayed Ascii code",
+					agent_input_done, msg))
+			return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+	} else {
+		/* Static OOB key len is fixed to 16 Octets */
+		if (!agent_input_request(HEXADECIMAL, 16, NULL,
+					agent_input_done, msg))
+			return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+	}
 	return NULL;
 }
 
-- 
2.7.4

