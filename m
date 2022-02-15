Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 19:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiBOTtU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 14:49:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiBOTtS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 14:49:18 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F846660C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 11:49:08 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id n24so50794ljj.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=nbgayFeF929gkOcuBbiM0neyYmkLWR/NdGibiXj0Gfw=;
        b=YowUgmkC7u43Ub6w/3/5g67znicb148dmlv2F97pt8OyjG0MiYi6mvZoqj+lvsNAJq
         SW0UrVco6SfqzOztTEAo7melbzVaRIY4OFUhpSAuTsPIEItBj2P4e9CbgEbntL0QjdN5
         FQ/HQR63pGtpuuL/IyplGjVefmtcZL/tTgv/ywk6Q3OxZYMprtgheXBARyppEep/n0IM
         GhFwS/79ibyYp+tpwWLK87jJQdWsXFciDXepArQaywqWpDlEzl3viMTkGPtgvy68CT7R
         bz+4vPvPJtnFCSHQiIQ9+Q14FO5HiMdQZzC9zqXwQScJ+aFFK/Ne19Tfvn3dq0JkK9aS
         v++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=nbgayFeF929gkOcuBbiM0neyYmkLWR/NdGibiXj0Gfw=;
        b=3thOUneBOHReDLS41SAWmnKAXaPqhmXlO6XmarwVkA0exCcKOcwzU3S6K9YLizxMFV
         cBGm6yllWMMB2KVDn9AztIxIpnqgZLCtezmvl1hW3FEwjn3vG9u4TWbxOpNfNf9t5BCX
         Mg5aNeRRrEgM4zi/jBQWw33Vg67B/fhPmh/LoFSU10kzOcj0Ty5U3IjFvNv8mFJAgrCi
         OV8UfqShIm6KLLFy27jgQ+VDwUc6FGuv+y5cqGEOq6+ruYy2b+gAFEdalGhccZ9IP9Yo
         0aa9nEtke5boxEtHOXp7wrZk6w3i4s6ielnUdicyVdmOZZg/irzcbsPQquX5gC6bPSxZ
         fxAA==
X-Gm-Message-State: AOAM533+HrLF9O5X5CzEXGV7qu5MaKVHOOq1glvfKJlxpefnj+FxvPwo
        3zKy0ZZSGrar9xPr7+KV/Y+Eh7sN/Jk=
X-Google-Smtp-Source: ABdhPJycYwZXhb16GATfR3L/FQSOYeGNR6nuf54PITyEQFHjF3mrai3mtVSN28DmzF6erf+FfFiU5g==
X-Received: by 2002:a2e:bf21:: with SMTP id c33mr446985ljr.414.1644954546482;
        Tue, 15 Feb 2022 11:49:06 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:93f5:693c:adf6:4fb? ([2a02:2168:8737:3600:93f5:693c:adf6:4fb])
        by smtp.gmail.com with ESMTPSA id 18sm1496486lfz.286.2022.02.15.11.49.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 11:49:05 -0800 (PST)
Message-ID: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
Date:   Tue, 15 Feb 2022 22:49:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   Andrey Butirsky <butirsky@gmail.com>
Subject: Lenovo Legion M600 wireless bluetooth mouse connected and paired yet
 not working
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Detailed report is here, basically can't get any event from the mouse:
https://superuser.com/questions/1697648/lenovo-legion-m600-wireless-bluetooth-mouse-connected-and-paired-yet-not-working

Have the same mouse and ready to provide any assistant to solve this. 
Any clue?

(If this is a tough problem I would probably have to return the mouse to 
store, it's not cheap..)

