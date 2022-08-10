Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D26C00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 10:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiHJKCi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiHJKCi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 06:02:38 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10095.outbound.protection.outlook.com [40.107.1.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384B6DF85
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 03:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE73DJyp0Rt+TywdzNV2a+7CnfUh5XqCz4YVbR+pL6zZL/BjRyqLa4TKNcIGxysS6Vn/RFZ5rB4rKbxPhwXjQKvsoKOG1V1RyimbYzxMEwxwsyVS7ztuTSuzgNLRmZhMbzBpOY/E1XOou5foimTBEk8AoyPzQhRQ4ymswJApt8Pv7NeVQdHSFs19H20f+x0NfQ8e8sZW4YH6qdiriuG7EtwKT0iCHUjp2xr7jHWLGYH3gTyG0hsa9iLV7DHaaGPdBenxbxMuZ+OdxGCX1GsOO+7Ux7ngi9VffckFESugAHAkleP4siJeOhgoRJ+mZIhEWtv0ROs1feWHQHej4qjhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNzy1ONq4EFwtLdjBtNyTzoXguuMRPAaJS87dfz6iBE=;
 b=P/2EG/V4Iqbea7ozjYNJ3BGTHJISKDR1+MANbXnK26bE7VwzWf/zxDVFYqOLUJCmjFngnNxDjOOhJleTeAYW5e4V0JhfPGZKoDKB04BJijfJYlIdMe3aMByC6Z9A9HQFsHbWf5Ll10kuOX1jQwNGQfUWwnZYXu9Bzr9Z5M6Vma6RtCTar6yKhbKZUcGIyJSL9zFLRfyb9MXUu12DoYr8jkbbFJWA6AIRKwWDP3ktiJtrJbkp9+2wTqj6FsEin2YiEUA6M2JpigdZ71Gte/tDuZ2iDhkUoM6UDudhNClrMbGEHM3VcfmdPNSYCxCJvRVPAqvThYVCDNi6qjNepa1peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNzy1ONq4EFwtLdjBtNyTzoXguuMRPAaJS87dfz6iBE=;
 b=i2K+qkQStp6s6Ts8xF5XAnz+leuSP5lUIDknzTG4xT8vSeP2HzexICJ0P8Dgl2HMLHXSX/KHELDyf6cEg0R84EOU9mIzP0Yg7I5CNHT7oJ/5z0I2Wq0Wjwr5PAQ9cyak5tMT0BELcBShgyTPt/F3CDHsEk8hf3QaHDkZ+GPuHfA=
Received: from OS6P279CA0030.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:33::16)
 by AM6PR07MB4932.eurprd07.prod.outlook.com (2603:10a6:20b:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 10:02:31 +0000
Received: from HE1EUR02FT086.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:33:cafe::60) by OS6P279CA0030.outlook.office365.com
 (2603:10a6:e10:33::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Wed, 10 Aug 2022 10:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT086.mail.protection.outlook.com (10.152.11.240) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 10:02:30 +0000
Received: from n95hx1g2.localnet (192.168.54.119) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 10 Aug
 2022 12:02:29 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [newbie] How does automatic reconnection work
Date:   Wed, 10 Aug 2022 12:02:28 +0200
Message-ID: <2277279.ElGaqSPkdT@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.119]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e29c2379-1cec-4c06-7bd1-08da7ab77034
X-MS-TrafficTypeDiagnostic: AM6PR07MB4932:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFxp1kMCU9kK0FkiFEwlXPl/+5sCuN+VmSfFtUitwevyZOE3iwgV7tBKUwBRqYmppAALazWNJZ+2xOxyEqCcVu90hDn2pfaMCMLt/TRqM2ex1v5SKKb7//m2hDA63yCIUmM1XImLwuQ/iiaAPRQpP0YIql9J75L3ZFImQwFL0ioldJRcej4w0ZSVh36jOChDy5Vv2atZrWyW1PtQnCrF8ubd/OVQaYY9HAdRJsJUKNISnzva5JWFV89txVGDFOgTMP9W13xzB37v5xUYYsuzLJaaBjf6v3K+Qvw6RN4Qqqc0Lp+2HcWQNLUy509xkf6URmHnIutfIh2FlepLHcWEBbvzO9/21z/omS2QldNi0nZcxDhsupLHkDFOuiXs0c8vrPigORZLDsEcxtbN5m1xEfYRdzhKBw1/s2K9dXpsV+3h7KpQE17hTqzSfBuV1ZzEut+HwQULPBl/ZDbrLnES9HeVGLQUinF7WoJDXHGXBfmvwCD+Fb6+CtbCujSWcdcYq6WS+BfVsnnLbBav+Ta2Y/YOV5eTHd4uKEOjuRjdXxqU3uV+105loYTTOqqRvFsuzfQgtYbAH7VvHDkCbz4oD1O3iEmS9P8leWdTMNqcYrFero5EYp93djSG3T5nieeFKCZNDZTsCHj1rVjctGryQfuDk+D9BhCHz8R9lF1D/fTpaGqYfaLeM2LxATvP89k6iarYwU8eVwi9DMlYaL2QHrVQQ9qZYd9ldhsSEJ+mCQ80CrKh7sjUasgFqhGlyxqnQvLNIoWAfgyeF71pTOST8N+dsTdOLzHcS401DBWSEbe88SwLAKU9z3spEQpp+0ZMppr32C7brQzCqVJkgzRZfLQ+AUFK65y1SGB0gB4Pl96kIpnkYuE3gF3qrBXZUVYY
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(6916009)(316002)(478600001)(966005)(26005)(83380400001)(40480700001)(86362001)(33716001)(82310400005)(36860700001)(70586007)(8676002)(82740400003)(70206006)(41300700001)(81166007)(356005)(9576002)(8936002)(9686003)(186003)(336012)(426003)(16526019)(47076005)(2906002)(36916002)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 10:02:30.5656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29c2379-1cec-4c06-7bd1-08da7ab77034
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT086.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB4932
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Many Bluetooth devices seem to have some kind of "reconnect behavior". For instance
an audio speaker reconnects automatically to a phone as soon as they are within an
appropriate distance.

On the web, there are also many instructions how to troubleshoot problems related to
"automatic reconnect" ([1], [2], [3]).

How is this feature actually implemented? What do I have to consider if I want to
automatically reconnect my product with the customers phone?

In my concrete case, I create a BNEP connection from my product to the customers phone
(which acts as a NAP, Bluetooth Tethering has to be enabled on the phone). I would like
to automatically reestablish the network connection as soon as the phone is within an
appropriate range.

regards
Christian


[1] https://techwiser.com/fix-bluetooth-device-doesnt-auto-connect-in-linux/
[2] https://unix.stackexchange.com/questions/334386/how-to-set-up-automatic-connection-of-bluetooth-headset
[3] https://stackoverflow.com/questions/32288670/bluez-auto-reconnect-devices



