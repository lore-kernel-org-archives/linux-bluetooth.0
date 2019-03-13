Return-Path: <SRS0=EDUn=RQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E0C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 06:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2AB2070D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 06:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8fRfhTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCMGpK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:45:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33188 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfCMGpK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Mar 2019 02:45:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2D6dcEq143389;
        Wed, 13 Mar 2019 06:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=OoBbWJjmZfPi407TGSrJ9ONIk0BjT3JQnDQWjIu6kII=;
 b=Q8fRfhTDBgHP+N3+6C/jLhWL7/EV9YuyHBJPk/d2hBwYWUk7o/slaeXNsrEQX+4KIRDF
 MNTyI3dT41TThDnqL6WOHlXtfCf+U7mrRuunxZ9a1hZ2Q7jXyYoytgwDwS1oQZFsy/ex
 PHxdyvmpvIPv+/FbhkV+aOJ68YkCysEIL6vk6CBdiVHdWcvmjI09gvW8Ijvf9yeMRao3
 V6B1Ceg6FOHnkYb2cqCk+Mz8AECb0SIks9ncZWobRZe2fc/M6bSH6RHmH2eQS8DDrSU6
 VIb1GmhBq7gW+emHOS5CavTVnaA6iM9FjhHZCpH/3Oxig1a0ivrwNJQ0savsTslAoCAS 3Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r44wu8x0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 06:45:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2D6j0O8023554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 06:45:00 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2D6iwBQ030185;
        Wed, 13 Mar 2019 06:44:58 GMT
