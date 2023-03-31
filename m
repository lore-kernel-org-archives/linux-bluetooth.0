Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A0C761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 15:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjCaPJd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjCaPJb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 11:09:31 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060EF20D9A
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 08:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaZb6XvR7Qtmgn5kkirKHMwCfV3CtA5BtYnsCJUA3RZL06lmr6lJjZWQoyCwvK4MYaTXaULZkvCHzKzRINxe1y43wkjGLTj0SbgjaBJ8KVfVDCelUdzlPD/r0gen9XoIF71zRG4u7i6i8aq19MPPJ9Ffm9Q/6qlrP5vyYx7lk09PQjgEUMmW6RcrcWiGppQZebfS7IIlMgSaoXNbVk5JLqwZUWPhgBnkGlLgHur/12CE1H0qKzSkCgE1/G5aDZplgk4T8F7daEobRZwzOI6DntZnSQ5vwUpD9qyawnp7ChZaixSRAdDXEx586AHAiDjB5PQfKBZrC5Fgo3dBd+ROIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=584gJNlnePEKLRvxhQU8MUYHbrBFFJj4wsOa/X7xesI=;
 b=QYXvcJ7syx2p1hWLN6LyuGIvIlq8sOWk+5x7/+BZh3EgyqVRB2xjuTNCP+aWx0SDjDI9AJ0WaTMoplq4ReXf/RcgF53SLP3YEkgHj8v6szx7tTUZ/EK1um4VwdDZoKxRyT4miT1lvyWv1zbR9qZkluITnNaLFIp3R3VPC8qzUnfkV+PD5ZBijavD/lh4dJlJfZ0843lgQ1xF+Xw/z5Ax7SlqTXYl1z9lkw7iee8cnIwD6JGJmJMV3q1R194BcB8+eFXjO1ujlBVPfNyIwCZ0HyU2EQpBmLlmFe8a6xSShPmvv2UVM637hnzcNSKMfcM5E5Gy/uh3GH8aGZsAN4UXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=systech.com; dmarc=pass action=none header.from=systech.com;
 dkim=pass header.d=systech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=systech.com;
Received: from BYAPR20MB2664.namprd20.prod.outlook.com (2603:10b6:a03:fd::26)
 by DS0PR20MB6702.namprd20.prod.outlook.com (2603:10b6:8:167::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.13; Fri, 31 Mar
 2023 15:09:11 +0000
Received: from BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::fb:1ffb:38fe:e0a0]) by BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::fb:1ffb:38fe:e0a0%7]) with mapi id 15.20.6277.013; Fri, 31 Mar 2023
 15:09:11 +0000
