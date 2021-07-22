Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E9C6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ED861244
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhGVFTE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17714 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVFTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:03 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210722055938epoutp02b2518824b564edfb229ef0f4c5cb3667~UB3grX3h31391413914epoutp02I
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210722055938epoutp02b2518824b564edfb229ef0f4c5cb3667~UB3grX3h31391413914epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933578;
        bh=VYi8m00j+Zc7e8blA7w08sfGYaVxcsRHyuW/+Vw29hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0lbf3L9Njut7vZRxCZaib4PRPADksqYAgMn3Q0WCim4JRUESaLloPgKUbHNwQYML
         GDD+FqgmP6R2brEtYU6X+Ds9Esal1t6t0jUbVbj4yfvBEM6dAU4S2WEx/xFjXhOk35
         s310ZHRCzy0IQFjPDkzLLovvskcoL+GlC/YWnGYU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210722055937epcas5p4d66c2b9da389f37e00b9d1f1c7934d2c~UB3gCdkFW2202722027epcas5p4I;
        Thu, 22 Jul 2021 05:59:37 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.72.55882.84909F06; Thu, 22 Jul 2021 14:59:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210722052742epcas5p1b53db2cd68028170a86f291bd052bf14~UBbotMaDg1801618016epcas5p1g;
        Thu, 22 Jul 2021 05:27:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722052742epsmtrp2a46cd7161b8fe3adebc48c3490e39b4c~UBbosljIJ0094500945epsmtrp2D;
        Thu, 22 Jul 2021 05:27:42 +0000 (GMT)
X-AuditID: b6c32a49-f4fff7000001da4a-7a-60f909482b58
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.F8.08289.DC109F06; Thu, 22 Jul 2021 14:27:41 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052741epsmtip262374b4d09145238197a36e68e0a226b~UBbn8oVbT0848808488epsmtip2I;
        Thu, 22 Jul 2021 05:27:41 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 5/7] adapter: Add support for PHY Configuration
 Changed event
