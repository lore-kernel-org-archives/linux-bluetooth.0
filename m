Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8491BC6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbjH3SyL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245426AbjH3PO1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 11:14:27 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A83E8
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 08:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvdTMdoHDIpgvQz52+JObx13uBuZamKUjCsvN9F9JF+WJmCP6Ky+SceiAqNQNk+vrz1BVSNGE3v0XVtSmAF9zFmtlenlPjLeo50Qh0jIVnpbMEl67WZoT9ZCCG/vxnIptms0AL322mz5VXfIKomw0Ta2PExwgpwukrJsAQnkZ4k1V0KQmmXVViD4ZlsnJBQ12AlGDd0fuAX4zPFMuyjv5UlAFaoBOanI2CKxEatsSpsd8LUXLwOfkym562zITw6QBL3rd8nIbBI4FgyWExD/SrrE4tIZ/mCp9d63RTOA1qGyaQ4sAIy/rrqdni/R2Y4TSbka0PuWJx4WhuNS/ZZwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otbqitD6T2SJLrjRnN63uNKrblv47VxymRqnvsNFWLE=;
 b=k7JR2U70F0hklP74TEAqcVgwXeVk7d1XYV/69gcOYqclhCqRjVP6clPC6rtw7dJ7FwkLUdN+frJdCGEzVbCVomWab8ES/jZ+yIxTkmZhZc4OEHLBxMqxWo1hTv4XCJGrNEOqi3t4dgyoOMqpsbPuJw46Bwrb5mogI1wZSpaaqOYCltgfzwK++4+xDYgmrcYs6VwSVD4tVgTteG7jqBNHGAMNeuG/4N+3h2ZkvfZpqGOPgioi31Ndnyqj1/nUYuiXN4Lmp/KE0z2GMBfOvWwEBPldz46Emsqh2MKc0IciEIAyDiyDxSUEDYXd9Igu7ge/mSQRq620qtuM6HFq9ZySjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otbqitD6T2SJLrjRnN63uNKrblv47VxymRqnvsNFWLE=;
 b=HMLpD+rW21Pu4KJ5a1bHq7GOAb+1HucCZH8N/afyNqH6cmojVOFg/GW3WR2Z5PSUSIQjpM/lkNdzpm9efxl4nVMh22pdemCnjwVAEoBy4ad69cKPjKGtoLvS32KSlabf3XLYTw8weO9DBnlJtW5bFKa6nF1VVI4mcM+ovIYidsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:14:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:14:21 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 2/4] monitor: Add decoding support for BIGInfo mgmt event
