Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40220C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 02:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5836206D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 02:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgKJC1e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:27:34 -0500
Received: from smtpbg704.qq.com ([203.205.195.105]:42422 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727311AbgKJC1d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 21:27:33 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 21:27:33 EST
X-QQ-mid: bizesmtp21t1604975251trs4owio
Received: from [192.168.50.182] (unknown [119.253.42.49])
        by esmtp6.qq.com (ESMTP) with SMTP id 0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 10:27:30 +0800 (CST)
X-QQ-SSF: 01400000002000J0Z000B00A0000000
X-QQ-FEAT: EFW0E7CCjXfgUzlP020u17CYq+WRmWvfpzWEu5Z4WqlHf+PWdbBiGe5i8AjCK
        RhiYVADfY/4d/+jPGweA8DqNYAUmiZNr5mAKvrUF+aKPqSGIfG2NuRxZA4A1IQSPGmeEas8
        rMo0FfMJWxkcTd0na3T4DEi3jHlZVrHgG4ySV3oYLIaCmhLnLl48GaQV9PxqwM3j7RrbHZ6
        4e+TvUni7vxsC3s1NeR3o/SdNhBwDwQyPJIFNIPBCni4/ZxVUoFvBx2sgE9aAOKeOzr8O9R
        ZI7DOH5r7oGcCaVEuoSaxdid2s2I/dS/7KEQ2COIh3HIOcpTqQcKc6Zi+VI3Ebul5nHw==
X-QQ-GoodBg: 2
From:   Jiaquan He <jiaquan.he@9amtech.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: About bluetooth mesh remote provisioning
Message-Id: <CA9A55F7-7B5B-4838-A87D-CD60D7842A45@9amtech.com>
Date:   Tue, 10 Nov 2020 10:27:26 +0800
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:9amtech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

Our team recently come across a scenario about "remote provisioning". I'm not sure it's the right term. That's a case where the provisioner and provisionee don't communicate directly, whether due to the distance or obstacle between them.

I know that security is essential for bluetooth mesh provisioning, which might strictly limit us to pair provisioner with a device 1-to-1 closely. And some posts on the Internet states that's not part of Bluetooth Mesh spec.

But I'm still wondering if it make sense to have provisioned nodes in the network who acts as relays, so that out-of-range devices can get provisioned.

Thanks.

Regards,
Jiaquan

