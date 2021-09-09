Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 09:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAF5610F8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 09:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhIIJQc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:16:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6118 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232724AbhIIJQb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 05:16:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1898xNhB016388;
        Thu, 9 Sep 2021 09:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=VeyiJdp9XKV1Hb8wXx35YL6aSC/EeRzy6gIfvKTLV+E=;
 b=WxEFA5e1UXCipwpjXIjNpiAPkmGGHDIgIr84ShmyYixB/wmNPEA/fl9vRuLFE19PZfWX
 J4TQRlc6c8FGxD2LApETlpCqVHpRUwVFsclv69mgYaiboQAcsXsijsWQltlB0/+KFA+g
 7JS/of/Ukr8JD9AZNq3kVmN71tak+BzdS0C6LPY5Zicv7dLYsUNcFrXVS3pn9g5pWHEK
 IbQljjhQJyVSg+0GdaewJe1YJkC96lnxIH6IP8E0zjlQHjIuOcMHWiWcQGKhDU+hmcNc
 x3Bb/Q+U/gvXz3gJSpJbKd4O6WS/tT+MWNPRYqPtVOL7QMCl9MEymo/+sRkKYK2lDuL2 Rw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=VeyiJdp9XKV1Hb8wXx35YL6aSC/EeRzy6gIfvKTLV+E=;
 b=VkGr/lo4rLgjqKQshEZo5xVILUg0TloILa1EozyFl/wEA9veJUlqwR0x8BvzKG4KsIHO
 6wg/mga5Et/VEfn96ReZAvyL4KGbIt15KyPJugpmn7pW5BNu54LXXxF6Y6LQkcNlQg7N
 M4BlN5Bh4Z36Z7S9z258LfJtvR7LiN5WRdDFfOi0/xNpCa/hXXDKUfX6pQUowcnmUMaC
 2jTvPr72ugIonT8XwKkDCKSM5/5Ndcu4swCcEh4XhOJnVsokJUErl+jovFVNrRbc0m9q
 uslueqHuj5FaCcp4FsYWKDk/VQp/JYYn9+/ZatcacM8d6zjOUNUVPyPYq+zxyH6SpROk 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayf8a81cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 09:15:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1899AJJw077496;
        Thu, 9 Sep 2021 09:15:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 3axst546ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 09:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWKT67geFwmZnuRkhDsQDDpJEddieBcwID2ByoI2Yh4xayeDhn1RVArVvUFO6XsREd1t/1L8B2KT2Qnyll64/bTccA193mXM9LDQVAfcqR4Y5UE0JD7JiF6jqNh3Uf3QLwdVA4CNKC7MPAJwwFvKaR3MXjxXvo/moS3WTx5BcOwivFNJKJ3j9HWagGUqsWbk45JWIlhqoUW+nTa4CBpyEKIaZMMMupAyjXEuZQh/bDb/eC0LsGmskxqKRiDF20+05mod64FjHCKLWc8Tcio3b6M6m//XDEWm3NWby7j5ydBOksh9UfVzJxRG7V3iycoIeTDzcNVRKdRvuzlwrBumZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VeyiJdp9XKV1Hb8wXx35YL6aSC/EeRzy6gIfvKTLV+E=;
 b=XCG7kcZ4TnRigZXvCk7lOa98smJWkr+GqwzNuAxKlb0hIBvW/h4kSPT7KAk4HhqEeEWQBZmeYYx1EBgTJDVS9om9oSAdX5txIXPGBcoYacEw9mLauFdcd0D6svCIEdojDRNexJaYYon9hEni66Uet5YmDVLj055/Mw9fPme/82QZWp9Uw6OUIIJrAuOIPTDb9TWSbDTZr3TtpZ/P7NMpYdtFVPk0C7Uv9FClThVmdZnpZQYi068LGaC7COIoOnHUixyKaidFTd4JuIljm1mw1v5mxNohQ6JiA4lyXejsg9Nbm7bSAuoRthcDpRkO3bQuljQ2fDo0V2EiAbShGHj+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeyiJdp9XKV1Hb8wXx35YL6aSC/EeRzy6gIfvKTLV+E=;
 b=MK0etvIZDgKXwC/iaznAO+BMpZgRFndvQlNUtqG4sg4vXf9HJvOR0F5QAT0aPvMzIf5YmDzzNooqdgruSDOWFvxLE5oh0CUKb1DGPfJqERPFP+8bjJnAD4fEt2aVYmzz9polaYaSJgMAOB2AxDJWZCGArfXnmZ3SGC0eN7JLHtw=
