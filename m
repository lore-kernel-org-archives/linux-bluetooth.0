Return-Path: <SRS0=tmcz=3Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D582C32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 08:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BA4214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 08:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VrQjsOMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgA0It6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:49:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgA0It6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 03:49:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R8muPS073223;
        Mon, 27 Jan 2020 08:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=kVcFi2lgBzaVyyAsMAuJKq3/dDM00AMCKyQhBCPrxLg=;
 b=VrQjsOMoH3ddEZzsWAPiXaltYHUYIrf62j/GNOsfpblRsMOM6ZgBD0vJMe5aULuI8PqU
 khHXxBgm71HKm4+9Yh/HvMBI5C6y46pSIl5B1JYgkKXd3tPAloEaMuP1ev/D3D37Us8t
 uIFaIND4rhGGouIOx5lEtzq93q0x0MiIvNO8TPwa47qFdY2RtX6Boq026ohfbBYol6yA
 P9IFgX2IpDT1e+5BiZ1ufhSIahE8VpZZt+UEU4+4xj7uEQCQFPj41spLL0KYnY+g3FVo
 QebDAvHEImfjNKaAueImhQlf4X4d171fhARhlTR5pBKxGXBI76nBebnebfTKbfgFp2/W DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3twvfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:49:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R8nO4u180935;
        Mon, 27 Jan 2020 08:49:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xryu8wy14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:49:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00R8ns9Y002870;
        Mon, 27 Jan 2020 08:49:54 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 00:49:53 -0800
Date:   Mon, 27 Jan 2020 11:49:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add initial implementation of CIS
 connections
Message-ID: <20200127084947.GK1870@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117000137.29166-1-luiz.dentz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270077
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


url:    https://github.com/0day-ci/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-Add-initial-implementation-of-CIS-connections/20200118-034643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/bluetooth/hci_event.c:3188 hci_cc_le_set_cig_params() warn: inconsistent returns 'hdev->lock'.

Old smatch warnings:
net/bluetooth/hci_event.c:5567 hci_le_adv_report_evt() warn: potential spectre issue 'ev->data' [r] (local cap)
net/bluetooth/hci_event.c:5569 hci_le_adv_report_evt() warn: possible spectre second half.  'rssi'

# https://github.com/0day-ci/linux/commit/88d6b37aa7d732b2392e953206c3231560035c3c
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 88d6b37aa7d732b2392e953206c3231560035c3c
vim +3188 net/bluetooth/hci_event.c

88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3150  static void hci_cc_le_set_cig_params(struct hci_dev *hdev, struct sk_buff *skb)
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3151  {
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3152  	struct hci_rp_le_set_cig_params *rp = (void *) skb->data;
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3153  	struct hci_conn *conn;
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3154  	int i = 0;
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3155  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3156  	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3157  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3158  	hci_dev_lock(hdev);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3159  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3160  	rcu_read_lock();
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3161  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3162  	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3163  		if (conn->type != ISO_LINK || conn->handle ||
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3164  		    conn->state == BT_CONNECTED)
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3165  			continue;
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3166  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3167  		if (rp->status) {
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3168  			conn->state = BT_CLOSED;
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3169  			hci_connect_cfm(conn, rp->status);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3170  			hci_conn_del(conn);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3171  			return;
                                                                                ^^^^^^^
goto unlock

88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3172  		}
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3173  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3174  		conn->handle = __le16_to_cpu(rp->handle[i++]);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3175  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3176  		BT_DBG("%p handle 0x%4.4x", conn, conn->handle);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3177  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3178  		/* Create CIS if LE is already connected */
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3179  		if (conn->link->state == BT_CONNECTED)
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3180  			hci_le_create_cis(conn->link);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3181  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3182  		if (i == rp->num_handles)
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3183  			break;
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3184  	}
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3185  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3186  	rcu_read_unlock();
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3187  
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16 @3188  	hci_dev_unlock(hdev);
88d6b37aa7d732 Luiz Augusto von Dentz 2020-01-16  3189  }

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
