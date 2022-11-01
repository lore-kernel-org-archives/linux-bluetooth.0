Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F7C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 15:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKAPTy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiKAPTV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 11:19:21 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C4D5C
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 08:19:12 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A861184F48
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 16:19:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667315950;
        bh=pHSkQsTbF/pzNNBTFi8tC76ImaBfIPuPC9iIBn2ubEM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VWHgLZOzgC45FZ3uEAHyV4PDpx5vWtI335hUpIkU3Vars3prjtuthOOpbngZ9qWQE
         cGSFPyN/8c6C9PtycdWcUMduSKs5srYoLXCJA3sKWVTmiTwAqYVGAJCqUonS/DcV6B
         e6M3ufqjrWcUG79ibKTV7xEfiYxoXxxHtWvIvjlwVI5Y4T4NeGsGiCkdbhPirUkl0R
         kYBrylBrGQuycdMUGyf4ISui+bK6FzvIe7VkcVM8QW5V/RrjrSlTgerhlhkHC2ce+P
         dqLFKxzkHw8VHj04BRf5E2HEOyYo7WYsjS2dqceLnFeGTbeZdp9Gd5m3zYtEil3lUN
         vpI/8cXdQ5boQ==
Message-ID: <1f4bcb64-9402-3975-960a-fc1c1f7cebe4@denx.de>
Date:   Tue, 1 Nov 2022 16:19:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [BlueZ] tools: Make hciattach_* firmware path build-time
 configurable
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
References: <20221101115333.18223-1-marex@denx.de>
 <63612127.4a0a0220.ee3ae.be5c@mx.google.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <63612127.4a0a0220.ee3ae.be5c@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/1/22 14:37, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690839
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      1.01 seconds
> GitLint                       PASS      0.86 seconds
> Prep - Setup ELL              PASS      26.44 seconds
> Build - Prep                  PASS      0.68 seconds
> Build - Configure             PASS      8.16 seconds
> Build - Make                  PASS      723.76 seconds
> Make Check                    PASS      10.90 seconds
> Make Check w/Valgrind         PASS      287.82 seconds
> Make Distcheck                PASS      233.70 seconds
> Build w/ext ELL - Configure   PASS      8.17 seconds
> Build w/ext ELL - Make        PASS      83.94 seconds
> Incremental Build w/ patches  PASS      0.00 seconds
> Scan Build                    WARNING   476.19 seconds
> 
> Details
> ##############################
> Test: Scan Build - WARNING
> Desc: Run Scan Build with patches
> Output:
> *****************************************************************************
> The bugs reported by the scan-build may or may not be caused by your patches.
> Please check the list and fix the bugs if they are caused by your patch.
> *****************************************************************************
> tools/hciattach_qualcomm.c:218:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
>                  if ((n = read_hci_event(fd, resp, 100)) < 0) {
>                       ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/hciattach_qualcomm.c:253:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
>                  if ((n = read_hci_event(fd, resp, 100)) < 0) {
>                       ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 2 warnings generated.

That's unlikely caused by this patch.
