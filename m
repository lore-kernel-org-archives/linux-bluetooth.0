Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AD5C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46D52082F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 10:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxxainUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAQKYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:24:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45180 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAQKYe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 05:24:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HANRQk152928;
        Fri, 17 Jan 2020 10:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=I7p0+z1M5R6fIqDgwPlMajpmtPLunaqaqI3sSlF5YPc=;
 b=BxxainUHv3tmalOqkGfB5NZBBdEafKURmGVLGnGFQgd3oXPGa7o3DY8F54VawgNH52qp
 +3mlIGyodGDe07YQvDL4cvIK1K/4S7la2xCqGJ1l/ZMHItlSq3YT64seYjulyJsbsViO
 q7VSYVKBX2P6ml0b7HHKZ1MAU9kPhKgFgKTGGbwL7+j6ZvsWUwWitpbrl9yC7gGlvZcD
 Ow7KdF5uKkJlKzrX0EGCJViC+LoqQQWotj+InU3lo3AxBVks8uqw/bVqPMmEHj++aBY6
 2sQ7T465fhxRIqVALMGZakxY+FlfoVYwA54Uf4aoFVOk9ht+IYx85EvmDlROwLWW4em4 xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xf73u7trx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 10:24:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HAOOFn047978;
        Fri, 17 Jan 2020 10:24:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xk231gbeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 10:24:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00HAO5Fg010883;
        Fri, 17 Jan 2020 10:24:05 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 02:24:04 -0800
Date:   Fri, 17 Jan 2020 13:23:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     rjliao@codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: hci_qca: Retry btsoc initialize when it fails
Message-ID: <20200117102356.x3hqe33pkvaw3o4e@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170081
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Rocky Liao,

The patch bb2500ab0270: "Bluetooth: hci_qca: Retry btsoc initialize
when it fails" from Jan 15, 2020, leads to the following static
checker warning:

	drivers/bluetooth/hci_qca.c:1624 qca_setup()
	warn: variable dereferenced before check 'hu->serdev' (see line 1623)

	drivers/bluetooth/hci_qca.c:1718 qca_power_shutdown()
	warn: variable dereferenced before check 'hu->serdev' (see line 1701)

drivers/bluetooth/hci_qca.c
  1615                  ret = 0;
  1616          } else {
  1617                  if (retries < MAX_INIT_RETRIES) {
  1618                          qca_power_shutdown(hu);
                                ^^^^^^^^^^^^^^^^^^^^^^
Dereferenced inside function

  1619                          if (hu->serdev) {
                                    ^^^^^^^^^^
Too late.

  1620                                  serdev_device_close(hu->serdev);
  1621                                  ret = serdev_device_open(hu->serdev);
  1622                                  if (ret) {
  1623                                          bt_dev_err(hdev, "failed to open port");
  1624                                          return ret;
  1625                                  }
  1626                          }
  1627                          retries++;
  1628                          goto retry;
  1629                  }
  1630          }

[ snip ]

  1689  static void qca_power_shutdown(struct hci_uart *hu)
  1690  {
  1691          struct qca_serdev *qcadev;
  1692          struct qca_data *qca = hu->priv;
  1693          unsigned long flags;
  1694          enum qca_btsoc_type soc_type = qca_soc_type(hu);
  1695  
  1696          qcadev = serdev_device_get_drvdata(hu->serdev);
                                                   ^^^^^^^^^^
Deref.

  1697  
  1698          /* From this point we go into power off state. But serial port is
  1699           * still open, stop queueing the IBS data and flush all the buffered
  1700           * data in skb's.
  1701           */
  1702          spin_lock_irqsave(&qca->hci_ibs_lock, flags);
  1703          clear_bit(QCA_IBS_ENABLED, &qca->flags);
  1704          qca_flush(hu);
  1705          spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
  1706  
  1707          hu->hdev->hw_error = NULL;
  1708          hu->hdev->cmd_timeout = NULL;
  1709  
  1710          /* Non-serdev device usually is powered by external power
  1711           * and don't need additional action in driver for power down
  1712           */
  1713          if (!hu->serdev)
                     ^^^^^^^^^^
Too late.

  1714                  return;
  1715  
  1716          if (qca_is_wcn399x(soc_type)) {
  1717                  host_set_baudrate(hu, 2400);
  1718                  qca_send_power_pulse(hu, false);
  1719                  qca_regulator_disable(qcadev);
  1720          } else {
  1721                  gpiod_set_value_cansleep(qcadev->bt_en, 0);
  1722          }
  1723  }

regards,
dan carpenter