Date:   Thu, 22 Jul 2021 10:56:38 +0530
Message-Id: <20210722052640.5863-6-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmlq4n588EgzuuFndWW1vMudbHbLFt
        XTuzA7NH35ZVjB6fN8kFMEVx2aSk5mSWpRbp2yVwZdz9epC9YDNfxaKef0wNjJ+4uxg5OSQE
        TCS2n5vA2MXIxSEksJtRYvrfe+wQzidGiYbVy6Ccz4wSH18/ZIdpedB3HKplF6PEvFmfmeFa
        vnc8ZwapYhPQlHj98QsTiC0ioCzxbN9hMJtZQFfizPt1bCC2sECoxMVnC1m6GDk4WARUJQ49
        TwIxeQWsJG6sgzpPXmL1hgNgEzkFrCVm9L4BWyUh0M0usf/YQzaIIheJQ3cXQtnCEq+Ob4E6
        VEri87u9bBANzYwSOzZvZIdwehglHvzohuqwlzjX9IwVZDMz0NHrd+lDhGUlpp5aB3Uzn0Tv
        7ydMEHFeiR3zYGwViQ2rOuGWfTy2kBnC9pBYfeM9NFD6GCXW/33FMoFRbhbCigWMjKsYJVML
        inPTU4tNCwzzUsv1ihNzi0vz0vWS83M3MYJjWctzB+PdBx/0DjEycTAeYpTgYFYS4VUp+pog
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnJc9HiglkJ5YkpqdmlqQWgSTZeLglGpgklY9L1Nx/MRp
        /dZdRbUOcouZTpQ4HyhmzGdbttXx3ltPw30NFauZOB2nr1394nO55eFl67i937yyWt9uHzY1
        KyIr9Ow/tX+zsle/+HLnm3NcqlzUgT9iFhd4Oy5fFJtUfHPfbR8zS/E18S6l7rVSdvuYjG4z
        8YQKvuu8n3V39es/8vpORSz1t757FRt8+7ZN3f8y56ZDHvfeFmuIvpD29+nifLdL1P7ePquT
        9kGxeSZqiVkF3QxPvxaYbb4bkTl93vn/IjEPfp4ScHh6W+/aiTKbqh+fJ/9uuPTtz529x228
        jr755fCs6ES6DmvkhkNzFjquqMnwnflPwP61rdAa+QnHfD9tCmCfX/LVYK7HPSWW4oxEQy3m
        ouJEAB1RpEhUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJMWRmVeSWpSXmKPExsWy7bCSvO5Zxp8JBleXWVncWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJVx9+tB9oLNfBWLev4xNTB+4u5i5OSQ
        EDCReNB3nLGLkYtDSGAHo8TnGf+AHA6ghJTE42U6EDXCEiv/PWeHqPnAKDHx8HJ2kASbgKbE
        649fmEBsEQFliWf7DoPZzAL6Ek8vXAebIywQLHH6YgyIySKgKnHoeRKIyStgJXFjHdQF8hKr
        NxxgBrE5BawlZvS+AbOFgEqWftnLNoGRbwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjOAw0dLawbhn1Qe9Q4xMHIyHGCU4mJVEeFWKviYI8aYkVlalFuXHF5XmpBYfYpTmYFES
        573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwKR01TW0WkfiUJ68wFUhjYeNkZd/LObbkvBBzeGW
        1JNjd2q+Sc3+GKuopbXfjpf38PKN7kJrbR/2JThMs+w1O63xptmsXoMltb5JeJqLeM4Wr14b
        VYOyluSMdfYhO5p339sUPu/ALG/JLJ+Nmi9+TNu0UC0zSPya2Rth09bdWtbTV/UALUkwf1Jy
        syLga2LSmp8Ss85ayZrafWtcHb39i/n8/X+e1DOXSus+WNoQ2pT577JvjkqA2//SL2rbjkxc
        X14V8rheK9nEa9WxwFcTLT7dK3U+tingMOc09w9FE1Zqy7+YlP3zd97bgOeHl3kdWpwoebVt
        e6j6pytM/v+8KgRetbmc+qW47RVD9CYfJZbijERDLeai4kQAUoJf94ICAAA=
X-CMS-MailID: 20210722052742epcas5p1b53db2cd68028170a86f291bd052bf14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052742epcas5p1b53db2cd68028170a86f291bd052bf14
References: <20210722052640.5863-1-ayush.garg@samsung.com>
        <CGME20210722052742epcas5p1b53db2cd68028170a86f291bd052bf14@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change will subscribe the MGTM PHY Configuration
Changed event. This event will come whenever the controller
PHYs changed. Upon receiving the event, it will notify the
user by emitting "PhyConfiguration" property changed event.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 src/adapter.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c64a5333d..84dd2e5bd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9682,6 +9682,28 @@ static void read_phy_configuration(struct btd_adapter *adapter)
 	btd_error(adapter->dev_id, "Failed to read phy configuration info");
 }
 
+static void phy_configuration_changed_callback(uint16_t index,
+					uint16_t length, const void *param,
+					void *user_data)
+{
+	const struct mgmt_ev_phy_configuration_changed *ev = param;
+	struct btd_adapter *adapter = user_data;
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter->dev_id,
+				"Too small PHY configuration changed event");
+		return;
+	}
+
+	adapter->selected_phys = get_le32(&ev->selected_phys);
+	info("PHYs changed, New PHYs [0x%x]", adapter->selected_phys);
+
+	adapter->pending_phys = 0;
+
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "PhyConfiguration");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9917,6 +9939,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
 						controller_resume_callback,
 						adapter, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_PHY_CONFIGURATION_CHANGED,
+						adapter->dev_id,
+						phy_configuration_changed_callback,
+						adapter, NULL);
+
 	set_dev_class(adapter);
 
 	set_name(adapter, btd_adapter_get_name(adapter));
-- 
2.17.1

