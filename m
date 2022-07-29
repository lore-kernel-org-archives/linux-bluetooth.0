Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E979C00144
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 08:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiG2IBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiG2IBE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 04:01:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E833343
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 01:01:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T7E3IU008950;
        Fri, 29 Jul 2022 08:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=RQsj2YEAo3ZHHmoIWC44VV7ABu8yNT/Sd0wkm5fWRZc=;
 b=kMbcvNZa7jnli2DjBd2BI4SD49iJQCbkIFLSC3Lw7llo0OKJd2EMPJjZygS8GQtFRgrG
 JDa6x4zY26I/def2r/lZNYswWLLEQnVR9Ut5BICm/iex0RMNmvcDnsNXVqdghc3eNNy1
 cMS3Kc80B7yixtN+iFEloo4ewEmtj+/SdR5bvPRf5nwVZMv/s4xLRuPnIchPATcEMcJD
 f0GLNRLYIPMhSBjPJzcaZ0mOd2v7F+ghJ2mL4ieR6UcjVuq3oHYvj+tfkl03AQKrjqw2
 2JfXbA6JLI4NPnj7reYhGYaWf4nvgPPM7nR9zkWaCi2QVOe9NdUAbuMWLa33vU2MXNVo Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4xqxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 08:01:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26T5v6TC034500;
        Fri, 29 Jul 2022 08:00:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh636e5pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 08:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntx1SGj0rVYHOpOCqDAmaU8M24npXDd1A6vuYJjznk7EBNUlWoyvpfUiTPFeSjrBwyt/SqNma3k9Q2VPe8sKiXjXT+8hkbKiEEt9iRNYcqIv6gBhocmadAuGqzgt0FffeqrdSHTmCpnEjibUUC7qw0EOa6UQu82l95aj8cQY37haKCgnYeDYGAuV/lsyfHMsPUNC7USx4AhwhNA/6PZxA04jYrE119yHpxr4jhADHncx9w+8KWkkJC80JcBPN67ovUXOk/tbnJxaHaJvMyyFjw31/omK27BHCk0hMP11iuV7hDkKopXMykro4sQEtW4ZkC3bWHQTENv9T6yh7JilZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQsj2YEAo3ZHHmoIWC44VV7ABu8yNT/Sd0wkm5fWRZc=;
 b=Dw3ZoiaWaJPMbb2v1cBeApfsJSEBBFfCv1ZKMyHyudI1+dGasCPLmG4oGyf6Bq0nlF/Fo2IreO36stR6zC8gpZ6x1YR0pg1gIWmFxPZx5pM2F1FKhpxgnxzfMGJnOj82hkqSwqareG16M3RdmblbsIyWI/7yzfQJrxJnTfRh0MD1LiwADvBtGZsXegE40ggNRkt/E0648fr8YfrUor1b3C4VTVeocrLO8Doxe7fYhLuj2CTasQEMJLpwifBOaySzeQ2mdSfg8DG8bbWQ4qqakBxyC89y8bEwOz6UmDCOZNFd8I1E4x7pawELdn9Dk344Uzr5FQJ//Qyge2W2EpPyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQsj2YEAo3ZHHmoIWC44VV7ABu8yNT/Sd0wkm5fWRZc=;
 b=G1QElxsJKaHzxi5byhZ7FiP3xpGugzliowAh8AFX4GPN2PJt/KBubtghoIToFqwkPytXmorpeTThJx72cav+bwqtO2CUadSj2XvVhcXccaKHxw/wHt4/a9JjkPR+y8rbLLPtdy1pSNbBHZDzqp3Qccym3YPrZY5Q004rZPvM74Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4680.namprd10.prod.outlook.com
 (2603:10b6:510:3e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 08:00:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 08:00:56 +0000
Date:   Fri, 29 Jul 2022 11:00:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luiz.von.dentz@intel.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: ISO: Add broadcast support
Message-ID: <YuOTr1AAJq3dMmyY@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f68c8e3-548a-4c2f-e2b6-08da71387774
X-MS-TrafficTypeDiagnostic: PH0PR10MB4680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhT7Gt8Es5OPHHaHpnb3CO4x1ByoQidnl7hEa4S+eJ/QMF5VorbXRUWuoTtEuJfSu095wX6M0v/7bYt3MIN5uZ+RXyuVj64x1B//piFFL6SGlWEbtvJuX2nQDDHV9PGyJmjfnQuZbYIXfw0ScKmrOFTelZScx0BzeHZkZwtOiX2IFRNP+sOh2ROyZe7nHk3WEB0CkZefN7TcTSHNFX9rPP++LO+iUScwRbVOzkC5RgjHTAUURqZJcWLS3llAM42BvnE8arGTI/9THACNJoiBQ/4Vv0Nuz8ZctzH75OjFcDGcCyab5mhZF4yMmaf8dMhQFiaZZt6gNNmhY+4/7jPsQJOMeTLspT3wF9bUJ5ivJJNQIEr6sIqmHSK19ZL2ioJ4cDGNx4NMmCelQvY0GTWAyBlWOpYPF8GNmimgTrPTkiceZQlrygGWwHGvT3Zy+EMzccQO+cxHPAwli1W4NaLmGo6x+N4vJ+mKvuf9DF4m+orLu0/mwvF5jnEeMepCGvPuU+z1ILNfA8uRwD6qaacwJmxcT8Ykbw3QqXP7t4lfEVSTmWAoymG8cvPMVSA9tlVVfgIugXjHKjUdRy6boUBeUmiQ2sCDM7ma4nsc/xv2ZT7ZHZ4VRN1pqH/gNf29RgYAnqg8UABcZ1cv0nNlQsCn/NzkRRpAQmCGPrGZ9uTInWxa908n6bckbCCkBApI/VHLv5WU0sj6eMiDGxQkRIJFaqTjUpoIjP4rK0WINq9Gj/vfEd3jb8YBwvZwCZB3yeK9EeQK/YjWapH07D6wTLHt50cpgRZzADp+DOb5Olt9v8DlYlKvzM4G6FeggQ8t3Xz/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(396003)(366004)(346002)(39860400002)(52116002)(9686003)(83380400001)(6506007)(6666004)(44832011)(5660300002)(186003)(6862004)(8936002)(478600001)(33716001)(6512007)(6486002)(41300700001)(26005)(38100700002)(38350700002)(86362001)(316002)(2906002)(66476007)(6636002)(66556008)(8676002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tkdtsWfGoNivYtE7H1YR4vsBc9+05XazSMx9edO6Pzuwp4vhtz5ybq28iZ99?=
 =?us-ascii?Q?Mbs+y0DN5C2nrCX/rpiKcD+XDFwPxyd2LKYi3ySVmdG9iWRXAw1jtwz0nkYr?=
 =?us-ascii?Q?ZuYH1EMfqJGPX72P47UPrrxkKOgdO8KhDHgJMh/1QgQ5KTnm2+dFJP5LmUgY?=
 =?us-ascii?Q?O7vFhS86UGIVNVDFIS3ZkQwrG+Del44HP9zqWA/hF6uP71cJ/eeaEMrLDkqs?=
 =?us-ascii?Q?TwfvUYZUdDCWQWJ9yzhNHL5YQi/4QZeKwp0z4O6tCxXXz4t6cvzXAa8Y3qJ1?=
 =?us-ascii?Q?/Zc5+WQjjyBQFeKI682S3KHQmCzbWKqBelgvdAIif0dHB4IH72SBrYsjzQZw?=
 =?us-ascii?Q?Q3ePQ2K5WZJBReK2bSca6M+RdoE04i2VhqJV9o88/vHrO+mfJ31g8cflNdH6?=
 =?us-ascii?Q?dgUNEc4qf90JMwp5anoPI0tbHGoKV/M7tF9ATGA+QI+zXNwNFo/GRzB9h+E3?=
 =?us-ascii?Q?OIhIGyV2tBahhxjoaol49sDrauoY19iIOH9ka/OMSZ9/rZsWplNo369c5sKX?=
 =?us-ascii?Q?XTHzj294gkCnijjTACaIKBWpGlaaUyi6Z//cvWAHYX989ysPt5epYJ/wmXEd?=
 =?us-ascii?Q?mtNHihxuX3DSPjInKlKCj8Ri4j7Gmfo3oA3iutK+KvtuHlhqR/p3ntTKDWP/?=
 =?us-ascii?Q?RGEasmbbbOztbAAK+kmnYpNLvOkJK7lyZ2ChgiyM/4dKpjlXRMMBbrFWIcwA?=
 =?us-ascii?Q?fg9YRnlbv6OtqNrl2MLEaSIhLTqUVL5Ik0FClqWExRwW60Cs4e3LEWGdH7mU?=
 =?us-ascii?Q?LELauY1FIowClhmM8gDGtBCv4FGKYNki1S/dl3c2bmG0ms9suRSIHhsx/DKi?=
 =?us-ascii?Q?2vZcG1jjeDFUmwLcH8Q1Lr3eidn+CkqcDxNxO2EGSWbS+zSXZGwejMeDckPS?=
 =?us-ascii?Q?ycap0JniXXtSpNb98mmBUwwAxY95yYZmorSnwutWOvq31T55kAfJYbLuaAc5?=
 =?us-ascii?Q?YtmASPmW+ZVEB1ICiOV73l4OOTqqcTEs7QDE1uDc+sA28MteWDYOj+EwLZHC?=
 =?us-ascii?Q?PdZwIY7v4COyoGJ2NRWUCPAyWEEJXvzMJT769mBDTImqey/2i0wmrubrpPPr?=
 =?us-ascii?Q?eBUsG0Yn+eACSIF9PaIrvXmZQv9XbX6JdqLiIR9xwXa7owc3BGyoh3grmwEr?=
 =?us-ascii?Q?umAqf50GDJUt6V2gIUZ8jrxQv5IyHO3wgNGovuwE8ZcxIw/Ut+CJZgMsHpnf?=
 =?us-ascii?Q?pyC6b+VdGrJ8BkYWg/ldBT1Apk+XuWkEgl2Y1dCfWrWxJgQzuunsP9esoojJ?=
 =?us-ascii?Q?QN3UeJMKae+VnRZMKV1VZ/GfzOWrcCEP2u8Hu2B9S+thL7tv22M/jvzEgScO?=
 =?us-ascii?Q?mbUNztoQvPaTc7CqIM1Htk7g1ANroIzRPW0NDtdpkPZXSSoPfE+Ad28wK5Ov?=
 =?us-ascii?Q?TxUgLa/v+yPROm8ri3CRuZ2JpAMnxXHxIfxehPyHRFmzTiqUG6xyzjJEr6IM?=
 =?us-ascii?Q?w0aKgu1JpDtmDYkYeiSXvpv+pZyjGhl/F7ba0aCDUoZ4ClDFTWclyFGubvKl?=
 =?us-ascii?Q?1836ic6o5tTBV58MEBHkAaWFs297086chgd/1VNvCMz5hhiprFDdkKlf/7Cx?=
 =?us-ascii?Q?8bJhCUu2hOycEVtk+796vJa4wHtyk11ojoDh9jdY8h5R1n0MwcU4cumTtmBF?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f68c8e3-548a-4c2f-e2b6-08da71387774
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:00:56.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qveuYKvayfaBvzhwPHmFNcM5IDjx8LmQ/cz7knfOjeK7KBK47y9Xz4O0Lv6GPCe25Ixrk5hf8ploiMZaKdASO4dIM+L2OwlYHVagYmX6D4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290032
X-Proofpoint-ORIG-GUID: fa32fymB_rQf5vhAQ0v60oGLKdwXK8WO
X-Proofpoint-GUID: fa32fymB_rQf5vhAQ0v60oGLKdwXK8WO
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Harshit Mogalapalli brought this memory corruption issue to me.  Can you
take a look?  I don't know how to fix it.

The patch f764a6c2c1e4: "Bluetooth: ISO: Add broadcast support" from
Mar 9, 2022, leads to the following Smatch static checker warning:

	net/bluetooth/iso.c:1282 iso_sock_getsockopt()
	error: copy_to_user() 'base' too small (252 vs 254)

That warning is because Smatch gets confused but in reviewing the code,
it turns out that Smatch is correct (like a stopped clock which is
correct by accident).  The actual bug happens earlier in
eir_append_service_data().

Step 1:	iso_sock_setsockopt() sets ->base_len to 0-252

net/bluetooth/iso.c
  1208                  if (optlen > sizeof(iso_pi(sk)->base)) {
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  1209                          err = -EOVERFLOW;
  1210                          break;
  1211                  }
  1212  
  1213                  len = min_t(unsigned int, sizeof(iso_pi(sk)->base), optlen);
  1214  
  1215                  if (copy_from_sockptr(iso_pi(sk)->base, optval, len)) {
  1216                          err = -EFAULT;
  1217                          break;
  1218                  }
  1219  
  1220                  iso_pi(sk)->base_len = len;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Step 2: iso_connect_bis() passes ->base_len to hci_connect_bis()

net/bluetooth/iso.c
   235  static int iso_connect_bis(struct sock *sk)
   236  {
   237          struct iso_conn *conn;
   238          struct hci_conn *hcon;
   239          struct hci_dev  *hdev;
   240          int err;
   241  
   242          BT_DBG("%pMR", &iso_pi(sk)->src);
   243  
   244          hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
   245                               iso_pi(sk)->src_type);
   246          if (!hdev)
   247                  return -EHOSTUNREACH;
   248  
   249          hci_dev_lock(hdev);
   250  
   251          if (!bis_capable(hdev)) {
   252                  err = -EOPNOTSUPP;
   253                  goto done;
   254          }
   255  
   256          /* Fail if out PHYs are marked as disabled */
   257          if (!iso_pi(sk)->qos.out.phy) {
   258                  err = -EINVAL;
   259                  goto done;
   260          }
   261  
   262          hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst, iso_pi(sk)->dst_type,
   263                                 &iso_pi(sk)->qos, iso_pi(sk)->base_len,
                                                         ^^^^^^^^^^^^^^^^^^^^^
   264                                 iso_pi(sk)->base);
   265          if (IS_ERR(hcon)) {
   266                  err = PTR_ERR(hcon);

Step 3:  hci_connect_bis() passes base_len to eir_append_service_data().
The buffer here is ->le_per_adv_data which is also size 252 bytes.

net/bluetooth/hci_conn.c
  2058          /* Add Basic Announcement into Peridic Adv Data if BASE is set */
  2059          if (base_len && base) {
  2060                  base_len = eir_append_service_data(conn->le_per_adv_data, 0,
                                                           ^^^^^^^^^^^^^^^^^^^^^
  2061                                                     0x1851, base, base_len);
                                                                         ^^^^^^^^
  2062                  conn->le_per_adv_data_len = base_len;
  2063          }

Step 4: memory corruption in eir_append_service_data()

net/bluetooth/eir.c
    69  u8 eir_append_service_data(u8 *eir, u16 eir_len, u16 uuid, u8 *data,
    70                             u8 data_len)
    71  {
    72          eir[eir_len++] = sizeof(u8) + sizeof(uuid) + data_len;
    73          eir[eir_len++] = EIR_SERVICE_DATA;
    74          put_unaligned_le16(uuid, &eir[eir_len]);
    75          eir_len += sizeof(uuid);
    76          memcpy(&eir[eir_len], data, data_len);
                            ^^^^^^^         ^^^^^^^^
    77          eir_len += data_len;
    78  
    79          return eir_len;
    80  }

The "eir" buffer has 252 bytes and data_len is 252 but we do a memcpy()
to &eir[4] so this can corrupt 4 bytes beyond the end of the buffer.

If you look back at the caller it sets conn->le_per_adv_data_len to a
max of 4 + 252 = 256 but truncated to 255.  This eventually gets passed
to iso_sock_getsockopt() leading to a read overflow.  But the first part
of the bug is in eir_append_service_data().

regards,
dan carpenter
