Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC735CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 13:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjJMNYE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjJMNYD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 09:24:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74311AD;
        Fri, 13 Oct 2023 06:24:02 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qrI93-0003Hg-1g; Fri, 13 Oct 2023 15:24:01 +0200
Message-ID: <b96190f1-44f4-4562-9030-6916e97c8b82@leemhuis.info>
Date:   Fri, 13 Oct 2023 15:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Content-Language: en-US, de-DE
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
 <ZRyqIn0_qqEFBPdy@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZRyqIn0_qqEFBPdy@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697203442;e0bf53fd;
X-HE-SMSGID: 1qrI93-0003Hg-1g
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 04.10.23 01:56, Bagas Sanjaya wrote:
> On Tue, Oct 03, 2023 at 09:20:38PM +0300, Kirill A. Shutemov wrote:
>>
>> Commit 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
>> broke Realtek-based ASUS USB-BT500, ID 0b05:190e.
>>
>> Devices failed to connect. hciconfig showed a controller with all-zero BD
>> address.

#regzbot fix: Bluetooth: btrtl: Ignore error return for hci_devcd_register()
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


