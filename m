Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796C5C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287A321D43
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 09:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F56FMjbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRJlO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 05:41:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54134 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRJlO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 05:41:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08I9Os6m163718;
        Fri, 18 Sep 2020 09:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=vDBF5kFrgqmdPnZPlrHbxd9DtRdslvQv1y7jICfqxDw=;
 b=F56FMjbpDm/iShzCGMW7SrZG5PraP2yUgvS0H5xYmRNE1E2U1/M1BacXiCtTvPDll3Hg
 /qSAUoeHQtEWOBAwHy9sAmtq77vmlyrPIJ1MXOlxgH9gO6B4YaGunJRjXKU9hG2lCocf
 AJon8270mfDwuS4docu6jWFBMHzFlMP/EKwp7j45FLId+270pEzOaAdof1K5WLdZoZ1C
 n7qlYNLRNecl71neEhxJkt7MbNodNOBWlzQD7VdnaFSvpgOFtXEW6uVaRuLiceE/q1Z9
 EHOv1jDsCJn8wmbXTXbeTof1koOS4duK0d3efdk0MeWKKVboTRJ8ZBbJFBnPguYf92S8 Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91dyvvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 09:41:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08I9Q6dH094197;
        Fri, 18 Sep 2020 09:39:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33khppefxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 09:39:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08I9d8Iq021928;
        Fri, 18 Sep 2020 09:39:08 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 09:39:07 +0000
Date:   Fri, 18 Sep 2020 12:39:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kiraank@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: btintel: Add infrastructure to read
 controller information
Message-ID: <20200918093902.GA882111@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=3
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=3 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180079
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Kiran K,

The patch 57375beef71a: "Bluetooth: btintel: Add infrastructure to
read controller information" from Sep 14, 2020, leads to the
following static checker warning:

	drivers/bluetooth/btintel.c:490 btintel_read_version_tlv()
	error: 'tlv->len' from user is not capped properly

drivers/bluetooth/btintel.c
   426          /* Consume Command Complete Status field */
   427          skb_pull(skb, 1);
   428  
   429          /* Event parameters contatin multiple TLVs. Read each of them
   430           * and only keep the required data. Also, it use existing legacy
   431           * version field like hw_platform, hw_variant, and fw_variant
   432           * to keep the existing setup flow
   433           */
   434          while (skb->len) {
                       ^^^^^^^^
I feel like these days we are trying to not trust firmware...  Smatch
is complaining because it distrusts all skb->data information, but
unless the devs at Google have a way to connect a fuzzer to this then
trusting is probably harmless.  Anyway, the rest of this email assumes
that fuzzing is possible.

If skb->len is less than sizeof(*tlv) then it will read beyond the end
of the skb.

while (skb->len >= sizeof(struct intel_tlv)) {

But struct intel_tlv is variable length so it's more complicated than
just testing while we need aditional tests below.

   435                  struct intel_tlv *tlv;
   436  
   437                  tlv = (struct intel_tlv *)skb->data;

if (struct_size(tlv->len, val, tvl) > skb->len)
	return -EINVAL;

The length has to be at least 1.

if (tvl->len < 1)
	return -EINVAL;

   438                  switch (tlv->type) {
   439                  case INTEL_TLV_CNVI_TOP:

Ever test which is reads more than 1 byte has to have a check:

if (tvl->len < sizeof(u32))
	return -EINVAL;

   440                          version->cnvi_top = get_unaligned_le32(tlv->val);
   441                          break;
   442                  case INTEL_TLV_CNVR_TOP:

Here too, etc.

   443                          version->cnvr_top = get_unaligned_le32(tlv->val);
   444                          break;
   445                  case INTEL_TLV_CNVI_BT:
   446                          version->cnvi_bt = get_unaligned_le32(tlv->val);
   447                          break;
   448                  case INTEL_TLV_CNVR_BT:
   449                          version->cnvr_bt = get_unaligned_le32(tlv->val);
   450                          break;
   451                  case INTEL_TLV_DEV_REV_ID:
   452                          version->dev_rev_id = get_unaligned_le16(tlv->val);
   453                          break;
   454                  case INTEL_TLV_IMAGE_TYPE:
   455                          version->img_type = tlv->val[0];
   456                          break;
   457                  case INTEL_TLV_TIME_STAMP:

if (tvl->len < sizeof(u16))
	return -EINVAL;

   458                          version->timestamp = get_unaligned_le16(tlv->val);
   459                          break;
   460                  case INTEL_TLV_BUILD_TYPE:
   461                          version->build_type = tlv->val[0];
   462                          break;
   463                  case INTEL_TLV_BUILD_NUM:
   464                          version->build_num = get_unaligned_le32(tlv->val);
   465                          break;
   466                  case INTEL_TLV_SECURE_BOOT:
   467                          version->secure_boot = tlv->val[0];
   468                          break;
   469                  case INTEL_TLV_OTP_LOCK:
   470                          version->otp_lock = tlv->val[0];
   471                          break;
   472                  case INTEL_TLV_API_LOCK:
   473                          version->api_lock = tlv->val[0];
   474                          break;
   475                  case INTEL_TLV_DEBUG_LOCK:
   476                          version->debug_lock = tlv->val[0];
   477                          break;
   478                  case INTEL_TLV_MIN_FW:

if (tvl->len < 3)
	return -EINVAL;

   479                          version->min_fw_build_nn = tlv->val[0];
   480                          version->min_fw_build_cw = tlv->val[1];
   481                          version->min_fw_build_yy = tlv->val[2];
   482                          break;
   483                  case INTEL_TLV_LIMITED_CCE:
   484                          version->limited_cce = tlv->val[0];
   485                          break;
   486                  case INTEL_TLV_SBE_TYPE:
   487                          version->sbe_type = tlv->val[0];
   488                          break;
   489                  case INTEL_TLV_OTP_BDADDR:
   490                          memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
tlv->len comes from the network and it's 0-255.  If it's more than 6
then this will corrupt memory.  There is no caller for this function yet
in linux-next so if tvl->len is less than 6 will that leave
uninitialized memory in ->otp_bd_addr?

	if (tlv->len != sizeof(version->otp_bd_addr))
		return -EINVAL;

   491                          break;
   492                  default:
   493                          /* Ignore rest of information */
   494                          break;
   495                  }
   496                  /* consume the current tlv and move to next*/
   497                  skb_pull(skb, tlv->len + sizeof(*tlv));
   498          }
   499  
   500          kfree_skb(skb);
   501          return 0;

regards,
dan carpenter
