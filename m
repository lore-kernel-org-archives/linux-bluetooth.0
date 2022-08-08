Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F114C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 07:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiHHHuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 03:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiHHHuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 03:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6208E273E
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659945022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qM45affOhnD+FU+wuhvpBMqS1WJXnyFcF1WmV+y3FOY=;
        b=Im+svTXwWs6U8JacJMAn5dgoSY1Oj1FbaFyyZwT9Il+erNK6f9BaOJUgRPQDytLBG1XYS4
        bJZSCtvLeyIGDiQeNAFEWJRFKHVCKD5LScOejl37FsPCLpyFsymAkeZwJAJp4t9T7TDwRS
        GAJCcTSfwUvXX177M0olBXMUaPwir5g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-_5wPRWDSPcaelVpF-YrF2A-1; Mon, 08 Aug 2022 03:50:19 -0400
X-MC-Unique: _5wPRWDSPcaelVpF-YrF2A-1
Received: by mail-ed1-f72.google.com with SMTP id z3-20020a056402274300b0043d4da3b4b5so5181107edd.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 00:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qM45affOhnD+FU+wuhvpBMqS1WJXnyFcF1WmV+y3FOY=;
        b=MZYpKGxmQjddGFnsZyaoujFUTOVIAtLBHf1pG6ahLiiLC85J7dtdWOORJgCdiq4rAa
         rhlVY1FPO6cea12aiwB6qFtQp6ZakPJcs6qa2FYF6qS5Osb1KTP7CSQ8VnUzfEohPOuw
         4TbAxD4FZov8KfEZxZ7NRUGyzdDFxM0VT3TZsX1xV+zMnh+a5VGzObL+OmBX/3rioZUU
         /eJ1+RbDCmp/0cuySEJmV2k3Wk2nhe8qE8gLp1DRGTQbG+ntXSMHNN2am1idIXJlCtUQ
         0wA2/Cj7sTWsCbzemd4fg9GYkS0/g56PCf1P3FAE2H+uUAkdTQ04uRjOmMC/O9nNUfQw
         heCg==
X-Gm-Message-State: ACgBeo3a8fLVHdTyQS0keo5qhQ6S5whTTkWg8IYpE1+FWXO3vIqQj5M5
        ifgTVD3MQHKjIsq0Jbls/DadeNCtzWI7/VBHVlBJ4ny+Tio4xoQ0R5WlWuAhTcjfVM2+hvb7vis
        OrRa2eBiQMNxR/0+jsYAM3Avf72quujYp58i2Su6KBsBRdGtXv7Ld4TrwxGrp7EOJOBrUNxnoi0
        ktWJhn
X-Received: by 2002:a17:907:7601:b0:730:3da4:217c with SMTP id jx1-20020a170907760100b007303da4217cmr12414763ejc.563.1659945017654;
        Mon, 08 Aug 2022 00:50:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6f2mC1RksQzdw2WEhd+rROf66Knn3YD0VD30Cw2Avscuw4yps6WSyrSE/3HqU4vk7LktGKaw==
X-Received: by 2002:a17:907:7601:b0:730:3da4:217c with SMTP id jx1-20020a170907760100b007303da4217cmr12414746ejc.563.1659945017347;
        Mon, 08 Aug 2022 00:50:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id n25-20020a056402515900b0043d1a9f6e4asm4242318edd.9.2022.08.08.00.50.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 00:50:16 -0700 (PDT)
Message-ID: <0f13f7d7-da9c-2d69-bd4f-8d4a4749832e@redhat.com>
Date:   Mon, 8 Aug 2022 09:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Bluetooth: hci_event: Fix vendor (unknown) opcode status handling
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
References: <20220807205740.777363-1-hdegoede@redhat.com>
 <62f035a5.050a0220.aebd4.50b5@mx.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <62f035a5.050a0220.aebd4.50b5@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 8/7/22 23:59, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665926
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    FAIL      1.88 seconds
> GitLint                       PASS      1.09 seconds
> SubjectPrefix                 PASS      0.84 seconds
> BuildKernel                   PASS      33.71 seconds
> BuildKernel32                 PASS      29.15 seconds
> Incremental Build with patchesPASS      40.88 seconds
> TestRunner: Setup             PASS      486.89 seconds
> TestRunner: l2cap-tester      PASS      17.54 seconds
> TestRunner: bnep-tester       PASS      6.73 seconds
> TestRunner: mgmt-tester       PASS      104.38 seconds
> TestRunner: rfcomm-tester     PASS      10.12 seconds
> TestRunner: sco-tester        PASS      9.90 seconds
> TestRunner: smp-tester        PASS      9.92 seconds
> TestRunner: userchan-tester   PASS      7.00 seconds
> 
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.88 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: hci_event: Fix vendor (unknown) opcode status handling\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit fatal: unsaf ("ace/src' is owned by someone else)")'
> #68: 
> Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
> handle Command Complete") was (presumably) meant to only refactor things
> 
> total: 1 errors, 0 warnings, 0 checks, 13 lines checked

Note no idea why the bluez.test.bot infra is emitting this
warning. The git commit id style is correct and locally
checkpatch does not generate this warning.

Regards,

Hans

