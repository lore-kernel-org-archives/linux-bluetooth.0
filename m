Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11765C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 06:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjDTGoA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDTGn6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 02:43:58 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B321FE4
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 23:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nawQuXypFBmbuSFmjWfjVORQ9KAUfnGLhCUUyObEYRskAukRXp13I4C13w0gTwxL2zyDbaGrI8w/hvI4Z3mLKBbreQ+NcYqmPYNTZVjiNT90cqZV39dd/RIEKl8Ype95YSDvxiA7+F2pIel/Nsry/SiYnV7Q8MNb0/T8B7h7/GejaMLpcfmSM43ZVpJnkhJV22QjBhwjauYPN7PSVBamzANQA+MEyqmw7nBsOYHtZpptp0e05aGGsbG4w++z739zHaH4xFq9ROPVJdQ3Ymvezk9gKdbeNULzS0dYMVIHBz1klaSFo/xYApBu0UKTHmJCVs5r9k+Xvlzjt/Pa5KPI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGpn8En82DT9IOLpGLoQzVN+cp71x1cSCKQLH9LzZ8k=;
 b=eDe8PywraKaNwsrW1RpHkLfva51LWyGXDUpDT/2+i9Y/gdNi+wyo24tIUYSlbNgp2+iyatiFlykxzqn+WaEr6NCR8hKNvk7Tuv6tNfen86RFk4uQEs/VxPGfo50Ru/aApoNZuC2uLukkC1u6DfrhMtXJ6pA05Dl7sB4S0fhJRVhN/gZb0hGQ/wxR5Gf4rVfzPfpQhOPHr4XhoMKxW+0rwGYwJrxAufqJIQlLk65jOVw095PPT0XYjfIa2N3y5HXn4x57IJVOzNqshHQX0HwAOoWRjy6TF0byMkyJhYDhisF6tT8C/1D4vlXnCAwYj8SW+eLgpj5qGjPFnBpb1/xAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGpn8En82DT9IOLpGLoQzVN+cp71x1cSCKQLH9LzZ8k=;
 b=D3FYiRnBXghuz5D6+D/wD68nzNx1v1o+HHhXp0BSCB+qy3H9WtWPtBxVzUP+oyRFVVzIPhdEkdCUCavQUZM+SQQzAuEXFguMkixtWKVHcpj1JlfkG1pXsKZGOveZC5SVRtgHcf75RD2+3h+VZQ1eySmncv95hBOn5QjzJWmKTPY=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PAXPR04MB8093.eurprd04.prod.outlook.com (2603:10a6:102:1c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 06:43:54 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49%5]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 06:43:54 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [v2] Bluetooth: btnxpuart: Enable flow control before checking
 boot signature
Thread-Topic: [v2] Bluetooth: btnxpuart: Enable flow control before checking
 boot signature
Thread-Index: AQHZc1N5usIzWUGwBUKcm+ln7YhWPw==
Date:   Thu, 20 Apr 2023 06:43:54 +0000
Message-ID: <AM9PR04MB8603E56E293979217DD74E91E7639@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20230419152413.1688840-1-neeraj.sanjaykale@nxp.com>
 <644010a7.170a0220.86a64.322c@mx.google.com>
