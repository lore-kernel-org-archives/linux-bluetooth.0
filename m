Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8AEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352844AbiELKvf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 06:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352774AbiELKva (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 06:51:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62465DE42
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 03:51:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C9YveS003183;
        Thu, 12 May 2022 10:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=i0Q+kCC7mYue64wG4xWeZM+HzfNF9I4NSTCPEdLB99o=;
 b=nvuQI1VHKE7qgYI/yQAl9zeR15LbTCaL+Yuq1mczQTERT5/k3uVQzZTqRsIW35sELGW4
 FSYrpa11As0nL5Sr14qo+Cr5EFQETXdU/AoHfNGiemRY4JzFqkCz/rAJ8e5DYeCF17nz
 5bWCtFY71gyckSXCwMDOUQpgORjWXXCakjOdDRlxnB9NCCJOo4UF46VBxFNM39tp/Jbz
 OXjg7wKBQ6hYQU3yQcAn0rNRZtvWh5Qld3Wn3b79NDWafXUXd/8BqH6Fd0Kla0y298O7
 5eoW4LuWpMbGh2+2lfmqriL7RLDYmdnFOMMGUROdAUPnMsNB+sQne/8Lr68vLW9CzPQ8 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04kam3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 10:51:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CApF1s018145;
        Thu, 12 May 2022 10:51:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6fu1wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 10:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPRsjrGYxB3OwFt3ylMQfkJqTxH2382+Mi2FtWDvO9yhtvrXcHwMR9W5AEQXu4hsxGOoo+NI/PvXwi6EN9Jh8jwNjPKe09jg3RDO0gJuxdN3OnphtqgxrPNCdA46hJUKJcAysbLsqx31WN6cjJRu5l4n7v34/JlxLtc10CSuowLONoy3YWK4xPzBTrjNhWY5S0IqjkLXUKcHcprWWmPXG4gx3cKSGPbYwNmGHbf2gqvzj2/7/EqSlFsQln09ickwh4NnoNP+O0oDOnA7MjZNxxyLej5pwBof0ZXCIN51p8qD5o8lShghBRCaV25jX6mB7hU977yXdF/PSQw+94/2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0Q+kCC7mYue64wG4xWeZM+HzfNF9I4NSTCPEdLB99o=;
 b=hL7En47vCQoxCoroTyBpKvaXD5UFCdpqikHAUunHU/fU4jhj0nPCALHboO4sNlTeUSi/eG+C4u45qH+EaL5OsnuZ0CKpMH5wPEY+TasNOXKPu2YCqj40G8jU4tli73ihEgCNdGRvl+OlzH507PGu5hDdRPkmGFtdtj3z2jZlqWqCTi6dsSjAERWippOd4QAHJC4LCno7263dePImZ9saxWT/e/vCuHMb8bCY84Q5qsvajmznzdO59H8WqIpeMiv6obNwCqNLcY0ovIjaIN+V7yyoKnMYy8WVdfOBzY6pcoqBPge5nvU9bbOPfHgYhdgroSjUAeNVRzKIJNEw3UUGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0Q+kCC7mYue64wG4xWeZM+HzfNF9I4NSTCPEdLB99o=;
 b=cdTj4knxVk7U+GHEhkvRIAuxQT3gSs6Zra1jWVGCrkQURCNQvmV0DEOI2kWboV8D47oK0wnk7p3NErhMV+tkD+jbCbeA59MzbsUZdj7vAV4Sjti8HCr5+yvxu2sFyAKm09ITtWxXVcMRtCiOitSY/7X41+Nkz/OsHp4+L5Ehx5M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6274.namprd10.prod.outlook.com
 (2603:10b6:510:212::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 10:51:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 10:51:18 +0000
Date:   Thu, 12 May 2022 13:51:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org
Subject: Re: [PATCH v2 5/8] Bluetooth: Add initial implementation of BIS
 connections
Message-ID: <202205121532.jtQf7nFA-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506215743.3870212-5-luiz.dentz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef15fc12-11ae-47f1-a3fb-08da340557ef
X-MS-TrafficTypeDiagnostic: PH7PR10MB6274:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB62741DD8D18390CFA1DEC95B8ECB9@PH7PR10MB6274.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJFipbrRVy8Cu93AKFKhqS1k1cz0XlVsdek39w72Cb/Rb3Yu9kDqFf2U/USDe1hMxYoMxbLwZlC2MXN9E5SnKDyxgAEqF/0UTG/mnafMdWSbIy5dV6zFclsIRq4V2+hhwSmig4W/LforjBD+Fg8NmxKI8FOMRcuZ3J0o0s5ozg7Z2oN2xDdx6nMFFGBbahcu+ftU0G4kuY+LcK4MY05oLLTiYArP1XBCSw3qUXOLHazV+bNDMT/F+jtuc0i4/mAYeXBK6/smkROFrDlzDGkE2J51/g61sOu4zlks6nMVhhTT4C3GkrZYidttVZyfeU4mUNE3BDW118qAfBXcOpVFaQtCQk6BSVnB8kjzs88rr4nrTYC5XjSg9VqKkm2fGaziZR/t9FTZVZoXt4nuDBnhvDHHLXVcfkSSUfeCodVPE/qhPJkhV3AogsUywuGpd85oq5gyW+drphoawHTfb2iHF7yzrjOLhARZfXS7Ep0QCkbLgnjn+pxvpoAQhbqR7bDqVDK4ifrUIsUKE2GpHOiYqH+31AgMeGwskyybHaV5Jv4k9u/zG6A+1N//IA4bDQ0U1Rij1hcn9QmV5z80FveB1BZMUgSAoiE+PY824xvMmgRj+dDYAsGX2BiJMzQa0DO/HZM/CVg/wxZeQPMKY7wqPqrPZuaNOWW228+a+n0odk4SnZshFYgbYwqTmKYWIvkFcgmfOJgsAoKTnzRePQQmpnYyPzV4jMrfr4Ye0CJzzfK47qtltwTR3tIswYFecB6eHBmoXE8kPOJ8+bVMJSkCQCfVUPZDE4NxFDSMfl6sHMpTPllNigdevQqeorr7Hc2n83TbYsVHYMobJapY0opOcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(8936002)(6486002)(5660300002)(6666004)(966005)(2906002)(52116002)(44832011)(83380400001)(38350700002)(38100700002)(508600001)(26005)(6512007)(9686003)(186003)(1076003)(66946007)(66556008)(316002)(66476007)(4326008)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N7qAedWxGxPHQ1ZszkiNCoWak0dkvdCpRGlay5BnGjuxIKYuKDVTwnaP2JJ3?=
 =?us-ascii?Q?MF9kmDtcvhuTZItFTls4aw6mpKCDzoYWankbbrrdupU3y2yHb8CtXk+8IWcF?=
 =?us-ascii?Q?v6yefD7JHORJ15D0jjO6ioZ3ivCsOs2KYe5NyAFd+RmeDfKdLH1zbszjpg3c?=
 =?us-ascii?Q?iDF0SXXxQtxaTPVZght9aV/KjDJUdVAaqqANJPpAB7xa/rFzWsUz/LW65RPX?=
 =?us-ascii?Q?oh+liItPTLSge8aa/4l8R2Bg5V5L97UsyXY+3dHpSIYbgVESEkTPgbYfPJBn?=
 =?us-ascii?Q?DvHDaezkJMuVsJRR95900l8MMliUnz53DL08dajpcbDXLZPcl+iUQcyKYvql?=
 =?us-ascii?Q?S6QxHhsTu9xjcJjAdWyn/+i8aArkUHe/50bz19RYfrk4i8kFFHJrqFVC3IQa?=
 =?us-ascii?Q?2Y9cnneyIPI0RQmRLCycfDPIElCXiucjbmPvWWMStAnxmGHYk5MudvESGTbr?=
 =?us-ascii?Q?1WPUSFwGtrnp61VT9gkez12YREXSyg2octf8ZR76TPHinpKvoGoqU0YTeg3u?=
 =?us-ascii?Q?QrSA+jHcktGHGWz1dgPTlDo4E1gdBIDFhh0Q+hY6TNbtVzp1DB1livRhgcFg?=
 =?us-ascii?Q?yVFo9CeNkoU4kGqZBS6k2eKsVESyEXJ3g2DDWDJaP2hEOXhVpd7PijLpQpph?=
 =?us-ascii?Q?2SOTe89kwTestGDZUW7eP3FedcUoKyA49RS8mQtaEFAJTi6i+gnatdTLM+nl?=
 =?us-ascii?Q?2a6Ld4LgH4gPtAtqIgDG9gVug/AsHmE2wq2RGxj9ubMZ961bp3/6ygf/C8vC?=
 =?us-ascii?Q?o5Gj7ZOvIII4ndzD1RTnDKTLxcOyYCXdaUaNd5MZevh0C1gjPoV6QmqRsTHm?=
 =?us-ascii?Q?FJ8MbvJ4y3vOupnCYvNZYGG8Ef/4E36Vc/j4SU1+Q3blddx0g9w7iWMMlfuy?=
 =?us-ascii?Q?mZWINvrI40zn+3+uCyxp2k5YgzUPi0lnx6iDJMjwp92yrOkDGbaz6IG/4QAl?=
 =?us-ascii?Q?KrJBmNHsGBMEz9CMzbj9WOO4SxAiJZndp2YR/lmaAa2mWld5Yj2D5YntPxhs?=
 =?us-ascii?Q?jwHRIc5M6ylCryxRn9FaGk6MUCZI9rTXxVt1dMNEjjtihGj2L5/UDyruj7fq?=
 =?us-ascii?Q?x7mbvYDoK/aGnWggUCybn/j+z3TWP+HTeLKtq1X9eYVITcSPeW9OuBHiBnTL?=
 =?us-ascii?Q?m6oUmAL1ihHMD2S+2Xrq9a2mV8NbHpu1q9fNz1tXOZawQ1aTtn5dgT4q1KxW?=
 =?us-ascii?Q?5ZtdEUpKaxrnbudN+vpcqFhUwhjcB+d05ZilGRDy0yotUMr444CcucE+vvRs?=
 =?us-ascii?Q?hodNtTbU/Ui5oGw5jAnrpx4/9xi+9Ut8wJnlWW2pqv9S9jQo89kHhXk+5owr?=
 =?us-ascii?Q?2mH2M0SVSkCwmBMku8qtAzy/F6S15stEMGGaJcVlwIH5IQu/g6R5Haq0G9Yz?=
 =?us-ascii?Q?Bqi5SScsW/gZdYv5XKyCD//DHHIp4U3jcOkwDULaZKJyhTO7NSYraMe/L3qF?=
 =?us-ascii?Q?4BHqpzhaU04GVPgw9Djz6rvgDDvZiGW++K2nvGtUynS1IL7j7WUCAG3ODqz6?=
 =?us-ascii?Q?cKw+DEUEPQp9ROXT3I5DoBr0+WbZ1a0h3zczTIBqZxqShI89uEm7mteJ1E5R?=
 =?us-ascii?Q?UA0KQ693S6apj/+vI5KI24N52EE4SS8msP6NmVsp0MCbLmZ4jI13UVpbP4X6?=
 =?us-ascii?Q?5MpvIO6B0bgHK8ac3EL8+iOcD1NLz+umUvmIwPg3OX4Yjvc1P7oA8F8Gjhye?=
 =?us-ascii?Q?SrTWZrzuPEp8vEUEIIrwLIcLRyNnHC/ksJoCTYD9LbYQGkPiQwgpB7mEOhLs?=
 =?us-ascii?Q?oU+TcxBHDqYQaqJSC8i0fFHqHtAqX2A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef15fc12-11ae-47f1-a3fb-08da340557ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 10:51:18.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeQ8lzs7NbFnvweFn1MR5psf3fPr5rkuLpcShlym9dLF/N7ZQanXKjvXn49MWkv2VzB8PC9+WJkO3qokbjvOAdlk/Kiz8MSxO7zm1FQWGSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_02:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120049
X-Proofpoint-GUID: leEKmEVe79MSBnKIK8WibTZ5EFId7PyH
X-Proofpoint-ORIG-GUID: leEKmEVe79MSBnKIK8WibTZ5EFId7PyH
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-eir-Add-helpers-for-managing-service-data/20220507-060014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: csky-randconfig-m031-20220508 (https://download.01.org/0day-ci/archive/20220512/202205121532.jtQf7nFA-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/bluetooth/hci_sync.c:1110 hci_start_per_adv_sync() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +1110 net/bluetooth/hci_sync.c

2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1091  int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1092  			   u8 *data, u32 flags, u16 min_interval,
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1093  			   u16 max_interval, u16 sync_interval)
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1094  {
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1095  	struct adv_info *adv = NULL;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1096  	int err;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1097  	bool added = false;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1098  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1099  	hci_disable_per_advertising_sync(hdev, instance);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1100  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1101  	if (instance) {
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1102  		adv = hci_find_adv_instance(hdev, instance);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1103  		/* Create an instance if that could not be found */
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1104  		if (!adv) {
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1105  			adv = hci_add_per_instance(hdev, instance, flags,
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1106  						   data_len, data,
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1107  						   sync_interval,
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1108  						   sync_interval);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1109  			if (IS_ERR_OR_NULL(adv))
2f80269de71810 Luiz Augusto von Dentz 2022-05-06 @1110  				return PTR_ERR(adv);

If hci_add_per_instance() returns NULL then do we really want to return
success here?

When functions return both error pointers and NULL, the NULL means the
feature has been disabled deliberately.  So, for example, some people
like blinking LED lights but others do not want them.

	p = get_blinking_lights();

If there is an allocation failure or some kind of an error then p is
an error pointer.  We have to return that error to the user.  It might
seem like a small thing to us, but maybe it's important to them for some
reason so we can't just ignore their desire for blinking lights.  We
have to handle that error properly so they can fix the issue and retry.
However if p is NULL then don't print a warning message, and don't
return an error.  All the surrounding code has to be written to support
that blinking lights are optional.

The hci_add_per_instance() function is not optional and it cannot return
NULL.

There are some examples where this is done incorrectly.  Sometimes
people think checking for NULL is just safer because they assume people
will add bugs to hci_add_per_instance() so that it returns the wrong
thing.  This occasionally does happen.  I fixed a bug earlier this week.
But we generally don't work around bugs, we just fix them.

There is another code which returns ERR_PTR(-EINVAL) when the feature is
disabled.  It also returns -EINVAL for other errors.  The callers have
to do something like:

	p = get_feature();
	if (p == ERR_PTR(-EINVAL))
		p = NULL;
	if (IS_ERR(p))
		return PTR_ERR(p);

So not everything conforms to the guidelines.

2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1111  			added = true;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1112  		}
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1113  	}
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1114  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1115  	/* Only start advertising if instance 0 or if a dedicated instance has
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1116  	 * been added.
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1117  	 */
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1118  	if (!adv || added) {
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1119  		err = hci_start_ext_adv_sync(hdev, instance);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1120  		if (err < 0)
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1121  			goto fail;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1122  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1123  		err = hci_adv_bcast_annoucement(hdev, adv);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1124  		if (err < 0)
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1125  			goto fail;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1126  	}
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1127  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1128  	err = hci_set_per_adv_params_sync(hdev, instance, min_interval,
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1129  					  max_interval);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1130  	if (err < 0)
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1131  		goto fail;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1132  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1133  	err = hci_set_per_adv_data_sync(hdev, instance);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1134  	if (err < 0)
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1135  		goto fail;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1136  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1137  	err = hci_enable_per_advertising_sync(hdev, instance);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1138  	if (err < 0)
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1139  		goto fail;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1140  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1141  	return 0;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1142  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1143  fail:
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1144  	if (added)
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1145  		hci_remove_adv_instance(hdev, instance);
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1146  
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1147  	return err;
2f80269de71810 Luiz Augusto von Dentz 2022-05-06  1148  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

