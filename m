Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A2DC00523
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 02:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83D721734
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 02:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va3a0IzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgADCxk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jan 2020 21:53:40 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:43090 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgADCxk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jan 2020 21:53:40 -0500
Received: by mail-pf1-f172.google.com with SMTP id x6so23213232pfo.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jan 2020 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=V5xys3awqtSGIHbInjB6hk1pCPnn90ilnMiPl+YQvAM=;
        b=Va3a0IzRQY34jPiO/W2vje78w4u/zrNy+jhvwP2mmQlKPgDheqf1wK2fE5dORtZVRw
         /Ky1mdqJL2mp3LWA/tZ77U7wsxp44NZBDo06tffiUV3b6aG6trMsxSRf4/IfoiCIH1wK
         lY88NvuYa6httioHItbK+EAtNA0j3NZPzJzmjGxcWTtNkYptbDDHLxXIMdlJAtvqpLgj
         4IezvjRWZbUML3wJKtZNcn3f+wDZDU9/4nEzEl9eKiDR7xYuh8gGglsaampT6VUcrUHa
         /2N5l3CEWzJj+QwIQFBim//N4evdPvdhh3+UsfAgbTjK0chLKWWUzmbFnb1lmir4fDyv
         UE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=V5xys3awqtSGIHbInjB6hk1pCPnn90ilnMiPl+YQvAM=;
        b=cps3Pm3E/rusDoYlRZdoPIZkSJqS/QQWH1tF7DVoFTVu5dCUtm93FULH8QFx2ihge3
         LQkXOl6cwJRpZ5Sktf4jl/h54spKWuz1SCNrtevzn++rdFJ2dBQpSFKyAWADMkvpse6N
         gHpMpA0Y8nDGOVIbCP7Be5JG+DL6mbW2Pa+VGXotylqFNmzyPjzCuqYiBiQDqSX97QrR
         EkdOpfa4kGfeumTOt6PO7uV6sfPtMzJz3axKzDG18BZoynPLzmxHa4qw9of0vyRpGnui
         YyZ2JMHsvoWaTcDpp14RokEbqWZZ4i9tegM0UmM5i4ugyQ8S88im9EM+6yXAvcIYIlUd
         aUpQ==
X-Gm-Message-State: APjAAAXD3+3WpKwwST6vXkcNDT/Tc9zMju82sijl78Ub9o4v/YL8Nmd/
        DGraJB4srf/1ZG+8QnFYB5c60fvL
X-Google-Smtp-Source: APXvYqwE/Pydi/qNp4FZ0pLhH9/fe6HqEo75zO1rHIPhBcdlQZzP9LJNBjnc1Iimt7NNAd7jGAMTow==
X-Received: by 2002:aa7:968d:: with SMTP id f13mr95477066pfk.67.1578106419352;
        Fri, 03 Jan 2020 18:53:39 -0800 (PST)
Received: from mozzy.local ([2001:8003:2518:fa01:462a:acbd:21ff:a9ff])
        by smtp.gmail.com with ESMTPSA id r20sm66093327pgu.89.2020.01.03.18.53.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 18:53:38 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
From:   John Floyd <johnfloyd0657@gmail.com>
Subject: Bluetooth Serial Port Disconnect results in high CPU usage.
Message-ID: <500ecaae-103b-dc09-24e7-ad6f12200199@gmail.com>
Date:   Sat, 4 Jan 2020 13:53:36 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Similar to Bug 205579.

However I am using the dbus interface to create the serial port profile 
on the server, using similar coding described at

https://ukbaz.github.io/howto/AppInventor.html

The connection works well but the disconnect ups the cpu usage (~100%) 
for the thread running the SPP code.  Subsequent connects, data 
transfers and disconnects still work over the bluetooth link.  The 
initial connection before disconnect runs with <  3% cpu usage.

I tried closing down that SPP thread and restarting it, but the cpu load 
stays high.  I have also disabled the bluetooth on the client and 
re-enabled it.  CPU usage stays high.  Only restarting the bluetooth 
subsystem on the server end, resets the cpu usage.

The test system is bluez 5.52 on fedora desktop.  Client is Bluetooth 
serial app on android.

Running the server on raspberrypi zero results is similar behaviour.  It 
running bluez v5.50.

Any suggestions?  Need server operating on raspberrypi for low power use 
on battery system.  Cannot afford to to restart bluetooth after each 
disconnect.

Cheers John