In-Reply-To: <644010a7.170a0220.86a64.322c@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|PAXPR04MB8093:EE_
x-ms-office365-filtering-correlation-id: 029a997c-524a-4005-3cf2-08db416a9c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pARSi0kg2hWgFRAQ3BrzulgksI10vIjLNyo1NEfD2yMLdalWmlJJvdoDYxo94kh7/k1wlQipZkA8hwkArMAa0/QxW61tSBHtDyDi2n8k4vYfL6Xp8449IB72s+B4GnMgeoVkE9vZR6OE+h/3R9f8nZBYhZwjmAVHKe8RmWKDAA21t6EHpVkNSkhTNp9Nr20rnZezh4cIPm2HOmZWssLMDUEf+e/FGVrO1z9XmTqL2sdnyxFkKrOEvk7ghINHHCVQ8cR6AXRtz0MAnznt9XK9PmWtrsNbRr8ZX6ECrX/5WQJDR/T/x2+pj2T5CqOHmz37V3TLVa7Sw+yawwag96oDHuRZrFSBHC2TFerW7U+yKqiiIoRT9vvCykHd8Xi9U75AHCYLYNjL2ua5F9vrqrwdLAU8Lk5QQOi75FGMZ50hzWEk42+7sydTkawQa6+OrTQScR0JKMPnu3AOWj+tHo8o7hLbqY9YbXTblSfBEoSAePT/RdLSnIYYBNf7WjKE3Hd65R38fV+TisKIz39MfKvmygyjq18NrN276LlxejNyOYMe6VBfMkKIwmBTFaYAygDSNv1vIjZVc5cUepl2CTvTgTuts7JmfhLIW+h2Nz8uj65zfMHEOk46yvI68LlNCzLD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(186003)(6506007)(26005)(53546011)(9686003)(55236004)(7696005)(71200400001)(122000001)(86362001)(83380400001)(33656002)(55016003)(2906002)(316002)(4326008)(5660300002)(41300700001)(8676002)(66446008)(66946007)(8936002)(66556008)(6916009)(66476007)(76116006)(52536014)(38100700002)(38070700005)(64756008)(478600001)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m5tf65WqUd6hpDnq5iLYiK4+CHaSDvDyemy98bPaK9Re3+zMrHahc017vxDk?=
 =?us-ascii?Q?uXF52DO8f4CFswVHQsNCWk599++krq0GCGkTfAQ4f00QYyo5tR0Uadjj8jkx?=
 =?us-ascii?Q?SUXTX63ryZzMHgUUQf9rR2po4Hl1bQl6S7ZlMxZXLdJTQQoA0UTx6dUY5C3P?=
 =?us-ascii?Q?Z18dvaR34oULYbyGLzU4QsxER+0iD2VKluuSps/DlKDbB8w0K/TajhXZE2mO?=
 =?us-ascii?Q?itGl4vQ3f3D31OIJI5ePZexrNJTnKmDihZlTx72DLizfdaoHm0rEbDyQGdAx?=
 =?us-ascii?Q?aYVM8HtiB14wBsCQK3ytbEgB2d4oFfL84HvtSSiRNNCXUrZxfrj1U9MOavxH?=
 =?us-ascii?Q?Yq2d6rlpPUWD1AEEidOXO0BZhTFa5JNAwBeyvCB17zdbR5JpvYnaFsLCxQbR?=
 =?us-ascii?Q?cx/ZVrGKbfqfgQUl8gOQ8MYf0czLqAfJ5zmqKsUBSqqOWeTDDFtbpS4/Bu9V?=
 =?us-ascii?Q?ws+r55lT6Cni5BapXTwipRC3kK09pTY2jy50pSpJjPTtF4oL7UklLLMU7U57?=
 =?us-ascii?Q?9cy7PoifBp9GOu7eAKLTRwI6mVbtNu69bJqGKbHCapDfuSwH44Qz1+UYqdro?=
 =?us-ascii?Q?W12MsXySFzA/eNZY+nnMtz/mHq5GZ4s8tQ9mnIpJaZ+ySFbuPfZuEwYneYi3?=
 =?us-ascii?Q?CWojD7TImD4I0NDSXMtHjmY3/wP+GndxZafFaMkutZk2Q2yMzPzGjFnzQ2lE?=
 =?us-ascii?Q?njdzClW6TaXaAHfE8Fs94D8UBdvAqOLErlphbUB0duSS+l5d3v5b/uVX1LL3?=
 =?us-ascii?Q?SW+XvydAVTiVNjZI4r6+b4PsxyyZtFyM3RhOC0S+qerJQBTHLpKfYAgygFgV?=
 =?us-ascii?Q?ufCvpqbmn8nAKztphWjwnSA6LeVlf65amonPDV6f8zSne4Ht0f3Ym2rD/7vg?=
 =?us-ascii?Q?cpFEiuM4zX6kzpnWgQtr402Uq727K1RCT0UD+EO2o9I2ewKUVxh9Rx8d3Xb6?=
 =?us-ascii?Q?fa9tn2QVz65I9GTnmuy5OEVEEmnzpmRb1W8yY1hfi9UuJhdIZp3DbCL7siSF?=
 =?us-ascii?Q?OO8U1uhd+y/OUxG3gtmsYiN5h7z1DhuBNHzowmmRyx6fxYvaUSy/xONEDR77?=
 =?us-ascii?Q?fohU5gkuPWiHzDrxZQJChWDsnR7bam2JlxpfufMb5FaCdqHPZ2CRY+USKx01?=
 =?us-ascii?Q?w8JKb9QCETQ5+KSjyLwOFhfPSf0hDsGBB/ZGF0evDFYZMUpM2OXGzc8tDm1j?=
 =?us-ascii?Q?Q3qlpqO/vXe5U6Ta07Cu6juwoM5qFWFXprwO8TD0MKqJPfNDSFP5Qm9pwli6?=
 =?us-ascii?Q?la51BP45YIF68+3/hpB3FatUDNoHy4ZI6ipwxNYyzEJCEfG22FAYBHN/aAMz?=
 =?us-ascii?Q?N4Kpu+qS4f3ezoODSmgpkM6s3WdJ8p2VweJL0Ylu4X8ARdhnA4MLM6AwLXIm?=
 =?us-ascii?Q?GqJEFGCk1OSO4g6CM4wTqZRmkznrJ3OBMqKiSat2WstpPJ669VglTDx7ZuJP?=
 =?us-ascii?Q?zJJNAZ54zujqzO89cZjFuAsWbxAL4RiiF0Jhn0HbIopMtQBcrF1eUncigCFe?=
 =?us-ascii?Q?DnMP0Es1u91H3seHDgN5b4CpwpJGak1DzWimujhi3CfB8/u2H87EzYLSD0Ae?=
 =?us-ascii?Q?wNgwBu6/qqbv+RsGlK+MzXqs+7J80hbNLlXYNXXE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029a997c-524a-4005-3cf2-08db416a9c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 06:43:54.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2R75rzXCn4CJz2nyjnFVVYYBygeiDHThJKT0Xu4OVTofW0Ciu4srz1fzvI7Ui0Y447HCsV593Fb+9K1nMQAkzKBNe/TxlBXFk3YokbiwFRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8093
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I have already rebased my local repo and re-sent the v2 patch which has pas=
sed CI.
Please let me know if that's okay, or I should have sent it as a v3 patch.

