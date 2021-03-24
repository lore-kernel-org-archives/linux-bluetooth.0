Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98B5C433C1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 10:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D21C61A04
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 10:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhCXKOU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:14:20 -0400
Received: from mx.flatmax.org ([13.55.16.222]:51044 "EHLO mx.flatmax.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235617AbhCXKOO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 06:14:14 -0400
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41] helo=[192.168.1.33])
        by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <flatmax@flatmax.org>)
        id 1lP0Wg-00069s-0P
        for linux-bluetooth@vger.kernel.org; Wed, 24 Mar 2021 21:14:10 +1100
From:   Matt Flax <flatmax@flatmax.org>
Subject: PAN howto
To:     linux-bluetooth@vger.kernel.org
Message-ID: <2bd8e808-c9ed-cf4a-6f17-7e1e2ead4088@flatmax.org>
Date:   Wed, 24 Mar 2021 21:14:09 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi there,

Can anyone point to a concise and known good PAN setup HOWTO ?

We have embedded devices and are aiming to enable WiFi setup over PAN, 
as well as other PAN things.

The target OS is buldroot and userspace config and setup is preferable. 
We are using a kernel.fragment file to enable and disable CONFIG options 
in the kernel.

Buiidroot running Linux 5.8.xx

Bluez-utils v5.55


thanks

Matt


