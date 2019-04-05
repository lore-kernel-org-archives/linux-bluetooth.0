Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F669C282DC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 20:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1378206BA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 20:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFMPADAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfDEUJu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:09:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDEUJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 16:09:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35JsfeX026507;
        Fri, 5 Apr 2019 20:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vLtyxBYumTr606n5rS5QEEZ4AIFq+HyarZ8Ieph5HG4=;
 b=MFMPADAsUl320iGDV52Ebs1uRZR1FYMaoQYG5h8Q7cAwNyUlrBn96rZRoT0Fnzn06GK9
 9gPoVtrX7RdmuqsVUCvtKoS8Bn93o9T5jUiOO8eSK2FxgoKs5TmFgZ/qnWai+WTXTSpv
 Zh61Q+GUDkq+9oiw9SLnNO13NnwB/IA1ngNNZy3A6/zbpwxuAi+Vut8ojhkvfWRAE+Sl
 c8sGTiJYwkLtkiW/NerpcREhVoJwnA0151S9t64y7V1SxdYeOauEttf81qzZTCslkTsD
 7WcdyKEowPpM41AVycva+Yg/1GWtEyI5u0IRZf16dwNzCWc3qIfyqotuMK049WH4SUGt ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvtpufs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 20:09:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35K8Jb0126138;
        Fri, 5 Apr 2019 20:09:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rp357tbmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 20:09:43 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x35K9cdl012538;
        Fri, 5 Apr 2019 20:09:38 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 13:09:37 -0700
Date:   Fri, 5 Apr 2019 23:09:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: Re: [Patch net v2 2/3] bluetooth: validate HCI_EV_LE_META packet
 carefully
Message-ID: <20190405200929.GV32613@kadam>
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
 <20190403230835.1174-3-xiyou.wangcong@gmail.com>
 <20190404083449.GL32613@kadam>
 <CAM_iQpXnPyqGxgPF19CA9n=DGYmJ9d-Vn4fvu1kKunonPKpW6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXnPyqGxgPF19CA9n=DGYmJ9d-Vn4fvu1kKunonPKpW6A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=655
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050133
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=706 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050133
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


As I explained in my email, the original code is buggy if
num_reports > 1 (probably uncommon), but your code is buggy for
num_reports >= 1 (everything).

regards,
dan carpenter