Authentication-Results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2366.namprd10.prod.outlook.com
 (2603:10b6:301:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 09:15:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.014; Thu, 9 Sep 2021
 09:15:14 +0000
Date:   Thu, 9 Sep 2021 12:15:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>, Kiran K <kiran.k@intel.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: check the correct variable in
 btintel_get_codec_config_data()
Message-ID: <20210909091511.GC26312@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Thu, 9 Sep 2021 09:15:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0cd9f38-b70b-4cbc-6d5d-08d973725544
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2366DB4DF6F6FF71C312B3858ED59@MWHPR1001MB2366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94DX+GjNagbzyybCkuvk6rJeVZVwkzWIt2cqijhMcVmtdqy8AanNFFq1FU4Z86TSUNBE8RgzrAZxNRT1HE9GjcDs4/nt0t6SWp5CaXe18TSTW3JHPyz3UwVhe2F8iFcchLkM//L4mhNZGfS9mfMLyuzrj9m+31SwOldf9vg/F7ReVEUvVkBdV7HJJYhuXRk3tNKTBsFNgLON+s5+8UWz2lnCWELlHs5QCphMddGo7REA/5UFtfyRpbtN39ef9hc8eGTkTXd225nxdSjqKfbLqJb1yT/MfeEhA2kwh+B5ikdiavXSo4glYYzt4hjxd4ouAQHth6ZXaYbIGWfIbmkAictmPg5keItXiWOn69SeQ2I0voFV/lKsdfwsv9cpueu2pG+jt1m5Th4ja39mlzOGDpdrNhmvm4QdzUeoDy9kioySIsltvV63HlQLDHpi0FSMY67zmw5ETYfgsSMZUnN4ZakTJ7dd7I0Y3MUGleUXbqn3PQD7MOtNzwQQ+plraCw1ri0VO0pXdRV2+51cLyt+chD9nIDcAo1o4cIwu8UKSVaK06XGyn9QjbSJ/b4MJ4RzcwAc9sGqozya8cVGLTuYgiuisCysiD3IL8qVpDyGt+Bp9kV8J//ZRRc65sDuH8PMi8QE4MtvVOVzyUOeDT4T98Xr5LrXxuIWcw4TXLclVFU6zBkVsrhuz18OTjKBews9XauNuCrvhriyKEhj/Dgn4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(83380400001)(8936002)(5660300002)(186003)(86362001)(956004)(478600001)(8676002)(33656002)(4326008)(9576002)(26005)(66556008)(2906002)(66946007)(4744005)(33716001)(44832011)(66476007)(6496006)(316002)(1076003)(52116002)(54906003)(38100700002)(110136005)(55016002)(9686003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q4Gpkr5i8MH01Oq6U2+ZWnK/fQQpU/gJuVHH87dtIlM6JVGt6o3bC5ZCPTsu?=
 =?us-ascii?Q?k9lHP5slgSH+rZVpQeq8fzCwaMmJb22aMHQurJQ6o87veQeGHhl+h/oJi7wW?=
 =?us-ascii?Q?IRS6RaFjR5YGLTfahpS7TwT3hKvdlmyCHEmLyYsLGZeA7YePyP8JSO4WyeWr?=
 =?us-ascii?Q?eNgYrdV+QqgjFi5X4kfeaU6OXC0wxXiuxxvbWqE4ljTsRQ1xX3GKTBnr+HSL?=
 =?us-ascii?Q?5e/QwRy0ogvuNf0wUgvwsr+mDpJs79t0MgnX6Cmn9Z2qRsmKH7Iusza55z7o?=
 =?us-ascii?Q?s1UufGqKL2HM9d3Tgx6FstNM/zHBVeUVbRpMFbMbsvzVRM1bT35aaKA52ewA?=
 =?us-ascii?Q?QijSpX9dJt26PTydNdL3Zebfj0N2ywYH/PVBTxnucpFFz2RJvHlo6661TpO9?=
 =?us-ascii?Q?RRrGb5W9e7JASvCeX6gIccihRSBFqPlFqA1Ka+ojKTC0yHWCWRNO/6HaJANm?=
 =?us-ascii?Q?ZwPzYtWC2AjzlMB8arRBFJQQL+SlLK9AfMQr32qrhmggdEB8rixDygbcDax7?=
 =?us-ascii?Q?j50U6aU8KI4lbg9t3v+zcTbvFgGzSJ0o2E36uRnolnIETyo7/IhPmBtAx7od?=
 =?us-ascii?Q?l/X73LAXjeXvnf5GE65puz1bnpG2VMUeM8iW13VobKsH76BSfgjetwARiGbI?=
 =?us-ascii?Q?vx/nMvyqRdWjtrOgEuS7WDeLAmPtTLK1PLtRVQf3nRsd5kr3zOWqlm0UxGAy?=
 =?us-ascii?Q?qIn8gH6haDxsBzExQQhJ2PIwQ3kj1hqNgu7U6zoBM+avqB0d7qfjAmDOk3wD?=
 =?us-ascii?Q?zIjs2GKcdR7s5jUMWWRY3Hm4x86s4gj5FJjjzfV3sNvavbOLECHL1v4Ow+s0?=
 =?us-ascii?Q?l1zL1vIWpyrHt15YEL1uDIno/d+MW6flc9JxhEWRB90uwBw9rI7TjQx3oYbw?=
 =?us-ascii?Q?L+O1aAOsVxUUaY1PyMEqfta3Baq3s5dejEz6zLnmxr+2GdHLHiZrWpr125e1?=
 =?us-ascii?Q?fe0QICP/TaeQWdFtu42hobKkwuj6ZjVmA4EwxtN+feUhtjrs+VQ+fPStpMv6?=
 =?us-ascii?Q?cMEX15SaDEv0uTEk9SoYUB5GxmFD6kayVYKMuYGVfZ9SudsVRtDCdCKkyImR?=
 =?us-ascii?Q?Ib+EsCwitBne2QcUrM4LP+otsMV0o68OzSZrC01VhdDjpsM5k+M7+KQzU7F9?=
 =?us-ascii?Q?WHSIfq83DwcEBnsPR+7Yit2PhWzlVAHNDZ9+Cf6hsvze8rrjYDFlxGAhVO3L?=
 =?us-ascii?Q?g81v8CmfIP7b7AWHU3NJchM8fW8y9tqjeBfGjQy+/91uzxFdu/pAv63qKk2Q?=
 =?us-ascii?Q?euj/eRW3SFSFu8pzl7/+525D71e+zqShAWJqUQ2F5aSLrxJyD4SFGTvtTkQi?=
 =?us-ascii?Q?ejzD9gPi9luKi1hngrnc2hf2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cd9f38-b70b-4cbc-6d5d-08d973725544
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 09:15:14.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik3asnlx5pgOi0SHG9EY1dLtB+1SwoHKn3FEIX4TUySOMq7Ym8uU+SS+SWkSYbYrJQLmfXxMD57EG8cZQbSr5yo081d7/NUQ/2EEWx84yNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2366
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090055
X-Proofpoint-ORIG-GUID: QFKf_4JOQWwS0Wa6hLcXyYZ2NLJApVzo
X-Proofpoint-GUID: QFKf_4JOQWwS0Wa6hLcXyYZ2NLJApVzo
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check "*ven_data" instead of "ven_data" (without the asterisk).

Fixes: 70dd978952bc ("Bluetooth: btintel: Define a callback to fetch codec config data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 115bb2d07a8d..9359bff47296 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2176,7 +2176,7 @@ static int btintel_get_codec_config_data(struct hci_dev *hdev,
 	}
 
 	*ven_data = kmalloc(sizeof(__u8), GFP_KERNEL);
-	if (!ven_data) {
+	if (!*ven_data) {
 		err = -ENOMEM;
 		goto error;
 	}
-- 
2.20.1

