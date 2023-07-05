Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F0C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 07:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGEHkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGEHku (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 03:40:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20728.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::728])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3ADE41;
        Wed,  5 Jul 2023 00:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZWYsl5tZzLJDr7NxsaEHeK6rBId0GNMhU+46oaFNatWYLhnMCwRvb8IEZZhV8YYACuZkSzPsLT6Bx7MEnX4zuggfKqTpuEEbfCRe7IIzLSRrUMvMqZedSRstVwVxtwJAylGL0kwuxwWSB+z2MOe4A+j2EjGLXQbhvSspmYEPIi8tGOeM9NvwnyTXKnjFdva2DUSBFwOk+KPnJZThrUT9TU9H/anzNMMZOsNQ/wvnc/yHmirfuMsnkCbd8nCx/dvuarfjgV8kehRIaB8wSXMzA8q/yaA1hNxmXKuxZUfDBdjVIozbmvqje7zQJ9B8ai15do1Hw0XBj7Zn67dPhPPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndG8I1dEgxLKRzPAqFQJKtGwh9cytzriU4U7AGSaHEg=;
 b=Y5gv6mMw7DB7Ikj3xrl5G14v+zfIl7Oc4b8uqcRBraPzZzEdsG2ETioj8Eymo7MhRHXNc3dRjtVubckdVJnz+w0gXqbp1cx2rKwVoSDMaRsIguvuRw140rUnMANhZrDvke9/Zyp7TVRL/7xvPMysidzYXPf2DaAvlqmHBoRcGm3HHp6nILSUMF2pWUsyhhPGRaT0wsE7I3jD2CUVpHCiO5Z+1gFOeIPaLhAj9HiuB9ro0dVoWmZRAwCEwwVYBYCh6FUcKZbwpRt1XyD3t6A3GdW3f4PAXqHCZIKe/MVjFP1UUNwXkzF1Sd2gvsfkNl23fIULdUADfSw3M1+Bk2W+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndG8I1dEgxLKRzPAqFQJKtGwh9cytzriU4U7AGSaHEg=;
 b=TApghh5YmR7hg4WMjwscjxh30/aiCqAPQ4nhTuypcGTXnkufRlatOKjar2B3RoBDI3xRrctUSdiGXmdADtKFXiaiiD3iStUf6nDtMA0rrB/FPKf/tDZsXCFDaZw3A50siW/4i9u2XxcDVdg0rrVZ5qmsTtBg97qV+o+GRPFQSoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DS0PR13MB6175.namprd13.prod.outlook.com (2603:10b6:8:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Wed, 5 Jul
 2023 07:40:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:40:44 +0000
Date:   Wed, 5 Jul 2023 08:40:37 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Hilda Wu <hildawu@realtek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alex Lu <alex_lu@realsil.com.cn>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: msft: Fix error code in
 msft_cancel_address_filter_sync()
Message-ID: <ZKUedXk6uTLqDff4@corigine.com>
References: <be155fef-7758-41b2-a6e8-8f7e253ff452@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be155fef-7758-41b2-a6e8-8f7e253ff452@moroto.mountain>
X-ClientProxiedBy: LO4P265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DS0PR13MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f1faca-3dfd-4e34-0a08-08db7d2b23d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cN0dwnbT2Uz50KY5WM19J6xh9yOOaRaxj4K6+XlKXC1fpx870U16nm1gPNfTy1PJTnP7E/REK4TPe5hmHQG1ZtFw//bLmEBdBqLOwgZv+ZQdvQAxxQp844U9NASRuQA6bLu2+8sZzhqvv/T39LiIlwB7EtWSe5kkLcjicGNT/xCHNuWOKXeMO7ZmCA1IcGV85C1po2EWS6amA9FL55NfUah6o7+lCNRc1nJmSFsOFQZQrJaVL5foRv99mfmf3cqmgHRdA8PQRsO4QuhlftcwVTjvec+fIIExKHHgMVjtRq6U4CCgqcvdhX8lznZP0itsmZiCEycQN/QKk+ezTljhC/KNyAhufyIazG+Cf1SyfkpzjRO+9VhfBbxXYU7oGISbOCfJ3oaRi7IZ7YSgfcfxavuvGOaeRIAP/6AyNFeOzl5m84HVidP548wDn27ccR/zMAEGQX5prvDt39cZXeFwSd12FwE0MzsfN+ibP4u48JZlsBMJ52dXvseR0GSHhIO3IUaD+hrp1pd3QCmZrcYiy7pZwZ+ojJ8CIZbB2JsBCiqRYAOzHo5lfigb/5ALD9qeXxMc24TFy2iklQ0+J67hyDViyrQkwG1ad+nAdUTB7XU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(451199021)(6512007)(186003)(26005)(38100700002)(6506007)(2616005)(6486002)(5660300002)(8936002)(8676002)(6666004)(478600001)(54906003)(44832011)(86362001)(316002)(66946007)(4744005)(66476007)(2906002)(66556008)(41300700001)(36756003)(4326008)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRzB3T/9tuXo/e7yKd/lwBPXrLnjTpbL6zvc2HFJnjaPpgt7BBnp1j7FFPH2?=
 =?us-ascii?Q?HqqRXKFlsaUPCqZRGNTWpM9tWYFMLm0EgZ8tJAqOtmtn9/1hwSBEuhupnW1I?=
 =?us-ascii?Q?e4sW7sF9LFlrW7VGiJ2vMrMxgHwFUXIh5BR9rPaI5Rqpw6+RNZVoFKVvS8HN?=
 =?us-ascii?Q?3iMZBUPZ3g3b0nivnO/ZQJg7SlUCni7kQ+lNvWKqpmqCFiKEjwGmElOlwoj1?=
 =?us-ascii?Q?24U2G5qWkFfKUZySDlO+t7vnsQ4juZcLPI1u6eyVay02M8bXrRILMz3zcZCm?=
 =?us-ascii?Q?ltisc1B5qF1XhL5+08Yh6sEVMXWnLZ6BAI6vPyn11fL+WQ2tE+HGW0VVn4Cw?=
 =?us-ascii?Q?a0Dg5mpd58GRNYg0x/TC9badOJtPcKZNMg6suzPLiYn2vY2hhMWebvlbf6LV?=
 =?us-ascii?Q?FQSfTDMdvYwrWv+Fy0hEsl3u3lR3QIA43p7x3xQ0jIGuK4ODZ67JGsaXJ7Hz?=
 =?us-ascii?Q?Za4zZOCaIDnilJ4jOL28IhRr/A5E3rT+JflTdftfER7YY0jPiga5uNd5IfZX?=
 =?us-ascii?Q?qWDxJhg3iyVLwnm3Kd80sP7FnduuQl1MOn9NNFJpnAfKSt5yZk094bbzoNXk?=
 =?us-ascii?Q?p/FL9aUGA70q7bbL6ybCRMe1fBul/U5LEuuvnngu0HvE49lJ+JlxKauCXtRn?=
 =?us-ascii?Q?DjAvQs9xyzvXYLA46Riu85U3bdM/XDJZcMj5gcSc0tn+KC5frFw5DxCBK7k/?=
 =?us-ascii?Q?6naAZuJUgdp8wJlxLnXiIqz7QmbH4JGE1ZexU2ZnAERHp7GW50AfvrUCDGeL?=
 =?us-ascii?Q?iSZBTNtZIIZnlBTFUPca5n3MT6NqyvAJD08DK1ROeVqbZEsQmwsdf4G6Zv9K?=
 =?us-ascii?Q?timnEDQ2IlPTFY/YrebvoHREY1351VzeDFOUoryKMJnolu1WMJtrz7TiOPjc?=
 =?us-ascii?Q?aRDX05w6mXC7xIButxOYPtfGtWoFEwPw2cxZWHBwVvwa1zpsRNW7zcoop4Vr?=
 =?us-ascii?Q?dIdm4WKuJ5PHvmJLSTyQYZllCB+FicETR7yH000qVqd2LvHQwCsKTgoLrGOr?=
 =?us-ascii?Q?rAQ4fmBTXe2eiSEAHvbedBuXL+Kr1JY4vHjKfG+T93IBkcRxnXskHegIome0?=
 =?us-ascii?Q?/ZS9LyjuSHsmaLWHjb/+hinAkE/7DvhE9jykX2do7J03oCoIMxkEJ8rt4bRM?=
 =?us-ascii?Q?83zcMjBmgwxv2Uam2T5wyxU1jknQ2kxpyoQZj1alb/1DwbtcJazCxsR/R2p7?=
 =?us-ascii?Q?kaile6pZ7+oEvWjSpFyoEwz3J2RDNJuy8lp4JpBBzpBzZPM5XEnbXdBEKdax?=
 =?us-ascii?Q?gk0ItEQViFMH40/Tws+UYVWqJ6iUhIY4QzWIl/cEv5FmB0ZsNH4UWH6xDMGx?=
 =?us-ascii?Q?jRhX2Bsfd5JPNyFeu75iF/vFUwXUtknlk1bGorOkOXCUbPEtIkC3jlzlf1tm?=
 =?us-ascii?Q?gWlUhjlWIk1b1Jkww0AjoVk8dH8zsBpNx1QoSTsLFU2IUzViecjdHPfQUrn9?=
 =?us-ascii?Q?yxBmMJ97i5rJ0NeMxfM4aH1Ogc2g9UJK0I29rAcW6MNW1fU8G0EUx4x/mt35?=
 =?us-ascii?Q?0d8/ny3YYp2GKEWFm01KJaY3tYpm9majt5vJXQam9p/dX00s7FDM8VW662dU?=
 =?us-ascii?Q?TwNPwBacCoSyc2ppGfNfR4kZsjvKnibD90z5uUbX8ljTzeUpbcQMd1XxJJcg?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f1faca-3dfd-4e34-0a08-08db7d2b23d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:40:44.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OmtY6W1ohHW4fNwsE7+XxicTAFZkTUX9d189vUGty45IcdxaV4FTY0skxPP85/wyIcXsKGR5vIrS7IQs/vFqvE428IzLgwAyn5j9Jp/D9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6175
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jul 03, 2023 at 05:17:16PM +0300, Dan Carpenter wrote:
> Return negative -EIO instead of positive EIO.
> 
> Fixes: 926df8962f3f ("Bluetooth: msft: Extended monitor tracking by address filter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
