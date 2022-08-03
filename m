Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6636BC19F28
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 16:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiHCQCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiHCQB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 12:01:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23909275FF
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 09:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjj4w9H7bB/KnBc6s3RtTk6murz1TMDTpEEmFt3a8QCZ7ONwdx8CwNkGuGWtZvccEQkhfbIOPNZjlgzJEnOAQSTICRf+hAl5EVn+w0dWEVgudU2wkI0aE5b667Rz4LPq1Qe1CMTRRXZq63fBtn0Ujhfy5R8GuNK1EVe6vGrbXIQB/s+yjydcxFmbJa9TNn6UDp8TbpkmU8MXotWeObtPEvxeb9VIJ5CuFnspsOuj3+1kPxbKnQaZUeSELxA2j9w6UKKoptwMIJNV0jXiQPoE9NhXxdr3taLM4EnEpVyxvfnvC6dCATqHy+wDflhSR20rVKn1lY7ISnTjM3FvFHsy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGuW9DKEwNnIATLfztYWxs3N2ifhROSJCFYSFvW9tbQ=;
 b=R4nNY8Zv6YWLMWM3SMiAW9V/gO0osA8D6feoL5v93n/rDmVLqnWg1jstJAx2oz6aclXH2qBHslIhoKFS3CEJClag31N9Ajg2l1GGN4NWqIsta8vUzTRw2BKVYeBiCEXWsuz+rqsDXkoNQPKUKEnbc5+1aw/i6su0n4PMn/B6y87eeVILCOdlcMx08e4NmZrZd2nL9zyFXXcYKRpTqr/WCrkyorln35nTO933kQTtXNt/2feTd3JY4y6rXq5QPzMsZXXCJFm2JC92EwG/zZSwwpXNc2OaJEjwy7RpamwBHGT5/D3OXqVUFxwESIrLxxHJ8mWz/PAFqhnwiFkC9LtNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGuW9DKEwNnIATLfztYWxs3N2ifhROSJCFYSFvW9tbQ=;
 b=o0IhIiY6jWvh0kJvvshidbuAOhSVYWn/Z8SuK/1Iom2PfhXoSytCf51WGZnnEaF9vtvh68FQKCt+/DTi+4b8Jz0oebsAqc6CqW1Bu2E9dnslq1g4/8ZzkiHm7yPf1pXWWklTwYiLVJAUN0jCQiRxuw4xu4iavvUl60bxRQbQnXXaqg2fQ/F/JFP8eXwYq7gdP+cEyfbn/IvYn/f5t+p7r/to9s/sQQVZ9WTRJTzIEJg7oJoUS4UE7ZZxpLnuXr/1d13p3OlDKYUU/dsvsqZM1+Fibg/hxkBC6cM5HgmWT2IISK9BsgnRmYlbASLtGdVQO7gzJQSiCtaRqBwDv3cGvg==