Message-ID: <a74362c7-c0ae-5a15-7d73-93863f98c97f@systech.com>
Date:   Fri, 31 Mar 2023 08:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Bluetooth: Fix double free in hci_conn_cleanup
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20230330220235.1035456-1-luiz.dentz@gmail.com>
Content-Language: en-US
From:   Jay Foster <jay.foster@systech.com>
In-Reply-To: <20230330220235.1035456-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:e::13) To BYAPR20MB2664.namprd20.prod.outlook.com
 (2603:10b6:a03:fd::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2664:EE_|DS0PR20MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: de31ccd4-9632-4eaa-869f-08db31f9e1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXkNZVcqLqKul/6b802gF99ERsZZIUBPREDUrAfR+my0y6xkaoEJJbVZoGTEQgQ0MbnHV12tIYCImAHWLS2G+74qy/AXGEGI5aAXWlxhapNrIaH2vEAWdpfsf8WvN7IrOwwwS3e5bBlNapDj04EdDdg/gTz9Ua66j8Q+wvkqR4BYeTV6kfjfAD72/GWjmHzPSSibTDKnvRmTQ9PZdbdFLmuzhsX3NSGa1TXRF3ECY4/Ne3czAH2wSnNcrZ6eiVHE6YOrc2WmOS+7nGpmS0NPPuLj7x6JJbzZgOQl2m/i2HNSZ2sA+tooiUqTqcEPeoa5xmsJy37UCdyf1hIdMPbloYf3SrQgBtlzM1woc/joWKzSGQ4Rd+N8/gul0i2ywoJgWS2LMkMaLkNP9Z4qSjFlj4yau5rmrOfv5JsbIpaOTdqWUYb9HVYdVGFEqG9B7Qy16GnZMAz0ZoHUKSwLbWI3Gm1/NmAw0CrZPBcVVYnViHjTIjZBhLftOy3fes55gEtUfvIUBURQbDNoBWTm6XZu7di29M/OP3pZ6PQAOKkmCueFm+11/2ba5f1KgeVbpYRMo045TPeB385gIQsfotelAbAdS3ONsJML3gld6qbhvNbPoxUNDq+wwUrebW/5/PVNt20QBDmskFHqKHfAig31v+gZPqxlL2oZAqbBOgY+rQme4xPdQ/AHaV7fwvZ6ZaH1zOEHxlPcgRjkr8VDQ/dq0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2664.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39840400004)(366004)(396003)(376002)(346002)(451199021)(83380400001)(36756003)(2616005)(6486002)(6506007)(966005)(53546011)(316002)(478600001)(6666004)(186003)(2906002)(26005)(6512007)(5660300002)(66556008)(38100700002)(8936002)(66476007)(31696002)(41300700001)(66946007)(86362001)(8676002)(44832011)(31686004)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hCTlJmNGxBU0sxL09FV3hoSkZiUW5lb0luTUZ2Ym5VdzBydXBkZlZRQWdL?=
 =?utf-8?B?anBxQ3lVc3RBOVhlcjZaT1IxaUJRNytKVUJrRVUzQWlHKzNOVFluelRYd2dm?=
 =?utf-8?B?dUR5bWZvSTRxNitMOExYazBJb0VmWGI2TThzMko0aWVzZFJrMGtELzhrZUNr?=
 =?utf-8?B?SXFVQnBManF2Wk81a0VDQTdHZkFCR3dSS0NybEtVUVl5VWdidy8xWEVCbUNL?=
 =?utf-8?B?OXliUFRxb056bjJ1eWRya0V3LzlOMVdTdGp1MXdlbE91RjRFT1V6RG1XWWtn?=
 =?utf-8?B?SjZKNFpDdTZVeEViZUhIbXJ6alR2dGpGWWQ0bkdQTUJIUU8ya053SktCVGtn?=
 =?utf-8?B?ZFc3MldFSFBOWGF5Qy8vNlVzN2pPdFpKbG93WmFyUmZqWm9QMnVYSUFjZm1v?=
 =?utf-8?B?WDFlRWZnblh4ek44TDhwT1pFeFNxTkpnK01sdjdnYUZtM0lFUy9yQ0EwS29l?=
 =?utf-8?B?WGlwWmQ4QW5iM0M3ZDFYYUJuZk1wYnJHT0tKa1I0ajBLdG5OSVZxQ1pJdjAv?=
 =?utf-8?B?OXh1Y1cvaFVyK1NjVEw3a3B6VXVxR0F3aWFNK0dlRGR6S0dhb29jWWN0dGdl?=
 =?utf-8?B?b0hxUmtMcnFvc2xGd1hydXI5OWNtcW5jL0JtK0dYRWlRKy93L3J3c3dxYnhY?=
 =?utf-8?B?NlMxcy9RcnlXOHZ6bE9PeEU2ZVU3aWpPMldVSlp6UXUrUDdGc0VUUUwyUWVI?=
 =?utf-8?B?R24ybXFIZ2MxclNTcTQ2K1BHK2NZL01NRHk5czVGZFhTVitKOXJWREdva0Fa?=
 =?utf-8?B?OHUyLzVHaHdpVXMrbGVaY09vS1pVUUpUSkdQQmF6aXA5SzhVeEhTMUVwMTk5?=
 =?utf-8?B?VkwrK2VnNHpYdUdIQVk4T0dUdGtPcGtiZlRNZ2xnT2xhK0hHRWo1bGhQTEVJ?=
 =?utf-8?B?aWRBNTBIUFdtSmsxZTVFSHpRcnVNclV4TDNwaHRSTlNHSVVYZzlUNzN0NGV4?=
 =?utf-8?B?M05EZTMvVGVMMEVEc0w2Y2EwRnd3V0JUektYZEtpWmNFRWFsRXpzZGk2d0dj?=
 =?utf-8?B?N3FwT29veHZXSFBtQTZzSm5sbU1lVFBBclg5UVFLc3psOXFTL1A1dXNCZjI2?=
 =?utf-8?B?Y1RJbjQzbWFJNnU0N1lsRDE1ajdweXdSeXpyendaSWYwRVZ0dFd0V3Q3cXNj?=
 =?utf-8?B?Ui9PWURKYmQ0OUIydytLbnNMYzNFa1c4UUpWSjhaeXFPUVRtTDh4OXFWL1E5?=
 =?utf-8?B?LzQzTzFaaW1KVHo3dmZJUkdveUFDMC9NdG5Ua2tEU2hOVHlxZ1JvVEJlOVpi?=
 =?utf-8?B?SUc2d3lTYnJ5NjJTWlU5VTROMmFnUlVLNlViaC8wVmVpSHNIMVJqWk53akh6?=
 =?utf-8?B?RUM4ak1oeWNVYU02ak1XUkdBWFUrRWJxN3FlZGNic0s1Vytqdm1rbVhDNXJa?=
 =?utf-8?B?bS9Qb0JSaWlPL2R0NVRncXdWbWVjUnZGWTdMejJ0RUc2bkNOSk5CY0ZTN2lF?=
 =?utf-8?B?WnRhVkpiRFhTeHBwZzZKVEJTNzhWblVIUHFwUUlhS3V3aFMxMHEvekpyanBY?=
 =?utf-8?B?cW1zS2cyT2VzOFhxb25hMWl2NmwycDRIUmlOY3Q5QzNJaHlCQzhrVEhHck9y?=
 =?utf-8?B?T1VMOGFieHpObjY0MVc1TDhNemZ4YitwVjg2Q01nRkxhNUs4U0hTSGphQ0Yw?=
 =?utf-8?B?OERTRmcrR1FQSHBBS3lyMnh3WUhzY1FldlVBZkJTUnVaajFaZ3c1OVFyaC9O?=
 =?utf-8?B?Vm5LWC9NUEhvK3NiMWJ5SHh5K1NYTzQ2OElEMG85WldPVElKcC9uMzczODY5?=
 =?utf-8?B?NVozVzE4M3BZRHF3TDRoRUptMHlzMzZBL3o5ZmQ3OU90MDhDNGJWVFFOVkpV?=
 =?utf-8?B?UnNBU3JIUGs3ZG1pb1RObnp1TDhKbkNPQW5MMGhSM2tzeGg1SXJJcVU5by9u?=
 =?utf-8?B?VG1vRm1YWnpwejRhZ2UxbHQ3NGRsdjNTVDlaWnozK05lVjNTeWYwZmVYakJG?=
 =?utf-8?B?OUtnbVh5L1gybjBuRnlpMFRiRjVDdkFwcjB1M05rWXliTEFrbTcrOGJEdDky?=
 =?utf-8?B?cmErcDhHUTJFaHhqM0dTYzV6dnVlbFhhOHpod2x2aE4wVzFVQThjOGtPR0RL?=
 =?utf-8?B?eFlUM3MzZE4reXl5bEhsNjJwWFl5SHRmOXc4WjM5bElmdDlqVlI3NG8wNFpP?=
 =?utf-8?Q?Sjgj9BeWcttNPQ/lDYZHcPWuO?=