Thanks,
Neeraj

> -----Original Message-----
> From: bluez.test.bot@gmail.com <bluez.test.bot@gmail.com>
> Sent: Wednesday, April 19, 2023 9:33 PM
> To: linux-bluetooth@vger.kernel.org; Neeraj sanjay kale
> <neeraj.sanjaykale@nxp.com>
> Subject: RE: [v2] Bluetooth: btnxpuart: Enable flow control before
> checking boot signature
>=20
> This is automated email and please do not reply to this email!
>=20
> Dear submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW
> Link:https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
p
> atchwork.kernel.org%2Fproject%2Fbluetooth%2Flist%2F%3Fseries%3D74139
> 9&data=3D05%7C01%7Cneeraj.sanjaykale%40nxp.com%7C79951d698881465b8
> cdc08db40ef861d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 8175169714039256%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3D6aDUcH5b18oDWqwCqW09yxvE4lMa%2FlnMwcJCbOSq5Kc%3D&res
> erved=3D0
>=20
> ---Test result---
>=20
> Test Summary:
> CheckPatch                    PASS      0.65 seconds
> GitLint                       PASS      0.26 seconds
> SubjectPrefix                 PASS      0.06 seconds
> BuildKernel                   PASS      43.02 seconds
> CheckAllWarning               PASS      46.60 seconds
> CheckSparse                   PASS      51.84 seconds
> CheckSmatch                   PASS      138.05 seconds
> BuildKernel32                 PASS      41.38 seconds
> TestRunnerSetup               PASS      573.80 seconds
> TestRunner_l2cap-tester       PASS      20.80 seconds
> TestRunner_iso-tester         PASS      26.49 seconds
> TestRunner_bnep-tester        PASS      7.21 seconds
> TestRunner_mgmt-tester        PASS      141.73 seconds
> TestRunner_rfcomm-tester      PASS      11.55 seconds
> TestRunner_sco-tester         PASS      10.92 seconds
> TestRunner_ioctl-tester       PASS      12.47 seconds
> TestRunner_mesh-tester        PASS      8.81 seconds
> TestRunner_smp-tester         PASS      9.86 seconds
> TestRunner_userchan-tester    PASS      7.63 seconds
> IncrementalBuild              PASS      39.02 seconds
>=20
>=20
>=20
> ---
> Regards,
> Linux Bluetooth

