Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C97EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 23:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjGLXRx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjGLXRd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 19:17:33 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 16:16:54 PDT
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0E2703
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1689203309;
        bh=XhwDSPgzFYYtLQ+xsSBfgW1YWK6L8CKR9neCgOZCqCY=;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
        b=xUlkPy1dfEeoryOQ3dyz84vrtMdMNF3uARdK/OSNhzNgKhx50quH6NRbMbUEBAJ5b
         FhAxpkmTnznjXinEf0qtD29arEse9mcgjXNVotrEA7V6aUENCiUVEWpJKN5YwdgFqV
         6ojDwjpi0x7PR0Vv1WKXKQZHPiNqwD5wbMaxKxNTGxtjEUCXOU6DeG1bgHDFq51kuW
         1Zycw8EAE2djymwJTCabElTaYAS1u2Z7waA99qEbHFvUo55eY2I0Xj9fymMr+uMRxP
         b+4fN1Lpz+UK+p3HK9jw8jcrsNHZNqR1bNJk2bkUWpwJhYl7ZyZphsaUDey0yHSrjE
         w/I8m0ipLTsVg==
Received: from [192.168.61.156] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id C2A74168008A;
        Wed, 12 Jul 2023 23:08:28 +0000 (UTC)
Message-ID: <370f0784-05c2-a36d-bfe8-f5159aeb8729@icloud.com>
Date:   Wed, 12 Jul 2023 19:08:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "tomasz.mon@nordicsemi.noluiz.von.dentz"@intel.com
From:   John Holland <johnbholland@icloud.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: bluetooth broken in Intel Macbook 2014
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i8VweLpzmhiGRJ5gmGa8hOFhgMFevfGu
X-Proofpoint-GUID: i8VweLpzmhiGRJ5gmGa8hOFhgMFevfGu
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307120204
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I've had my first attempt at kernel development in trying to fix a 
problem with newer kernels and the bluetooth in my Macbook Pro (2014 
vintage). I did the bisecting and found that the commit below seems to 
be the culprit.


commit c13380a55522bf14e54779a142487c224509db95
Author: Tomasz Moń <tomasz.mon@nordicsemi.no>
Date:   Tue Feb 7 12:57:41 2023 +0100

    Bluetooth: btusb: Do not require hardcoded interface numbers
......

Reverting this change in both 6.3 and 6.5 restores my ability to use the 
Bluetooth in this Mac. I created a bug in bugzilla for it.


This is new to me, I'm a retired application developer. I hope this is 
close enough to the correct process. Thanks,

John Holland



https://bugzilla.kernel.org/show_bug.cgi?id=217651