X-OriginatorOrg: systech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de31ccd4-9632-4eaa-869f-08db31f9e1e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2664.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:09:11.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 47224f68-59f8-42cf-9b0c-62ae261b2df6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErUVhxSFdh/VuWhmOqe8DloPnbBZW3QHVaNAJFSZfwYZDIqtzoXChEOASL8B5PjyljBLhGE1xFS0Q63fnl97Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB6702
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Do you think this might be the cause of 
https://bugzilla.kernel.org/show_bug.cgi?id=201269 ?

Jay

On 3/30/23 3:02 PM, Luiz Augusto von Dentz wrote:
> From: ZhengHan Wang <wzhmmmmm@gmail.com>
>
> syzbot reports a slab use-after-free in hci_conn_hash_flush [1].
> After releasing an object using hci_conn_del_sysfs in the
> hci_conn_cleanup function, releasing the same object again
> using the hci_dev_put and hci_conn_put functions causes a double free.
> Here's a simplified flow:
>
> hci_conn_del_sysfs:
>    hci_dev_put
>      put_device
>        kobject_put
>          kref_put
>            kobject_release
>              kobject_cleanup
>                kfree_const
>                  kfree(name)
>
> hci_dev_put:
>    ...
>      kfree(name)
>
> hci_conn_put:
>    put_device
>      ...
>        kfree(name)
>
> This patch drop the hci_dev_put and hci_conn_put function
> call in hci_conn_cleanup function, because the object is
> freed in hci_conn_del_sysfs function.
>
> Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]
>
> Signed-off-by: ZhengHan Wang <wzhmmmmm@gmail.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_conn.c  |  6 ++----
>   net/bluetooth/hci_sysfs.c | 23 ++++++++++++-----------
>   2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e4aee5950c36..00d1e7201a44 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -168,13 +168,11 @@ static void hci_conn_cleanup(struct hci_conn *conn)
>   			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
>   	}
>   
> -	hci_conn_del_sysfs(conn);
> -
>   	debugfs_remove_recursive(conn->debugfs);
>   
> -	hci_dev_put(hdev);
> +	hci_conn_del_sysfs(conn);
>   
> -	hci_conn_put(conn);
> +	hci_dev_put(hdev);
>   }
>   
>   static void le_scan_cleanup(struct work_struct *work)
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 08542dfc2dc5..633b82d54272 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -33,7 +33,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
>   {
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	BT_DBG("conn %p", conn);
> +	bt_dev_dbg(hdev, "conn %p", conn);
>   
>   	conn->dev.type = &bt_link;
>   	conn->dev.class = bt_class;
> @@ -46,27 +46,30 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
>   {
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	BT_DBG("conn %p", conn);
> +	bt_dev_dbg(hdev, "conn %p", conn);
>   
>   	if (device_is_registered(&conn->dev))
>   		return;
>   
>   	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
>   
> -	if (device_add(&conn->dev) < 0) {
> +	if (device_add(&conn->dev) < 0)
>   		bt_dev_err(hdev, "failed to register connection device");
> -		return;
> -	}
> -
> -	hci_dev_hold(hdev);
>   }
>   
>   void hci_conn_del_sysfs(struct hci_conn *conn)
>   {
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	if (!device_is_registered(&conn->dev))
> +	bt_dev_dbg(hdev, "conn %p", conn);
> +
> +	if (!device_is_registered(&conn->dev)) {
> +		/* If device_add() has *not* succeeded, use *only* put_device()
> +		 * to drop the reference count.
> +		 */
> +		put_device(&conn->dev);
>   		return;
> +	}
>   
>   	while (1) {
>   		struct device *dev;
> @@ -78,9 +81,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
>   		put_device(dev);
>   	}
>   
> -	device_del(&conn->dev);
> -
> -	hci_dev_put(hdev);
> +	device_unregister(&conn->dev);
>   }
>   
>   static void bt_host_release(struct device *dev)
