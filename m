Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1E9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 22:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKAWxF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiKAWwv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 18:52:51 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAF3205ED
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 15:52:25 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BE87784F48;
        Tue,  1 Nov 2022 23:52:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667343143;
        bh=3BAHL/TpPcN7NsM7sUACWlH6UCSg/grbuEUqN21rTAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TO2HeBy9TFHbX2wtjV4LkhEtSGGdQuxNblLxIN4ZgrTJg5XfMKl09LKseyU3qfZ/4
         OxYLuESRGLZq9UmHFvLLSAs1zc53GnCPX2pKWwRTjYcIY3HCmj6KidYySEYZjXp8MP
         Kuyv/eebki3ZB7FY0pKQsqzrmYHKlOb5koaKyqUqvkbQaOuFXb1YP+ILkb1wSs5vTz
         vvahso5ExYagqSfID2asezfZmOh6xB7pCjY5IdTQzPG7RMwGlxwnVYyr+zPraX9OLV
         3gqtbOnOydDULGpDiPlATGBDUDHpWhyetMuaDpopQvjjBUEmbDUBlPCekHMeF6CjNe
         xXwxMyCr0uf8g==
Message-ID: <52c65cd1-9631-50a7-aded-7e4a877bbad9@denx.de>
Date:   Tue, 1 Nov 2022 23:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT
 binding
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20221031204804.195267-1-marex@denx.de>
 <6360471e.4a0a0220.4aceb.91b7@mx.google.com>
 <a7485b76-b4aa-a6d6-b509-c6f370380926@denx.de>
 <CABBYNZLpaT7FCwXrGq8RU4owP74VA7Eo99jceFzVsqqVnYFaHw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CABBYNZLpaT7FCwXrGq8RU4owP74VA7Eo99jceFzVsqqVnYFaHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/1/22 23:44, Luiz Augusto von Dentz wrote:
> Hi Marek,

Hi,

> On Tue, Nov 1, 2022 at 3:38 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 10/31/22 23:07, bluez.test.bot@gmail.com wrote:
>>> This is automated email and please do not reply to this email!
>>>
>>> Dear submitter,
>>>
>>> Thank you for submitting the patches to the linux bluetooth mailing list.
>>> This is a CI test results with your patch series:
>>> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690631
>>>
>>> ---Test result---
>>>
>>> Test Summary:
>>> CheckPatch                    PASS      2.99 seconds
>>> GitLint                       PASS      1.48 seconds
>>> SubjectPrefix                 FAIL      0.58 seconds
>>
>> Should the DT bindings really have Bluetooth: prefix/tag too ?
>> git log on prior art indicates they shouldn't .
> 
> If it is meant for bluetooth-next then yes it shall contain it since
> the CI does attempt to check its presence, in the other hand we could
> perhaps use the prefix [bluetooth] to avoid having the CI run on
> patches that are not meant for bluetooth-next but I don't think other
> subsystem do require this so it sort of hard to enforce proper
> prefixing.

Linux Documentation/devicetree/bindings seems to start with dt-bindings: 
prefix always, so maybe we should keep it that way ?

This binding document seems to follow the scheme now too:

next$ git log --oneline --follow 
Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
c8ce64900db47 dt-bindings: net: broadcom-bluetooth: Add conditional 
constraints
cba6164f7c5e3 dt-bindings: net: broadcom-bluetooth: Add CYW55572 DT binding
88b65887aa1b7 dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding
0b4de2523f281 dt-bindings: net: broadcom-bluetooth: Add property for 
autobaud mode
88ffadce9d4cc dt-bindings: bluetooth: broadcom: Fix clocks check
71793730ebfdb Bluetooth: btbcm: Add BCM4334 DT binding
7820ee1c4757d Bluetooth: btbcm: Rewrite bindings in YAML and add reset
