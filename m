Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DEEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 02:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjGGCaa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 22:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjGGCa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 22:30:29 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2108.outbound.protection.outlook.com [40.107.108.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF5199D
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 19:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkMXYTK9q+erDO1fiaFmvOr1THx2u5pDY3cIoAczHyDGk3jjsLXmPEeb48gvv5ghPFTLq37jzE9GEHex8VvAX1jAhO3VwBwCSWapCCB7gjptARY1j3WjZooznek+782q8E8I39Bb6iugIUMi0F5ZTjgZrpzjRFq7ZiJCEBaodZ2s/w+y0grSo9CsjXyEr6XKmp3RBaw/8v1KAn+4hIGxbCW/aoptulpdF2ZeyILuR1TGcxVObvYybzXd2tTADjuoWMq6jll/tmKpr8hC9Spn1BDDEulzVkrrdq4t0UvtP3idwBkLUbSulbOkUZo0BGA3NGQot4IZtyaBf50h4dZhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNAJt9kittScLjpq6sjlUYm1TZKB8VQIdPigUSfarxE=;
 b=BWARBAgMC/hldqGP1tRpmYSKgR2WtmlD5rPBIkAPH1s8vIT3q3aQuDV+v1JQZsdY79dF86JBEZnM270ElEEFBzna1sAHEOsg0cLuddY356DKPO6syGKQF/ra7jRo/bEVQ6/VxrEHe6HimTPrgEJT17iWLr9N5ayr9d/QoriXuy0pk+MNPPNuSyNLmipcfCBzVEr5aCe7pWHkinERzrDtydP5LwiMaJ8LHSADg+9i4ebPmseorVr7uLO/bNnpXxOk0l/e4ANXE1q2t01NQoOBv16igcyD2429kW9B7d2Tgrnp2PH8dZAee1JEyhaieasdWNLv79LzTLNuZoKzXqFNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gallagher.com; dmarc=pass action=none
 header.from=gallagher.com; dkim=pass header.d=gallagher.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gallagher.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNAJt9kittScLjpq6sjlUYm1TZKB8VQIdPigUSfarxE=;
 b=gVE2jr5RpuSuW7M1PFV3RrcLxm+dE2UcbG8oBXwXR0mjpHQvFvgUjMnMGJFvBzdfop0DE6j4idgju4Ju1JoH/FvgRqxNlA7EbuUUAdbxbz0YQ9kI3MO49IeeBtl3ctxqAN2jHFTh91j578NRRIPg8EFY1kMxYERjZA5pw6z7okE=
Received: from ME3PR01MB5623.ausprd01.prod.outlook.com (2603:10c6:220:c8::7)
 by ME3PR01MB6950.ausprd01.prod.outlook.com (2603:10c6:220:163::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 02:30:19 +0000
Received: from ME3PR01MB5623.ausprd01.prod.outlook.com
 ([fe80::be85:ba3b:8b72:2e15]) by ME3PR01MB5623.ausprd01.prod.outlook.com
 ([fe80::be85:ba3b:8b72:2e15%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 02:30:19 +0000
From:   "Xigang(Ted) Feng" <Xigang.Feng@gallagher.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Fix for Bluetooth SIG test L2CAP/COS/CED/BI-02-C
Thread-Topic: [PATCH] Bluetooth: Fix for Bluetooth SIG test
 L2CAP/COS/CED/BI-02-C
Thread-Index: Admwetoijgsr3B0STmqdV7N4r/13WA==
Date:   Fri, 7 Jul 2023 02:30:19 +0000
Message-ID: <ME3PR01MB56237F9982C4F3C9201AFF1FF02DA@ME3PR01MB5623.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gallagher.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3PR01MB5623:EE_|ME3PR01MB6950:EE_
x-ms-office365-filtering-correlation-id: 9b5eb456-e1ae-472f-e395-08db7e921b52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xC2gjSDQU29cDR3cnW8viMgpLamJvX0xHKJ1cz4YSFZnngphpyvZ5UbcX9/m05Q4Za9ZEjRL68WHfGwD0BUY90zj6QRPPHKv3uYuAbWv2yUrtXvK++qAvNorZNfR5yq833dak4TBzLGnkdzs+g/Wl/rHW6RIB0pH+rehrFE1LrtJXPVGYHAs+qe8Iergs+G1InHuAe66YDQzR8Y0/r0hFI9J2AeB7vQJj/jmBp64hqIHLksqgW7+z+5pstI5tAoKlIOaLQYd7HIKPvvWRUnU4JfcwmbQSh8BFxfBiKHFFQcAqypW9ImNgoAHjqrKoHNtgU5XszOJVcLF7aK/s78NEBI6ayOfPzvldbosjk/W1TTedPTfbgnFfUXN4kOplkLcwYBNOeJpIELBh4709ysysIPWn5fbo73oXU5JRoYDwz84Y0Z5RglOUstxj1fwg8HK1KolgW3+V44WKcvsopJF3EIVnbVB6A9AaFwKBirVQT7UMCpzV9oIc1dNbeOq5k+DWZNqe2QM8pIwAXtOodQQN0Z4vMJO+C271MTirvAVNTYZpKStkcrNL+2HmZUKryKOuqVo0+YfUp1CKbU4U8PB8rO4QOT++AG+tPE9nw1jcLGKo1LT0ZpvdP1czFmVtLfI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME3PR01MB5623.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(346002)(396003)(366004)(376002)(451199021)(86362001)(83380400001)(186003)(316002)(41300700001)(9686003)(26005)(6506007)(478600001)(122000001)(71200400001)(7696005)(38100700002)(76116006)(66446008)(66476007)(66556008)(55016003)(66946007)(64756008)(6916009)(8676002)(5660300002)(52536014)(33656002)(38070700005)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gRgYyCchiLgR7jgWEUW6wTaI/FOpxvGBtPKlgh2yAdUrpRV0ifPGVwxgUeia?=
 =?us-ascii?Q?D0dyB/rxM0fwe/JEGWt1/o26zZAlJGSyFi93PMcf5efZZBl6tGweInrGDxoo?=
 =?us-ascii?Q?LTRUaptznahqREmkk9GCErU/QX8MHHM+1o1zpkIfXoeMRpEnZbSC+W62/SPE?=
 =?us-ascii?Q?ha5biuwrtViJGjnRqimeakWjpSC+usbF+gJgi49u7d2dcdw4FTOJr5EX+Vxz?=
 =?us-ascii?Q?/riBBM3spp30ZZeCEVanDKwnGzQope+6Uf0vLpeTwJja+Bg+uR1lxV0CHCeg?=
 =?us-ascii?Q?v8/M25sB6pcUSDZMc2MC82a40A3nxR04sp+AdvUEYEWZ+4m5M9zAxlVwsfxF?=
 =?us-ascii?Q?TLZuG21Nc0iiqbP31cVdCeMF71B2ZwUmNQ7QdMSzIL4Do2vrWquSdX2RUCM8?=
 =?us-ascii?Q?7gm81HpCkXOaB4y5dFKwhbqzOHFAAVuK0esWlg0DX2KV6B9LyMAahImgAeGB?=
 =?us-ascii?Q?7tr5lFot2yRGrIs1adHD/5lwUdqzHGQd5yWTCnivOaNwl2ZMGfewFxol5B9c?=
 =?us-ascii?Q?IKF2bLa3/ipIvhGKU4bY8YJovhDpIgxvaRuMrZfS3i01pZ6fNqoEx4zE2iJK?=
 =?us-ascii?Q?mcNXRLL3RU45iV5TMXrezOB/0BGV0l3xYnjsFcPTY5oVW7zkVfYzB+0f+pVw?=
 =?us-ascii?Q?3xeq5IgdJ+79KrjXeWuud6qL8UTYJdcP3Fl8AyQ6rWh4JhswbzFr0UxYYol8?=
 =?us-ascii?Q?8uCnE0fvsKzfOTqu9zsaZCswJ1Akj7eREguh02kwffT442EyU88PndAzlStS?=
 =?us-ascii?Q?nJAjFRtd3IkHxn5tY/NvfBbXiswvV3Cc+a3Qsz5sfArAfwWhuq0pR9HUxjES?=
 =?us-ascii?Q?4QiW8v4a+Yg2QrECPUKa7BWkknWzUivfzaAmFyTkXg5gQRw6ieRAbA4SZwX6?=
 =?us-ascii?Q?r21/EZg1JVStqeLU7Jx693h5I2z78+e3AZgn5cMruiPqdjz6xIklHb5v7U7/?=
 =?us-ascii?Q?ic0ys9WR2zh8BPdZGjsx0vLk/g7Od48xJwuX5iv58VHyJzM0YcvPcTsXbiwj?=
 =?us-ascii?Q?iwgshI6ImPl5PzDHyYoq5XxfUbzyI1dpRSkXfAGfPlfxtnqykWc4VmEWKPSi?=
 =?us-ascii?Q?pnYr8t3KftM2Dpi5AQngCQB/rtc3vHYskafjah+81ijbjNoLvrIhzPWSe2vS?=
 =?us-ascii?Q?VJVy7PPKmFD/tx8WlQXboq4eA6TscyOiF0/28cCWLMmPDcTc+2tqXBQyXyuk?=
 =?us-ascii?Q?R97st3k2wqW+bcRpBt89MQcExUWLdeOSzCn8Dda+9ekpFK/yf7Wcpz/Uz9jD?=
 =?us-ascii?Q?P16NUymkV/qH6zOJ0e0BHJovnDd/7q+R25mlHW9RVMJQf2wo8scjfKCmqzZW?=
 =?us-ascii?Q?a/ZU1Et4cGD4didz1HLj6vS1JipSLbbNub4sB4yGJg07Tcd+46i9koOVziWC?=
 =?us-ascii?Q?+kN+5YrkBvp0EAyauYr7DRvQo8W/Hk5ScMkO/HN3jyit+QHXlV8Fs+65OA69?=
 =?us-ascii?Q?9lsXbv2BmlyKrplcJ2o6lIZ/MlJr0s+jiiUka+a+Rxm6D+Cq5qZGqF0eufQj?=
 =?us-ascii?Q?KWxjkKZ0R7XR/HC2ZoE7/vGe8IOEFqHsaSOkCWUBmwiPbWQ96NnCUc25GhhJ?=
 =?us-ascii?Q?60UFGEZUu2YNTSk60NraBBxju4smnon+RBIQ7U1O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: gallagher.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3PR01MB5623.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5eb456-e1ae-472f-e395-08db7e921b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 02:30:19.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2156b869-431f-4815-b2ce-b4893b5c9aaa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCw5dhBhfVmiY5tgvL492cDM96qXxz2C/EK8pPBjebF0pcEzwzFTpQtJC3NU5enc3mf0bXFklBOQr44b3zleIDPOehwMq1ZXGqOjd/ezGO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB6950
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This test case is for verifying the L2CAP signalling PDUs that have invalid=
 length are properly handled.
With this patch, the "L2CAP: Command Reject" packet is sent correctly to th=
e malformed signal packet
contained in "L2CAP: Connection Request" packet.

BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3, Part A page 1041

'When a packet is received with a Code field that is unknown or disallowed =
on the
signalling channel it is received on, an L2CAP_COMMAND_REJECT_RSP
packet (defined in Section 4.1) is sent in response.'

Before this patch:

> ACL Data RX: Handle 1 flags 0x02 dlen 15
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 1 (0x0001)
        Source CID: 64
        malformed signal packet
        00 00 00                                         ...
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 1 flags 0x00 dlen 23
      L2CAP: Configure Request (0x04) ident 3 len 15
        Destination CID: 64
        Flags: 0x0000
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1
        Count: 2
> ACL Data RX: Handle 1 flags 0x02 dlen 25
      L2CAP: Configure Response (0x05) ident 3 len 17
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0
< ACL Data TX: Handle 1 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 4 len 4
        Destination CID: 64
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 4 len 4
        Destination CID: 64
        Source CID: 64
< HCI Command: Disconnect (0x01|0x0006) plen 3
        Handle: 1
        Reason: Remote User Terminated Connection (0x13)

After this patch:

> ACL Data RX: Handle 1 flags 0x02 dlen 15
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 4113 (0x1011)
        Source CID: 64
        malformed signal packet
        00 00 00                                         ...
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 1 flags 0x00 dlen 23
      L2CAP: Configure Request (0x04) ident 3 len 15
        Destination CID: 64
        Flags: 0x0000
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0
< ACL Data TX: Handle 1 flags 0x00 dlen 10
      L2CAP: Command Reject (0x01) ident 0 len 2
        Reason: Command not understood (0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5
       Num handles: 1
        Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 25
      L2CAP: Configure Response (0x05) ident 3 len 17
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0

Signed-off-by: Xigang(Ted) Feng <Xigang.Feng@gallagher.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17ca13e8c044..c3af7727ee1e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6534,6 +6534,14 @@ static inline void l2cap_sig_channel(struct l2cap_co=
nn *conn,
                skb_pull(skb, len);
        }

+       if (skb->len) {
+               struct l2cap_cmd_rej_unk rej;
+
+               rej.reason =3D cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
+               l2cap_send_cmd(conn, 0, L2CAP_COMMAND_REJ,
+                                       sizeof(rej), &rej);
+       }
+
 drop:
        kfree_skb(skb);
 }
--
2.34.1
________________________________
 This email is confidential and may contain information subject to legal pr=
ivilege. If you are not the intended recipient please advise us of our erro=
r by return e-mail then delete this email and any attached files. You may n=
ot copy, disclose or use the contents in any way. The views expressed in th=
is email may not be those of Gallagher Group Ltd or subsidiary companies th=
ereof.
________________________________
