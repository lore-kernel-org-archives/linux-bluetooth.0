Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB15C4708C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 11:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiLFL2A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiLFL1g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 06:27:36 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D654C19
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 03:27:35 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F9AA4154C
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 11:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670326052;
        bh=pcwj0xSndXh6KnkaS8bTnDF5WeQqaKV6mdZEo74JDfA=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=D3cveoQ7I+Mhh9nwp2HxgAztuNTSJfZqpoXLA769KsP1n7kdDcW/PgYlY49/NVtQS
         cQ3cCGsf4bJZvlJYS5FG7OE61dhGwSGlsGwHxXqUsqvVli52lYcCl9yZoKarVQ0Uee
         0PrDvUEu2opeq3TkONmqS4qq2u+wYkDdjdPqegEGSr+qvJrUY2QB+V09QfhkQg2x3b
         NcD6PMteaiCMn4plZgBWZXUIEcw4WiuSlh+D3+ydNMODtr8tN1icKIFBk3hcGm74kH
         LOUdaXx3EYe0Kys953/UeJ/w3blEr8KtmP8iqGf2bYXhfuRMEkIgQf1Hsvv3KBekCT
         Q8WRKqJW3ensw==
Received: by mail-ej1-f71.google.com with SMTP id qf25-20020a1709077f1900b0078c02a23da3so1369996ejc.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 03:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcwj0xSndXh6KnkaS8bTnDF5WeQqaKV6mdZEo74JDfA=;
        b=K3YS2pIWQrxeCTNhCn7skpt6IKYTlbj5WJBDNVFEhP+t2BNDdYYBUavUtt5TrXZm2k
         aW/rAVaS0JJmKcNeZpMz7lg9QAql4SNaPyI93CO9y6b/xHKZFBpJt/e+KGuowe9nhnAZ
         pc1Gn98BrIzjHZ5Z0X4Rd6eSsr7orVmvr6WkMtURkL9xsfUciLB8/9wu7mGZfO3h50BP
         TU4S9ENb+ZtrpwO06THXgDNBYfPHaeyD+UILbTqKKSV+piYcFznuKTLVIb40kZ9EJCCu
         27FOZAyUVWND5E0lzDRq0qle97lRFBhdOZtlTl8aqoxXIheuFZFoOhyLrz0Ti5g7NO5Z
         SzEQ==
X-Gm-Message-State: ANoB5pmIW9dunYiIW//CtiNmVEnVZDjXM5eI7Accbkv4UMZW2Xhpgz0t
        JwhWQyoVCnUlhZikGo19nz+CGhd521A1gyu7nFWd/2ZGk7ss+rdguld71WNDICZHTvSNijr+FWH
        miHUUap6PWy/0xjIoP2CNN8uisyah2PN6fiRvEcqnuS2YuA==
X-Received: by 2002:a17:906:a209:b0:78e:ebf:2722 with SMTP id r9-20020a170906a20900b0078e0ebf2722mr69523362ejy.490.1670326049536;
        Tue, 06 Dec 2022 03:27:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7+7hJEm7RS//qwjZI2NkgcgeFfx5BgIMCo+8buUL8NMmMPAqOa0RpikMn7gYObBbSc3mEwnw==
X-Received: by 2002:a17:906:a209:b0:78e:ebf:2722 with SMTP id r9-20020a170906a20900b0078e0ebf2722mr69523351ejy.490.1670326049362;
        Tue, 06 Dec 2022 03:27:29 -0800 (PST)
Received: from [192.168.1.27] ([92.44.145.54])
        by smtp.gmail.com with ESMTPSA id r6-20020a508d86000000b004587f9d3ce8sm865452edh.56.2022.12.06.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 03:27:29 -0800 (PST)
Message-ID: <f0b260c1-a7c4-9e0e-5b29-a3c8a7570df1@canonical.com>
Date:   Tue, 6 Dec 2022 14:27:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
From:   Cengiz Can <cengiz.can@canonical.com>
Subject: Regarding 711f8c3fb3db "Bluetooth: L2CAP: Fix accepting connection
 request for invalid SPSM"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz Augusto,


I'm by no means a bluetooth expert so please bear with me if my
questions sound dumb or pointless.


I'm trying to backport commit 711f8c3fb3db ("Bluetooth: L2CAP: Fix
accepting connection request for invalid SPSM") to v4.15.y and older
stable kernels. (CVE-2022-42896)


According to the changes to `net/bluetooth/l2cap_core.c` there are two
functions that need patching:


* l2cap_le_connect_req
* l2cap_ecred_conn_req



Only the former exists in kernels <= v4.15.y. So I decided to skip

l2cap_ecred_conn_req for older kernels.


Do you think this would be enough to mitigate the issue?



If so, older kernels also lack definitions of L2CAP_CR_LE_BAD_PSM and

L2CAP_PSM_LE_DYN_END.


I see that L2CAP_CR_LE_BAD_PSM is basically the same as
L2CAP_CR_BAD_PSM so I used it to signify an error.


I think it should be enough for the sake of a backport.


What do you think?


Also the range boundary that is defined with L2CAP_PSM_LE_DYN_END is

non-existent in older kernels, and it's hard to decide which value to
use in this expression:

`if (!psm || __le16_to_cpu(psm) > L2CAP_PSM_LE_DYN_END) {`


I can easily define L2CAP_PSM_LE_DYN_END as 0x00FF and call it a day
but I had to ask if we are absolutely sure if that's the right value.


Because the comment block states that it's from the "credit based
connection request" ranges but l2cap_le_connect_req is not credit based.

Is it?

Thank you in advance.

Cengiz Can
