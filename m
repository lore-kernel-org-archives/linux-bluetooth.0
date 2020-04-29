Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC90C83004
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 16:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2127F208FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 16:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD2Qs4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:48:56 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgD2Qs4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 12:48:56 -0400
Received: from Exchange.peiker-holding.de ([82.119.189.130]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mw9Hm-1jDGNO0bXo-00s98D for <linux-bluetooth@vger.kernel.org>; Wed, 29
 Apr 2020 18:48:54 +0200
Received: from Exchange.peiker-holding.de (10.0.1.22) by
 Exchange.peiker-holding.de (10.0.1.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1779.2; Wed, 29 Apr 2020 18:48:53 +0200
Received: from Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42]) by
 Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42%13]) with mapi id
 15.01.1779.002; Wed, 29 Apr 2020 18:48:53 +0200
From:   "CEE Forostyan, Konstantin" <Konstantin.Forostyan@peiker-cee.de>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: L2CAP: Fix errors during
 L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17)
Thread-Topic: [PATCH] Bluetooth: L2CAP: Fix errors during
 L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17)
Thread-Index: AQHWHkYRSCKhloHlV0Kvhytr6OLHOw==
Date:   Wed, 29 Apr 2020 16:48:53 +0000
Message-ID: <2723effa610a46a8a9343be31bcffc71@peiker-cee.de>
References: <77b02337bc404dea9fa88a286c091b83@peiker-cee.de>,<08f0a119cfa0481fbf49d7fde47a08fc@bshg.com>,<cc33f16c2e164328b8248fc3967ebed5@peiker-cee.de>
In-Reply-To: <cc33f16c2e164328b8248fc3967ebed5@peiker-cee.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.112.2]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Provags-ID: V03:K1:HjDnpUM4QgxLNZ3VNFi7uj8g7peWdYQ9ANSbmFIZJCxYEse5+AQ
 rYlvTnrEMC0rVqM1L8ArZ91N7bLapn0pBdjjqlgKUOcZXj9I1ZhdmG7o5erYtb26oO0h78E
 yweL4qhR3XoF2Fqb0Etf5cNplkhl13HYk+pGSyyabH9MZuistWTW9IDDRUSAnrpTSoCfPJs
 jBDrmRxGhOriVA7oCjcdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vkZlrIlAShc=:/mO3xoggEqP/swx1LshcH3
 CsV+tDREDyn3OsQjGf1Hc8FiUV67zVxwKOI3BV9Wl9wI1msENs1ntF7HgYRyyO35UC+oS+SqF
 FDIc0Z5b2MBpnw89jBzio9OXKJZCXHPIIxqYCZDwnwm4ZkaiAB8KQ71G8LdlLIbiTmFd3fmkW
 Cgp3Eo1hrNsvxparl8XZfciu92XQPiWpKdYJJhFKIHlLfH8w11uqAk9oRXk4jwD5/ynX7a0xE
 r+jPtAY3vHYwO2/p5Z+yNmQ9aM+/0QGy0zisB/Aq97cSH1a++WMuPpGM8QNplMbi6HJi6IptX
 SVcq9hIDKrlFDBqj8SnsWQ9WH3WjLignowXdgbwENWKcxXXrCBkPO4soUAw3Of8wFi5u/+gD2
 Pfp0KfDbgn6qBCVCejnwTxiC1M7Hp635WBNhLQIYId+gCrpVTgyTHTKrj9BZ5zIw/B5rnbWtn
 NQQudvoqHoc/vU7ReNe7dvnQJGCBaEDsZWANwqlXHa9n8ZZzAaOxKL0dExpnfCRzjV4Lalv1+
 8+vFjHm+AGIKli+R2NQDDjoQYZm2VGF7coW3CZzX7qM4wauow+8JadywYoYiowe7SjM3XXyO7
 EPFQ0bFuUHZ0GHcHfPgBKxeIp1g2/G8uPv/jIKUtHkx1+DzP8LJ7EvgmOoi7DoFzk7V/2WpvU
 82Gzjk5g89bFtyrx+duGOu4JZAn9KabPPM283UNMezIWMxXfSzp2ZhORPK6FWpmhKPUxNSTih
 baqGKkhRE7O1mDyZopeYt3y+JlC85+Q+FB2Q27yRSzjvughIxw4JqLhLxjrZVwM4USqr4j3Fm
 DmApViecvNiE9Ek9s0kjGqNQuX2ko1EJZfIgqtoSzr4J/YMw0Tms1b2QftyMSGxAY97yBF3s6
 mZYo9QOdqMz/Cl7pPfYw==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

During Bluetooth qualification tests I found out that Bluetooth stack responds with an error to a correct L2CAP_CREDIT_BASED_CONNECTION_REQ. Please review the 2 bugfixes I made in kernel in order to correct this problem.

Best regards
Konstantin


--- a/net/bluetooth/l2cap_core.c	2020-04-28 18:19:10.481887583 +0200
+++ b/net/bluetooth/l2cap_core.c	2020-04-28 18:21:41.000000000 +0200
@@ -5817,7 +5817,7 @@
 	if (!enable_ecred)
 		return -EINVAL;
 
-	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
+	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
@@ -5855,7 +5855,7 @@
 	}
 
 	result = L2CAP_CR_LE_SUCCESS;
-	cmd_len -= sizeof(req);
+	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
 	for (i = 0; i < num_scid; i++) {
