Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2010C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 07:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiCEHEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Mar 2022 02:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEHEP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Mar 2022 02:04:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E321E6E99;
        Fri,  4 Mar 2022 23:03:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j26so5288375wrb.1;
        Fri, 04 Mar 2022 23:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vPG6PDJwgSnS9+7PHGBxz+lZQLqaHuKQ0+ss5kybgjs=;
        b=N+r+1xde+tII44gALowBCUsmkV1BqKIYJec28U+aven/jGvMXHiEGNhcxnMXHb5Fh4
         prESX/f2jJRlor5Jqi5pJkZdKKt/EwJni8OG039oYUU0aW5GlRY6LbgCJA83II3f/Xa2
         tatkCGDgNweXICTr43UYo7WpMRKsDY8Ce8ipqLL21RcH3RqAfeBhqcn2OzYTEfljfR7P
         WhLNyJw5qv0sJKmJMt4/2qV7tgOkdtM6TN0PFtuGFdkDCXztUomRckA8bsRn1u1VKD/a
         OcEEX3UqYGAtn/VGav0h8BfsCupOUnXgoCPJZOtimqHQjGgCZnaFogcHjraG+UEjtcqc
         faZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vPG6PDJwgSnS9+7PHGBxz+lZQLqaHuKQ0+ss5kybgjs=;
        b=yM5iJKmOpU4FZY6Q3oJ84nWMrpxvjhKW1JsvXkLpsD1qZ6Q5XB40xaZVayyLWDlBsp
         jpmHsY2whdPYLNF0235wWsyNddABHbBbeu5P438oI9Wq5beeVHKxtOhfaPz9hNoqwmKL
         sVL+u1yvoYBWhZAoi6jITRJfu6JapjafzAKfaKKFSwSrnDujQuWg79UzzoY1NcH6Hz2Y
         BZQTJDUKcJjQgRvvR0oqdkcChRaYheV4kWMJ1flI6Pyk9ukoZCkz+WEWRxDhXfa7dycc
         TO7O/cvOQb83FftMHeo+WRfrWmKEdnXeLRVU/UUHf2qFuMVOquuYZDaGgABiGv4FBpZB
         BCOA==
X-Gm-Message-State: AOAM531d3o684DVGoB0kohVClPvFOmsN2tu7BNubia1iQHzOuf3tF6so
        /QprMEnbj+E8AXWBwvIRRNynirwQ2RlrGQ==
X-Google-Smtp-Source: ABdhPJwcguxNvMyJZozht5D5Xi/RTHBMlbIPNRLw8Nhyjp3CJo16ZdfyhFCsamFN1X5ywLhfMX25xw==
X-Received: by 2002:a5d:4578:0:b0:1ed:bf30:40f3 with SMTP id a24-20020a5d4578000000b001edbf3040f3mr1521545wrc.669.1646463804432;
        Fri, 04 Mar 2022 23:03:24 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0038181486018sm7816836wmq.40.2022.03.04.23.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 23:03:23 -0800 (PST)
Message-ID: <0aeedaac-2be1-6dae-0d2d-589c73fd21e2@gmail.com>
Date:   Sat, 5 Mar 2022 08:03:22 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
Subject: Re: [PATCH v2] Bluetooth: btusb: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL on fake CSR controllers
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <4957ed07-36b8-58a0-2307-d2e6e2940527@gmail.com>
 <71CA3E33-9498-4970-BE1A-6308D4AEE054@holtmann.org>
From:   Swyter <swyterzone@gmail.com>
In-Reply-To: <71CA3E33-9498-4970-BE1A-6308D4AEE054@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

El 07/02/2022 a las 16:39, Marcel Holtmann escribió:
> Hi Ismael,
> 
> the patch no longer applies cleanly against bluetooth-next tree. Please send an updated version.
> 
> Regards
> 
> Marcel

Fair enough, I didn't expect the sheer amount of changes that the
new HCI implementation would bring right in January. This must have
been brewing for a while. But the result is cleaner. Lucky me. :)

Finally had some time for this today, done. Sent v3.
