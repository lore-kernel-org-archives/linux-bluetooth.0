Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D20CC2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 12:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA91206BB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 12:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvTWAGgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfFGM7T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:59:19 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38595 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfFGM7T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 08:59:19 -0400
Received: by mail-wr1-f42.google.com with SMTP id d18so2086259wrs.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Fj6vkYSd2ePxtJn7Pl0RDPTxpFXA2cryHKqyfEQNKsY=;
        b=EvTWAGgmvkm75H1vJmbfvVCkEvgvEckip+Da3jQka9ASHeyxZ3m8lSpaxPjZMA/X9J
         32r6NRzyPjiVuYUKe92PuFke4iWt09C86OcwntRNnebCZs5tIel22eF1c+GHzhebpE6Z
         xI6rmIMsNzc7MomH/1MZkZ3LzlCarK3NZdVKr0r9nhR5HRneoZPLsFUxDZkGcHX9DfHL
         2IMSnuohaPO1FJMP1f5Qr5KD9PacLgZ+d4nRzduAGgcD8ltziszuTy5FzJbI4ArWVnmg
         Aza6uc1BdyiiJ/ys9k4u4rNy3Q/U2a1OOQih/GysifjGkkDlRynzn4uGg8bmUZh4WUWd
         AWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fj6vkYSd2ePxtJn7Pl0RDPTxpFXA2cryHKqyfEQNKsY=;
        b=LczZ4x9MLh0enr00dGZ7IIYGPwoKjQaxqoSKJpiOfdfScTYeJBopFCITxk1VEW98Wq
         4/6dnlS6dn2BzNM9Xnv+KwJNWfFJ8qhbOn8Ny4deDfKjakqC108y3gXqIZIIRoJ34wEQ
         cwKRCwvkt78GjzeX2+9innkkoJYGdXMGebI6Z+MBwKdVX7vRoWlNho2ix9FBfHt7Pf2c
         nWMjrVl1XrieyH6aV3Aff68IsodoD3+IvXTJVdWFHpzE9ioAH50cckZOJZG+ov0fG7/G
         mt1f/l2ffBnLtAkFodNbOUh80VyTD2NFBsIXLDb4zy0M/46BZ36S2QR9UzDpWgE6B5z5
         V7+g==
X-Gm-Message-State: APjAAAUvnzdlWhvAy5XV8ZAgomxJOfytMo8V7nAo0t7sqQu3KIXDGeZf
        1qVrsQPHfLGabAk2o7eJWxiA20tfX/A=
X-Google-Smtp-Source: APXvYqzylklCGhvuh+O5WtLlgMLK8ka/ZEORwfhzlAa/+UPxd32SnbXV4EaJSleqCSxhwnURNfH6ew==
X-Received: by 2002:adf:9023:: with SMTP id h32mr33970325wrh.95.1559912357553;
        Fri, 07 Jun 2019 05:59:17 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r2sm1830978wma.26.2019.06.07.05.59.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:59:16 -0700 (PDT)
Date:   Fri, 7 Jun 2019 14:59:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Is BT_VOICE_TRANSPARENT correctly defined?
Message-ID: <20190607125916.wswblh5nxrx7hapm@pali>
References: <20190519101854.2ygwxeqbixappks4@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190519101854.2ygwxeqbixappks4@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 19 May 2019 12:18:54 Pali Rohár wrote:
> Hello!
> 
> Now I'm looking at BT_VOICE_TRANSPARENT definition which comes from file
> include/net/bluetooth/bluetooth.h and it has value 0x0003. It is really
> correct? Because it means following format:
> 
>   Linear Coding, 8-bit without padding bits, 1's complement
> 
> I think that usage of 1's complement is not easy as there is no C type
> which matches it. Should not it be 2's complement or rather Unsigned
> type?
> 
> Seems that main usage of BT_VOICE_TRANSPARENT is mSBC codec and I doubt
> that it uses 1's complement signed format (specially as it should be
> modification of SBC codec which encode bytes as unsigned type).
> 
> There is another define BT_VOICE_CVSD_16BIT with value 0x0060 which
> seems to be correct as it means Linear Coding, 16-bit without padding
> bits, 2's complement and encoded by CVSD codec.

Hello, can somebody look at this BT_VOICE_TRANSPARENT definition and
verify that it really should be defined as unsigned or 2's complement?

-- 
Pali Rohár
pali.rohar@gmail.com
