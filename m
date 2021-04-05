Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6395C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC5F6128B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhDEVOE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 17:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhDEVOD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 17:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617657236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHsXo0o7qlL2ZVcOVo9pCX3WptTTFrRmG38/jpMB3R0=;
        b=gfD4YvOCqfMiY6USDJmn58Q4cU0bv5/8C+ooGBENSfrwTwOtZlY4G8NIDhoE9FTvz2k9u0
        aNimIHj74NNPS67T7QEK2aKFP88DG5up9gQrw7AhNAAsnG5WS9NRlWKYUOeIEmwbYnaQLS
        eVZDmuoFZ4kmCUn/asF3HuMAzl6sXgU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-gC_HVWGUPD-GGbK56ST5oA-1; Mon, 05 Apr 2021 17:13:54 -0400
X-MC-Unique: gC_HVWGUPD-GGbK56ST5oA-1
Received: by mail-ej1-f69.google.com with SMTP id kx22so4700932ejc.17
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 14:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHsXo0o7qlL2ZVcOVo9pCX3WptTTFrRmG38/jpMB3R0=;
        b=WhD6TDEzCeODMw+9SbjOzCwQgPum1xsLoL7xdm9LRkrGtu+d51feurfO7Bc2RHrES1
         k+CXTor+6a4Yf3YbDRZUEL1KlfvJxV1HqbOn5iIaYYyvpDNGvczlpu3etGVBsm/mON84
         YUKmJo/vViOnxL+wRHdDIeLgQQyS79DFeN0WV0GsQPJiB8sCAH436HS2VmAnwY+28eUo
         uW1u9kvDb0wql4qauczu7XWnWQ22Z8MMpmR0GmJrn37cqaE7aK6SID+e6TV3jyo0b4jB
         QzTB3NzU7PCxlIAPNESa1swBlVfrI/kU+LbDL+DMYBRbvvRokUjsYS7zSOZWLFCFIrE6
         BRgw==
X-Gm-Message-State: AOAM532jBN8+yOHyAATXmj2UcJscwDPYVz22iK06et6WoLAyHUJWsZ7c
        AYInTZcjwFXdGqIGGVFHXqc+DmCLm1FnLisfvZoLwonW/T6FLdK2vRYEX65A9+6qVkBjSqlxft/
        mQZBORC6LPFsQHXi7mOm/xhGMNI3dWpbFwiLm65m7s26dxwALckT/GobXElmgLRLGl2XeMtsVpt
        fOhmtA
X-Received: by 2002:a17:906:f18d:: with SMTP id gs13mr17407885ejb.81.1617657232752;
        Mon, 05 Apr 2021 14:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEqYm3dENlhyUHgokAMAix6tdOHrSo4xH5m91arVOV14SKNSgpC5gWWfnvbqYxlgnVYcCxJQ==
X-Received: by 2002:a17:906:f18d:: with SMTP id gs13mr17407872ejb.81.1617657232551;
        Mon, 05 Apr 2021 14:13:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x17sm9594528ejd.68.2021.04.05.14.13.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 14:13:52 -0700 (PDT)
Subject: Re: Bluetooth: btusb: Revert Fix the autosuspend enable and disable
To:     linux-bluetooth@vger.kernel.org
References: <20210405203533.17091-2-hdegoede@redhat.com>
 <606b7c81.1c69fb81.ee14a.21cf@mx.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cc067b86-cf0f-3554-10c1-ac5dd3e23b6b@redhat.com>
Date:   Mon, 5 Apr 2021 23:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <606b7c81.1c69fb81.ee14a.21cf@mx.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 4/5/21 11:09 PM, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=461009
> 
> ---Test result---
> 
> ##############################
> Test: CheckPatch - FAIL
> Bluetooth: btusb: Revert Fix the autosuspend enable and disable
> WARNING: Unknown commit id '7bd9fb058d77', maybe rebased or not pulled?
> #25: 

I just checked and '7bd9fb058d77' is the hash of the fixed (reverted) commit in Linus' tree.

Regards,

Hans



> Fixes: 7bd9fb058d77 ("Bluetooth: btusb: Fix the autosuspend enable and disable")
> 
> total: 0 errors, 1 warnings, 19 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> "[PATCH] Bluetooth: btusb: Revert Fix the autosuspend enable and" has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> ##############################
> Test: CheckGitLint - PASS
> 
> 
> ##############################
> Test: CheckBuildK - PASS
> 
> 
> ##############################
> Test: CheckTestRunner: Setup - PASS
> 
> 
> ##############################
> Test: CheckTestRunner: l2cap-tester - PASS
> Total: 40, Passed: 34 (85.0%), Failed: 0, Not Run: 6
> 
> ##############################
> Test: CheckTestRunner: bnep-tester - PASS
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: CheckTestRunner: mgmt-tester - PASS
> Total: 416, Passed: 402 (96.6%), Failed: 0, Not Run: 14
> 
> ##############################
> Test: CheckTestRunner: rfcomm-tester - PASS
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: CheckTestRunner: sco-tester - PASS
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: CheckTestRunner: smp-tester - PASS
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> 
> ##############################
> Test: CheckTestRunner: userchan-tester - PASS
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

