Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5150EE0210
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Sep 2023 22:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjIMWZy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMWZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Sep 2023 18:25:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A71BC6
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 15:25:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so41779866b.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1694643947; x=1695248747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2uTVzeHZ009FRQZc+I1NmAahlcge8wTWySLmskl4JU=;
        b=LBFE1weqA/ghy3hldOZ/VBU9VcvkP9lW1KTMkw7854rWAirlwlsaIzZyLo61wCGH7o
         3BaykpLC+70oYyQYEY/grDWB3yzqLBUj7MslTJUWBkGfoqeQIousy9ok2Qtb92teJlLI
         MiS9casoMVpNCVSxACGUHWrOXzIKaf2uqxjmzsyactPC9HnKvcB1WAnjoXIZ4+ruGGGP
         U9detPPT+4eisxJiB9kibi49gZJuSIr2378+Rtjbn5gwqdNnBv5uQ5gcQhbtSyZsNjbn
         teEghvldx2qinxcVWhwht4L/IeuxnwGZpFLmFnSsJhHyqo8vUuYxz5v8f9zRqu6BRkIj
         Hn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643947; x=1695248747;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2uTVzeHZ009FRQZc+I1NmAahlcge8wTWySLmskl4JU=;
        b=D8QegWQNc+YcuAjHyUVaaLqwGom8CBuobZeodCFEi+nJse+bdFG4/XWW2SQa3IxFuj
         +4KqKPQShIs9HRmEuvDxIYMlgSjTF3MWPOtOHDx67/8NYzXB2z+c4dgbiu9a9VJJISBa
         KQCF5aYDW2sz2Z8Wd+UHy2hatlcG0iP4kihyORsb+YN33H3fhP3jGqHgHfZXcHUSXbPJ
         tADTld8vGszpw+oFT+c799J6yalbsPkAlN25LmdkFrsPTxDAYGbq+rSD2IWLv+bOYu7D
         k1uH2jx9582AaLu2LLRl39fcHq8EdU/hLH5w78DYIq3MyJT2Nh5cepPcKSFovrr5p2Uq
         SBJw==
X-Gm-Message-State: AOJu0Yxss5SDL5m4WoMFZ/TW/yu+/6ed7NPpxbIBgD+QrFH/KJwNyweJ
        grjIxQM5pi88VJHpw4k+Ge7SoA==
X-Google-Smtp-Source: AGHT+IFKALtwRIojpRvft/xkf5Geuu4hvAILs1rLPlzD9wHj5U4bhPWNpLMrGRp8X/okuuRY1nl6tQ==
X-Received: by 2002:a17:907:77cf:b0:9a5:cbb2:3fab with SMTP id kz15-20020a17090777cf00b009a5cbb23fabmr2904431ejc.2.1694643947270;
        Wed, 13 Sep 2023 15:25:47 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b9:1300:b94d:1db:d33:df08? ([2a02:578:85b9:1300:b94d:1db:d33:df08])
        by smtp.gmail.com with ESMTPSA id p27-20020a17090635db00b00982d0563b11sm56657ejb.197.2023.09.13.15.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 15:25:46 -0700 (PDT)
Message-ID: <7f4eab50-2532-4975-8bee-3f38bfaee3e1@mind.be>
Date:   Thu, 14 Sep 2023 00:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-GB
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
 <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com>
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: Re: [PATCH RFC 0/7] Fix a memory leak in Bluetooth L2CAP
In-Reply-To: <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

Thanks for your review.

On 05/09/2023 22:42, Luiz Augusto von Dentz wrote:
> Hi Olivier,
> 
> On Mon, Sep 4, 2023 at 3:12 PM Olivier L'Heureux
> <olivier.lheureux@mind.be> wrote:
>>
>> Request for Comments
[...]
>>
>> The "ble-memleak-repro" program reproduces the memory leak, if the
>> kernel is not patched. Its source is in
>> "package/ble-memleak-repro/ble-memleak-repro.c" [18].
> 
> We should probably create a test in l2cap-tester using SO_SNDTIMEO
> first, so we can make sure CI test such case and we are able to detect
> if the problem is reintroduced later:
> 
> https://github.com/bluez/bluez/blob/master/tools/l2cap-tester.c