Received: from DM6PR14MB3871.namprd14.prod.outlook.com (2603:10b6:5:1b6::20)
 by DM6PR14MB4185.namprd14.prod.outlook.com (2603:10b6:5:21e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 16:01:52 +0000
Received: from DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::253b:a801:a7fa:617f]) by DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::253b:a801:a7fa:617f%5]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 16:01:52 +0000
From:   Chris Laplante <Chris.Laplante@lairdconnect.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Chris Laplante <Chris.Laplante@lairdconnect.com>
Subject: Connection Event Length
Thread-Topic: Connection Event Length
Thread-Index: AdinUlfvqRD4wjaQRtuX4cXX500htQ==
Date:   Wed, 3 Aug 2022 16:01:52 +0000
Message-ID: <DM6PR14MB387122AE48F0A1870EDED496FB9C9@DM6PR14MB3871.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lairdconnect.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 139d0e6f-0c58-4e49-5df8-08da75697b52
x-ms-traffictypediagnostic: DM6PR14MB4185:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XASRUKzgTIcPi/4kAuuZbAmHrdMKKgenf9NohMBJyC3KYIXy4uxdbUoVlJVZoytIW6SFYX7Ji5Vs5e01vMyMh6tBLbNHa6EfIcPzymKhSz1xW6TAGVBwUSnh8RtnZseEgJuheUcCeOe7FZkhXue3CgSvjhCzqaejiqEVxl6pVlcxB6Jzw/w0amIi0MIoZXQGKHXFBe/PXT4y7Z03iS7F8VRYNv37VURfQFQLlKxoVjyTmKmmY8kNcu46Ph79GSiYhl9SL2kBxA/DwSYOMifN923tNy/b/sQNARA5027LjaO1tpAFYlh2r+6bGKBOA3/b4vs7+0FQtBzlf7YU0/f7pXWB/yWnBRhEqbxkE0/DmhbylnAKNJZnjoDPiM0E4SYmA78ECOg6MaB3BwATfLo3T1nv+7XCX7wMVLoo5n+SYG1CgGw11H65QEJAvFkoLtyn9w/nxrcutMjDEYqCLgJe27lKnR3Qv+9nRe1sGOQQRI60CkuWJbCyuvcT6ty128ZPwcFIkPmeOr6BdBCAbtyMgBdIdW2lYenZmfue1mmJ6F0SN/d5MIFrH12/Er6NvQq5mSVo74mAE+rXo+v5YTJm0MVXbi+/M+mlBPB/Ij+ej/6EN3Ah1e4FYY6vtX8udd/hmMuqWMEchWLgmocjN7JV2PVloVFnz6kL/5ve7UK4TKev77nxnFmnRAcRQTRNVgn+hVsJ0isGJw5f3M8JY49qSFAnB7rpsAnagh+Vzw/QEthSJWkR0tOYvxZTW9JyepcW0IBIpxy23gM5GwBAcZX6Ps4vpnANRHVPCKTU9vywFjOiqxicnNIffegsK+WgYRJf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR14MB3871.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(396003)(366004)(136003)(86362001)(107886003)(38070700005)(33656002)(186003)(7696005)(6506007)(2906002)(26005)(9686003)(38100700002)(41300700001)(122000001)(83380400001)(3480700007)(5660300002)(478600001)(66556008)(64756008)(66946007)(4326008)(71200400001)(66476007)(76116006)(8936002)(52536014)(316002)(7116003)(8676002)(6916009)(66446008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K61R9UKDrToAup0mIwhKjjgzqtlCp8MLEYigQbf6RDWrcLK8KFr+uy9qgDJe?=
 =?us-ascii?Q?Vgbo8dhXLnwvbRRlGOK+a6DSXEx9335d99+DlAryA8TxUf8cYJauXpZ3XHmC?=
 =?us-ascii?Q?ZEattypkwVYQTj9XLmaQo6Duj3IixVYGvfXL9WtDs9m+0dwuxmVPmEtyVMaW?=
 =?us-ascii?Q?EW1GQ0DBlRiE6w4UtcHu8CegwnQuYOGjLlUuWqWSaWfMpmjYOMuo8haO0EFY?=
 =?us-ascii?Q?hN26FJBlH2upev6cK5Ov/VaxncnMzey9ys/ZR8Nt4hNxI74DsPdSodJ0w3zU?=
 =?us-ascii?Q?J7OshRZ4oO38dnJ816MqikXfKA5eO8m4pHNibUsyfhCH56baeC7mRncJ6SrO?=
 =?us-ascii?Q?cyRaBUKfwKnPV9EPkzyJBEW0AjaWJZHCpCBoUmkcfmcMV+Go3gfX4XzGVf64?=
 =?us-ascii?Q?9/FZAz1x7vVpKsTFG21KvceckFWv+1MGnBF/pZZ+Uq776JS4KWl2JhHlD4hD?=
 =?us-ascii?Q?khX+sNCnArSGdykj2Tc47q5AuHurIZiTyqgO41xpMtK1+YuO6E+H5QFjN+oV?=
 =?us-ascii?Q?Y8OCoO76ycC4gc7qQVURCkiPj5G0iT2Dnw7XgVScXyKj7iJvmaLoF0MvGIfG?=
 =?us-ascii?Q?17qhUlhjdBESBSXfJYXgJJwohjAvhwLTm9s+i2vk8wOCSkrD8y3Hm/7Ixyen?=
 =?us-ascii?Q?uN618vfaQKI7T9AYYo+VaVd46xKQE94v97EectR59/f/6j8XJ0iSkURrjWaZ?=
 =?us-ascii?Q?+zP71hvFdjgpZ8bOYGaElLGkg3HCxwwa5vutOiQMr9KZDTBHCZSYX3E47FCm?=
 =?us-ascii?Q?JahUYcVfr068amfwqQvXaspYmRmAwSbQOiGoQYF6IH57iEX0FAJJY+3P/4IU?=
 =?us-ascii?Q?xZRe2Ob0qsFHfxWWn25rq9nu6XCwb9jyXkO5o5Q64GOZBmcAkSkexPwRwyax?=
 =?us-ascii?Q?z+Wzbs6u03p6t+ITNI50kxvq2eDMDP9y7vdnq8a+NwHWqPq5GAmO3SHzWd34?=
 =?us-ascii?Q?Iehn8ejzDFt15/uq9Lso99wfHvlaBBfZ3s1LqaiP7AY3FjkmWVNJHTklq48J?=
 =?us-ascii?Q?qdr1rl1Vgks7PBBpzl51khv2zXj35ORb3I5tzgdmZ8qITdK//SNkpGqQPB4O?=
 =?us-ascii?Q?MdYQE7OvPRK87+R9MGhlUoBU+xdd6u4abrNSXCC31+BCQnlZy2xbYogxn2bm?=
 =?us-ascii?Q?cUhN6ej93UEI4Yj1LpWlYQ5CIKvJ8ixppk05WDeIbJtt9zsg2gvGQcDvIBM7?=
 =?us-ascii?Q?YFtqrKWnRrsBcU2dRE+kH/HbVPDf1FrWJEpCxHOnOKJ3l6wxrztd145d1rZI?=
 =?us-ascii?Q?IWqHtfa7tSEMN2cXgdEnWzlPz/v+iCICvJAr/2utB4py3RCX6Zt9Q0hC3eQi?=
 =?us-ascii?Q?gFCICgSPL5tyebx3ivNpN8Cipwxnk5AILc4lDnc3yWFS+QGw5nKgu6uZa2HF?=
 =?us-ascii?Q?bkTIZ+g3IpHmuEQiOLJqoLecv5w6rQpskLvOxz2bM+CkB0dxTD4+Q5fssu/W?=
 =?us-ascii?Q?yNQMp2lCR1wChCq6/k9XQqv3tqjl+aIL5bX60kw1s5goVHeXA8S5xiSWhVjR?=
 =?us-ascii?Q?sT8zf1QhAnCS8xBbxn8QhZlCAyMw2XUY2ejHuUbwCedEQ/+pcMSfTlKetucZ?=
 =?us-ascii?Q?TXRlMGXkWofF0GSgRMoCM7y3AV+W2PPTLiypJb/ffSfp01Qdjm/movDoch2U?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR14MB3871.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139d0e6f-0c58-4e49-5df8-08da75697b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 16:01:52.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFpRdvuQNCQCCRckVU93lcr23uKeyjXBgl63khAu5CnRS487j2KcWKxXqRUbqJntY0qM7YjlW2m/1lVK1cvjREhtXkYBdIl/H2GltCuEf3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR14MB4185
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Can someone tell me if the Connection Event Min and Max lengths can be set =
in BlueZ? I have a customer using BlueZ and their throughput is less than o=
ptimal. It looks like from their sniffer logs that there is a single PDU se=
nt every 18.75mS connection interval. Looking at the mgmt-api.txt doc in th=
e BlueZ-5.64 release it doesn't seem the conn event length parameters can b=
e changed.

New Connection Parameter Event
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

        Event Code:             0x001c
        Controller Index:       <controller id>
        Event Parameters:       Store_Hint (1 Octet)
                                Param {
                                        Address (6 Octets)
                                        Address_Type (1 Octet)
                                        Min_Connection_Interval (2 Octets)
                                        Max_Connection_Interval (2 Octets)
                                        Connection_Latency (2 Octets)
                                        Supervision_Timeout (2 Octets)
                                }

        This event indicates a new set of connection parameters from
        a peripheral device.

        The Store_Hint parameter indicates whether the host is expected
        to store this information persistently or not.

        Possible values for the Address_Type parameter:
                0       Reserved (not in use)
                1       LE Public
                2       LE Random

        The Min_Connection_Interval, Max_Connection_Interval,
        Connection_Latency and Supervision_Timeout parameters are
        encoded as described in Core 4.1 spec, Vol 2, 7.7.65.3.

I am a novice BlueZ user so if for one I am not looking in the right place =
please point me to where I should be looking for this info. And also if it =
is supported please could you provide details on how it can be supported.

Thank you in advance!

Chris
THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY B=
E PROPRIETARY TO LAIRD CONNECTIVITY, LLC. AND/OR ANOTHER PARTY, AND MAY FUR=
THER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED RECIP=
IENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY T=
HE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY O=
F LAIRD CONNECTIVITY, LLC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE EX=
PRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, LLC.
