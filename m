Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63944C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F82074B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 12:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="edOAm8BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgDGMeZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:34:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgDGMeZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 08:34:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037CWwMq194539;
        Tue, 7 Apr 2020 12:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=PkCrTT9IlKCikFpqzKZ+v+t1aZQY2cZpxs4o/qLxPRY=;
 b=edOAm8BXwG5i6/P5P86/U6BVaeauOc5rAkZogpZUbELbjN5tGNye9z9oL0debZHoHVS4
 30C1wkAsgI5gGA5witI1+dpSOaCJujuCT1tw7kGN3nuMTeMtGU7w8czfnFT9Jad3NYIW
 5zljjwXe0Q6kCzxw2SlrKAdqfySa78al5lBtOREDjt/QTJ+YrW5a0obLyO+t+qonnxTM
 x4yzD2sFn/8KqK5aJKsHVPmO9H4BE+n9MBEfCeh96Hxr1pmvQml+Y1gYVO+y7u7eXANR
 8m898sKxvPZGeAQIxWmBPBu12U3CThAlZRkN4hpeSuW9drmshcaCaFb8ykwtIvCr6w5S DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 306jvn4hf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 12:34:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037CQdjF098591;
        Tue, 7 Apr 2020 12:32:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3073ss1b9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 12:32:22 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037CWLH3008627;
        Tue, 7 Apr 2020 12:32:21 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 05:32:21 -0700
Date:   Tue, 7 Apr 2020 15:32:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     sathish.narasimman@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: btusb: handle mSBC audio over USB Endpoints
Message-ID: <20200407123215.GA101015@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=3 adultscore=0 bulkscore=0 mlxlogscore=524
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=3
 mlxlogscore=569 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070109
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Sathish Narasimman,

This is a semi-automatic email about new static checker warnings.

The patch baac6276c0a9: "Bluetooth: btusb: handle mSBC audio over USB
Endpoints" from Apr 3, 2020, leads to the following Smatch complaint:

    drivers/bluetooth/btusb.c:1665 btusb_work()
    error: we previously assumed 'data->isoc' could be null (see line 1642)

drivers/bluetooth/btusb.c
  1641			if (!test_bit(BTUSB_DID_ISO_RESUME, &data->flags)) {
  1642				err = usb_autopm_get_interface(data->isoc ? data->isoc : data->intf);
                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This code assumes that "data->isoc" can be NULL.

  1643				if (err < 0) {
  1644					clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
  1645					usb_kill_anchored_urbs(&data->isoc_anchor);
  1646					return;
  1647				}
  1648	
  1649				set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
  1650			}
  1651	
  1652			if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_CVSD) {
  1653				if (hdev->voice_setting & 0x0020) {
  1654					static const int alts[3] = { 2, 4, 5 };
  1655	
  1656					new_alts = alts[data->sco_num - 1];
  1657				} else {
  1658					new_alts = data->sco_num;
  1659				}
  1660			} else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
  1661	
  1662				data->usb_alt6_packet_flow = true;
  1663	
  1664				/* Check if Alt 6 is supported for Transparent audio */
  1665				if (btusb_find_altsetting(data, 6))
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
The new btusb_find_altsetting() dereferences it without checking.

  1666					new_alts = 6;
  1667				else

regards,
dan carpenter
