Return-Path: <SRS0=lHyt=SE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC330C10F00
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A482082C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4w2GPLcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDBUvD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:51:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47570 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfDBUvD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Apr 2019 16:51:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32JwlOF122869;
        Tue, 2 Apr 2019 19:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lTQ0XoQ5cxWmJFtMV1e3DjWjT7ExLvWPdtcrzmIDMXY=;
 b=4w2GPLcxr/q085LS6HULH6ALpa92uGolDVJ99zjHnC1TWxgH9wPTHn1mWTcUQMXMpn0Q
 lfF1jlUbVFCv07MbHQqV5KF2Of9vHhwYUfi2TwAb+fXfamHNzYg8HW1PQuIV8R9zj8zx
 DRFnTlBl+vzkJPSz1hTrvl83es2WCo6vlr7mHrWV4dPD4w8e5fq957z3o9Q8fvgM/lq8
 EHUkPdwTbLQJGcorCsmk/q/ad4XxtDQM59hPfNRWDOxf0GdjtCQvI+k//kCqsFqS5dGx
 wrX3UyyChu0o5ED2f0laepTm8Zzf8CnqFxto8Mb+rpd/iOyqgXl2P1mLlnquCL8qREUw YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2rj0dnknqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 19:59:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32JtbKb094102;
        Tue, 2 Apr 2019 19:55:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rm8f4pxxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 19:55:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x32Jtmd0000775;
        Tue, 2 Apr 2019 19:55:48 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 12:55:47 -0700
Date:   Tue, 2 Apr 2019 22:55:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing
 ADV events
Message-ID: <20190402195537.GF32613@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam>
 <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020132
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020133
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 02, 2019 at 10:42:38AM -0700, Cong Wang wrote:
> I think these likely()/unlikely() are reasonable, ill-formatted packets
> are rare cases, normal packets deserve such a special care. We
> use likely()/unlikely() with pskb_may_pull() in many places in
> networking subsystem, at least.

The likely()/unlikely() annotations are to help the compiler optimize
the fast path.  They are not there just for decorating the code.  We
should only use likely()/unlikely() where it makes a difference in
benchmarking.  Otherwise it's just a style question, right (obviously)?
And it's better style to write things as simply as possible.

regards,
dan carpenter