Date:   Wed, 30 Aug 2023 18:13:29 +0300
Message-Id: <20230830151329.477509-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZ+ncrqo64pEc9FSASaiScR=G-bBmAVEqYtU37JKn_v3Tw@mail.gmail.com>
References: <CABBYNZ+ncrqo64pEc9FSASaiScR=G-bBmAVEqYtU37JKn_v3Tw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a80243b-c094-4568-362a-08dba96bc967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dhx3a1ZGLSvRqbERJgoYXkpkw4xNr0IwOprU892WrRXEOEEvgmAapZVQY5PXyplHl0WVA7CWExkChHrqCLecxZXfxd+d5XsfJ2GxOX63CTowDRSns+pt1CCLzL62AGfsNULq/KT9XbbsRmZdLUYPJErOWIzT70q3HUCVz2RyGZ/Xlxc6X7eMLcH4vCJA7pfBJSXXkEW/kZTs+L6gOR2OMkctWD2zr1JaQePAws9Zhi8BDiqPfjD5q+YB+bTDHPpniwushhpLArPAt8gocY/KHB80iZmCtdIPsIIGBooKxNhQFRwdqLkQ5P4y2choDZTzJ/2Gead+u/BIlEj52PQ9FVGFlb9yYotpSmwzH80LC5NzcSM189rXvalYBgevOK6R4YWLJQXvwGH25atP33chdERSOHioG/LCHR9avyBZZrzWaSkaUBFUsJwFyCerQFMLpg3Pn7TFV6etkqjmxFGbqUbirZBG9/ji0PrR4PfANO9VO40fQVhats/y5hkEeqxlj0CjLmGWdUsS2QkiIREkt4i+SImmUiCub/aT1aNeTX3TXQ8729mQkTR/lM2qgG7JqV66zHDvSxs22vPzV99XcdPhg6us6/UGC6aR2ydzutgEohqVj9W3qPN8kne0F2NE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(2906002)(5660300002)(86362001)(36756003)(44832011)(38350700002)(38100700002)(8676002)(4326008)(41300700001)(8936002)(83380400001)(66556008)(1076003)(26005)(316002)(2616005)(6512007)(6916009)(6506007)(53546011)(6486002)(52116002)(66476007)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W2dQpzZLjgvCyk3rVmG6bNjIE8ML0XEgwjaCfoKLt6zvX2EcfvhB9OQ7e1Fk?=
 =?us-ascii?Q?8fItjC7wlb2Ae25OrBDiiqFV7tECBB3heM99rBU+ox013KRWVlrNqKsaeNyu?=
 =?us-ascii?Q?Uwb8pKmI1ocxhaZqBgb3MIOPmL+m7BzLBNxQPJWFGDkfQIUH1VBNuYE5ZC21?=
 =?us-ascii?Q?P2PUQn1j61KULwGB4sBT2mEs40vEfqMZsKYc2gl0y1O06n+9BHLHeuXoHpcq?=
 =?us-ascii?Q?NSpERr59wv0RNVjtyPOU3ZJ6yf5h9TnZq3ByKZPyZxQuJA7AOKZm3DI5mFIE?=
 =?us-ascii?Q?87HSRB9CczvCyPmZ2jJsaSfyV+7aMNDTzcL/nGv/5OXNzgC1JJcgGchxdyAl?=
 =?us-ascii?Q?6x3VQlJZdOjkoNwbZnooXk8qYYEqfDZmOlYMUKt99DVZA4uCUTLfXSy9kGEY?=
 =?us-ascii?Q?hgN93IOhqhpvqJEs3A4C9eMqJxdaOqjq0+Mbd4weaDSgKXuBdmowvo47PiW6?=
 =?us-ascii?Q?6tGl3vctkYwEphybZW16yobQ4sg4fN6buGBifhw5EtnfUNLPAQaJObejlLO6?=
 =?us-ascii?Q?TeffyEirqczc2rR7Xnp1mmfuZpX5rZ8cFG8pNboINikplSW06hXt/hcYnBNy?=
 =?us-ascii?Q?3pfr6jA0BfNdn4Kcd+GzKKv64lUc5T9Wp1Zdo1ivMpMlGxz6OL/NByvbCYBM?=
 =?us-ascii?Q?pHKdDCM9FQp6HnXCcCyB1zlZkdZtUK6LXQqTwilfDXzfjqVc70XW4CXHg6Fd?=
 =?us-ascii?Q?GltWhrlEPuEVHz6+GBm9Gb9vmknGl/IMJN5FqOkwYt7r/G4DMOekzbT80BP6?=
 =?us-ascii?Q?g0X+L5maSV/MY/p2aQRu8BnNmfBhl3RG4f1cpxo0eNxFM2MYW8vPYMQkjrlL?=
 =?us-ascii?Q?wwv0MHQSWlBeZltwZY+EnD8l79X32SJ1NbVwGy7sHWTWQGJ3VJ2Vzv5Rzoqm?=
 =?us-ascii?Q?fA0dDlglLPOtWibs0YQxu8cNimEMFVh6wVc6b2vB8gBJzlFSk7+JQP+vkhqT?=
 =?us-ascii?Q?NJLPzh48P3yoVUL+reyva1vYHyl408ToQ9Gjt6pv0KSia49BpaJtdsID4mp1?=
 =?us-ascii?Q?U9xKXYfzbs2GfIuwxoeB9Dzh3ZEW39zEtZ5/6lT+j0G/b/XLC41vQiU8CyZO?=
 =?us-ascii?Q?dffpfZ0rI8Cl5hbxUKaAqhe85dF1fyRPIDlxw8WDoOdY118vuuiJYQTlHv8k?=
 =?us-ascii?Q?g+8zDMv5ZNIFf/F++pBlOYqHorjjiXH3baFUATAP2OTs7YdJj7pqGv76Zdv0?=
 =?us-ascii?Q?5tgGEhsCzE5P+P/U2aZAIhUSG0bCHm8VNydMTp6IkmPhz0QDOvidzaNbg2sq?=
 =?us-ascii?Q?gBNnSY4TEYaqNN2bDwhYZ/cqq1t0UaNVsfPTx0ove6N9c3oazS8HVU6nUeEi?=
 =?us-ascii?Q?B0zi6qWxPVN9VnUtm3jz2EVtOWCuF9H0uw41wQZj3FEl2uJenh17BNmdtW2b?=
 =?us-ascii?Q?SaS0NhBSGnleWQmFA3RxjOEXfzOcOIV8JXNExq0XYn+Wta8IeMIMqlOYXtd/?=
 =?us-ascii?Q?tLPSRC/HSL5knOwpBroe+4/9aDe17WX1r04rqcmfMhfpOtjeisDA8/QuXdK+?=
 =?us-ascii?Q?wwK0lBLJ1Kmn6WRdI6FzB2Q4spdhU/JLyNiZlndNharQE3rpdzGd0Fjz+BS5?=
 =?us-ascii?Q?xVZOoCE8jdQrBJygaBwNeWXpuDcFO09B2gSC90QlSPkdFQzznNitulu29D+9?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a80243b-c094-4568-362a-08dba96bc967
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:14:21.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYwhjZxcNdXdv9yoEOGObqvfiJczo9jADpRJWC6XhovgckSjX3AfanSNTLwKTantkxCmrGuIZd0SXFO1X2n8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Friday, August 25, 2023 11:06 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH BlueZ 2/4] monitor: Add decoding support for
> BIGInfo mgmt event
> 
> Hi Iulia,
> 
> On Fri, Aug 25, 2023 at 12:41 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This adds btmon support for decoding BIGInfo MGMT events.
> >
> > ---
> >  monitor/control.c | 25 +++++++++++++++++++++++++  monitor/packet.c
> |
> > 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> >
> > diff --git a/monitor/control.c b/monitor/control.c index
> > 009cf1520..b843d076f 100644
> > --- a/monitor/control.c
> > +++ b/monitor/control.c
> > @@ -5,6 +5,7 @@
> >   *
> >   *  Copyright (C) 2011-2014  Intel Corporation
> >   *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> > + *  Copyright 2023 NXP
> >   *
> >   *
> >   */
> > @@ -788,6 +789,27 @@ static void mgmt_advertising_removed(uint16_t
> len, const void *buf)
> >         packet_hexdump(buf, len);
> >  }
> >
> > +static void mgmt_big_info_adv_report(uint16_t len, const void *buf) {
> > +       const struct mgmt_ev_le_big_info_adv_report *ev = buf;
> > +       uint16_t sync_handle;
> > +
> > +       if (len < sizeof(*ev)) {
> > +               printf("* Malformed BIGInfo advertising report control\n");
> > +               return;
> > +       }
> > +
> > +       sync_handle = le16_to_cpu(ev->sync_handle);
> > +
> > +       printf("@ BIGInfo Advertising Report: sync_handle 0x%4.4x
> num_bis %u "
> > +               "encryption %u\n", sync_handle, ev->num_bis,
> > + ev->encryption);
> > +
> > +       buf += sizeof(*ev);
> > +       len -= sizeof(*ev);
> > +
> > +       packet_hexdump(buf, len);
> > +}
> > +
> >  void control_message(uint16_t opcode, const void *data, uint16_t
> > size)  {
> >         if (!decode_control)
> > @@ -893,6 +915,9 @@ void control_message(uint16_t opcode, const void
> *data, uint16_t size)
> >         case MGMT_EV_ADVERTISING_REMOVED:
> >                 mgmt_advertising_removed(size, data);
> >                 break;
> > +       case MGMT_EV_LE_BIG_INFO_ADV_REPORT:
> > +               mgmt_big_info_adv_report(size, data);
> > +               break;
> >         default:
> >                 printf("* Unknown control (code %d len %d)\n", opcode, size);
> >                 packet_hexdump(data, size); diff --git
> > a/monitor/packet.c b/monitor/packet.c index 8eae8c9ea..96fc2662e
> > 100644
> > --- a/monitor/packet.c
> > +++ b/monitor/packet.c
> > @@ -15396,6 +15396,37 @@ static void
> mgmt_mesh_device_found_evt(const void *data, uint16_t size)
> >         print_hex_field("EIR Data", eir_data, size);  }
> >
> > +static void mgmt_big_info_adv_report(const void *data, uint16_t size)
> > +{
> > +       uint16_t sync_handle = get_le16(data);
> > +       uint8_t num_bis = get_u8(data + 2);
> > +       uint8_t nse = get_u8(data + 3);
> > +       uint16_t iso_interval = get_le16(data + 4);
> > +       uint8_t bn = get_u8(data + 6);
> > +       uint8_t pto = get_u8(data + 7);
> > +       uint8_t irc = get_u8(data + 8);
> > +       uint16_t max_pdu = get_le16(data + 9);
> > +       const uint8_t *sdu_interval = data + 11;
> > +       uint16_t max_sdu = get_le16(data + 14);
> > +       uint8_t phy = get_u8(data + 16);
> > +       uint8_t framing = get_u8(data + 17);
> > +       uint8_t encryption = get_u8(data + 18);
> > +
> > +       print_field("Sync Handle: 0x%4.4x", sync_handle);
> > +       print_field("Number BIS: %u", num_bis);
> > +       print_field("NSE: %u", nse);
> > +       print_slot_125("ISO Interval", iso_interval);
> > +       print_field("BN: %u", bn);
> > +       print_field("PTO: %u", pto);
> > +       print_field("IRC: %u", irc);
> > +       print_field("Maximum PDU: %u", max_pdu);
> > +       print_usec_interval("SDU Interval", sdu_interval);
> > +       print_field("Maximum SDU: %u", max_sdu);
> > +       print_le_phy("PHY", phy);
> > +       print_framing(framing);
> > +       print_field("Encryption: 0x%02x", encryption); }
> > +
> >  static void mgmt_mesh_packet_cmplt_evt(const void *data, uint16_t
> > size)  {
> >         uint8_t handle = get_u8(data); @@ -15500,6 +15531,8 @@ static
> > const struct mgmt_data mgmt_event_table[] = {
> >                         mgmt_mesh_device_found_evt, 22, false },
> >         { 0x0032, "Mesh Packet Complete",
> >                         mgmt_mesh_packet_cmplt_evt, 1, true },
> > +       { 0x0033, "BIGInfo advertising report",
> > +                       mgmt_big_info_adv_report, 19, false },
> 
> This should got to the ISO socket not via mgmt interface, that said we may
> need to do some changes to how we discover the broadcast, it seems we will
> need to do short lived PA sync to enumerate the BASE, so I think we are
> better of having the driver register with BAA UUID, initially this can probably
> be done in userspace so once it detects the device is advertising with BCAA it
> will attempt to fetch the BASE automatically and merge it into the bt_ad.
> 
> Later on we may decide to move this into the kernel as part of general
> discovery procedure and then merge the discovered BASE into Device Found
> event, etc, but I think it is too early to evaluate if that is a good idea or not
> before exploring if the short lived PA sync would work reliably, or if we really
> need a dedicated API for discovering Broadcasters.
> 

I submitted a new kernel patch, which enables a broadcast sink to discover
if the PA it has synced with is associated with an encrypted BIG, by looking
at the socket QoS.

> >         { }
> >  };
> >
> > --
> > 2.34.1
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia
