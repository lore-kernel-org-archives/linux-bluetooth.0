Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24084C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 12:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1D42074F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 12:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="HZoU+VQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgDUMma (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:42:30 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:40040 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgDUMm3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 08:42:29 -0400
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 49639t3mGrz4f3lwJ;
        Tue, 21 Apr 2020 14:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key3-intmail; t=1587472946;
        bh=qEvOiTZfqc3G4vohRzWnHcWlyI2LTxqpwugwYkxBkiI=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=HZoU+VQ+XpMdu18VP4mlLailS6EcC3VE5UDoLS9m4PtVGT6dpSRfdPVhzzbD5q8Aj
         JHtyXx67vcDIZty6pdUUYL/ANYb+hVlzkhksbddxHberkYRl47Quw19Wdw1xQjAYKI
         83dkkCbCGWFYpAPHFQ1g2ObKyndKxAJHwWIN9/Qc=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 49639t3Ny8z6CjR2R;
        Tue, 21 Apr 2020 14:42:26 +0200 (CEST)
X-AuditID: 0a3aad0c-94bff70000004734-ba-5e9eea329bf5
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 8B.55.18228.23AEE9E5; Tue, 21 Apr 2020 14:42:26 +0200 (CEST)
Received: from SI0SWIEXHC02.bsh.corp.bshg.com (si0swiexhc02.bsh.corp.bshg.com [10.49.76.142])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 49639t1zV0zB18;
        Tue, 21 Apr 2020 14:42:26 +0200 (CEST)
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) by
 SI0SWIEXHC02.bsh.corp.bshg.com (10.49.76.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 21 Apr 2020 14:42:25 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) by
 SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Tue, 21 Apr 2020 14:42:25 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272]) by
 SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272%5]) with mapi id
 15.01.1913.010; Tue, 21 Apr 2020 14:42:25 +0200
From:   "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
To:     "CEE Forostyan, Konstantin" <Konstantin.Forostyan@peiker-cee.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: How to to get L2CAP Enhanced Credit Based Mode working?
Thread-Topic: How to to get L2CAP Enhanced Credit Based Mode working?
Thread-Index: AQHWF8nrK1u7IRXZhk2vsyaioBali6iDglRw
Date:   Tue, 21 Apr 2020 12:42:25 +0000
Message-ID: <08f0a119cfa0481fbf49d7fde47a08fc@bshg.com>
References: <77b02337bc404dea9fa88a286c091b83@peiker-cee.de>
In-Reply-To: <77b02337bc404dea9fa88a286c091b83@peiker-cee.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA22Te1BUZRjG+c5eOLvDwcPhsm+7gbUTTiDBSjpgUGOTFIVdHG2mGrkscGCZ
        YJd2wQFqRkTuqKEyK6xAaAu6cW1xEDVJluSqoYWAREAJyX3SFVAL7OwuyP7RP8+83/N8v+/9
        vvPOwVnUAC7E4+RJtFIujRdz+Wz+a7Wur/hOl4dJcm84+Q/dzuP4l/YfZe3Aglt0zViwUe/2
        EfYZPzCajo/bTyt93ojgyxrValaijkpZuPKEm44qN+QjHg7kVvg284JtPuLjFFmCwc2mQ5hl
        0Y1goPcGy7LIwODoxfrVZBlBQZFmNfkZwWLbBMt0GJeUQH/+sDlwIgsQzOdXYqbAkdwJuoN6
        ZKqdyCC4e+WcraX2hZZRo9lnk+6Q/fCJ2SdIP9Bl5ZgPpchA6Mk4bfZ55OtwOC+HbaoR6QoN
        Db3mPSxSAPq/ljiWF5Gg/cHiA+kMU3dXGB9n6o2gXqIs272g4vIDrqXeDFWnZ1iWtg7QVTLO
        tqABcLZxDBUi0Fh10FjhGitcY4VXIPZ3yCWGluxPkPhul0i8lZG0Kk2yxTtKkaBHltnZNaPu
        w397GxCGIwPahmNiZyKttzyMso9URKfKpCpZuDI5nlaJhcSB2bxQyvGZrUqOTIhTqeIUcgMC
        nCV2Ihr+YDgiWpqaRisVFsyARDhbLCCc+V+GUWSsNIn+nKYTaeVaGoDjYiB+vceADko6lk6J
        iYtPWovFrgSysbGhXKwT67YYzjOgV3E7pjdn0tRblShNUMXFruLPWXBqzV1Hu9EBvHCq7AwL
        b71WzuhsrZbRObM2llUymj3yO6M5Zi2paK1m4RqzjuYYGB0zKcWWK+S0UECITb1JUxdZsvzZ
        7YXPEyvpZWGUs1WwfoNpNIhwJHYkbplgO+aPWr83EOmmT+2waq5DvlqGIQf50FkTA/XjU2ww
        VGVyYH6xhAPG2WUOPD1Tw4V/i4dwmBzp5UHp8E0enLgzwYPB/J/4oB1a4MPxiQYCih+W28OP
        xn8coF6dRYF6qJMC48lMR7h/qhDgeK4a4PrSeQDd+X6Aqao6EXS09olg/tK4CIzFba4wUt/9
        IizkPhCD8US9Owwf+8YDhrUFnnDW0O41zcwEY2ai2HbKNJMkadL/zGTVXX+cMB3LWYn039Tf
        GtDzi2ShZdee72fcsI85OUWirArBBfLkWCh378YAXBDhIkN+FXc8EjMCD2U+HV3ZmW384PK9
        WZ/sutt2Dbfwr7LeZn9q82GIvO3qpdKJ0BqjKPPNuYG+IkFzqVPndNcolXmuSTn2jjBBG1AX
        VP3I46JbSuD0Cz6uMe9f3XH9zy8Gf7uWtLynqWND9eb02KLy2XZyd5S652v3R56lePPMJ34G
        8XsvO9HuGazgrYIFW/fH9lQIauFrFze927E3gavyzueLDqblhuza95bWPXl3X0VW6mO9btLl
        pah9LSG5KwrbI+qgcENXrZe8dWV7xP3e9snwIn2981xs6DEFR8xWyaRbPFlKlfQ/gw6cT2oF
        AAA=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Konstantin,

