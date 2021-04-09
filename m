Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517DC610D1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhDINji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:39:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52728 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDINji (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 09:39:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139Dd2pb160673
        for <linux-bluetooth@vger.kernel.org>; Fri, 9 Apr 2021 13:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=h56VINJys518SBrHJ/KsmE4/VqMzqSFYYELQR+6XRl0=;
 b=d4sQksBpkIupIeMTQVVzKtLrXCHcDcMFeWKaG1fczHv486mmrFzDYhdSIaicc0AHGTmD
 mafbC8yzVo/OyVjPPTaynfcqStnVH9SKVf1dx45wMMcjoch5dGPn0ApDMH9TGkX3nQwR
 C6+eS3Nd8PnF1kzsFW1LRAkfcArKxFhueTc0xRZ5i/5oOCzyBArAbdhGyAj/e8doZSPm
 uZ6zreMeQTJkTSlzAwU7VvxKtWO7su8A78GhYcNLkxKbHKE73BKnrJvgAUhge0o6IRFu
 O4xbHeBHl66O4GxE7+TA6OgjbRoO/7cfhjFSLpll8REd4zeCqyRj6W3FjTMHjk0Cv8Qu Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37rvas9egq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Apr 2021 13:39:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139DaDW4029211;
        Fri, 9 Apr 2021 13:39:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37rvbhmgdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 13:39:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 139DdMjU029380;
        Fri, 9 Apr 2021 13:39:22 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Apr 2021 06:39:22 -0700
Date:   Fri, 9 Apr 2021 16:39:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: btintel: prevent buffer overflow in
 btintel_read_version_tlv()
Message-ID: <20210409133914.GP6048@kadam>
References: <YHBCNqdojHJT2usi@mwanda>
 <60705678.1c69fb81.97cbe.bb64@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60705678.1c69fb81.97cbe.bb64@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090101
X-Proofpoint-GUID: JAXuTO6dOWjxuadvM9Y3epL0b21pJfo-
X-Proofpoint-ORIG-GUID: JAXuTO6dOWjxuadvM9Y3epL0b21pJfo-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090102
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Apr 09, 2021 at 06:28:24AM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

LOL, just did! #ANARCHIST

> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=464363 
> 
> ---Test result---
> 
> ##############################
> Test: CheckPatch - FAIL
> Bluetooth: btintel: prevent buffer overflow in btintel_read_version_tlv()
> WARNING: Unknown commit id '57375beef71a', maybe rebased or not pulled?
                              ^^^^^^^^^^^^
This commit is from last Sept so probably the problem is on your end.

> #15: 
> Fixes: 57375beef71a ("Bluetooth: btintel: Add infrastructure to read controller information")
> 
> total: 0 errors, 1 warnings, 16 lines checked

regards,
dan carpenter

