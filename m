Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3229C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D7D61216
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 17:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhIORty (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhIORtx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 13:49:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEDC061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 10:48:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 140so2886694wma.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2cyKAotCn/0kxWMWgbHuH36DM6cXIpw5VE9D8kzuJIU=;
        b=VA45/aislW3lZdQEsCZ2+URfrpaUWrvj56UCambWUPUr/PHqjXPPrwLcjSNGRNOJqI
         JIO72QAz9XGH4B2+QLa+pZkxP43eKQ83TTFc2zEL0VZcyz5KNJZcaVv7kVDsoIxgIbO9
         8ldnHjEoBEvDyVtDkL49aXMqtub/3L9zaEpa7UAqhiaA9PWzi/3kcGsHNEup51krLhIT
         fSYKdv1kxSXqUrVodWvFWM1uwN17UzcOggIAY+/EtQLUDVuQRU9oBLu5JNPuiCF87nO9
         77fo/vaPytno3aaU4ErCbZlVSJeQ+hRmyGO3DU3n+FxulkaQ8MSl0we3GPJesRp3+V4w
         EvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2cyKAotCn/0kxWMWgbHuH36DM6cXIpw5VE9D8kzuJIU=;
        b=XxfSE/Yo2iO23eouYMWUZ6ei3mK2G5hbPFQWiZzznNgCNQw4UNFyW8jOhH+ESG4lGT
         ABYMwWfootl7vuNgxrkI7/Z3XMV9Btgf23IAT6L/v/3O0zwbeaSKoVtlnI21JlTrcN4M
         Fqrui9/uSSGTtEJLb61bFLc0oarQ7RNS8zCp6bm9sbjkwwO1BkaaQ/We/rK2N6KGVrmj
         l9HNySvcguAfHecR4jqbf6ydkBckZWC0pSNkZ/qRYGkeU2zItryNniL3wyulVDIltMKZ
         XNrhR9nUYI7QEsXjrXHUkoeEJ+w22jIO3Ve+dzWK455tSsGEvMfRvbRKIJjb+ldCwHVy
         77zg==
X-Gm-Message-State: AOAM5317fFKVCNuuE1Ib//Lte+rb+5A+bI6plbN3jH6yDezscHRxCe87
        mmA1hA5//Ec2H2E3gkAFwwgu4L07sOMB
X-Google-Smtp-Source: ABdhPJzVs40uBWGAYPHFDxSz5+qEWaM3wVIjc8A50PsbJZN7IbpR+tjgrWbEHIboe9CopULZFhf64w==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr5708172wms.35.1631728112111;
        Wed, 15 Sep 2021 10:48:32 -0700 (PDT)
Received: from [172.16.55.219] ([185.17.231.94])
        by smtp.gmail.com with ESMTPSA id b16sm648635wrp.82.2021.09.15.10.48.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 10:48:31 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   Miguel Horta <mmiguelhorta@gmail.com>
Subject: PAN - Migrate client from pand to bluez5
Message-ID: <7c398c7b-6688-9a27-e8e8-cec4fb148c89@gmail.com>
Date:   Wed, 15 Sep 2021 18:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,
currently I have a Bluetooth PAN working where both the master and 
clients run on outdated software, i.e. it uses bluez3/4 tools (hcitool, 
hciconfig, pand, etc).

I'm attempting to gradually migrate (unfortunately I can't touch the 
server for the time being) this setup by replacing some of clients with 
new hardware that runs Ubuntu 20.04 (bluez 5.53). I've been attempting 
to establish a connection with the master (pand 4.59, GN role) following 
a guide that I think describes the most up-to-date methodology, 
http://blog.fraggod.net/2015/03/28/bluetooth-pan-network-setup-with-bluez-5x.html. 
  Unfortunately, I can't even get past the pairing step, it ask for a 
PIN that was never needed before, and it gets canceled right after:

[bluetooth]# agent on
[bluetooth]# power on
[bluetooth]# scan on
[bluetooth]# pair XX:XX:XX:XX:XX:XX
Attempting to pair with XX:XX:XX:XX:XX:XX
[CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
Request PIN code
[agent] Enter PIN code: Request canceled
Failed to pair: org.bluez.Error.AuthenticationCanceled
[CHG] Device XX:XX:XX:XX:XX:XX Connected: no

With the old setup no PIN was needed. I've searching if it is possible 
to pair without PIN, or what indicates that a PIN is necessary but with 
no avail.  I've tried to use another agent like "DisplayOnly" or 
"NoInputNoOutput", but the PIN is always requested.

Why is a PIN now needed? What am I missing?

Any help is appreciated. Thanks.

