Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E12C04A68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 11:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiG0L65 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0L64 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 07:58:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE327CC7
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 04:58:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RAGpUi009181;
        Wed, 27 Jul 2022 11:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=LVybK+RKS1Bu8PSSRcA1nqEkSuR3TRETQJ+pb/17rLM=;
 b=WXcMBSedvx16mYZI7OBxk7WB4OUoSDBNw+h/0hLh3XvJCNRqj4UjeStRE/ebcGwq6MHR
 vvwwrVEdWtB6cY8w0RXxbylVzMAxqJnDzQ3AfDh5n7C55rMESRxG/1E5vv4EORUBakNK
 G2Gf+GuLHNnpoRJLigeVbX7Ru/FhHRL87c1Hep3k9PJx9o9SkHvXj5fRYwCLcQGXUvBA
 qCijaq1xuclLUaertxWy2GFjG9a4PE3ErqzhVdeu98+SrqmJ2kAeKmu4i285Aj3pUxOx
 ayApAi/VFP1nsHqHrfPDYMO6Gy+vn1ELd773KGHSsjtEEaK/d5gKSFAG6rpmG5ZFyNAK rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap0xxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 11:58:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RBdeXm006274;
        Wed, 27 Jul 2022 11:58:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65cu4gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 11:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdJkTAr7J/u9PlR1ikf9p4Zy98a0LLCMmZYym5Ahuhcibb+cyKIWZHR4B2RPEFSacruDhNfR7f8fjmFh+Bdw4rM/f4QqRk2/LK7rC1XkuTkpsmsGccRsbkKbsifCKjAlqOTxVTA8juXGk/cUMUhhhh8AMxUJyLJcc0v9jh5tFdqifIIOuxaZ53WJy7zmX7XhlzNT6Ih3tg6u40x/bRSCd3MbT8yOT1BnMqLlU0+tJkjSrgS6vO+Rumu66Q2/iCs5KY66itRkDEd6orzQg3qYU/WshbGZ43rRkSROYPFeIyv551xu2xz82NRwNYH6uUw9Z8p3e9s0G89fFJxehaiyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVybK+RKS1Bu8PSSRcA1nqEkSuR3TRETQJ+pb/17rLM=;
 b=RkOyVsGVCzRSODJfTwanKlQLBnmGlt6//Lo3y3a3popAgg5CMi45JU1uxHy1EsTS6PnDupjb7rs8342BR8HGOA7PD9IWIHlI5HW67NxUgIVRscdogtijKGAi4vPjFKespSneqE1ObKhVQWyAKa7m2UxlZDPLEiwJXDuESVXDkr/x7af9rahcVTDYoXT1USbsQAbVkQri4/R9E2Tk7Rsqufw12D4m9JjfnzQMpsS8SronrdgWWFg6KH1i9/lY9Lf6ZKIeN/xTZCyYWUbNUb8nxQAQuVzosRnbYJMjFtHgf6JyqFhSifTZ/4uELtlQJJuPvUSuKnUwAiLeTgs51XQYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVybK+RKS1Bu8PSSRcA1nqEkSuR3TRETQJ+pb/17rLM=;
 b=SCr9vK0f8cvCW0v3ci+cRtlQJPdg+ISQ9/sRbQdEfM4+Z9aSGY1z2nzKYnSWWWCjrbODX8e8iqNVOtbVk6FNsqpGaUgh4M4zYGciouvgzUyaJCzuX2Q4PRVgIwXhjrPvJLYt1Xhay4S49EYWJKI40PkxTOvWbO+B3kXQDrAOKL4=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CH0PR10MB5163.namprd10.prod.outlook.com
 (2603:10b6:610:dd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 11:58:50 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02%5]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 11:58:50 +0000
