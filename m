Return-Path: <SRS0=PdJ8=RM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C2FC43381
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Mar 2019 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3C7207E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Mar 2019 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K89suEaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCISlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:41:45 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52434 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCISlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Mar 2019 13:41:45 -0500
Received: by mail-wm1-f43.google.com with SMTP id f65so699439wma.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Mar 2019 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kiCknw0qgskccb0zSpOB60MfKOOeWg6735k1zCH8KLw=;
        b=K89suEafFFMW9pwsTbb29Qhnm2T/d0HLL2rwSdgsL3V2YkqWMzBQyo3MAgsrBeTS04
         gsDFcVM3bDtUhWhwM/2ol1IFFVlZ0BeLMOUj3PIcZz6xJDOuQjZPIjB9eHt38aZT+6Zt
         jreftTiU/ud7wD55v8EWZtWJ4ZqxkMKmdrm1r4nyiwOzoKFecpDC0kdhXGpNE0uKyo6i
         pyUpZtmuB8ySsiNOMnykuYlYec/kW7qlpUUaD/ROzx0JYtekK5eQwe4j359qDCIc4kTv
         ILu/5ada8PFn6BcMXeuTBYqkbFWxMBmSqqLGo6tvHuaOn6yJwMQxrpRBqXE5txfCgptR
         P+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kiCknw0qgskccb0zSpOB60MfKOOeWg6735k1zCH8KLw=;
        b=djL58lRDcvy92Wy/hAZ60KoN9bPb7HdtpKgyfiRJPc8iuVRlqWCzVj6uZB+xaOVZUP
         Dxi2XcFB1uOVuhla/Ul0U/y+zHCkPezRHd+Xgjn3RS5IVQhVRaWex4V1gaV85JiqdE0n
         kX/bQac0rDqq37U0/uV7hI2hCZ/vN3bspfzRO2+/FYWsYPz94W9vupvKAWRrFqwsGYFp
         egB6v0ekL+LM2FjjyLI7nCwqM4yQKTkPqsWkTWGQ6ttcro7VXFiwJW9DU+Ncq1ZKCOiZ
         J6l+EGAj22siNVjXwnZsDsT7AwbvcMKsienEhj9mIUqCBEEDmyYaEn5uXxO87eGCOAPk
         i4mQ==
X-Gm-Message-State: APjAAAWmL39b3uCO6SN08HZMVe9pBfL4pr/gMm7KwHrJFXahNlUodYPT
        Ca5zzCAhj7xfFBbuMKwE7SezKi+6A90=
X-Google-Smtp-Source: APXvYqzgOzzP4Xs1lpYtQHUxPDV9GLCJj8NZs9xSYMY5m1sICDWgCzDKXDbm/7NlUBpc1mHfjmmxwg==
X-Received: by 2002:a1c:7d8c:: with SMTP id y134mr13282846wmc.102.1552156903367;
        Sat, 09 Mar 2019 10:41:43 -0800 (PST)
Received: from localhost.localdomain (cpc119140-heme13-2-0-cust57.9-1.cable.virginm.net. [82.44.198.58])
        by smtp.gmail.com with ESMTPSA id y1sm1021599wrh.65.2019.03.09.10.41.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:41:42 -0800 (PST)
X-Mozilla-News-Host: news://news.gmane.org:119
From:   Andrea <mariofutire@gmail.com>
Subject: Bluetooth MIDI Virtual Device
To:     linux-bluetooth@vger.kernel.org
Message-ID: <3f34c10d-9b53-9ee8-6a84-3e2f8e697804@gmail.com>
Date:   Sat, 9 Mar 2019 18:41:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

is it possible to create a Bluetooth MIDI virtual device running on a linux machine
so iOS or Android clients can connect to it?

I would like to log the MIDI communication done by an iOS app and I was thinking that if I could 
route to a bluez midi virtual device running on linux, then everything becomes super easy (I could 
receive the data in jack).

I have found a couple of possibilities, but they all seem a bit old and not sure they would still 
work, not if they do what I need, so I ask before I try to implement one

https://github.com/ftonello/bluez/issues/2
https://github.com/skratchdot/ble-midi

Does bluez support it out of the box?

Andrea
