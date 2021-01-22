Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DABC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108FF23A03
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbhAVNvq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbhAVNvk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 08:51:40 -0500
X-Greylist: delayed 2233 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jan 2021 05:51:00 PST
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C4AC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 05:50:59 -0800 (PST)
Received: from muedsl-82-207-238-190.citykom.de ([82.207.238.190] helo=[192.168.178.183])
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
        id 1l2wG0-0005oF-G7
        for linux-bluetooth@vger.kernel.org; Fri, 22 Jan 2021 14:13:44 +0100
From:   Marius Melzer <marius.melzer@kernkonzept.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Use headset mode of Klipsch T5 II
Message-ID: <09143537-3eb6-dd27-47a6-791d30ba921c@kernkonzept.com>
Date:   Fri, 22 Jan 2021 14:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I bought some Klipsch T5 II bluetooth headphones but the headset mode is 
unfortunately not working.

All details in my (unfortunately unanswered) stackoverflow question: 
https://unix.stackexchange.com/questions/629197/use-klipsch-t5-ii-as-bluetooth-headset-under-linux

I tried this with Fedora 32 & 33 and an up-to-date arch linux. Both 
Fedora 33 and arch linux had Linux 5.10 and bluez 5.55.

Any ideas what is causing the problem? In which part of the bluetooth 
stack (kernel, bluez, ...) is this most likely situated and is this a 
bug or a missing feature of a driver or simply a configuration issue?

I'm happy to provide any further information needed (config files, log 
output etc., just name it).

Thanks for your help,
Marius
