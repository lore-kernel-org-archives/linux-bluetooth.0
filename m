Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9ACCA47A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 07:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359074AbiFPHzA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiFPHy6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 03:54:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164525D5CC;
        Thu, 16 Jun 2022 00:54:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G5F1ND009844;
        Thu, 16 Jun 2022 07:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uUSNCU0QtUEyUKPxGh8YcvklABY+3p5WgEn7tEZ0IaM=;
 b=c4Vjee7RhGzBAZ97ilmUFMp1DrA+3DDJURZIv2wl786QwG45K5fqvPNWR4pR7Ft8hYho
 Gfnar0tFlm+hoMtSb93KfLTZLnotft92BVyiCGU1kT/Dv0cYlDaSpc31o4PvHGGoSJDr
 UGcGxdMGi5eRH5suS2XmE2Dzq3tlpqeBs2OPbpeXg4N/HcsLoVVxujia+FSTmXSwyNKV
 4/1Bp8I1iqh2HLO8OCMMdhtM+iDGbp5CiiCHlgc2sN7t/DZ13N8kpffP9Ln0bjK+I8Ea
 qRONoVNy1MOPsRglMgZ1qqykD1Hb2jQTjaEsJd2EhMcE1scOdKgaMSqXzFM86PjjX9br Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktjhfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 07:54:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G7jffv021956;
        Thu, 16 Jun 2022 07:54:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwbsw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 07:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRCm/A2r3th+7Glcp9I/Tws1KHLdOxtrWt+YrWO/Z12mGRo1Ufem4dbUKkZbr3aj9EJQXkOdNeOEGc+inBNKis2YKDphw1KkgUXpgWsSfTwgNL7rD8seaN8slGpKlaaj1TlgHeKz8bd/Z5Up46OtP2wNe5i4jeGRfQbk5W48aeCvXlZWfTIfM9QcTlT8AHGgWgtGODNW7sMr204mQ+2ohhneJupbs6FGxGbswtL0QW361teCfSUr7bmK5ZD/mxOY9SQgM+i+8SlYgJHzuXwDeC0fEbl6hyIjTLELyqEg5ZR61WWL2jTY/nMaauY6Hue5yeGi8vR5Le1AukBWha4cxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUSNCU0QtUEyUKPxGh8YcvklABY+3p5WgEn7tEZ0IaM=;
 b=h6tZVm/OzjBHr3pahYmlA3E0Y71dS8i4Fyrwt8wVfXPrM0tmaoXaOQMGh4mIIqBdw2PAknoKdcOsLj8QJuQYB4EZp4+a0sDA21hRekDAsP13wZMsJIp2d5lozw8oVOjXWq3+AGVCaX9rSm4m3yC/f70YHA3k1lJ66TJ221sWNtvtbb5kYrBOuJ70TB/eM+CkAi1KYBQkSwpVgTmLSse7qQHaPLM57S9Nf4f1MZE+qLiFmD9G6LB0SqHPSfxBlw+Cjx8GIZikN2Hr8qnYzzO+iNonZ1Up0i6LeswvCX7/g94s/wK9Xs4kyH0W1+pcqhlkO71d/KBhAfytxYKtHhUjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUSNCU0QtUEyUKPxGh8YcvklABY+3p5WgEn7tEZ0IaM=;
 b=FTsnDdxnicc9dzwlugj3sBSngo1YyBDgXt8GntlOvZL0lQFq3FHSLYesXAuQsQibWV2BhU7IOpjzEB9tL2O+OaB+3xgLTNEtSnOYyrxEdO59nzyZEN3BtYUILqp+8pr+t7SLLOVK1yF7JFV71TJpZm18uBXG/rafS+yMJ0Ah6eg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2308.namprd10.prod.outlook.com
 (2603:10b6:405:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 07:54:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 07:54:49 +0000
Date:   Thu, 16 Jun 2022 10:54:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Use strreplace() in
 btbcm_get_board_name()
Message-ID: <20220616075431.GA16517@kadam>
References: <YqmXmsTX7dD+5HjN@kili>
 <CACRpkdbStsAF2Jngohh7Lsg6xs0Vsc-v_SR3WC3ndbZEhx9tEg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbStsAF2Jngohh7Lsg6xs0Vsc-v_SR3WC3ndbZEhx9tEg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8bd33e6-4ba1-4d38-428e-08da4f6d7cab
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2308:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB23083503B2E996409AEB04E48EAC9@BN6PR1001MB2308.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBbvxe0o209PC6YTbJThfanQwTHtdf0xrimldFVUpNT7tcxuKTAgCofzpr9bohb1NnRZqnF57/Oa9msCWmTTU8SvYeDvTxx6K2SuEm6umqaNigT4YoDNJwHxzPBkTtfMpOWXCt3c4WZfn8UJUaMzLMBLEqXCVycHLD2kL3kmgCjuhjmDS7NnntWSJCaAXAUv4pBrxO8Afv8oOq9AiTZ6I9iSgx/S0SWXNCqbSRez92aPPgmsjV6ljF8Bqy9HUONBfYQdxzTfLUwigyOCa0NGHLFPVkUz931l8IeUWca3pjBDY+0aQE7BqYyY1gxsRb0TR2c6o6DFdxesTB+hSPOfRf9r3w6yEIAW+Tmxk+qFUKW/e7Lf/QEAfU2UOVJJ/7mIw3dTXjc1o5b6Jd9z9vOjgVq4lSj1hV2dJUFWAWpogyDL5WTPrDoMui2hoRXkVCTNTqvo35a4joaxJyayh7n6eLQliQYGOYkQKmkdEw9YDF/rAkztk+1XOYEPC9kqhTS1V2oDbFixPNV4obCXQAYG1wRRKlYSU2YNYfvM0rDmhhtiNu/6pOfkq0gGlxzJh0iNbxfExVgadz7VhH11MJbjhUl5wJ+B0gj53fywaYSETp67SkyQJe7X/VJgtOjxGlEMnKULiOYmD0EiB34w88mdlcr/BiIdiLTZTEDxbLza0rI3bWWXBKN2U67PSeooz7P0OTnAMpAZRxPk9OrDm8hs+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(66556008)(66946007)(86362001)(33716001)(2906002)(4326008)(6916009)(1076003)(38100700002)(5660300002)(66476007)(54906003)(6666004)(38350700002)(33656002)(8936002)(8676002)(53546011)(52116002)(9686003)(44832011)(6512007)(508600001)(316002)(4744005)(6486002)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iQXqCTgZEEKWb3YFQc0n6O+bKw8OSw1BCZ2Q7O34qj3kHamcXECy7idNOLn5?=
 =?us-ascii?Q?Qsjj+XsZw+tbuhyhTGm3uwgBA2KJvFT1AjEAmSz+IjO4kD//NXiLfFXrGWdi?=
 =?us-ascii?Q?jP4tCWpzHxs+jDjUB50tgqLoDmXFHAwuIdxWjxf7kCoMTGqDAhWMxmuCyOeZ?=
 =?us-ascii?Q?dSWHz3lgjUiyRLdIJ4mQnyLrcoxrz8vgWH+f5BhwbPV5EJIFvZiJ63ud9hAM?=
 =?us-ascii?Q?h57LKbYdYSD6HNEp6h0InNebM3krLCV8xS3Ou72wTbAl+xV4QcjJZQtdVi7t?=
 =?us-ascii?Q?RGy7r1K4dr+kxlKcpsGi3uxqYA/BNRz+x+GwbY3Ro6I1IJlK/jyIanow8LCM?=
 =?us-ascii?Q?hg2L7lyXN+rPRpnM0kKPDxChWoA8hd/PYB/XI8VVObBHjHHT7qPFAwbzQ0lK?=
 =?us-ascii?Q?6NsTntZrVBIQhx0QL+6h490Xiof8ZTSZg8Qp/HSorOgWVTHSC+Cnzeiahk7e?=
 =?us-ascii?Q?f97XdzR6XgMHL/0VzFN9xAOsO4buKBG6hlbi4TBeCb1ksD+PGxoWpDHAcY/l?=
 =?us-ascii?Q?HulAR991OLI1zPhZicsVT2O0Y4QRff9sEbTahxfq/7AGFoHXAwoB4hxHMYoo?=
 =?us-ascii?Q?UxOt5TY4qIywZPVgujAALpM2p0uLsfCRlDawjn1cmUvnALoqpVGdNeY2DPUC?=
 =?us-ascii?Q?UQp6vhJqUwu+aRy5Xs06HqMF9J88+Tf9AB1rJt/O2J/kb4n7FRoI0q7gF0JQ?=
 =?us-ascii?Q?3t7qK6zwkMdmmuWlMqGjibSPibskiAO8wfxtIIPVLnSmCBAGkJPuvxIiyEIG?=
 =?us-ascii?Q?A+yaX/+h4qugO437FVtNibx/OVVTlPgCTG+BnxZKj9Kz+BZLAZNstg59FmgA?=
 =?us-ascii?Q?xf+9nGTuErlWL4Cxg8gRj+JuL45V7UVknLiaqXfJMd9hQl8MNHAey1xs4vt4?=
 =?us-ascii?Q?Dcm1+wYIlV23QrYmBsJt7vGFO0hbMJOJzytxLMEdRZw69tUUMW7SHkysl3NJ?=
 =?us-ascii?Q?1QnS9AHmdTbFJ2zzzXnKwmUgrMFzjYTHtLgp2b5Yp37wscQVsqitPRmRsC38?=
 =?us-ascii?Q?tKRxP8nHrPanIPibLUW7FbCZWYDHMV9//oRqdzcxhcowKpK+fE9lHOOPU6o1?=
 =?us-ascii?Q?p75So4Fk3tHZRm9UoW/cYVQ6SayRUExYFr7LmCiatZw6lr6lDiE0hqvTtb4c?=
 =?us-ascii?Q?Iqo33Vc14icOhvkrN56/ofiWZGyvCUruBB0UlBH4PFDTnvIF3rp/16bUTAfE?=
 =?us-ascii?Q?Q0iWUeAWokvtsM+0SefiWbGvjPKz04tA1jgGei+6S36YR+h+W6xJ2WkhpglW?=
 =?us-ascii?Q?M654mWz+CS2ZXkIJ3PS+YpAMn8C2jvReJR87ZfJgmEkXYG+FhoiWi1PeLjAd?=
 =?us-ascii?Q?Q0QLeX4xqB9z1LZEl4S2y14iZKaaTWCiUakFTfWT5z/BgaF0/0LTO6GgODyH?=
 =?us-ascii?Q?OEjEVAZgN58dw2MDkTlN7BB7NbFQ78cFuGPZLe0xuUaI2IPOeXO+40Wanpmg?=
 =?us-ascii?Q?3eLEiPOD6Di2ri8laEz2MjohXlZ/0SUu5rMHbaqL3rxHfA9zelwms9WJY5lT?=
 =?us-ascii?Q?tuWMv8X/jS2S8ExQXZhDH4WZjLGStXyH6jPxxTvpj5W0m1Xg5ptaCD4QMQ0/?=
 =?us-ascii?Q?VTVB9K3QIwfQFZGPV7Q4AZ384bfx3MC38b9Var+GypLv57KX6CoJBGZgM090?=
 =?us-ascii?Q?r71uxHgCj9l6Km/xTnSxDPQqe3hxFzwo3Gkhw5f7zfiyv+XU4JVickLPmU5h?=
 =?us-ascii?Q?o3Dy7IEskmkuVXJPYI0vEVDIX3Oi5Kowf+7pw5RZX6uiGVsw8A79275pYBlg?=
 =?us-ascii?Q?IVgTFZDSlR9G7HEvh7JVWIimaoTokls=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bd33e6-4ba1-4d38-428e-08da4f6d7cab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:54:48.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5gfnpWftIseaIkERQ5pdHctZxJGLdLuk/DlfMAt4KW9Er+VRXoxKX+bxCmJDYygeEAHChLJsUC0tjns7jVLWFr0dwkIq1UiB2FSP2S+0d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2308
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-16_04:2022-06-15,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160029
X-Proofpoint-GUID: xqBMhAWD8cWiLARf4HNjI-OpLxNfZM9M
X-Proofpoint-ORIG-GUID: xqBMhAWD8cWiLARf4HNjI-OpLxNfZM9M
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jun 15, 2022 at 11:50:35PM +0200, Linus Walleij wrote:
> On Wed, Jun 15, 2022 at 10:26 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > The original code works but it's a bit iffy.  The end of loop test
> > should be something like "board_type[i] != '\0'" but instead it is
> > is "i < board_type[i]".  Fortunately, those two tests are equivalent so
> > long as the "board_type" is not an empty string.
> >
> > It's much simpler to just call strreplace() instead.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I think I just copied this code from the BRCM wifi driver for the combo
> chip, did you patch that too?

Uh, I did but it got lost (my fault).  I will resend that.  Thanks!

regards,
dan carpenter

