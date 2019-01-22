Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89AC282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70ED21721
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8W1IgZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfAVM7R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:59:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39015 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfAVM7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 07:59:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so14069516wmi.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H9JtaknP1fT5QmX63bb5xCqMGbzzVUZ2EJQ41u87s2I=;
        b=F8W1IgZ+FgDODSbYyYSeopIRtW6gNJIFthgvqdQeUHKSGjkLY0BP0a3TUMIjLhfdOk
         X1ks/DyaXCHLy6xKdewCrf1KzeszPVy090A3ZwfwHyB+YCSTkJUflold/uIs9RfQBLoF
         hLSzuhWYTnpvNC2yoKy2Juln+aKbyFwo9diWMsOukzMEmG81oX1/x7Y+6KALpY6fQjj/
         cHSfVeCZQfkeMdJ+VfiawmGOWyY0AxjT3r7HlqOOgJii3xM4yUWIJVcP4Ri4MHKo6F9I
         4oOc2ygXuAWW+Uldv/jEy0vR46/vyuANZ3XuaQiLrSf4HmvqWbTd7Iuc8nrRxRfy6lcB
         H5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H9JtaknP1fT5QmX63bb5xCqMGbzzVUZ2EJQ41u87s2I=;
        b=YGATRZ8PdREdzuWIshoJp00jZKzdOjMaUjFQfADs66gEsVE6n+7T96zcy741oeISdy
         pl9xLPS9QUrtS5JDhsYmpZIg3CpJLBcXkCGsHYKwcdgn3T9stlY1hj0bvUjwSr/sf1HJ
         FF79NV+WXgiCyrJ33qm66RnVfPMO8wU/FVdn+CD9C7O3+GfkvVOnQtYf8AyHjgMLfWlI
         IWJAJxr/zvefpKqjbDx8fJqi1VUmB5a+si9CPcdEkNw/k7BrE2KhHztL2jhpSOiWIYG6
         SnWFxPfINv7zHDSYTMosmjxEmGmCx5eOtKQ1uO5eJ4tuv4F6EFFTsfCUOzHGIVvP++fZ
         4K4Q==
X-Gm-Message-State: AJcUukdhrJHpe0PiOQOVRXvw9y6dx820l1mmLFszqVQuV+24ZIPDp/Ch
        Z4n/ZY46iFyiqpS+KJ88iOs=
X-Google-Smtp-Source: ALg8bN4DHIAKQSFh8AeMnWYdMrjKhKPZIMkiqErkOXVtX2ZLiVTCAsCaf4gbqeIZ4olm9lOSnTh7mg==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr3622454wmj.142.1548161955657;
        Tue, 22 Jan 2019 04:59:15 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q9sm73287360wrv.26.2019.01.22.04.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 04:59:15 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:59:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Subject: Re: [PATCH v2 1/8] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190122125914.uotyzna5aasa4vw3@pali>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
 <CABBYNZLL7Usr=bS2rcJCCV6STVwi9ywq3Om6jkF8cfB8GC6mcA@mail.gmail.com>
 <20190121183016.jiqrtw3csllmqhif@pali>
 <CABBYNZKMPfkSvHqryeR7P8QitQVAv+-WVudSV=hpVaPjTOUu3A@mail.gmail.com>
 <20190122123812.hypezv5oypabeb27@pali>
 <CABBYNZK-qBX8cQmAmb4w1H21_W_PGKvvDPnQaTJ0RBK1TPJwJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZK-qBX8cQmAmb4w1H21_W_PGKvvDPnQaTJ0RBK1TPJwJA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 22 January 2019 14:54:30 Luiz Augusto von Dentz wrote:
> Hi Pali,
> On Tue, Jan 22, 2019 at 2:38 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Tuesday 22 January 2019 14:35:42 Luiz Augusto von Dentz wrote:
> > > I will send a v3 which does the reverse discovery, that should make it
> > > work with existing paired devices that reconnect and configure since
> > > otherwise there would not be any endpoints to associate with.
> >
> > Ok.
> >
> > > Note
> > > though that in case of PA the endpoint object should be considered
> > > optional no matter what since otherwise it won't be backward
> > > compatible.
> >
> > Yes, patches are already backward compatible. When endpoints do not
> > exist, pulseaudio just refuse to switch codec.
> 
> It refuses or there just no other profile/port to switch to?

It refuses just to switch from one A2DP profile to another A2DP profile
of same type (sink --> sink OR source --> source) with different codecs.
Switching between HFP and A2DP or between A2DP sink and A2DP source works.

> Btw, are
> there anything special I need to do in order to test your patches? I
> guess for apt-x I will need your lib right?

Yes, for aptX you need that libopenaptx library and remote device with
aptX codec support. See also profile switch limitation in patch
description (tl;dr you need to issue profile switch command two times).

-- 
Pali Rohár
pali.rohar@gmail.com
