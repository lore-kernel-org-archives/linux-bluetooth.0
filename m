Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A831E92FF9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Oct 2023 08:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjJFI3N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 04:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJFI3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 04:29:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9E83
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 01:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIjk29jBmAjgD5qJaedWd+9XN9WkUyDA30M2U7l334FGWmUMn5oWDQjNOSgq4T4lUqbSjld7u7la6FklvSGdlEn2lIiz7SCaEB9nTlmeEj6yQS0fWcINvhYhHJBOODeOlKi4oPjrClGgv6WNB5BZW/Hs1t6J1EDt+pWyvh/0KWS53wEleSzo4LBIbgV8uP0WvGJtWVHO8o0V1JkQDAu9/LK/lN8nyOC1fcX+nbdbn7UAeHoKjkgoHKLLc8/O19prEO4mNmurwO9Y2JalGA/xJk3nUI2KL/KWbJLT2GuuDpY3l42gGtfEM8BAS4JMnbE3jezs5P/z/z1T/zmuU1GRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdD+Zwaqv8vrG2kq2vOTUgFJYqOZuKu+nivSuRyR4ls=;
 b=SFbzgBlvSyjpJahPF4owEE0o94Rv/dzBfvaOW4CE3yo3uHx1l3nm2SQ/DYtjkhzUJaajh8iCmiP0szpJj1orIIYiPz2TRKKDo/tNT2xwRwqmo0vENMHdCFUh7BPlbQAJFhmsUAb83HNLe4A/PNFKebJ2IKQijob1/YgUxOVqn1lKTMuvz7F3W5yKS38FRt77t+yinyiPrUVSosR3J63QbLjyQF221oVXBTCnCVgEPlNKLGD0tRbBqvNsLVuCjZdBCmSDbEH28JRCafo8wCQC12uGsmMPkxtR8sw4/kTKBOxWXlPiOOppGS6Pr4F1Ccyp/o4ksi22NP3nyfIKCvvp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdD+Zwaqv8vrG2kq2vOTUgFJYqOZuKu+nivSuRyR4ls=;
 b=pUZubUDyqlzQgy/wdxqSuY+YTkpSWe9UjbjEYPAwHkxeyorOZNv6kdx0xtLcnKjDiPMxZ/FZpHiYpT+d/GYH5kdsWvVkri5cuv0jpwukuN6jpcu6hYqbkNaYDpYMYnqwrFeNCwq4ksChWAXc+nnoVqsbGmPxmXfL1A0V1TrBPKo=