I didn't know about "l2cap-tester.c". Agree, it would be great to
integrate my test app into it. I could try, but I don't know the test
framework yet.

>> Memory Leak Fix
>> ===============
>>
>> We have fixed the memory leak, see the patch series in
>> "patches/linux/":
>>
>>   1. The first patch
>>      "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patch" [11]
>>      enables Bluetooth on the DK2.
> 
> This above should probably be sent separately.
> 
>>   2. The second patch
>>      "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patch" [12]
>>      adds many dynamic debug traces that help understand the kernel
>>      behaviour and freeing problems.
> 
> I'm fine with this change, but we better use the likes of bt_dev_dbg
> instead of BT_DBG.

This commit intended to increase the visibility during debugging, and
I was not intending it for a permanent presence in the kernel.
But if you find it useful, I can submit a patch RFC v2 with
"bt_dev_dbg()" instead of "BT_DBG()". Note that there is currently no
"bt_dev_dbg()" in "l2cap_core.c" yet.

>>      "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patch" [13]
>>      and
>>      "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch" [14]
>>      fix the memory leak.
>>   4. Patches
>>      "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patch" [15],
>>      "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patch" [16]
>>      and
>>      "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch" [17]
>>      fixes the use-after-free that appears when the "struct l2cap_conn"
>>      [5] and "struct hci_conn" [6] objects are freed.
> 
> These I'm not very comfortable applying as they are, I'm afraid there
> could be regressions if they are not accompanied with proper tests,
> besides I think there are less intrusive ways to cleanup l2cap_conn,
> see below.
> 
>> The commit messages explain why the commit is needed, which problem
>> the commit solves, and how.
>>
>> The first and second patches are present for the memory leak
>> reproduction only, they should not be part of a final fix.
>>
>> Patch Status
>> ============
>>
>> As of writing, the memory leak is fixed. The fix opened the door to
>> other problems, especially use-after-free, sometimes followed by
>> crashes due to NULL dereferences. We think there are weak references
>> (i.e. pointers that don't increment the refcounter) previously
>> pointing to memory that was never freed, but now is freed. On kernels
>> v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
>> use-after-free and NULL dereferences, but not on kernel v6.5 yet.
> 
> I think the problem is that the lifetime of l2cap_conn shall be hooked
> with hci_chan, but the likes of hci_chan_list_flush -> hci_chan_del
> don't actually trigger l2cap_conn_del, which imo is the culprit here,
> because connect_cfm/disconnect_cfm is not called when the connection
> procedure has been aborted prematurely, so perhaps we shall get rid of
> the likes of l2cap_connect_cfm/l2cap_disconn_cfm and instead do the
> cleanup with in the following order:
> hci_conn_cleanup->hci_chan_list_flush->hci_chan_del->l2cap_conn_del,
> that way we avoid having multiple code paths attempting to cleanup
> objects associated with hci_conn/hci_chan.

I fully agree with your analysis, which correspond to mine: we should
call "l2cap_conn_del()", it would properly clean the allocations in
"l2cap_conn_add()".
I have tried but it was not obvious to find the right place to call
"l2cap_conn_del()" with the proper locking.
As you write, connect_cfm/disconnect_cfm is not called when the
connection is aborted, and that is the root cause of the memory leak.

Your proposal is most probably the best way to go.

> I'd change hci_chan_create to take a del callback to avoid having
> circular dependencies on one another though.

Interesting, could you explain how you would do it? Perhaps point on
a callback example?

>> Reproducing with Buildroot
>> ==========================
>>
>> We have reproduced and fixed the memory leak with Buildroot [7] and a
>> "ble-memleak-repro" test application on an ST's Discovery Kit DK2 [4].
>>
>> The "ble-memleak-repro" repository [1] contains the sources of a
>> complete external Buildroot customisation [8], with the patches, a
>> README, and more explanations to reproduce the problem with Buildroot
>> on a DK2.
>>
>> References:
>> ===========
>>
>> - [1]: <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
>>         "ble-memleak-repro repository"
[...]

--
Olivier L'Heureux