we have qualified the bluez-5.52 regarding Low Energy using Services and Ch=
aracteristics with normal read, write and notify but also for long characte=
ristics.
Only problem was a bug within bluez where wrong error code was returned in =
case of read/write at specific offset.
The response should be "InvalidOffset" but is "InvalidValueLength". We have=
 fixed this here and submitted the bug. But no answer if patch is applied o=
r not.

Best regards
Jan

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-owner@vger.ker=
nel.org> On Behalf Of CEE Forostyan, Konstantin
Sent: Tuesday, April 21, 2020 12:45 PM
To: linux-bluetooth@vger.kernel.org
Subject: How to to get L2CAP Enhanced Credit Based Mode working?

Hi All,=20

I'm trying to enable L2CAP Enhanced Credit Based Mode in order to pass BT q=
ualification test GATT/SR/GAC/BI-01-C, but it seems that something is still=
 missing. When my BT stack receives "LE L2CAP: Enhanced Credit Connection R=
equest (0x17)" it answers with "LE L2CAP: Command Reject (0x01) / Reason: C=
ommand not understood (0x0000)"

I'm using BlueZ 5.54 and kernel '4.20.0-yocto-standard' with the following =
patches taken from 'bluetooth-next':

From 145720963b6c68d0c4054112c09050995259b8f8 Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Mon, 2 Mar 2020 16:56:19 -0800
Subject: Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode

From 15f02b91056253e8cdc592888f431da0731337b8 Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Mon, 2 Mar 2020 16:56:20 -0800
Subject: Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode

From 4be5ca67d59d707a4b1c8608ca230ad65aa4f232 Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Mon, 2 Mar 2020 16:56:21 -0800
Subject: Bluetooth: L2CAP: Add module option to enable ECRED mode

From da49b602f7f75ccc91386e1274b3ef71676cd092 Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Wed, 25 Mar 2020 12:37:53 -0700
Subject: Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections

Can anyone help me to enable "Enhanced Credit Based Mode", please?

Thank you and best regards,
Konstantin