Received: from DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 08:29:05 +0000
Received: from DU2PR04MB8646.eurprd04.prod.outlook.com
 ([fe80::34a8:afba:3750:c308]) by DU2PR04MB8646.eurprd04.prod.outlook.com
 ([fe80::34a8:afba:3750:c308%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 08:29:05 +0000
From:   Devyani Godbole <devyani.godbole@nxp.com>
To:     Luiz Augusto von Dentz <noreply@github.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Mahesh Talewad <mahesh.talewad@nxp.com>,
        Nitin Jadhav <nitin.jadhav@nxp.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [EXT] [bluez/bluez] d4a0d2: build: Fix missing file
 unit/test-micp.c
Thread-Topic: [EXT] [bluez/bluez] d4a0d2: build: Fix missing file
 unit/test-micp.c
Thread-Index: AQHZ9+6n95NEI+oxi02vpk55xoyUNbA8bgFQ
Date:   Fri, 6 Oct 2023 08:29:05 +0000
Message-ID: <DU2PR04MB8646078FF5B8975F479D0C24FDC9A@DU2PR04MB8646.eurprd04.prod.outlook.com>
References: <bluez/bluez/push/refs/heads/master/0a7496-d4a0d2@github.com>
In-Reply-To: <bluez/bluez/push/refs/heads/master/0a7496-d4a0d2@github.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mahesh.talewad@nxp.com,nitin.jadhav@nxp.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8646:EE_|DBAPR04MB7223:EE_
x-ms-office365-filtering-correlation-id: 9115e803-caf1-4da2-89c6-08dbc6464dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyNlr+5y/YbvXSD4DbDQCBtk8hkIz8pTbZWzNWyBUpWc63UG/EMSZ+IgFeCZvFpDQbVVFic9qHiynLsZbrnYTQeIpsMD17WcMmYDazU0T9bJpRDgLezzCiwS81Cx9rvyaTux0TyDOVhckgXVI+rMbkq10OoaqKbHFWJFjDAHUjvNYM7U27OEDyd6Ml8F/rdyqI58ZKyes98bqqTmdVRj6iDzKaGEGFRJ4gXmHxahFhdpTSJf6w8oBS2wG2YIfVvhpEjbsGTtz2RMdxYDMV2JFGwDIfKlh42tNd1EbFLM0fYorAerLt914Q/ShNnUbzGHoiLkO/7NdVhc9xa7JeKMY0fB9Qeo6D7AoI0y+pr5LOThuThBRhwB+TPaHzzCNromOgNKQ2F7hDePdhu7sMDD1hNd+WkQd9cmnaqoto21C5ySh2tTgOME1qPkp6v71jHO3wlhVUZ998Hqv365pqsBCJXfO0Wh1zWSlPArenrAzPr135NBbmaI8T0JkUnwZVJhKR0/G1Lh6EfA1sEDax/DioBb0kPbIVUPUxYKdbNjVOiWqOrth7kBk8/FtaC4pA1vJ8jVybBlFGh9nWfspPi44ulVsIEaEyGah/dQs+pAk8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8646.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(71200400001)(478600001)(45080400002)(7696005)(6506007)(55236004)(966005)(33656002)(53546011)(38070700005)(122000001)(86362001)(38100700002)(2906002)(83380400001)(26005)(9686003)(66946007)(64756008)(66556008)(5660300002)(110136005)(41300700001)(66476007)(66446008)(76116006)(52536014)(8936002)(316002)(8676002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8b3lIjAPyerpB7qTX2lduH2RXhH2FlOhWC7zecO31VaZ+K2QLPIhfdclBbKd?=
 =?us-ascii?Q?rEH/EKPNkgtFR6Wihmym102NfdtMhGMzI+l9UDXjinEXZBkzzjgAscpLe8qT?=
 =?us-ascii?Q?GluBI5vKQ+/Agyfj/TKjArjs16PYVQu7MDjdpleL2DhojJ47PzEiUXDamHi7?=
 =?us-ascii?Q?muCsZRQWWpA27jCffpdpU6BE4XfPMEUV89ttM8sAxBiQLMNc3om1tZ0YmkSl?=
 =?us-ascii?Q?b9Necp5o2Vxj+SCSPnxMPhwFi+zVKu4cPkLm6UvtkvcOSi7EqFs082S6V3WE?=
 =?us-ascii?Q?cESQ/6MQYPoKP2tuzBu4XOmX1rSnZobONsl+HuhpVwGqOWHptxq2ucUYuDVl?=
 =?us-ascii?Q?MFiLCxXsDtwlwbP80VePzb5WcxyJ0PTlY7dWnqKP2QSIf9W5+mPptFhbN/k7?=
 =?us-ascii?Q?fT39hGG8aQBBg4J/yZLO5pUav00uER6q+QDQqX18exNsZ8AqhspZK2R80t42?=
 =?us-ascii?Q?24ZNXQsnSeRifzkTDOC0LfQcsGudtU7UbQvMMusnT1cMB8tSlzmbmOLwtnJB?=
 =?us-ascii?Q?VcA8isrUxTzBOCSen6dxPHJq4LS1w49OXrEgO3mo+FtWiHXLIuEvKnO0e6on?=
 =?us-ascii?Q?oYiySC0ICqK8juHmkeNDZETPtE4Gc0g32ZJLypwkW83Xmnk2xcCH8k08Fjs2?=
 =?us-ascii?Q?n/34mxP4iRF/kRlODqzo6/7MYE/Ri0kmUnOXLzVm0vCPUlhgCKUdRDd3eJAj?=
 =?us-ascii?Q?xTTVSsW5ysu87bOmT+d82vpN3GLdWvYCw6Bm3EMj0vCeJZf7LA73V2SllYwS?=
 =?us-ascii?Q?/U7OVTZUkf7j5JizX86dTdSE5PwwViObDI867ET76drRYvAK7f+0EF05Vjrs?=
 =?us-ascii?Q?kbGZ85uv9ofEomPPNFHswhCWNz7nbETkpr6ByQM+ULfYvq5zhZX7kYHH6QsY?=
 =?us-ascii?Q?+4aXE+pgum+S+YjAcb4kTh0zvUMaJYP5g6be3YxIaJO51ABeSkAAPokR5QCE?=
 =?us-ascii?Q?yxeeiL4/mjCtPalDnK9PhT7mThUoTIpQw/MzdEskfEwSsAcDldalP1biTJr+?=
 =?us-ascii?Q?wX+SZHAEHjvUnoCsyYCDl8oW6xmprTyYieHjcAZ9kIkFnU5SS8kOm3RcbA/V?=
 =?us-ascii?Q?NAHaBh/2QFr4UH3EvVVwZratA4HbEZU886fwPWyQTC2PK3VZIFXTyfTbZNX6?=
 =?us-ascii?Q?gjmBcr5cAnix+ws0xKzY612GZ2mnRh2/q7ZC6vT9lAaFszSQsl1tnYqXdHYf?=
 =?us-ascii?Q?EsX5iftSR5hTUwYBMPQnjYsYKWMSp/z0gmsAypp+ekOnbMJrsCZp74sGfms3?=
 =?us-ascii?Q?93YtXRaU723oZi2i7u1OrLry2druc6w28J7u3vu/vNo7eaVXZjHMqOI2pplX?=
 =?us-ascii?Q?M2RqKMMV/xPamHtdJ/ecckMx8A9VEIDeTNZOqKKrNnAM3Znsd2fY7K+oBNLE?=
 =?us-ascii?Q?XMzEvrrrMYSO5tJs6HwVpJyJmY79KJLUVX7k2Jw1poHc6OQzwWgbClkBt6BQ?=
 =?us-ascii?Q?u1v8GZIO9GtmeK7wOdGasm31m7U4IQa1eXPBNzrGBlVhgwtMhPS02xpG6SoE?=
 =?us-ascii?Q?lWilGPZ+IDL/a3oZPHcqWBf4PxcZHqCz0kLIKfC1eYClY6gulZ0JFOUpabpy?=
 =?us-ascii?Q?KKGisxNpQCZjWwRP0xupRK6MQd4yrSktqdGqcIma?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8646.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9115e803-caf1-4da2-89c6-08dbc6464dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 08:29:05.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpgWf7upNglmtMkF8xB1QqWfC5VyJmYOHbHFs0FHy1aGl1aRyk9LGwQHF9V3IOhKNpjL8NP7dawj/+9iG37rOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

++ @Mahesh Talewad @Nitin Jadhav

-----Original Message-----
From: Luiz Augusto von Dentz <noreply@github.com>
Sent: Friday, October 6, 2023 6:17 AM
To: linux-bluetooth@vger.kernel.org
Subject: [EXT] [bluez/bluez] d4a0d2: build: Fix missing file unit/test-micp=
.c

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d4a0d223eaa5d220263be1f3ad0cd396869f6245
      https://github.com/bluez/bluez/commit/d4a0d223eaa5d220263be1f3ad0cd39=
6869f6245
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    A unit/test-micp.c

  Log Message:
  -----------
  build: Fix missing file unit/test-micp.c

This fixes the following build error:

make[1]: *** No rule to make target 'unit/test-micp.c', needed by 'unit/tes=
t-micp.o'.


