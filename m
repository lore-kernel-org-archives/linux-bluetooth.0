Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A261C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 20:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjE3Uzn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 16:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE3Uzm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 16:55:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315E99
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multitech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO4hKSwhPPj9A5if/BRBTeBIEbEKx/lJXvDhVkE2Grc=;
 b=IPkIg2TmQH6rr1qyitCb7JKG+GtET/BBjfbgerM108X2Ci6NYU0VCWGjJCpzpBdLBGnAGNhdHpso0jBDCNaKGWtOMsR5vjiHwHIKbQ0wkevD/tEDtI1cBX2pUyV6rLYvgMwHubbPPBgWquW1OHtn4L9Nce5ulhlGHZ6od4eOnyE=
Received: from BN8PR15CA0071.namprd15.prod.outlook.com (2603:10b6:408:80::48)
 by DM8PR13MB5077.namprd13.prod.outlook.com (2603:10b6:8:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 20:55:38 +0000
Received: from BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::fd) by BN8PR15CA0071.outlook.office365.com
 (2603:10b6:408:80::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 20:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.246.251.224)
 smtp.mailfrom=multitech.com; dkim=pass (signature was verified)
 header.d=multitech.com;dmarc=bestguesspass action=none
 header.from=multitech.com;
Received-SPF: Pass (protection.outlook.com: domain of multitech.com designates
 103.246.251.224 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.246.251.224;
 helo=ec2-18-222-80-210.us-east-2.compute.amazonaws.com; pr=C
Received: from ec2-18-222-80-210.us-east-2.compute.amazonaws.com
 (103.246.251.224) by BN1NAM02FT028.mail.protection.outlook.com (10.13.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 20:55:38 +0000
Received: from ip-172-21-2-244.us-east-2.compute.internal (ip-172-21-2-244.us-east-2.compute.internal [127.0.0.1])
        by ec2-18-222-80-210.us-east-2.compute.amazonaws.com (Postfix) with ESMTP id 4QW4RY6WXlzYcn6
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 20:55:37 +0000 (UTC)
X-Sophos-Product-Type: Mailflow
X-Sophos-Email-ID: 95040169d4b54dfd9e1b7a42e6b7e16e
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mf-outbound-us-east-2.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4QW4RX33d7zvPrk
 for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 20:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWhU8bYV8uxYuurjvg+JT+1gOM6JOOnIF6IdgVZboj00aNt8y1y8AwzkfG/5u5GG5NYtuSA8dk5It76rx+xQT2BOOwsdyp7A4b1NLQohJr1ijKGJdGjVd5a7z3aLpoKRsf2URNJH1qvarMLX9CIokQLiY3P/zqGNbuYFlQDMCUcOiwXgW9NKU9AqOapEEvsArSsVrixDHPPJpUK5tUi6gajanaU3I2irPC/TM8WFRj9zaoSirU2A9Ma1OkB6hu+KAz8+d5+6KXD1SsVafdWq/+uFGPBLD8bCnNulpF8FsV85fBuHoNPbSuft3uOeE+2xF/7wzvRCqzTSJD6tOTi1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO4hKSwhPPj9A5if/BRBTeBIEbEKx/lJXvDhVkE2Grc=;
 b=RDJgblIxAPTNuzAJGwGhyPCTeOPUbGe4mKHnJIBZ+qz5CouFC/qPMlxVwyXRJ6/yAKNf4MbK013aTsf2AMyIOv2jJej3dBqZjwGyD8fJ4735dMRbty6DovMppn1vdnD531cHZFirOa013my/E033OtXQY88g4xbOsEUlaBKn7sF8flRG9qU/CSYrrJmiDVOKPfbhxZmAaas2lLtJN4lIGkfniQLInU1HGGnykM1qtamuscOxWcEanRYdpxmdLBENcHRi4AGS6yRabF/VP6WgIVp0S7FDrSosQuXyzUbDPAhoWRxb6EFz+ZDyBMeLUHjTIdrQkleYS+GNtc8pdajgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multitech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO4hKSwhPPj9A5if/BRBTeBIEbEKx/lJXvDhVkE2Grc=;
 b=IPkIg2TmQH6rr1qyitCb7JKG+GtET/BBjfbgerM108X2Ci6NYU0VCWGjJCpzpBdLBGnAGNhdHpso0jBDCNaKGWtOMsR5vjiHwHIKbQ0wkevD/tEDtI1cBX2pUyV6rLYvgMwHubbPPBgWquW1OHtn4L9Nce5ulhlGHZ6od4eOnyE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685480133; 
 s=v1; d=mail-dkim-us-east-2.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:To:From;
 bh=TO4hKSwhPPj9A5if/BRBTeBIEbEKx/lJXvDhVkE2Grc=;
 b=D1LJdqFYyn8uDNa154j4ekjvYuvE85gkDfOfU45CPyfiE7+DwmffN85ciPp/DkKY
 2lqt1cy9iEY13ZfwoLI9QPwWrgKwSF0otFMNFJQEfiom+jRKoC0veC0LlCcnCKs7Q3B
 Wf/62FH1Lbvsyk3DcfNkMHEWG2PYaOjrpfgwq3bNTPBFEdZAOKfaXa/Hnl32pn+byrQ
 EfKl86Sbu4mjtttWcBsYkZ/n7B8Y8giDIyDeOA9O97yMxOuLrmjNYyqjmGk8TEVVhmy
 AIloD3xbfWkDr4zYJEwAsr232u0HWafSW+eiGCYsJTDcSCZke8n8vl87QVRkS7gFfyY
 ky5znS2zKQ==
Received: from DM8PR13MB5111.namprd13.prod.outlook.com (2603:10b6:8:10::21) by
 SN4PR13MB5310.namprd13.prod.outlook.com (2603:10b6:806:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 20:55:33 +0000
Received: from DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::6684:2208:6604:5962]) by DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::6684:2208:6604:5962%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 20:55:33 +0000
From:   John Klug <John.Klug@multitech.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: 
Thread-Index: AdmTORKiHNOcJINrQYKcvjpmVxZRcg==
Date:   Tue, 30 May 2023 20:55:33 +0000
Message-ID: <DM8PR13MB51113F4071035855E3AE61BAFE4B9@DM8PR13MB5111.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-traffictypediagnostic: DM8PR13MB5111:EE_|SN4PR13MB5310:EE_|BN1NAM02FT028:EE_|DM8PR13MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 419df274-5983-4e60-50bf-08db615038e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aMTA9e7hgI8ajn4wsH8lPQz6RmdYeIUiRt5hDaw5MC/s2PNL9kMxZw1tVwYY3DAql1sYu83MmaG4q9pM+wRJjRFTnIQe69Oj0H1plL8M+PoK4Z/uqSvWUW6ex5JSQu+pwZzmGQ5B4ExbSOtlA4OLFYMCM0EYoyRGIAOEh2kTCpwBJf5BdnMiuOxiNwjsamu2lvSE46zNkDaguJSoF0g0Qep2b50WaJpEtLFqs2mmvGPHcwB4xNCcusiefE05JqYcVB6NrSXYyDgpBnSQIBiATorkihJqdFCFv/rlLgcrTuDOia3xg5YlhdsOZ1jgwShs1Jgawvhv7qFegBljOC9BScd0yGzdZXGv3Mqpsy3xVtzQJOoYFFRinIGmcc6y4oPnUg+clzmQP093znq92aD6tecRiImWKaFBJC64DtuoatTa5j9XbNnH/aHEAPczPB/O2lqyd5JOkZBobz0JjalZelwzElFAfQT0CKqDleuNgfMzF/n3v+hYjRYqvTj6XVTUHbngq+RTMqCaQr58mloDtVIJUTEhqQhxmkMpc3IF+40CCrbh04h/yLfQM4EBgFzih+fNM5N2VJRWkoUJtRlo+AkUJvlNawEPxfqPodxobOsUCjSQfxZFMfwPYsm3MOgo/+W23/8kLYIYtp8oBDp6OSPwNJundO9qqlEq5s4XwC+hTCYBgGBI53yzj0pDB8N9
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DM8PR13MB5111.namprd13.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(346002)(396003)(39850400004)(376002)(451199021)(26005)(38100700002)(41300700001)(7696005)(186003)(6506007)(9686003)(478600001)(66899021)(71200400001)(6916009)(66556008)(66446008)(76116006)(122000001)(64756008)(66946007)(5406001)(55016003)(316002)(52536014)(66476007)(8936002)(33656002)(86362001)(2906002)(38070700005)(558084003)(19618925003)(1406899024)(239884005)(19559445001);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5310
X-Sophos-Email: [us-east-2] Antispam-Engine: 5.1.3,
 AntispamData: 2023.5.30.203018
X-LASED-SpamProbability: 0.091123
X-LASED-Hits: BLANK_SUBJECT 0.100000, BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODYTEXTP_SIZE_400_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
 BODY_SIZE_10_99 0.000000, BODY_SIZE_2000_LESS 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_QUOTED_PRINTABLE 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
 EMPTY_BODY 0.100000, EMPTY_BODY_NOT_EMPTY 0.100000, HTML_00_01 0.050000,
 HTML_00_10 0.050000, NO_CTA_FOUND 0.000000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_FOUND 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SMALL_BODY 0.000000,
 TO_NAME_IS_ADDY 0.000000, __ARCAUTH_DKIM_PASSED 0.000000,
 __ARCAUTH_DMARC_PASSED 0.000000, __ARCAUTH_PASSED 0.000000,
 __ARC_SEAL_MICROSOFT 0.000000, __ARC_SIGNATURE_MICROSOFT 0.000000,
 __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CT 0.000000,
 __CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
 __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
 __FROM_NAME_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_X_FF_ASR 0.000000,
 __HAS_X_FF_ASR_CAT 0.000000, __HAS_X_FF_ASR_SFV 0.000000,
 __IMP_FROM_MY_ORG 0.000000, __IMP_FROM_NOTSELF 0.000000,
 __JSON_HAS_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_DOMAINS 0.000000,
 __JSON_HAS_TENANT_ID 0.000000, __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_VIPS 0.000000, __JSON_HAS_TRACKING_ID 0.000000,
 __MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_32_64_CAPS 0.000000, __NO_HTML_TAG_RAW 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __SANE_MSGID 0.000000,
 __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR2 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NAME 0.000000, __TO_NO_NAME 0.000000, __URI_NO_MAILTO 0.000000,
 __X_FF_ASR_SCL_NSP 0.000000, __X_FF_ASR_SFV_NSPM 0.000000
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-Mailflow-Processing-Id: 5fd0b802135c4236ac6d3b1b2f1fd0c7
X-Sophos-MH-Mail-Info-Key: NFFXNFJZNldYbHpZY242LTE3Mi4yMS4yLjI0NA==
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0e50958a-b911-4793-0ea6-08db615035ec
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oG6d9rAcq1hOTPv0KFWCfDHGbvKU7qoe5CLtlY1fYilnINeIDD9TJ0AGE7g+baCMuVHWiGDAVoj18IyF1pg7tK3t4TCSxUjA1fStGW1oJp5GYTmlfQHt5Ip51q6joEd3U7sfqleCJATXm+OchfodEzB2zSkWAvJhLkTG876eBWmbUiKAhMovg6mBarRijQq47PeA83WJcBlxURww+h8ULokf0xE2zucpgs67cqak7x6CckzvIyWXOLCFFtKjm8Hs70S2D01DjuT4T+9QCUHO9AB9b6wXnOLpMLDHPu7MEryZACbAqtMD7gEemZHTjucOQg+tqjLO5c+BHr3tJPTjFhvtxzp5CNUSTtmi+4GFdVy18xVYyKboRnNyK2yvsWi7jtQlqvCg6jUqKcFFd0BbCx1Pzv3MNw35DautujcrhV5ootMqjJrGXamIPsHTZc7XJfCgyO/YmfeRqtfo/HEJT9QJu2tvyy9v68g3lkHTtusM3yGJ1LXrG9MhumpUL0lETQmS6kMGQkIJu3IhBEkcdJnt6NajwbaGRjcHEsmd9U9VM5j8sg3BQPzlHaiivgirffO+c4FiaS3ZXGJpXcYFrLxGlfk3+T+NqXno6xCSUgNdzYn/6k4+2Y8eVb4d5YSZefXXlO/kFmC3yWWcDr9sHGZFN+muf8CB6VhmVDRMmr6+0fkaI2TwNrgVcz/2rxIrN6M16uSFmy/3WfESSdTQMSOIrQYh3MiSO3Ey1MT+6BNjB8/Yt0LEtAWaHAwwFudKZDuTD4KXFxTFC2nQXw6knhBXeUWwUFRzp5UObFtRqLiwpbLeBMOfoViPc4xIn99flkBfIbqx8Gd8C9jmGa6NaOn3g0M6xkApVGahLIKxgHk=
X-Forefront-Antispam-Report: CIP:103.246.251.224;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ec2-18-222-80-210.us-east-2.compute.amazonaws.com;PTR:mfod-use2.prod.hydra.sophos.com;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39850400004)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(33656002)(356005)(5406001)(70586007)(70206006)(7696005)(41300700001)(558084003)(478600001)(82310400005)(52536014)(86362001)(8936002)(26005)(2906002)(55016003)(36860700001)(6506007)(186003)(9686003)(40460700003)(47076005)(6916009)(66899021)(316002)(40480700001)(336012)(19618925003)(1406899024)(239884005)(19559445001);DIR:OUT;SFP:1102;
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 20:55:38.2212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419df274-5983-4e60-50bf-08db615038e9
X-MS-Exchange-CrossTenant-Id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f802e804-804f-4d1e-b625-870b4d57fd00;Ip=[103.246.251.224];Helo=[ec2-18-222-80-210.us-east-2.compute.amazonaws.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5077
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UNSUBSCRIBE
