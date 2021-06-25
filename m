Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657EC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 19:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A508C6195D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 19:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFYUB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jun 2021 16:01:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4334 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFYUB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PJqY4j000887
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 19:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EsDdoQfVFu3SNM/3nUoSRpvPn9gmnR27niOKR68joKQ=;
 b=uhg347jk5kSPS+IHFgIAoSRo+rxej0B3hcmdw/EUN45CFh4KGLiOwZA+OVPfE8LIanK6
 mTU0/XD3+hT92g8pGhbrpUjjQRNTEnV6lTy02gMYHay7YNEqNgOm1zPrUW5zHzy36qLd
 5WBYidKNX+W9Aok9bruIszYNb8DRXz7Khm5eBDUsZjLzZOA+d+lvGCn4zyFPla+jfgQm
 LBpEid5cdWaNx9GwZlnbxY5UR/WgxrymSRXCVktJoEalke8JBuq7UZCeMFYcl6pUY87f
 QGyftkgFfLVzPZ//z1vPTMu44fWwH+BBRFe6nuxOlMsi2lwRokTEhsM8bBuG9y6+XQpT MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24aa67r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 19:59:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PJpSa9105582
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 19:59:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39dbb1x3vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 19:59:36 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PJu1XK114703
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 19:59:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 39dbb1x3vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 19:59:35 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15PJxYaT029460;
        Fri, 25 Jun 2021 19:59:35 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 12:59:34 -0700
Date:   Fri, 25 Jun 2021 22:59:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: sco: prevent information leak in
 sco_conn_defer_accept()
Message-ID: <20210625195924.GM1983@kadam>
References: <YNXveZZwzS3crmHH@mwanda>
 <60d60196.1c69fb81.dc5c5.0cf5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d60196.1c69fb81.dc5c5.0cf5@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: jDfLvUjTXzgepzPB_typVoa36jyfuTIi
X-Proofpoint-ORIG-GUID: jDfLvUjTXzgepzPB_typVoa36jyfuTIi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jun 25, 2021 at 09:17:26AM -0700, bluez.test.bot@gmail.com wrote:
> ##############################
> Test: CheckPatch - FAIL - 0.59 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: sco: prevent information leak in sco_conn_defer_accept()
> WARNING: Unknown commit id '2f69a82acf6f', maybe rebased or not pulled?

I double checked the commit and it's correct.  It's from 2013 so it's
not clear how the bot got confused.

regards,
dan carpenter

