Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91B9C282CE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 21:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33332173C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 21:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k7YcRC0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfDEVXW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:23:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54374 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDEVXW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 17:23:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35L95JF083138;
        Fri, 5 Apr 2019 21:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KSmrowENjzwH5GqnQ1MkuCn8+/tU6g3iJi2GqOVEW5M=;
 b=k7YcRC0Q37BOzpNBueap2spB0WUO3hxFv47yE24FE4rG0rTFZ1RGOpvbsn/fJn1IUtUd
 bAjah+dgEwB3lrn+SQAa9vw27sdrvfkc2q7i10kXvBB8z990dAnP3Yad1uCVdebWd/vR
 IOYJnbdgUypeZAJIZ6ADcYVzwtZI96h4iF6TRV1yn5B3GnyzrCjAekALNTYpQWrFkcLu
 /VU0MPUUerec1MUMHgk0/OqadozasTWs0qJ2QJAdPKWI/OsSXHqLI9M5pSpLzKfA1pgj
 wMTcQQip38U3BwuytnJdSK+KiPMY+WX6ccYiHZUhM1sd92BrkxxUbK+SLrvm0ZTVLdvE UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvtq3cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 21:23:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35LMKFI080785;
        Fri, 5 Apr 2019 21:23:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2rp357u616-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 21:23:16 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x35LNCh8010582;
        Fri, 5 Apr 2019 21:23:12 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 14:23:12 -0700
Date:   Sat, 6 Apr 2019 00:23:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing
 ADV events
Message-ID: <20190405212304.GW32613@kadam>
References: <20190402063313.GA32613@kadam>
 <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402195537.GF32613@kadam>
 <CAM_iQpU2qwezhk8XdnX+kvUi8Oi0mwNxRuFOo8uGvjZaPZGNWA@mail.gmail.com>
 <20190404080627.GG32590@kadam>
 <CAM_iQpXLoSU5f4tGtwDt9=+AQ==4CfYhnxcOmKkmvB+Yd0KNfw@mail.gmail.com>
 <20190405204838.GR32590@kadam>
 <5344bfc8-ba02-c17f-c4cd-0418d48e6fdd@gmail.com>
 <20190405211414.GT32590@kadam>
 <CAAHj5qj3PciY8ngqSGzH3=TQcm5vCghb0Z_0Y3DFQjTLMUM-9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAHj5qj3PciY8ngqSGzH3=TQcm5vCghb0Z_0Y3DFQjTLMUM-9Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=818
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050140
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=858 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050140
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I only deleted one unlikely() from around an unlikely(!pskb_may_pull())
check.  I made sure that the line numbers and debug symbols all stayed
exactly the same...  I just re-ran my experiment with the same results.

It's weird that you're getting different object code.  This stuff isn't
a new feature in GCC, it's at least 10 years old.

regards,
dan carpenter
