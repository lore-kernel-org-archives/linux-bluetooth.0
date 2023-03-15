Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11303C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 08:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCOIyz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjCOIys (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 04:54:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4EF1E29F
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 01:54:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u5so19273150plq.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1678870486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdpqTn64MNL9cV6/4Hyrbo7QXnfjJy9cXDR3qkRym/0=;
        b=h9DnbXG4nXyAlFTheFkr79+tj1382ggPRVISYd7fA9jkBgizZ5G/ZQ0pq85nNpInpQ
         deHPRhXYkZXYFmAYQIRYRCt4qOTWaIowsazBJ9XUvo+QOJDNjDFN+qJvJgsgQrFLMVHj
         BzgGZZj4rKYFZvGamc9Nu1IDRj+hgArEF2OPpxto673EOxPIFa4zQxrVv7b0VjgDjCUk
         OTL83tP6HBIqQd+pogRiLuoq5/qUBFIrA3LIz1Ch3tXnGRXTro+TRGydQ6zMswZ9zVSF
         06z9A1XefqAUkUDmJJ0cbrwksWKzN1dNhv6hyJw8zixF8PGnz08KGeNiO6YN0C+e8hPf
         EtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdpqTn64MNL9cV6/4Hyrbo7QXnfjJy9cXDR3qkRym/0=;
        b=6gaQHrnxZdjesCXsNAxUnVIMB/Klk8Cv/qqvgv+6Ei806iv3GLRx1aJIiZOaXVWOC0
         FA//HEF13zXVQP0fIUoE8aQs+ALhhB4GddOamj06G1sQRirT2wZjs1Prm7RrdJIXQE4i
         7HjakpoSeOQE52Mrw+LLBRauhG2FOBuDRDM2OG2fajdSivy8vJiAIwHen1xcPx2AcXcp
         kDuiYhmYydASHWd5D7r9z3j2oaizpbErIZdJZ3T+J9pnhSp6qUdRBMBTGb6rhNNd0kHl
         BfKLmzo7hbXyICISwVlFXH1a/IFNdnFuofXILhqtva8nX8KIvIF+b193udTwjjcYdJjb
         W8Ow==
X-Gm-Message-State: AO0yUKVSu3NMAQYTCS9GiDDR+ub6Mxl0vkX+xtzjLMRon/w3I5zohPLf
        XzRJBx0tHIaHo2g1viL9kKskHA==
X-Google-Smtp-Source: AK7set/NSFFB7DJnVrlYB/D9HDAZxyNFP3dh4EWz3psJLHsAul4Dddwjpk5PekShMOlT23uQbJ1wBw==
X-Received: by 2002:a05:6a20:e688:b0:d5:9da4:6db2 with SMTP id mz8-20020a056a20e68800b000d59da46db2mr3691340pzb.62.1678870485951;
        Wed, 15 Mar 2023 01:54:45 -0700 (PDT)
Received: from [192.168.1.148] ([113.161.36.151])
        by smtp.gmail.com with ESMTPSA id x21-20020aa784d5000000b0062485a1675bsm2979875pfn.137.2023.03.15.01.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:54:45 -0700 (PDT)
Message-ID: <b997c6b7-6997-0634-dcb2-bcf6df21c82d@kali.org>
Date:   Wed, 15 Mar 2023 15:54:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RTL8761B BT USB has been broken for a while (mismatched
 firmware?)
Content-Language: en-US
To:     Hilda Wu <hildawu@realtek.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "steev@kali.org" <steev@kali.org>, Max Chou <max.chou@realtek.com>
References: <af4f9118-a189-e353-8cf6-65cabceff3e0@kali.org>
 <1c2ec3d103444a778ddffabaac22206b@realtek.com>
From:   Arnaud Rebillout <arnaudr@kali.org>
In-Reply-To: <1c2ec3d103444a778ddffabaac22206b@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hilda,

On 15/03/2023 12:36, Hilda Wu wrote:
> Considering the FW was submitted two years ago, Realtek plans to release a new version to Upstream.
> We will verify the behavior on Linux PC. Expect it can resolve the issue.

Ack, I'll keep an eye on this issue, and ask the bug reporter to test 
again as soon as an updated firmware reaches Kali Linux.

Thanks for your quick reply, have a nice day,

Arnaud

