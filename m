Return-Path: <SRS0=NoyY=YH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAFFC4CECE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 11:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038FD20650
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 11:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3CI/4Ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfJNLHI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:07:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39712 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbfJNLHI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Oct 2019 07:07:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so19213530wrj.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2019 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tGfbOid9EFvh2WMLq4KJcM6T/F58R9dKwC7u9IWJS4s=;
        b=l3CI/4Olwdw2C5NUUl6OuFF3A59eij7gDutldu5Z5U2VgeTXryzqzlhUuVceXr4PlV
         KgqM3lf3N9lzv6z92C5PAVVTwqyULLFFcE2puq7RD44E2R8mzEe3xe+B31HXfDbM+zvw
         fGVt6JzeEripZqAv4b8M8ijRcXManluPb13PtYM7kOMaY8vh8gFYjTtkuDBDebx3EOln
         kZVUlUZClQVZ+aNrMY/2SjHvv7OlHDBXPOXbGsps8dPNmO3UnbzN0PlH1OebhhRK8oP2
         uLti2QkN3kUHe/hlcedIov4DPsQajVuEM3DrgiFozR9uwOAcJOWpaQLDBmGUoUU2LL4J
         nr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tGfbOid9EFvh2WMLq4KJcM6T/F58R9dKwC7u9IWJS4s=;
        b=ufh4cXno4LEZ76k1IeN5xxpOHX51WEUD0pj2R+I2vrZ5zrTe026WZ+ajgny8N/6Nrm
         /YfmVFX84/eMt5AelTG2sfppAWhJUWL8TKkNNpKvfA6dxveMory6QopWnqBKuvhgWX24
         byGDkFvaGYeXsXfE1bYxmikuV2Niz0+O5K1wajRwO8tdgeQbo13nhTpIUTwCF0LLIAMF
         0XeB6mmNRcdAQnGDB7SYtg6CeLr/VYwWUoCCxMdbK33tlEVOhjg9Yt+vvqo2/yvX5Hc7
         TDAGsFv3jIhddxj8/ISfLlIn0sGxXisLfJKGbRpd+LK/c7PZzp8VOvlvc8EPAim3MDdJ
         GMTg==
X-Gm-Message-State: APjAAAWv3eRhHoOOG3U+s/+ZO9+XCceEu3F1b/iWMHS76wuycnRPcLZn
        D28BTkyZbE7Rt05LF+2jEX4=
X-Google-Smtp-Source: APXvYqzoXq357NMdB8C5IuBYyB0q7ogiw6r6EdPJzc4kzzgGV+A79r+ANDjI0nbeg7IoJExebBPZ+A==
X-Received: by 2002:a05:6000:44:: with SMTP id k4mr26711124wrx.121.1571051226288;
        Mon, 14 Oct 2019 04:07:06 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c4sm18975886wru.31.2019.10.14.04.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 04:07:05 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:07:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Is BT_VOICE_TRANSPARENT correctly defined?
Message-ID: <20191014110704.l4xbyxrb2dgnk6jq@pali>
References: <20190519101854.2ygwxeqbixappks4@pali>
 <20190607125916.wswblh5nxrx7hapm@pali>
 <CABBYNZ+JPvvk1eACkp+cM9MtDZq+M78QLAtFcq-qrhR+8DsjnA@mail.gmail.com>
 <20190607152915.5m2z3gwvlkivr3ms@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607152915.5m2z3gwvlkivr3ms@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 07 June 2019 17:29:15 Pali Rohár wrote:
> On Friday 07 June 2019 18:03:50 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > On Fri, Jun 7, 2019 at 4:43 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Sunday 19 May 2019 12:18:54 Pali Rohár wrote:
> > > > Hello!
> > > >
> > > > Now I'm looking at BT_VOICE_TRANSPARENT definition which comes from file
> > > > include/net/bluetooth/bluetooth.h and it has value 0x0003. It is really
> > > > correct? Because it means following format:
> > > >
> > > >   Linear Coding, 8-bit without padding bits, 1's complement
> > > >
> > > > I think that usage of 1's complement is not easy as there is no C type
> > > > which matches it. Should not it be 2's complement or rather Unsigned
> > > > type?
> > > >
> > > > Seems that main usage of BT_VOICE_TRANSPARENT is mSBC codec and I doubt
> > > > that it uses 1's complement signed format (specially as it should be
> > > > modification of SBC codec which encode bytes as unsigned type).
> > > >
> > > > There is another define BT_VOICE_CVSD_16BIT with value 0x0060 which
> > > > seems to be correct as it means Linear Coding, 16-bit without padding
> > > > bits, 2's complement and encoded by CVSD codec.
> > >
> > > Hello, can somebody look at this BT_VOICE_TRANSPARENT definition and
> > > verify that it really should be defined as unsigned or 2's complement?
> > 
> > Are you talking about these:
> > 
> > https://elixir.bootlin.com/linux/latest/source/include/net/bluetooth/bluetooth.h#L119
> 
> Yes, exactly.
> 
> > Which is used in ofono:
> > 
> > https://github.com/DynamicDevices/ofono/blob/master/src/handsfree-audio.c#L93
> > 
> > Afaik these values work as intended with mSBC/WBS.
> 
> And I suspect that definition is wrong. mSBC does not use 1's complement
> format.

Any comments on this? Could either somebody confirm or not if current
defined constant BT_VOICE_TRANSPARENT is correct? In previous emails I
wrote why I think it is defined incorrectly...

-- 
Pali Rohár
pali.rohar@gmail.com
