Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7E7C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Dec 2022 20:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiLMUpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Dec 2022 15:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiLMUpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Dec 2022 15:45:39 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D8B1402A
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 12:45:38 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so6959429lfv.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3sq4fxhcYlr1zbE3/huyoAG2H+acQ6TXRgmL9+VhUY=;
        b=Xuxp9axW99Bu8ruVFkJepcenkG5uom7spXl9ygDmpLk4H/x6odwJZaShNEehWRtbfD
         aAuLCSAxDIiKQhwjpecwdcuQHkw8VCaLCZvwXNwrvXbxTtkfcSej5Tq2vQ5ZIOi/yir0
         XTMYGniy0q1bfRNkQCIs14FNgaPJ8rpfpVWc5kxyRf8qve8goSsZAgV8N9Dtaq9+YmW5
         XGGCOm3mLaWGctUqTJwNlzYERSj5eExKSgBKpjW1gUtYwt0JbjGHNrjRgcKKOiSy9brj
         k9xmps5a08paCHgKPYIB4fa2ZghZ3kHd9Qu6K7pbf1GcypRY0OCfwhidewFOHabmQ35H
         zw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3sq4fxhcYlr1zbE3/huyoAG2H+acQ6TXRgmL9+VhUY=;
        b=PSt4c4m+r6o7ynfMATa7wLmo0D8wIUgTEGwunJd3UDKtEbGvLUcdkKrBtNojlI+P26
         y3WyTVv0pc5yTd94eKOzzK7z/UrRu1G5/MhmEZZKJkB7kgjrNIb5YrbvhVYqj1c9cz8A
         5NW7u78WYIQeYnUBAe0h2/18Mc/b+M06hKQTA8REX6FNuwhnb/BJjqyCxrgGRUFkM2UI
         ErtdNDAs4/tthaYNr/my/VoZGKwuyXnz7KRDrMmDrG1Jg5O8cP3xajyGuracpbA5dLfK
         Cj59aG1+0yZ6SK5jD1LyawNMC+/ZRbxYIohkHPSAIudsIHogJHBCAkR8b0INHQTJY4u3
         gZ/Q==
X-Gm-Message-State: ANoB5plEjj8C7puch18lVzfQ6cjTrhfLvXXm4fTqM1NPaSkBJKJuTFZZ
        VFfxVVe8zBsbwDVkqQygjeLIiW1I5G8hQ21F6CisKueIPC/6vh0U
X-Google-Smtp-Source: AA0mqf6+4Sa2xmiUX5W2J/x3FC617mD2lhtg2MGE5LwqX11P6SAjy1P55SZ78mopQuLQgFKXcZLEL2WLrWXd33FmKtI=
X-Received: by 2002:a05:6512:31ca:b0:4b5:5da1:5224 with SMTP id
 j10-20020a05651231ca00b004b55da15224mr7831933lfe.106.1670964336238; Tue, 13
 Dec 2022 12:45:36 -0800 (PST)
MIME-Version: 1.0
References: <988dc1f9add28a70ba18ce2f3042aac0bea04b5b.camel@hadess.net> <7dc4-63974a80-14d-24592140@246924754>
In-Reply-To: <7dc4-63974a80-14d-24592140@246924754>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Dec 2022 12:45:24 -0800
Message-ID: <CABBYNZ+qY1H5TFYGAuM4iLRqgBHAaip1F23=GtaajqRqg-d66Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/1] Expose the disconnect reason over D-Bus
To:     Arthur Crepin-Leblond <arthur@marmottus.net>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arthur,

On Mon, Dec 12, 2022 at 7:38 AM Arthur Crepin-Leblond
<arthur@marmottus.net> wrote:
>
> On Monday, December 12, 2022 15:49 CET, Bastien Nocera <hadess@hadess.net> wrote:
>
> > On Mon, 2022-12-12 at 14:32 +0100, Arthur Crepin-Leblond wrote:
> > > Hello,
> > >
> > > I am trying to expose the device disconnect reason over D-Bus and the
> > > most elegant way I found was to subscribe to the adapter notify
> > > callback that gives the reason as an argument.
> >
> > Any reason why this can't be a signal with the reason as an argument?
>
> I chose the easy path by copying the existing code for the device properties
> that get updated like the "Connected" or "ServicesResolved".
> I am not too familiar with BlueZ signals other than PropertiesChanged,
> InterfacesRemoved/Added. What would you have in mind?
>
> And apologies in advance, it's my first time submitting here, I do not have
> an advanced knowledge of the BlueZ internals.

Can you explain what is the use case here? I hope it is not to
reimplement something like the reconnect policy:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n281


-- 
Luiz Augusto von Dentz