Date:   Wed, 27 Jul 2022 14:58:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: hci_sync: Rework hci_suspend_notifier
Message-ID: <YuEocqGzotojM7vg@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1966aad-a1fd-464f-d240-08da6fc75e97
X-MS-TrafficTypeDiagnostic: CH0PR10MB5163:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEiIglW0duGKV0Y45OrGryJX5e07kJSfI6Ql5c0KFiMTkM9dwOkdZkhl8nzGebue7lm3OlGLi5eMsx6waINQfG5D3RbS24ZjeREDfOv/UdQWzonHMkwb4j60sh4b+Eb/FEseP+cEpFIZpaHc0cJG/2JC6O6/Tf9Fkn7g4b/7SHBNBiVI5OzichNcSPY2vhfkrpCM0Cr+Z51a4oZ+iL6HCZ71lU0VhZDxOOeTGxqXJd+KQm5Vuwtu59OcqevqiZ0EefGl5BqC/qHm94QxUJRXqATtYULqxZirfMHqaq9o9PNzDhBl4JbTJecsKGFBJTefg2FhDgXvQgacYsGM3oh5+P8Y/k9Om2qAKHw3BIFLQFabV6rdSlhntOLeYV8yPrMKxdUSmEUo9NW7ceXRdasuCw2IMKabo1aOeGMOFc4S4X68hfQblGjKzPJy1E4b8RssvD2damChu0Rjvlpj9tVQpvPdDKV5WUYmAvLEe3lCdLTJEjyoLszxmNzRZt4p24Iyn+h9FL/0g7Sdujct/y04c3Db9Rv9wlt0G6UAna1Ap8zVDmEh3CCChaJNwBy7OEVLRoBZ4dnVbrbeTT5qenLvxSq9uhJffV4utkbEHzcPQZ5gjJHZ/zrpKUydaP8ZnZR4gTExvdCpycJ8u9jzhJQcdnx/ns+qmk4wZOjM19JuRjOd9KiF5K7TbBPLQlFkh6k4VMDL7XnsemOL0D70w1wHnKKcMtCYSArex46YWmeQ1qHz9JYul+0ArPpnrEpUrfeGrKSVd6vMGtJadoB0BFE+c2oePKhtcUPrqQ7TD9ZjfAOrg0RnWK2j5uZhPFbxzmac
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(39860400002)(346002)(376002)(366004)(9686003)(186003)(83380400001)(66946007)(4326008)(6916009)(66476007)(66556008)(8676002)(52116002)(6506007)(2906002)(26005)(41300700001)(6666004)(6512007)(33716001)(44832011)(316002)(6486002)(478600001)(86362001)(8936002)(38350700002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFqb8E0QfRkrxGviNI2rMGDGxlqcSMfw26i6h1eAt1qZ3B9vsZLiPb0CY3+V?=
 =?us-ascii?Q?sKXM4E5nLQXT6HQhH5d/SphklJxqOLtgJI8SWk1FO71px0cxMG346ZRcQ1Wf?=
 =?us-ascii?Q?Hv18b0+vB1POSb3IGvYj0JTCnSDVkFN0/t4C1YsQF0GXNq6XA65SN6nG5+EL?=
 =?us-ascii?Q?oZDmWO92yFCbg/+OjjXpQNC89Rl6YjKOlJGNXSNNVPwK+Pd2OUDuvx1UMJ4u?=
 =?us-ascii?Q?AeQzlr24JZodKKOnlNlCQ+6jKKHqT+SS47VhCbm3PFYI6MDTBBEhQFS4Yllv?=
 =?us-ascii?Q?hSub3BJSocFj1VkqihdG6RNuuNIFut0H40JuQ19Iyr33I5fn4cusFr7vdQTZ?=
 =?us-ascii?Q?jVGerzGlBysmPBxeJHdHz/bCmIJKNkLBspOS/1APShaspACF8641/TjPUdLa?=
 =?us-ascii?Q?cY6XNr5QmDkAVpx06atEClkT+/Wrd6yImBEoJFgrzCkdQyvEerM2eWuD16PO?=
 =?us-ascii?Q?1p8u4RKWPQl3BvQWbF5CrmhZX3jB4qLQ1X8YW+Gi/js8c9qo5HlGy42lKXIU?=
 =?us-ascii?Q?EAjJeyTj57+FfAEjMo9IhPCL9DODYtN0cy4N8RpXJHsOfxBHXQqOZWGl3mBz?=
 =?us-ascii?Q?1aZrf6kgMmWBs/zJ2KbvCskxqWubryy7EXzBdCqO4UZAZdnMT+1x/sJGznE+?=
 =?us-ascii?Q?xb3ZD6XnUYrT5kEC4v61dQI0+9Z/C+wt1G5UWwSpwqJr8GhfZjZ5oHp7H13g?=
 =?us-ascii?Q?2n2dLDaJgqu7jQxdVsh9gh08S/lYbVQhzxuJGWMYmV0Vuh7P57kcve2aC8yv?=
 =?us-ascii?Q?5zvEHeGqKEtClltAxD4Z7374NqpS0L40cNVcT/qZ5bszDBFh/EHJePzUufBQ?=
 =?us-ascii?Q?V4r7zCoD/LCGKtnkhSA2e+mGV1KYNenyyzX/1jN6S75X7XuyWQ51wk5YwB8Q?=
 =?us-ascii?Q?YWxa2VoK1kdW6VXGd8gP4cbwNjEsQkUa/1oquTuuyidEGZwoYTgfjuV4FHix?=
 =?us-ascii?Q?KUYMqEElyE3s2WgXcGuKxcwq3d/mXQEXUsdtoPBGMNIRSEcf4IH7q2JN+AmE?=
 =?us-ascii?Q?nkE5BSWh00QTqxWGJTbkaU8W7aw5qs5jtzlqL6hpJ7lXWFNBsjLYqbLD7MwX?=
 =?us-ascii?Q?WDmF5Ywo2IG9BTwvieb8GTtZTf+6ROMJIOm2mMWYwwPnQI5DExjun4e+orc9?=
 =?us-ascii?Q?umiDhzJPzW+a4FvC4Ug+Zw+FspJAVOEZSi51zPo/Bxc1qMMNg19v0gZCBk3K?=
 =?us-ascii?Q?h30iC8hA5G1VkduzuwRHSlUijiYSAvjQvTMuJBZ1ZcBqnRhAVuSR2Hf9ASEW?=
 =?us-ascii?Q?C6hnYamw2677VwahQkKqbskPrQuBQDosH9XcOcBot1szx2so+FjwPZA1Ld1X?=
 =?us-ascii?Q?k0m2JU2vzoobn1oXGjtv0a7O2G1IWgxXTf+U96pxR8BVhTGIOVlj4EvFz+Xv?=
 =?us-ascii?Q?yVW6lFRUbJZs+YQFY7GlfOTFd4ibgFKK1jUzOFebLuQjma1OduB1i49nk8PY?=
 =?us-ascii?Q?nQHS8FyCsAzp7AKzdSIq7orTqXCKuZ37T0vsGcfxkfRE9TWbsLFPXdVm8Gzj?=
 =?us-ascii?Q?rDaP6ESs0EznaVHAdU99qmioBL1HorNu6TW21W+pHGwa7ai4/v0bB7s/HwyF?=
 =?us-ascii?Q?ic703E1+H9bVtKO1Ul+ACn0TBi3OzZENksPo/tyUJ9oVIVHBdZsRtmyOIyps?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1966aad-a1fd-464f-d240-08da6fc75e97
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 11:58:50.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipia+Rbf2z4kvdx78Ugn9Vm+de69dUE/Vwa3dpKU3BnZS6FaO/7N5b/flaJ+CWvRJsBybF3n5EFHhC9R1WGcSkEoWDWWkyI5YS7KpI61dtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_02,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=735 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270050
X-Proofpoint-ORIG-GUID: IiBG8UNx1q4iRK3PfHfYx0Yfll7e02Pi
X-Proofpoint-GUID: IiBG8UNx1q4iRK3PfHfYx0Yfll7e02Pi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz Augusto von Dentz,

The patch 182ee45da083: "Bluetooth: hci_sync: Rework
hci_suspend_notifier" from Oct 27, 2021, leads to the following
Smatch static checker warning:

	net/bluetooth/hci_core.c:1944 hci_add_adv_monitor()
	error: dereferencing freed memory 'monitor'

net/bluetooth/hci_core.c
    1942         case HCI_ADV_MONITOR_EXT_MSFT:
    1943                 status = msft_add_monitor_pattern(hdev, monitor);
--> 1944                 bt_dev_dbg(hdev, "%s add monitor %d msft status %d", hdev->name,
    1945                            monitor->handle, status);
    1946                 break;
    1947         }

The problem is that msft_le_monitor_advertisement_cb() will free
monitor on error.

net/bluetooth/msft.c
   243          monitor->state = ADV_MONITOR_STATE_OFFLOADED;
   244  
   245  unlock:
   246          if (status)
   247                  hci_free_adv_monitor(hdev, monitor);
                            ^^^^                   ^^^^^^^

   248  
   249          hci_dev_unlock(hdev);
   250  
   251          return status;
   252  }

I really think freeing monitor is the wrong thing.  It's a layering
violation.  Other error paths in the callers do not free monitor.  It
leads to other use after frees besides this one that that static checker
found.  For example, it leads to a double free in
__add_adv_patterns_monitor().

regards,
dan carpenter
