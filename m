Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00983C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jul 2022 22:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGFWyJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jul 2022 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiGFWyH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jul 2022 18:54:07 -0400
Received: from mail2.multitech.com (spx.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BC74124BEE
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jul 2022 15:54:06 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 510DA585F7C_2C6128EB
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jul 2022 22:54:06 +0000 (GMT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 8C2A6585F2F_2C6128CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jul 2022 22:54:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3hmstlNxvPo9pvriLW7v/VEA/htXHgdkilXojRDyYfeIremtl3sBvM9ZMKaNgc/rvh8w+BcMUQNuTtbeH9PRrGvY9asFsCHqrum8m3yHxg1mT4xzaHxdqMXyimLNVoAXujc86KWMIww4KkSYtuHPIfWuAHXQF31MTIQptAmop0mzMks/Qoi+Zo9Fd8Z8Q8LsPQJmZ9KcsvSDyHPpGMsWb5xpZLU6kUnUSFha9bB0HRoPf+YWA7hokdS6hz5byTo6XfaelyfQPJosPQdzE/Ua/FAKahYEtEw+SQCl6zAzBgz3wOPVUZF3+Q2JI1f7rJn9gO+pMgb+/TZkzvauAqeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYngRsfYHigkxs3FaFqn6HXHFZsAxd35p1xXlz9ytZ4=;
 b=YrG/1u15Wzd/ym8WoLb3ny6pIRa4dlXLYdesSptfLMaAqkcei7WVo4YgrX5V1wbqJr2h+jIspI9+G/jnU894eGe53q/qVlNX3PxM5Wg97EcZ47rltT09OXvJCnYIVEbOGUDXJTDl6cRGxDkJNXUfql+wzVNSnvzYu0xFKJnS42+XNCPlDpLzw7JjTF2EoXgVkEStpCJcpmmhgLS7w8wXHLYeoK/OJw8s/CRSRTtKlroy4Ja7Nsit3QnFEpEjJ/ieVzJJEiw7wzwJ+0+GjJZVerRVgaXngRx/9xtIiKCnU8u/m3l4ELCHWp9w7Vbrg3JV+n0dGPDvnV+34/rbEdag7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYngRsfYHigkxs3FaFqn6HXHFZsAxd35p1xXlz9ytZ4=;
 b=JuZ21V0A7I/mrMeHdvA784UlpagQ6PWXantt35XJMVtrs1wySiVaB3Mqrp6E5IYf82xv+pWfljm1kKjsoQQY6mtl4YIfUfouMc4HCGNAOKvIwXOzP3Qn2nQtPfVbevWAGurMe8iWTiETC87ud9wUZlmz+VopctIHQ6SEr507UFg=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BN8PR13MB2883.namprd13.prod.outlook.com (2603:10b6:408:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 22:54:01 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.013; Wed, 6 Jul 2022
 22:54:01 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: [BUG] Extended Scan Hangs
Thread-Topic: [BUG] Extended Scan Hangs
Thread-Index: AQHYkYPWWftWQokBQUOT5vMZZwl4BK1x8pUy
Date:   Wed, 6 Jul 2022 22:54:01 +0000
Message-ID: <SJ0PR13MB5755BDD8A189504972CCAF8DFE809@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755B252BAE811BDFE22E3F7FE809@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755B252BAE811BDFE22E3F7FE809@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e331641c-81fc-f12e-6f3a-34ec0e51f45f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e68bf0ef-1439-41da-9eb4-08da5fa26b50
x-ms-traffictypediagnostic: BN8PR13MB2883:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9kU4BpwJoMTSb7KZCEtcTyzch+1rj0TbMnoyLypVOA9RSmyJEkO0RXuimpQv8YeFABkdW7TKH+9Pz6CI/VSc2UO3/G+q5JjXgSd0h2t1jmtg3dh57csrLxlf3VZ6LXjUBHXJwqmueNGequJeHDD8ZuohPq4CbuHdcREIVtJDBQKImRQhb2jTxZRVtX2J+NLjHdFpTbwbePGbODFiOaXSkhBrLdC++o4nOFr/V0xIPfWi/PAFzjakir+LNkygF2pmp+fjyJZyAk2ZnKhmqdvSLBuifr2ZtL8l8GRpPwGD1hIpeUu82WiscQWVM+BZaVzSq2Ocsa+AXU07Y40AziIizAyxEBMt8O58phl8s6JoM7CFax+IdzT8pK8SmqxzKN3IAnJBrDm+12mQel6GwVgGtZiNU9SNBmkONEcgrFHTTyaTeCxmS9VQakoxSnKMIy0cYWJQh2/LN4VYDdYxBeivwNoCSnjNhuLrTgfir7+YGr8tlaLFWPJre2gEnJwecaYtlkYRXh4x1A2WjrrWKWbbkVGCL5Qg+e4x9nMgwxm/T9rJFsnu99mSuun1UXJOREQR0GIvI4vO6ezW7s0hf7tJoI88xRIoxMDZ5Wtz78OgFq1tJDcRysR2EbpRXpTH2XccgeV1B33NZkE3V/qBrYRnIMVXDcPEgBJKU9jiUmVD0YPXU9HBQxTmxuVkfSCdeCZUQqbLfDEtES8GS1E2Osvtk8PmHVSa2VMjyFKaA3KxwwlLwD0WvuWkytYtlP7k4TuTdn+1ZIDMTuqFklPUrIt8rHNOEBFSRdYRx6bMXnk2Vokdza68Fc02iBFPtqkUYk30
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(346002)(39840400004)(52536014)(53546011)(7696005)(478600001)(2940100002)(86362001)(9686003)(5660300002)(8936002)(6506007)(33656002)(41300700001)(2906002)(26005)(55016003)(122000001)(186003)(38070700005)(64756008)(66946007)(71200400001)(76116006)(66556008)(66446008)(66476007)(8676002)(91956017)(316002)(6916009)(38100700002)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?acI1/tlQUqo3SpPBge1OhZK+h4kWS31xdKZVP4saFf8hwG57Wj9hiyGCd2?=
 =?iso-8859-1?Q?O7CcrkU1BSatN1HFRz86iy7dOJhbEWysbyK+jvgx+8Uywsi0Qgb9T4axnZ?=
 =?iso-8859-1?Q?lNOJx0z7YYtE6U+nlqCJtfVYYn6jA2qN12UTQeVPoJFIRDauU6J1vTkxSg?=
 =?iso-8859-1?Q?74La+baXaLs39VT1ixhL5Br3DQ23niq1+gSWPF1W0aeV2fvYCNKzE4EG2k?=
 =?iso-8859-1?Q?rxipc5dBnjKY2f7RJbPrPiYHQPx3wG2o0ax2eRy4Cagm3902CZaRbHvXq2?=
 =?iso-8859-1?Q?2fOqy2FN4+9Vg4jxPOWT6lN+TYugLw7WfTIWw8nCXTwi2Tdh/InkhX6q/6?=
 =?iso-8859-1?Q?SjgX8nksnQ2NathEy664Iee7Xvn4V3H47kAfrkrirhvIVkxS/RMWHwm9DV?=
 =?iso-8859-1?Q?nvCaYmVi8occ/X0FbRqLq9+Xg3c+BaXEh9HTCs+CLni1X8xPl/jwURCF35?=
 =?iso-8859-1?Q?PjhOFt+cFXTC/JvspPwMy38VP9pyK40yNRG0726b26o97E43anNaHg5mdr?=
 =?iso-8859-1?Q?/ZgcKC35OZU1pyPvlMFIPJ5XUYCXq/lWL2f4raQgBP9Q4qdoDe5mX9wMVF?=
 =?iso-8859-1?Q?lOQTvvZ4eM4ezMJFZ45/olZWfOYY9O2SmN01R75/V5j2K9M3tY2c57MSh4?=
 =?iso-8859-1?Q?7xvZFsEs+jsS4ZV6iT+C24AjSS41QsFZrhetU9EZB9b9yEJjKH73I9G2+l?=
 =?iso-8859-1?Q?acIHrTD85Pb9RZjO/K3tZ/Muf6o8FpWpR+6Mt9UrScN38OI6bf7SjVzl81?=
 =?iso-8859-1?Q?SoD0QvcO11csIJ9ZCXFbHkssfTneTi145tFpp5BugL6AKxBo3LNB9GNXno?=
 =?iso-8859-1?Q?JSUlVkLCF8rWzDLW3rFjy7hf/2qE74TDubsTRwQEQS81iNxflCSIt2RLW3?=
 =?iso-8859-1?Q?lFtKtSJrG2+6dM0AURkPl9BlCzIjvzAunoXazsAO9tKjHtoQJaWT0Q8YgA?=
 =?iso-8859-1?Q?E+BfdWmlqNGR7cYd4eHUe/kfcwdWIXmALzrpQHtyQFfBZonvTH5Ri/R+zm?=
 =?iso-8859-1?Q?c7yfbvmIz/IAFMT+JVextOQ8XHUjS17tpPffIt5ukH4F1Jp4fjemwqO1UT?=
 =?iso-8859-1?Q?DpQlsXo3cgwbwkS+XOgLDnfFi5Xf0IlAAsHKERzTbpP7zD2gw88Ckc/wmf?=
 =?iso-8859-1?Q?LqBr2eoRH5kxtggq58C0Ik7y73eq61uSJ9SA8C3i7UHpvGccL9h/OOp9+T?=
 =?iso-8859-1?Q?GeBnWJtbyPx8C/W8nbmhg9n0iG/jCaAVdedO/GrRxXNFeCfM/zPo4XGJby?=
 =?iso-8859-1?Q?9jiBl5fLgNYFSgnzDsBiBdeYRLxAwYc/9KaV9FMNHSmbV0AJIdqP0zPLlP?=
 =?iso-8859-1?Q?Mw6nnVJQxisYW8MQb5AqMB1wksp9d7xvp+9teOKsmnvUflHa5LeV0VhfBe?=
 =?iso-8859-1?Q?tdb7TrJ6cQnsJRhuayds0s6gZd2LVnAuSgnJfmWejLZo1frpyqI4ZDwwWZ?=
 =?iso-8859-1?Q?leBYA06V3+izF191tH0HaEl31M282UK1EeSczE7cXNaup/LR43BwQVGhwq?=
 =?iso-8859-1?Q?/k35kFN14iHecB1Z9XycPk89Da7JS5VE+G6wChs5zcVUvWH0ke8/LsUqK0?=
 =?iso-8859-1?Q?+uieE01WPEoMah/ToP8USwcW4HrydqWpk3Pq2QBT2WLjRE8DPHQ07ZpCci?=
 =?iso-8859-1?Q?Nm4r+w9F/r34c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68bf0ef-1439-41da-9eb4-08da5fa26b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 22:54:01.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgXceTcLqwJ9X0P6EOUkai+OZuU0wFPSieWR95C8bIbiMz5+4Ny8udaZdhSPCft580KPFMsgfuABAwV/hAHlfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2883
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I was running btmon through pcat to avoid running out of space on the devic=
e.=A0 I think this was causing packets to be cut off midstream at the end.=
=0A=
=0A=
Here is the btmon output when turning scan off:=0A=
=0A=
=A0 =A0 =A0 LE Extended Advertising Report (0x0d)=0A=
=A0 =A0 =A0 =A0 Num reports: 1=0A=
=A0 =A0 =A0 =A0 Entry 0=0A=
=A0 =A0 =A0 =A0 =A0 Event type: 0x0010=0A=
=A0 =A0 =A0 =A0 =A0 =A0 Props: 0x0010=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 Use legacy advertising PDUs=0A=
=A0 =A0 =A0 =A0 =A0 =A0 Data status: Complete=0A=
=A0 =A0 =A0 =A0 =A0 Legacy PDU Type: ADV_NONCONN_IND (0x0010)=0A=
=A0 =A0 =A0 =A0 =A0 Address type: Random (0x01)=0A=
=A0 =A0 =A0 =A0 =A0 Address: 06:62:7D:C6:64:48 (Non-Resolvable)=0A=
=A0 =A0 =A0 =A0 =A0 Primary PHY: LE 1M=0A=
=A0 =A0 =A0 =A0 =A0 Secondary PHY: No packets=0A=
=A0 =A0 =A0 =A0 =A0 SID: no ADI field (0xff)=0A=
=A0 =A0 =A0 =A0 =A0 TX power: 127 dBm=0A=
=A0 =A0 =A0 =A0 =A0 RSSI: -68 dBm (0xbc)=0A=
=A0 =A0 =A0 =A0 =A0 Periodic advertising interval: 0.00 msec (0x0000)=0A=
=A0 =A0 =A0 =A0 =A0 Direct address type: Public (0x00)=0A=
=A0 =A0 =A0 =A0 =A0 Direct address: 00:00:00:00:00:00 (OUI 00-00-00)=0A=
=A0 =A0 =A0 =A0 =A0 Data length: 0x1f=0A=
=A0 =A0 =A0 =A0 1e ff 06 00 01 09 20 02 74 f5 eb a3 76 9d e7 b5 =A0...... .=
t...v...=0A=
=A0 =A0 =A0 =A0 11 e6 85 a0 41 ca 09 4d 27 f1 f6 dc a5 5f bc =A0 =A0 ....A.=
.M'...._. =0A=
=A0 =A0 =A0 =A0 Company: Microsoft (6)=0A=
=A0 =A0 =A0 =A0 =A0 Data: 0109200274f5eba3769de7b511e685a041ca094d27f1f6dca=
55fbc=0A=
@ MGMT Command: Stop Discovery (0x0024) plen 1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {0x0001} [hci0] 159.216816=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
@ MGMT Event: Command Complete (0x0001) plen 4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {0x0001} [hci0] 159.220056=0A=
=A0 =A0 =A0 Stop Discovery (0x0024) plen 1=0A=
=A0 =A0 =A0 =A0 Status: Rejected (0x0b)=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
John Klug=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: John Klug=0A=
Sent: Wednesday, July 6, 2022 5:23 PM=0A=
To: Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>=0A=
Subject: [BUG] Extended Scan Hangs =0A=
=A0=0A=
Bluez5 from master on 27 June 2022=0A=
1d6cfb8e625a944010956714c1802bc1e1fc6c4f=0A=
monitor: Fix crash when using RTT backend=0A=
=0A=
=0A=
Kernel:=0A=
5.4.199=0A=
=0A=
After turning scan on, after a short time it hangs.=A0 Here are the packets=
 to start discovery:=0A=
=0A=
< HCI Command: LE Set Exte.. (0x08|0x0042) plen 6 =A0#1777 [hci0] 11:06:02.=
731748=0A=
=A0 =A0 =A0 =A0 Extended scan: Enabled (0x01)=0A=
=A0 =A0 =A0 =A0 Filter duplicates: Enabled (0x01)=0A=
=A0 =A0 =A0 =A0 Duration: 0 msec (0x0000)=0A=
=A0 =A0 =A0 =A0 Period: 0.00 sec (0x0000)=0A=
> HCI Event: Command Complete (0x0e) plen 4 =A0 =A0 =A0 =A0#1778 [hci0] 11:=
06:02.741529=0A=
=A0 =A0 =A0 LE Set Extended Scan Enable (0x08|0x0042) ncmd 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
@ MGMT Event: Command Complete (0x0001) plen 4 =A0{0x0001} [hci0] 11:06:02.=
741819=0A=
=A0 =A0 =A0 Start Discovery (0x0023) plen 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
@ MGMT Event: Discovering (0x0013) plen 2 =A0 =A0 =A0 {0x0001} [hci0] 11:06=
:02.741899=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
=A0 =A0 =A0 =A0 Discovery: Enabled (0x01)=0A=
=0A=
=0A=
After a short time and 1215 devices found (0x0012), no commands may be exec=
uted:=0A=
=0A=
bluetooth]# scan off=0A=
Failed to stop discovery: org.bluez.Error.InProgress=0A=
=0A=
btmon output looks stuck.=A0 Often the output stops in the middle of an eve=
nt:=0A=
=0A=
> HCI Event: LE Meta Event (0x3e) plen 41 =A0 =A0 =A0 =A0 =A0#3484 [hci0] 1=
1:06:13.493567=0A=
=A0 =A0 =A0 LE Extended Advertising Report (0x0d)=0A=
=A0 =A0 =A0 =A0 Num reports: 1=0A=
=A0 =A0 =A0 =A0 Entry 0=0A=
=A0 =A0 =A0 =A0 =A0 Event type: 0x0010=0A=
=A0 =A0 =A0 =A0 =A0 =A0 Props: 0x0010=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 Use legacy advertising PDUs=0A=
=A0 =A0 =A0 =A0 =A0 =A0 Data status: ^[[0;32mComplete^[[0m=0A=
=A0 =A0 =A0 =A0 =A0 Legacy PDU Type: ADV_NONCONN_IND (0x0010)=0A=
=A0 =A0 =A0 =A0 =A0 Address type: Random (0x01)=0A=
=A0 =A0 =A0 =A0 =A0 Address: 0C:7D:02:DB:5A:57 (Non-Resolvable)=0A=
=A0 =A0 =A0 =A0 =A0 Prima=0A=
=0A=
Note that "Primary PHY" is incomplete.=0A=
=0A=
The hang during scan happens 100% of the time.=0A=
=0A=
=0A=
=0A=
John Klug=0A=
