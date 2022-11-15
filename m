Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC5AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 06:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiKOGls (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Nov 2022 01:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiKOGlr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Nov 2022 01:41:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B71F2F0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 22:41:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w14so22528316wru.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 22:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPexXP3uhjDbZmPtdTFQsryNfXofuLhfqLBahbl0WXQ=;
        b=NQgcA0dJ0yj9l3FSv47VzlDfV9pN0r0GALWn9zV1hzIzHnzyVE9Uy7QYHxYDEL4xSD
         zjeXIvP336wweX4Q6SQNQBi56vbOV3R4kBtsOQ1rLbYVg8+KvI3nX+qP3sWfiZooLkDN
         442TOBowWwZuXd/YatAAIL7EmDc35VByB6pVU8d2weheIe2eFBalXr8KCjr093j3Jy+0
         iB0ZjfMBIeBfOxyJJ/OB5I8M8z8paOJ+VotaVGdDS0qahiHA1PbnQjLhyZdrloAEHlro
         MLNJxlf6YzHw0fE3hKaJgmdwawacdSaR7o1ddQ6GmpWZLMxfzUHV3CKCsIYwESnrqrW5
         8YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPexXP3uhjDbZmPtdTFQsryNfXofuLhfqLBahbl0WXQ=;
        b=uLatOs5hbWYivpDeVDoKi9caxqRcJxxvlKShprueqJ+hM23TZWbtYShLDL5QkgIuOq
         BHYfK/fp22L58naZO7iIsSlKGPfUAQ62s4f33c+ZgTvuOjHMc1ZZq8PH0Bzot0/4BQzn
         NNLP8gcGVaW2tPHFs0A8xzE7u/LAYhuK9ygZfIFLLWRYir8a3mKvy8VzdsNbqKK132xf
         nDvCk9IUEUR9xT1F6+xVE5gucQPiWhq2GljKw30Wnt0lhR0wDTI0cK/F6vZnOHKJe1l4
         1ZTh2vDljBqoB6oudxtuOp7HoC95oHhil2EsoT3mi0wXCZcB8lKHY1xdoPG5z6EuQB2T
         s0bQ==
X-Gm-Message-State: ANoB5pm/UidJZZDfhZVtlFxX5lP/vs4fJf7cN9a/pAioaevkRc8/IaU+
        2YXR1Idk3bGpKI1XXVk5Kvg=
X-Google-Smtp-Source: AA0mqf54TByb8JZS2K92k5qIvBmp3Lkulz9NY0enMKBSWBxU0+12QlH6M4Mn9hj0NXvImEVVDbK83g==
X-Received: by 2002:a5d:630d:0:b0:236:57e8:c79a with SMTP id i13-20020a5d630d000000b0023657e8c79amr10166730wru.321.1668494504985;
        Mon, 14 Nov 2022 22:41:44 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id q13-20020adfea0d000000b0023677fd2657sm11332394wrm.52.2022.11.14.22.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 22:41:44 -0800 (PST)
Message-ID: <c8987bdd-8a8d-1491-c4c7-66e95f990148@gmail.com>
Date:   Tue, 15 Nov 2022 07:41:41 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
Content-Language: en-US
To:     Mika Laitio <lamikr@pilppa.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jack <ostroffjh@users.sourceforge.net>,
        linux-bluetooth@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <76cd4547-a68d-9d52-1d87-8299e29406ff@gmail.com>
 <LWPL3AC7.RRTERTU2.B5FO44IX@4YQH7VT3.DY2DZPQX.S6LIZ6VV>
 <CABBYNZKDEjYOW+b1snUsvBgidW37+tPbsidq0pXaOqWKvRC8uQ@mail.gmail.com>
 <7ea187e5-7c70-db36-1fa8-148507b2e7c5@gmail.com>
 <e382d911-90bc-de3f-9f3-6143ed8a9b75@pilppa.org>
From:   Swyter <swyterzone@gmail.com>
In-Reply-To: <e382d911-90bc-de3f-9f3-6143ed8a9b75@pilppa.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>> Thanks to this last-effort parameter we can cover that last mile
>> without people having to recompile custom versions of btusb.
>>
>> My dongle doesn't work? Easy, add this here. Most people won't
>> have to bother with this, but that final ~3% would be screwed.
> 
> So what is the parameter needed for now? Might help users coming to this 
> bug and finding this thread.

Hans explained it better than me.

The Linux people haven't merged this patch yet, but the idea is that in
case our generic workaround is a bit too much for a small bunch of dissident
devices and we are actually making it not work (we're making it worse!) when
it would work otherwise, adding «btusb.disable_fake_csr_forcesuspend_hack=1»
should neutralize any side effects, as that workaround wasn't needed
for your dongle in the first place. But we can't be sure of that.

I think we have received two or three reports of this actually helping.

It should be a thing you'd try and see what happens, this isn't an exact
science. Most people won't need it, we're just being thorough and nice.

Letting you skip our little shakeup. Easily.
