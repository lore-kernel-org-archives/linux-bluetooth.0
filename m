Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02EFC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 23:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B09B64F33
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 23:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCRX04 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 19:26:56 -0400
Received: from mx.flatmax.org ([13.55.16.222]:43778 "EHLO mx.flatmax.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhCRX0n (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 19:26:43 -0400
X-Greylist: delayed 1515 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 19:26:43 EDT
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41] helo=[192.168.1.33])
        by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <flatmax@flatmax.org>)
        id 1lN1dv-0002iK-P6
        for linux-bluetooth@vger.kernel.org; Fri, 19 Mar 2021 10:01:28 +1100
To:     linux-bluetooth@vger.kernel.org
From:   Matt Flax <flatmax@flatmax.org>
Subject: PAN howto
Message-ID: <304af64a-43ba-3364-f489-b41cc8a76dbe@flatmax.org>
Date:   Fri, 19 Mar 2021 10:01:27 +1100
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

