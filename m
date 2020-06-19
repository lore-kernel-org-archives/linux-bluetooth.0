Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93481C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCFE21548
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 18:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="R92physT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbgFSSKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:10:30 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:58992 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbgFSSK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 14:10:27 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0186.rbdmz01.com (Postfix) with ESMTPS id 49pRg462wFz1XLFjP
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 20:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key1-intmail; t=1592590224;
        bh=DtQdrwnwtqpNnlEyroFs6PYLb5etDZmDNMRh890itbs=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=R92physTDureWNn5o4oigc29W2Zo0kXaboEzO2xv33Ork/d6eCpUyKEKHuCguBZh2
         qgSZLxsyNj3NZMHEsHuC9mwGUgPHg3gIwtzzFMQEnHWCCFGo1f2OnqG1hVpz9tuZdB
         DCriOmBJjOTHtqdwzpxxGlBC0NuXfR4xqyFEG+5w=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 49pRg45hjRz2p9
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 20:10:24 +0200 (CEST)
X-AuditID: 0a3aad0c-cdbff7000000304a-44-5eecff9045b1
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 6B.08.12362.09FFCEE5; Fri, 19 Jun 2020 20:10:24 +0200 (CEST)
Received: from SI0SWIEXHC02.bsh.corp.bshg.com (si0swiexhc02.bsh.corp.bshg.com [10.49.76.142])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 49pRg44f8bzvl8
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 20:10:24 +0200 (CEST)
Received: from SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) by
 SI0SWIEXHC02.bsh.corp.bshg.com (10.49.76.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Fri, 19 Jun 2020 20:10:24 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) by
 SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Fri, 19 Jun 2020 20:10:24 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272]) by
 SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272%5]) with mapi id
 15.01.1979.003; Fri, 19 Jun 2020 20:10:24 +0200
From:   "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Question regarding Generic Attribute Service and characteristic
Thread-Topic: Question regarding Generic Attribute Service and characteristic
Thread-Index: AdZGZORl1AmsIUXhSDmQX5NABVkz+w==
Date:   Fri, 19 Jun 2020 18:10:24 +0000
Message-ID: <909baa33d2f847cfaa3f86cc7f554c03@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsXCZbVWVnfC/zdxBmd7dCzmXOtjdmD0+LxJ
        LoAxissmJTUnsyy1SN8ugSvj3eFWtoJfjBU/tz9naWA8zdjFyMEhIWAicaidt4uRk0NIYCaT
        xLevIV2MXED2B0aJLW1/WSGcJiaJK19vMEM4fxklmqb+YYJwzjFKzPn5jxmkn03AQOJa1x0w
        W0TAXWLP/tuMILawgIfEsyvPmCDivhK7p61hh7D1JH7u/ABWwyKgKvF6+yOwGl4Bc4mF3R/B
        4owCshIbNpwHm8ksIC6x6dl3VhBbQkBAYskeiLiEgKjEy8f/oOLyEvOXb2aEqNeRWLD7ExuE
        rS2xbOFrZoj5ghInZz5hgai3lli++QHjBEaxWUhWzELSPgtJ+ywk7QsYWVYxiqWlGpTlGhhZ
        GhjoFSWlFlcZGOol5+duYoTEC88OxlM9H/QOMTJxMB5ilOBgVhLhPfz+TZwQb0piZVVqUX58
        UWlOavEhRmkOFiVxXhWejXFCAumJJanZqakFqUUwWSYOTqkGJq6/sievvP/n2/Rh9Y6Yhc9P
        9X7e07eI39OnpdN/g+ZPxv4eo+mfM7SLcu5xc1TvEcz3Twg4dlV+4+EqcZulD/7YT07b+PtW
        RNuvVYaKl+o0vhz5ovy+30riTdu5n7d1TLxF3WSeVJ9k15O3YOH7+srqkLunTXLTqxqDYwll
        d+rfdK3ZLbS1ujvx4q09b3+71Ws6pJ0VLMzneuHn8DDQaJpky9myBe5VjT7ubmc43lT6vZqz
        79vRrxvWVzlNZT5XuFHxblnzrOmNOav26DFOsbhTuFb6o226/7GC286Jj/3+ivPann1Y84yj
        20/33Zkdf7dwefwrN3g17XhhaItp5KEvTP/W/VGYnr4vITFeTYmlOCPRUIu5qDgRAJkF/2sG
        AwAA
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Everybody,

the Bluetooth Standard defines a "Generic Attribute Service" (since 4.2) wi=
th exactly 1 characteristic "service changed".
Is that service per default enabled in the Bluetooth/bluez stack?

Best regards and stay healthy
Jan

