Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC0C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 12:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B157020775
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 12:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDUM4i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:56:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgDUM4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 08:56:37 -0400
Received: from Exchange.peiker-holding.de ([82.119.189.130]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCbMx-1jZMuW0c6N-009ft5; Tue, 21 Apr 2020 14:56:35 +0200
Received: from Exchange.peiker-holding.de (10.0.1.22) by
 Exchange.peiker-holding.de (10.0.1.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1779.2; Tue, 21 Apr 2020 14:56:34 +0200
Received: from Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42]) by
 Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42%13]) with mapi id
 15.01.1779.002; Tue, 21 Apr 2020 14:56:34 +0200
From:   "CEE Forostyan, Konstantin" <Konstantin.Forostyan@peiker-cee.de>
To:     "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: How to to get L2CAP Enhanced Credit Based Mode working?
Thread-Topic: How to to get L2CAP Enhanced Credit Based Mode working?
Thread-Index: AQHWF8nrK1u7IRXZhk2vsyaioBali6iDglRwgAAEECo=
Date:   Tue, 21 Apr 2020 12:56:34 +0000
Message-ID: <cc33f16c2e164328b8248fc3967ebed5@peiker-cee.de>
References: <77b02337bc404dea9fa88a286c091b83@peiker-cee.de>,<08f0a119cfa0481fbf49d7fde47a08fc@bshg.com>
In-Reply-To: <08f0a119cfa0481fbf49d7fde47a08fc@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.112.6]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Provags-ID: V03:K1:0Rh6gzpWW8pdGNjUeazB5oLUv8mXbWmqTQXx8rfj2uVz5rok513
 aitkseh3xNEVAn91UFOx24WI2lN7uMtkrjPsd8N26JxXkDUCNwZNFht95IAPNpslsrqROwQ
 IqN+crdbpJZJ1tQRt2HkoyJA5+TKYesCXauS1fsg/pArYTHNQzBQ0X68x4bLS0ZVHv23oQW
 rlJBrSHb6WRlvYCTrpnOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9OOq1kyLHNc=:HkFNbewUogz2tFu6nXmEXZ
 PAljRWYXFsOUBpehwvq5gsojpSgMM5WPQK/nHaIvZp81qxnxFoXm+NQdkfkt8DyfeIvwIsoTt
 WYbyRwz6Z4UydY3BsIuv77t7tB23A3xm4HDjwvlTGSaTMeNCX52+Wg1uEf7e7Cicf8mnpnxoZ
 P2C/b4bN8DaElHHGnTsjJSFl6QjWiQldIsRGvAM+7GNTTHx7eyvVOv16bDjErgj/lnx4cKSBI
 rbxTps8ADGMKdu6hM6BZp40baZsdBJGwO2IndES9pKy4MkOvwT8HjaFdeiiR0ERDnPagmvYjl
 MSg+yJ3BmneDcefPaDgveBudH3dh90dgIDSlJ5j/xpT49lll1qgJB+JF1uoRDitVAVhtzai3s
 Jbsm+y0SUVGcNtQUEOoHsHARnbofErSBfD9g1vZ+dpkhxVpljiSSBW8/iBU9dNmOZUXmmKTM4
 xJxs+b89FFJaYGJXHdCg+IQ6JxHPmJKGJHoLOJbfAf7K90LnGnNkoA3WuTq96Z/0hCyJjAszI
 ThmRyC3CN16IlusPwoG+qfSY2NTzNiHKAr/hL+nt90ylaNnce/joMxwgL04eZdfqnr7W5jE0j
 ovHHtLEvimvWFjGHrbl/Q+u4nsynO3lASUxhWSqvymEEONRB1fcjccLFIAPItx0D5bT98/vHE
 9wjqaTVHEV9AUvgkp+Eq/DEcxoyK6TSGCVIyrrJw9cK4L0AAMkl36GJmMA5YO41VaAFX5g44R
 blXzmK2s/NjUJc8YilstrZ124U4oqEN2arU6ItMf+YXkSly15HHuR089F9lWKNXi3WVPRxidH
 XAHUH8rrqjhvvINrFCJTG9XMYw/wy7BD/0qQOSFevQ5/trwAsc4F4frvYpHTAcRXwcsC+W0p1
 2FCFtXGYfEDVH+NJZp5g==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan,

Thank you for the answer. Did you succeed making GATT/SR/GAC/BI-01-C test as well?

I found out - thanks to Szymon Janc (sjanc) who gave an answer on the #bluez channel - that because of the patch "Add module option to enable ECRED mode" I have to enable 'enable_ecred' for the module 'bluetooth' in order to get L2CAP Enhanced Credit Based Mode support active.

Best regards,
Konstantin    


Von: Ryll, Jan (GED-SDD2) <Jan.Ryll@bshg.com>
Gesendet: Dienstag, 21. April 2020 14:42
An: CEE Forostyan, Konstantin; linux-bluetooth@vger.kernel.org
Betreff: RE: How to to get L2CAP Enhanced Credit Based Mode working?
    
Hi Konstantin,

we have qualified the bluez-5.52 regarding Low Energy using Services and Characteristics with normal read, write and notify but also for long characteristics.
Only problem was a bug within bluez where wrong error code was returned in case of read/write at specific offset.
The response should be "InvalidOffset" but is "InvalidValueLength". We have fixed this here and submitted the bug. But no answer if patch is applied or not.

Best regards
Jan

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-owner@vger.kernel.org> On Behalf Of CEE Forostyan, Konstantin
Sent: Tuesday, April 21, 2020 12:45 PM
To: linux-bluetooth@vger.kernel.org
Subject: How to to get L2CAP Enhanced Credit Based Mode working?

Hi All, 

I'm trying to enable L2CAP Enhanced Credit Based Mode in order to pass BT qualification test GATT/SR/GAC/BI-01-C, but it seems that something is still missing. When my BT stack receives "LE L2CAP: Enhanced Credit Connection Request (0x17)" it answers with "LE  L2CAP: Command Reject (0x01) / Reason: Command not understood (0x0000)"

I'm using BlueZ 5.54 and kernel '4.20.0-yocto-standard' with the following patches taken from 'bluetooth-next':

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

    