Received: from kadam (/197.157.0.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 23:44:57 -0700
Date:   Wed, 13 Mar 2019 09:44:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Sean Wang <sean.wang@mediatek.com>
Cc:     kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [bluetooth-next:master 2/3] drivers/bluetooth/btmtksdio.c:471
 btmtksdio_rx_packet() error: uninitialized symbol 'old_data'.
Message-ID: <20190313064449.GC2227@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903130048
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   df4db2340cec316ac054e67379f925c1850e2c36
commit: d74eef2834b5dd2153c4a4d11f14a039fcd64236 [2/3] Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices

smatch warnings:
drivers/bluetooth/btmtksdio.c:471 btmtksdio_rx_packet() error: uninitialized symbol 'old_data'.
drivers/bluetooth/btmtksdio.c:471 btmtksdio_rx_packet() error: uninitialized symbol 'old_len'.

# https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=d74eef2834b5dd2153c4a4d11f14a039fcd64236
git remote add bluetooth-next https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git remote update bluetooth-next
git checkout d74eef2834b5dd2153c4a4d11f14a039fcd64236
vim +/old_data +471 drivers/bluetooth/btmtksdio.c

d74eef28 Sean Wang 2019-03-08  369  
d74eef28 Sean Wang 2019-03-08  370  static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
d74eef28 Sean Wang 2019-03-08  371  {
d74eef28 Sean Wang 2019-03-08  372  	const struct h4_recv_pkt *pkts = mtk_recv_pkts;
d74eef28 Sean Wang 2019-03-08  373  	int pkts_count = ARRAY_SIZE(mtk_recv_pkts);
d74eef28 Sean Wang 2019-03-08  374  	struct mtkbtsdio_hdr *sdio_hdr;
d74eef28 Sean Wang 2019-03-08  375  	unsigned char *old_data;
                                                       ^^^^^^^^

d74eef28 Sean Wang 2019-03-08  376  	unsigned int old_len;
d74eef28 Sean Wang 2019-03-08  377  	int err, i, pad_size;
d74eef28 Sean Wang 2019-03-08  378  	struct sk_buff *skb;
d74eef28 Sean Wang 2019-03-08  379  	u16 dlen;
d74eef28 Sean Wang 2019-03-08  380  
d74eef28 Sean Wang 2019-03-08  381  	if (rx_size < sizeof(*sdio_hdr))
d74eef28 Sean Wang 2019-03-08  382  		return -EILSEQ;
d74eef28 Sean Wang 2019-03-08  383  
d74eef28 Sean Wang 2019-03-08  384  	/* A SDIO packet is exactly containing a Bluetooth packet */
d74eef28 Sean Wang 2019-03-08  385  	skb = bt_skb_alloc(rx_size, GFP_KERNEL);
d74eef28 Sean Wang 2019-03-08  386  	if (!skb)
d74eef28 Sean Wang 2019-03-08  387  		return -ENOMEM;
d74eef28 Sean Wang 2019-03-08  388  
d74eef28 Sean Wang 2019-03-08  389  	skb_put(skb, rx_size);
d74eef28 Sean Wang 2019-03-08  390  
d74eef28 Sean Wang 2019-03-08  391  	err = sdio_readsb(bdev->func, skb->data, MTK_REG_CRDR, rx_size);
d74eef28 Sean Wang 2019-03-08  392  	if (err < 0)
d74eef28 Sean Wang 2019-03-08  393  		goto err_kfree_skb;
                                                ^^^^^^^^^^^^^^^^^^

d74eef28 Sean Wang 2019-03-08  394  
d74eef28 Sean Wang 2019-03-08  395  	/* Keep old data for dump the content in case of some error is
d74eef28 Sean Wang 2019-03-08  396  	 * caught in the following packet parsing.
d74eef28 Sean Wang 2019-03-08  397  	 */
d74eef28 Sean Wang 2019-03-08  398  	old_data = skb->data;
d74eef28 Sean Wang 2019-03-08  399  	old_len = skb->len;
                                        ^^^^^^^^^^^^^^^^^^

d74eef28 Sean Wang 2019-03-08  400  
d74eef28 Sean Wang 2019-03-08  401  	bdev->hdev->stat.byte_rx += rx_size;
d74eef28 Sean Wang 2019-03-08  402  
d74eef28 Sean Wang 2019-03-08  403  	sdio_hdr = (void *)skb->data;
d74eef28 Sean Wang 2019-03-08  404  
d74eef28 Sean Wang 2019-03-08  405  	/* We assume the default error as -EILSEQ simply to make the error path
d74eef28 Sean Wang 2019-03-08  406  	 * be cleaner.
d74eef28 Sean Wang 2019-03-08  407  	 */
d74eef28 Sean Wang 2019-03-08  408  	err = -EILSEQ;
d74eef28 Sean Wang 2019-03-08  409  
d74eef28 Sean Wang 2019-03-08  410  	if (rx_size != le16_to_cpu(sdio_hdr->len)) {
d74eef28 Sean Wang 2019-03-08  411  		bt_dev_err(bdev->hdev, "Rx size in sdio header is mismatched ");
d74eef28 Sean Wang 2019-03-08  412  		goto err_kfree_skb;
d74eef28 Sean Wang 2019-03-08  413  	}
d74eef28 Sean Wang 2019-03-08  414  
d74eef28 Sean Wang 2019-03-08  415  	hci_skb_pkt_type(skb) = sdio_hdr->bt_type;
d74eef28 Sean Wang 2019-03-08  416  
d74eef28 Sean Wang 2019-03-08  417  	/* Remove MediaTek SDIO header */
d74eef28 Sean Wang 2019-03-08  418  	skb_pull(skb, sizeof(*sdio_hdr));
d74eef28 Sean Wang 2019-03-08  419  
d74eef28 Sean Wang 2019-03-08  420  	/* We have to dig into the packet to get payload size and then know how
d74eef28 Sean Wang 2019-03-08  421  	 * many padding bytes at the tail, these padding bytes should be removed
d74eef28 Sean Wang 2019-03-08  422  	 * before the packet is indicated to the core layer.
d74eef28 Sean Wang 2019-03-08  423  	 */
d74eef28 Sean Wang 2019-03-08  424  	for (i = 0; i < pkts_count; i++) {
d74eef28 Sean Wang 2019-03-08  425  		if (sdio_hdr->bt_type == (&pkts[i])->type)
d74eef28 Sean Wang 2019-03-08  426  			break;
d74eef28 Sean Wang 2019-03-08  427  	}
d74eef28 Sean Wang 2019-03-08  428  
d74eef28 Sean Wang 2019-03-08  429  	if (i >= pkts_count) {
d74eef28 Sean Wang 2019-03-08  430  		bt_dev_err(bdev->hdev, "Invalid bt type 0x%02x",
d74eef28 Sean Wang 2019-03-08  431  			   sdio_hdr->bt_type);
d74eef28 Sean Wang 2019-03-08  432  		goto err_kfree_skb;
d74eef28 Sean Wang 2019-03-08  433  	}
d74eef28 Sean Wang 2019-03-08  434  
d74eef28 Sean Wang 2019-03-08  435  	/* Remaining bytes cannot hold a header*/
d74eef28 Sean Wang 2019-03-08  436  	if (skb->len < (&pkts[i])->hlen) {
d74eef28 Sean Wang 2019-03-08  437  		bt_dev_err(bdev->hdev, "The size of bt header is mismatched");
d74eef28 Sean Wang 2019-03-08  438  		goto err_kfree_skb;
d74eef28 Sean Wang 2019-03-08  439  	}
d74eef28 Sean Wang 2019-03-08  440  
d74eef28 Sean Wang 2019-03-08  441  	switch ((&pkts[i])->lsize) {
d74eef28 Sean Wang 2019-03-08  442  		case 1:
d74eef28 Sean Wang 2019-03-08  443  			dlen = skb->data[(&pkts[i])->loff];
d74eef28 Sean Wang 2019-03-08  444  			break;
d74eef28 Sean Wang 2019-03-08  445  		case 2:
d74eef28 Sean Wang 2019-03-08  446  			dlen = get_unaligned_le16(skb->data +
d74eef28 Sean Wang 2019-03-08  447  						  (&pkts[i])->loff);
d74eef28 Sean Wang 2019-03-08  448  			break;
d74eef28 Sean Wang 2019-03-08  449  		default:
d74eef28 Sean Wang 2019-03-08  450  			goto err_kfree_skb;
d74eef28 Sean Wang 2019-03-08  451  	}
d74eef28 Sean Wang 2019-03-08  452  
d74eef28 Sean Wang 2019-03-08  453  	pad_size = skb->len - (&pkts[i])->hlen -  dlen;
d74eef28 Sean Wang 2019-03-08  454  
d74eef28 Sean Wang 2019-03-08  455  	/* Remaining bytes cannot hold a payload */
d74eef28 Sean Wang 2019-03-08  456  	if (pad_size < 0) {
d74eef28 Sean Wang 2019-03-08  457  		bt_dev_err(bdev->hdev, "The size of bt payload is mismatched");
d74eef28 Sean Wang 2019-03-08  458  		goto err_kfree_skb;
d74eef28 Sean Wang 2019-03-08  459  	}
d74eef28 Sean Wang 2019-03-08  460  
d74eef28 Sean Wang 2019-03-08  461  	/* Remove padding bytes */
d74eef28 Sean Wang 2019-03-08  462  	skb_trim(skb, skb->len - pad_size);
d74eef28 Sean Wang 2019-03-08  463  
d74eef28 Sean Wang 2019-03-08  464  	/* Complete frame */
d74eef28 Sean Wang 2019-03-08  465  	(&pkts[i])->recv(bdev->hdev, skb);
d74eef28 Sean Wang 2019-03-08  466  
d74eef28 Sean Wang 2019-03-08  467  	return 0;
d74eef28 Sean Wang 2019-03-08  468  
d74eef28 Sean Wang 2019-03-08  469  err_kfree_skb:
d74eef28 Sean Wang 2019-03-08  470  	print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
d74eef28 Sean Wang 2019-03-08 @471  		       old_data, old_len, true);
d74eef28 Sean Wang 2019-03-08  472  	kfree_skb(skb);
d74eef28 Sean Wang 2019-03-08  473  
d74eef28 Sean Wang 2019-03-08  474  	return err;
d74eef28 Sean Wang 2019-03-08  475  }
d74eef28 Sean Wang 2019-03-08  476  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
