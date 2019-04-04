Return-Path: <SRS0=7owS=SG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97CCC4360F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Apr 2019 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A267E206DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Apr 2019 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d5GARRW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfDDIfI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:35:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50676 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDIfI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Apr 2019 04:35:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x348Slno077778;
        Thu, 4 Apr 2019 08:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=c1PNVfR99rikt3rgvFfaZ4FGzo9A2+g1B61NnYnBmQU=;
 b=d5GARRW3laiyRuC5xLaOj/Z7RmtUAa/l/yUwU3Vej99F2ezhCx5rRn6ZSWgEdj+w+sjH
 TEjtvlsDu3wdHsaSI/Lc+5ct1BgrFln0OMOptitrz0Tu+RfiZwGyKaLrQpR2Bs4fgIS9
 PRQV6GPRTiKdkzZZQTYLmVZHvZosp+8/RMkB8p3UATlMLVrxxNr3U6e7RIZ3aW1jMKlv
 o3aSr1cSJl8qL2wqCqD22CwpZpSg4nrh13IFrM6+7zQznyShz5hGRvhyujwgGSgnhapn
 Ij8aaaQuDWYOrdMc4jk5CpwqEkNildl5wU73XQ0Eo1v04uXv0Me9o2fRYnufCzRJk16D ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rj13qdj39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 08:35:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x348XMjP115762;
        Thu, 4 Apr 2019 08:35:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rm9mjg2c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 08:35:02 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x348Yxws027142;
        Thu, 4 Apr 2019 08:34:59 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 01:34:58 -0700
Date:   Thu, 4 Apr 2019 11:34:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: Re: [Patch net v2 2/3] bluetooth: validate HCI_EV_LE_META packet
 carefully
Message-ID: <20190404083449.GL32613@kadam>
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
 <20190403230835.1174-3-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403230835.1174-3-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040061
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 03, 2019 at 04:08:34PM -0700, Cong Wang wrote:
>  static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	u8 num_reports = skb->data[0];
> -	void *ptr = &skb->data[1];
> +	unsigned int len;
> +	u8 num_reports;
> +
> +	if (unlikely(!pskb_may_pull(skb, 1)))
> +		return;
> +	num_reports = skb->data[0];
> +	len = 1;
>  
>  	hci_dev_lock(hdev);
>  
>  	while (num_reports--) {
> -		struct hci_ev_le_ext_adv_report *ev = ptr;
> +		struct hci_ev_le_ext_adv_report *ev;
>  		u8 legacy_evt_type;
>  		u16 evt_type;
> +		u8 ev_len;
> +
> +		if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev))))
> +			break;
> +		ev = (void *)skb->data + len;
> +		ev_len = ev->length + 1;

The "+ 1" is a bug.  It was discussed in a different thread.  Jaganath
says he has sent a patch to fix it already.

Probably it worked in testing because the num_reports was always 1, but
now when we add this condition with the "+ 1" bug at the start of the
loop the the the num_reports == 1 case will be broken as well.

Tomas and I should get Reported-by tags for parts of this patch.

> +		if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev) + ev_len)))
> +			break;
> +		ev = (void *)skb->data + len;
>  
>  		evt_type = __le16_to_cpu(ev->evt_type);
>  		legacy_evt_type = ext_evt_type_to_legacy(evt_type);
> @@ -5601,7 +5645,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  					   ev->data, ev->length);
>  		}
>  
> -		ptr += sizeof(*ev) + ev->length + 1;
> +		len += sizeof(*ev) + ev_len;
>  	}
>  
>  	hci_dev_unlock(hdev);

regards,
dan carpenter

