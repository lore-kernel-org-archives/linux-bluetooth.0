Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E8AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 23:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFXXth (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXXtg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 19:49:36 -0400
Received: from mail2.multitech.com (spx.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 11B6E8BED3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 16:49:34 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 9FD13585635_2B64D8EB
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 23:49:34 +0000 (GMT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 58F625854B6_2B64D8DF
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 23:49:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0vCx50cKuSMYalWA6OTXVuxrU0V6YuNVnB9E4dq51cTIjmCRnr3tBbqd/0AUuLLZsSArxnsv5f/IMzfI5w9mgRQWicN1iUpSeOz4qEIMck3P80GYUdvuw9PNQqgwjztt+djIbz9tn1skPuPo+amZKfyNWim5CdJElap7SJcXNrQDtP3jicoHgLYAKGlPQNa91Pix10pXB3MYucbMgZjczChdwPVUBfudpdkHac7KBvAF9JKiMYy1k6mhao9s7G3QYIKIYfPL5B9xkQPp0HmdtpNPbpqv4vL/LmcPEUSyh/qjJeCrdGiFS5DJsm6jV0IlsElvZtb15pIPuhNuibCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep9peXJ/1krHq4+uD1i3kvrxhX43QGrWfkBmWt5K4zU=;
 b=O3kCHhMF26LJyQz3BCZ08pSYuZNOfH3hbJ5V7j9/22+sl+UxdDPs7gF+Mx7Wnoeb7lIFWcurXitinddZd6FLPW1WR6OjmFgTS6JYD+xScEawXykCXwFh7v03258Flk6zgpHMF1WrVkqcaXKmVuy8Ufto0303fYcUJsYJfDugpDF1s7ZOqDW6qfD8P8Z//hjfobfQ52zC7OJarpcVswtmod2kaW2ehhLDtcejVR+E7dZ7gPdo0/+JmBlHxFFSTu81wfHijmgvL3qytKV8C+kEZb4eO6niL5ITBjmz5YrbQ6GutIvEIpCAVEOWjdM858rZdN/z0fz6j7a4B5hkUf/gQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep9peXJ/1krHq4+uD1i3kvrxhX43QGrWfkBmWt5K4zU=;
 b=GbMAh91i6Av6kfz3mEsA5nekvTufckYr7PPwkscYtPcLo5Lnmk7rYN4kbb5XkIim8ILc8A8GWEzzMc3R5Ew23KU96SwFYyux4qQVzDzkqk1z3o53rXdUoq2PPn9ObTGh/Fll04BOUDWbz+7JGlOYXcmQfZw3B8ZFMPwjJx+/YFo=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by MN2PR13MB3390.namprd13.prod.outlook.com (2603:10b6:208:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.10; Fri, 24 Jun
 2022 23:49:30 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 23:49:29 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: scan stops after multiple BLE connect/disconnect
Thread-Topic: scan stops after multiple BLE connect/disconnect
Thread-Index: AQHYiCKQV61I2nbW5kmBvaiLVBeB9g==
Date:   Fri, 24 Jun 2022 23:49:29 +0000
Message-ID: <SJ0PR13MB575514F481FA1D076CBDD3EAFEB49@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 64ef6842-037f-4f88-c45c-30a04020a6b7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9fe294a-2c23-46d9-471e-08da563c2e27
x-ms-traffictypediagnostic: MN2PR13MB3390:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FO84EnRcm0qknmud/9dfnBz/ZvjPx73sv2UqQ+g4JwLcolGj+/u1+12HtV/kVm78nYQblyrFqbwGAuv6qPQIbO/NCvBDQV8V2xgZrBEWwSGoqF7eWuT0dD9oLIMQDNLVwuOiD2HjFOtaxRRSfE0jUqjswxM6OQ/kdGlM4iwRMmFDHN240bSJG1DdhEHrWwDjVHDGWrMSaDsqsmXTTEYdj3VzcEnmTNdD5OCT+EuIw2AZ6KEXjxlkV9FgqtxeYCcObdKGADvYesyvovT5lr38TQ42wAb+MqmXhSxDZIjKM+QqxwnEasnstz1CMhAd7JM/GOu0uJQZw8JLbRrC525kOXrQ+TYQmonOw1Yjs7S1u0JL5Np0Tugg3lFcWPf5tVeBnoXliI2C6QRsOwJzGLX6U1E7INPlHiO14hu5YGu7cSUmXV2O1lrZ+fnRqtSrWU5NDJNbtg5H0hXu87u0utn7j9/qPpmbSsh7Ny8EXP0A1hHbx2MB2N3UfQsRCgXFIve5risBFlSEkATebDnGvCvMgOpNpgXgXOGc3RKV3Ew5ChpSeZ0z33/6MAOP6wivXdPg/wUpfSqe9UlBFevitlp4MoIWNxMj0C7VABtUHz+2fhJG7JhoUYvYp/ooNaQBr1ky2p0fJac2uBkHFNXNDppxl850IC5AKATbLHY96xRMmpGkiP86TSwyF4DJErasL3BS+SrzSgOHx4ta72/cU2L4kjbyGh6UR+nP957mg36lrJ9BGeFxr3NNeVp7bJdA2p5ZF/7PoU1FVFUOGub4CDf6HTgyA5pHTnH3g9de+w5/uk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(366004)(39840400004)(316002)(8936002)(41300700001)(8676002)(6916009)(86362001)(91956017)(64756008)(76116006)(66476007)(66446008)(66946007)(66556008)(52536014)(7696005)(6506007)(71200400001)(26005)(9686003)(38100700002)(83380400001)(38070700005)(478600001)(55016003)(2906002)(33656002)(45080400002)(5660300002)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W9YbBFpukS1PKJRYp2YLyr8Noc5FSwwhgCAuFJxKk/X41FausMKr0tWqhB?=
 =?iso-8859-1?Q?deFEdrdz3AaerDq9VbKzQz9jBdgsRE2jIdGeZ7ADOfp9QAjfeIZMSKkzwp?=
 =?iso-8859-1?Q?qXubhJ6WMorJ+zQsReDrQ/4/3gL/HbaexSN56c+t0YK++gFbURrTLx7Cg7?=
 =?iso-8859-1?Q?lnLgJGNP6Ca1dBeBr5cpy873jnpaIKJQltGhS+v3odQEqYvL1oTLOvVxLp?=
 =?iso-8859-1?Q?Dy1lb2pWEaDQwpxomdyiAmS79vNyxLJPy+Gc55yM5Dlo3Bv8bJGvta/rvv?=
 =?iso-8859-1?Q?Kii7LTeMidZRRTB5XChpxNx0XNeSzQ93hc/htVoOLx+9LN8TFedqFLiRlQ?=
 =?iso-8859-1?Q?QVPs9orvj4SWClctLWMAdy/sAnWg2+V3wShu3y57SI1ZlGgk8L1CNygWXM?=
 =?iso-8859-1?Q?7os4u7ThpbeAa+q6hvOolApwAm4lLdS8q8uP0Ftlk4MG4k7rmqWajySj+L?=
 =?iso-8859-1?Q?ny8AVjra0eCH1jj7/1hTJ+iCcqnAihR0lI3Cre4N5xSijspkgvI9OBEtF9?=
 =?iso-8859-1?Q?mN0w8jLibBV2bOuKZ/WE6L9stKoiul+OzhTfW6MwXUxEHl1cXOQBznp5Wn?=
 =?iso-8859-1?Q?AgATwep5OKqR1JaqpR6uSN3bl3lqghCVJ1kdx3lqvHaYT84VJ1E5Ii+Ykn?=
 =?iso-8859-1?Q?+xYV2TrA5BVAMUU0J/I5D+YrR/2nN8dzIoxbNbZB3XXtoz6mabNjaLZWeU?=
 =?iso-8859-1?Q?ZCsGOPg6RVcSnLAV9lfn44l+WQwA3Wz7wExspyNKy8l4UDUiF+bgo1udU7?=
 =?iso-8859-1?Q?xdMmUmQJ0fLOxNILzkTHVHR23VTtpZ0rNEyL8ZNuTIGDbScjP5yRgHH3+P?=
 =?iso-8859-1?Q?pYX/zUhkCxwBvT4FZE/l7WCcA8iwQ5YWYEOR9U0tM8sS6CrPhTyoGj/M9Y?=
 =?iso-8859-1?Q?KFqhsrjP+ym7nqRtgi2EuUtzYh/1+dvaDvidccj0h50zMqlQOp/V5sTG29?=
 =?iso-8859-1?Q?V1TZ97dWjForSSDeNc/zyCQGiZiwIO72Z2LuXkguSh8MD24r0CVyBTZMIZ?=
 =?iso-8859-1?Q?dsgqbb/d7SFed/k1eeyg4TBlunK9GN2FwHV9/+n28dR3xIISWlhhq7H/eS?=
 =?iso-8859-1?Q?jeVsKmk0zCDeaXNdel0AmAF81SR7aU9yksZVWxA7ZG4G46g5+gLx8w9t5v?=
 =?iso-8859-1?Q?UA5NzY6xJF/mbuLYDEzfH8yLKCyOG1dh6KjrX85u96VvvuR6Rb2oSSoDKx?=
 =?iso-8859-1?Q?OUYwZWXlA6AfvF0KWSTsGOF7uNdbP07upmecSOdeJC3qihWimY+1XKgtPs?=
 =?iso-8859-1?Q?0haJ02p1c1stEEk/DBL/yKf0pQgsnx3C0mtLSRJ/S+/oN5Afu6PmpMsqa0?=
 =?iso-8859-1?Q?HPSnOWONmEQTWeDueIcjYZ3eIDrfpioStkwgEyAU9JhntcGVs7T6fsf0MV?=
 =?iso-8859-1?Q?12rgoIiJflIiXSAXABPWh6dz9gJ4f1tTrKAMxSIqwIGh7CBYqHYZ1dWtqZ?=
 =?iso-8859-1?Q?6Q4YM6p9mFYTCaNhQUnxEVxJ2nowwpJZQXxXYxahyl27XUvm0+xBskX+F3?=
 =?iso-8859-1?Q?iDdY5+wNmOLBXkXuFXVUt05AgkV9iMoyPupuVuMdvZVOh7YQck37DaJZge?=
 =?iso-8859-1?Q?+m1Elb3llvuo5Jinwwa0FMb4cUkfhoJCWWhhYA6R2FqpfXX84K8bw/zQVE?=
 =?iso-8859-1?Q?tciwC8/bGMzuc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fe294a-2c23-46d9-471e-08da563c2e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 23:49:29.8230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5d3A1FvdgahP/1inot66xhRJwSeMVRnQJ7aw5SAPZkVC7YCXsbt1rUbM48aTrBrG2dywIOhPw7MA/hdS5EixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3390
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Software versions:=0A=
Kernel v5.4.199 with patch "Bluetooth: hci_event: Ignore multiple conn comp=
lete events" from Soenke Huster.=0A=
Bluez 5.64=0A=
=0A=
After running multiple concurrent connect/info/disconnect/remove cycles whi=
le scan is turned on (all done with bluetoothctl), scan eventually stops wo=
rking, and it is no longer possible to turn scan on or off. The show comman=
d indicates that the device is still scanning, and the state cannot be chan=
ged.=0A=
=0A=
The scan was turned on with "scan le" in bluetoothctl.=A0 bluetoothctl was =
also used to connect to the endpoint devices.=0A=
=0A=
In the bluetoothd log, there are messages like this:=0A=
=A0   update_discovery_filter() filters were equal, deciding to not restart=
 the scan. =A0 =0A=
This message does not occur when the test is running normally.=0A=
=0A=
Here is the tail end of btmon which halts after the problem occurs:=0A=
=0A=
@ MGMT Command: S.. (0x0024) plen 1 =A0{0x0001} [hci0] 2022-06-24 18:17:12.=
624762=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
< HCI Command:.. (0x08|0x000c) plen 2 =A0#24633 [hci0] 2022-06-24 18:17:12.=
627487=0A=
=A0 =A0 =A0 =A0 Scanning: Disabled (0x00)=0A=
=A0 =A0 =A0 =A0 Filter duplicates: Disabled (0x00)=0A=
> HCI Event: Command... (0x0e) plen 4 =A0#24634 [hci0] 2022-06-24 18:17:12.=
629378=0A=
=A0 =A0 =A0 LE Set Scan Enable (0x08|0x000c) ncmd 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
@ MGMT Event: Dis.. (0x0013) plen 2 =A0{0x0001} [hci0] 2022-06-24 18:17:12.=
629839=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
=A0 =A0 =A0 =A0 Discovery: Disabled (0x00)=0A=
< HCI Command:.. (0x08|0x0005) plen 6 =A0#24635 [hci0] 2022-06-24 18:17:12.=
630071=0A=
=A0 =A0 =A0 =A0 Address: C8:8E:7B:1E:9A:58 (Static)=0A=
> HCI Event: LE Meta.. (0x3e) plen 43 =A0#24636 [hci0] 2022-06-24 18:17:12.=
630361=0A=
=A0 =A0 =A0 LE Advertising Report (0x02)=0A=
=A0 =A0 =A0 =A0 Num reports: 1=0A=
=A0 =A0 =A0 =A0 Event type: Non connectable undirected - ADV_NONCONN_IND (0=
x03)=0A=
=A0 =A0 =A0 =A0 Address type: Random (0x01)=0A=
=A0 =A0 =A0 =A0 Address: 34:42:82:95:CB:3D (Non-Resolvable)=0A=
=A0 =A0 =A0 =A0 Data length: 31=0A=
=A0 =A0 =A0 =A0 Company: Microsoft (6)=0A=
=A0 =A0 =A0 =A0 =A0 Data: 01092002f69644aca805d759f0b1220b44947a78f52828a5b=
a9387=0A=
=A0 =A0 =A0 =A0 RSSI: -58 dBm (0xc6)=0A=
> HCI Event: Command... (0x0e) plen 4 =A0#24637 [hci0] 2022-06-24 18:17:12.=
631360=0A=
=A0 =A0 =A0 LE Set Random Address (0x08|0x0005) ncmd 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
< HCI Command:.. (0x08|0x000b) plen 7 =A0#24638 [hci0] 2022-06-24 18:17:12.=
631790=0A=
=A0 =A0 =A0 =A0 Type: Passive (0x00)=0A=
=A0 =A0 =A0 =A0 Interval: 60.000 msec (0x0060)=0A=
=A0 =A0 =A0 =A0 Window: 30.000 msec (0x0030)=0A=
=A0 =A0 =A0 =A0 Own address type: Random (0x01)=0A=
=A0 =A0 =A0 =A0 Filter policy: Ignore not in accept list (0x01)=0A=
> HCI Event: Command... (0x0e) plen 4 =A0#24639 [hci0] 2022-06-24 18:17:12.=
633365=0A=
=A0 =A0 =A0 LE Set Scan Parameters (0x08|0x000b) ncmd 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
< HCI Command:.. (0x08|0x000c) plen 2 =A0#24640 [hci0] 2022-06-24 18:17:12.=
633787=0A=
=A0 =A0 =A0 =A0 Scanning: Enabled (0x01)=0A=
=A0 =A0 =A0 =A0 Filter duplicates: Enabled (0x01)=0A=
> HCI Event: Command... (0x0e) plen 4 =A0#24641 [hci0] 2022-06-24 18:17:12.=
635411=0A=
=A0 =A0 =A0 LE Set Scan Enable (0x08|0x000c) ncmd 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
=0A=
Here is the bluetoothd debug output near the time when the error first occu=
rs:=0A=
=0A=
Jun 24 18:17:36 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_remove() Removing device /org/bluez/hci0/dev_C8_7B_FB_0E_8C_BC =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:36 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_C8_7B_FB_0E_8C_B=
C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:36 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_free() 0xc09df0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=0A=
Jun 24 18:17:36 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:start_discovery() sender :1.9921 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:17:36 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:update_discovery_filter() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:17:36 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:discovery_filter_to_mgmt_cp() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:17:36 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:update_discovery_filter() filters were equal, deciding to not restart=
 the scan. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:17:39 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_remove() Removing device /org/bluez/hci0/dev_C6_F9_1C_2E_EA_E1 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:39 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_C6_F9_1C_2E_EA_E=
1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:39 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_free() 0xc0aed8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=0A=
Jun 24 18:17:39 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_remove() Removing device /org/bluez/hci0/dev_C9_47_35_4D_C3_EC =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:39 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_C9_47_35_4D_C3_E=
C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:39 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_free() 0xc1a218 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=0A=
Jun 24 18:17:42 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_remove() Removing device /org/bluez/hci0/dev_D3_87_9A_19_E7_BE =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:42 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_D3_87_9A_19_E7_B=
E =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
Jun 24 18:17:42 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/devi=
ce.c:device_free() 0xc5ae88 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=0A=
Jun 24 18:17:46 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:discovery_disconnect() owner :1.9921 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:17:46 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:discovery_remove() owner :1.9921 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =0A=
Jun 24 18:17:46 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:discovery_free() 0xc1b130 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =0A=
Jun 24 18:17:46 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:update_discovery_filter() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:17:46 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:discovery_filter_to_mgmt_cp() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =0A=
Jun 24 18:17:46 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:update_discovery_filter() filters were equal, deciding to not restart=
 the scan. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:18:10 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:start_discovery() sender :1.9922 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:18:10 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:update_discovery_filter() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:18:10 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:discovery_filter_to_mgmt_cp() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
Jun 24 18:18:10 ecc8 daemon.debug bluetoothd[28264]: ../bluez-5.64/src/adap=
ter.c:update_discovery_filter() filters were equal, deciding to not restart=
 the scan. =A0 =0A=
=0A=
Any suggestions for further analysis would be appreciated.=0A=
=0A=
John Klug=0A=
