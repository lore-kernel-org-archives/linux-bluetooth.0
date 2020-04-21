Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937EAC54FD0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CA92071C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgDUKu0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:50:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgDUKuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 06:50:24 -0400
Received: from Exchange.peiker-holding.de ([82.119.189.130]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqsL3-1iwEfC0mvZ-00mueK for <linux-bluetooth@vger.kernel.org>; Tue, 21
 Apr 2020 12:45:07 +0200
Received: from Exchange.peiker-holding.de (10.0.1.22) by
 Exchange.peiker-holding.de (10.0.1.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1779.2; Tue, 21 Apr 2020 12:45:07 +0200
Received: from Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42]) by
 Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42%13]) with mapi id
 15.01.1779.002; Tue, 21 Apr 2020 12:45:07 +0200
From:   "CEE Forostyan, Konstantin" <Konstantin.Forostyan@peiker-cee.de>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: How to to get L2CAP Enhanced Credit Based Mode working?
Thread-Topic: How to to get L2CAP Enhanced Credit Based Mode working?
Thread-Index: AQHWF8nrK1u7IRXZhk2vsyaioBaliw==
Date:   Tue, 21 Apr 2020 10:45:06 +0000
Message-ID: <77b02337bc404dea9fa88a286c091b83@peiker-cee.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.112.6]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Provags-ID: V03:K1:po6HiFxDbM0yICCWYZn5lVsBrHGJwplsMu98aWiFiXC1ldG8BOs
 0ZFmL0zRt/hcN/bwT9J4SB5XuZ+WAPABKzWonSofMSMN3Fvn2Nj7MZZn0zVPp79cfX5YNhJ
 yKrMDB9jtdj8/S+YA9IRi88mjx34BEdTPeoaWhGFCmOvfNeHdBU3mnP2i/5v55UGGrZ56hz
 InFuyRwq3PfZ529eeWtiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gCm9D7WFYsE=:n8zaSgBHueCscWJ3QOrb7n
 +Iy8ulmjF5SBNXvqx0OoZMzSE/NoqlwwD7vYd2wgauitGLx7Z6hWlTK6Mw0j3adkLPw1fZIki
 eP/kVykjG5Vw/w3dVWfzpXrGv1YsV8zrPaeWQQLNgRxBMBVd9CXyNspbY1h3x4bZje7kyrc79
 QRf726y+Zkw7ktMg2yv4tUbvz3+0jsRga//GQ8WqAyVANoQiVgOJz+7LTqhEn3uedXhTTO4AP
 h7iDFUjlvRfee2dX2l/gLHoWtbP4JZdYKNLA8MaXm9W0LE8wSFpTzHOtn9puFtXLOgC7yVJt3
 kPuO9kJcOofmjncvdVruI94n0YcF6v3x24Z5xu0Vo5DWdGC0FRWuEpigtzVC1zVwFZhhZ6g+/
 BiPeQCWwCXBPGNGh+AFVw3k3uh/o0uXE5dQGv143Kg2Iip+O/jL7fxfKobwoGRByFBsgavv7x
 s7sFYVg0agWGN70+jtlKLUb6fZ2LU0S3qehBCWMICQEmxo0ZIGa0SuQyJS4TsnE+IsmS8H7YR
 epdYPY3rzSIKGKzp/ylPZXEfsKnGKIWErfQivVE7r0i8SLKuQHaV/UjeLZwb3Z3tearMmUXbk
 CUfZpq10cDDKIBZLdMdIYMJzs5MTYUK6+SGNEP/nP+XregQOpE4Wsi5VjNnMq/OI7pGcr/zw+
 TIfLEfxGxsAqRnnkp4jLyuYIwyxejV44FhNH68/yi9mukjh0KxNQCxOYTjy6pqeHYAJcy242e
 B8bXbiGTFqe3g8o9vverSZ1ke9rG64RjqEootkbVRjl6Y4EFKxjazaaCd0LbbM2ThBXK5BlYy
 qs3A9IulvlcNLhNwdjjQSnBTJxqUlMkp9YmBxlc7uEudb6dbhtw632SU1859c0cq/XlcHqwaT
 gQHlNOSn6Gz7clAYKVwQ==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All, 

I'm trying to enable L2CAP Enhanced Credit Based Mode in order to pass BT qualification test GATT/SR/GAC/BI-01-C, but it seems that something is still missing. When my BT stack receives "LE L2CAP: Enhanced Credit Connection Request (0x17)" it answers with "LE L2CAP: Command Reject (0x01) / Reason: Command not understood (0x0000)"

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
