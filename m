Return-Path: <SRS0=ATBr=VE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319DAC48BDB
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jul 2019 11:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D8320830
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jul 2019 11:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H498diNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfGGL1X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Jul 2019 07:27:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfGGL1X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Jul 2019 07:27:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so4920388wrr.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2019 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PGGhlgC+scjxuh1M6vtDZZeS9JTSVbQyEnxIGgCuYJw=;
        b=H498diNa0t1Owfw54fiDtDlHXlJqUsipkQDQGYqsia3hh1fF890ewlpJS6j6Y3rlD0
         W/wMlDtqzAVKrp26mFy9u42qQAtFG574sj2bqFpuHihyJ1CnVSTeNxUBJsU4/k8eD6bD
         Tl6JeKSUTk9tTbMu0jte/eqsNf/4RQhcoBwZzEBWPJljA4Z6VkdPXiJ+R6lXGY7qB1xL
         4NdJINJG3+4nk1ceCjiN9dXfJD9+dZovtYtqzxOJI3opT99TV8leK7EbtSMBTKStmYB0
         ddJJfeOsrGHQGY8FN5qBv1ST71e1wDdez0nqcZDCHgMZ/0S2cdtCufslmfJWjFXr8vBm
         SKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGGhlgC+scjxuh1M6vtDZZeS9JTSVbQyEnxIGgCuYJw=;
        b=Ev0bfoX5c+vbc0grvWxOo79KlvY0nkYKpBW75br5ABclWw+H2jdhgcSSuWP5Y6JTAc
         WsrjHhBhZnZjhFnfGTRjqnurFQJIBHIk5Q+OJ0jUjfNJo4nUTrTmmzW2AUF4+g2XLJsn
         7WbFnWqTaasN0/pRbd8WZQUU5J36ItqzZ39ruxqw/Bz7n/Got7ChcQ1MGIkY2OxkeJA7
         AdXe4sFOX83tuD3XORuDKYhHFFo29xDvS6u9LPhTB1vFtv4nHL1ViRXzfAdeU4RXy9vU
         SSL7Z5eeG3EexVcnCMt/Z+0Jpl+76Cp6hyqAmLWAIGo9jKRH+OQJMjvzV4jawTAnzvpy
         bzjw==
X-Gm-Message-State: APjAAAVhuRHxd5kbpcMjiRy/AeDIBcXqnbN7E7w2ffCoTGz9MdbWb38y
        g/g/6sHhJ1qeB/Ob/x3si8k=
X-Google-Smtp-Source: APXvYqx99K3ovDESenGNTRzH6Dmj+E1wFETU222e+Qy1Cf70IHPZpI3VTEOoj0AeEbc0LEURruuRZA==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr13150766wrn.54.1562498840849;
        Sun, 07 Jul 2019 04:27:20 -0700 (PDT)
Received: from n14xzu (host86-129-30-75.range86-129.btcentralplus.com. [86.129.30.75])
        by smtp.gmail.com with ESMTPSA id m16sm12861111wrv.89.2019.07.07.04.27.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 04:27:20 -0700 (PDT)
Date:   Sun, 7 Jul 2019 12:27:15 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Missing manual? - GAP Central connecting to multiple peripherals.
Message-ID: <20190707112714.GA10302@n14xzu>
References: <20190704212644.GA13491@n14xzu>
 <CAAu3APaed3UXY646Vr+2WyKhFRoohDV=7=aeD6sANf9N4BJw-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAu3APaed3UXY646Vr+2WyKhFRoohDV=7=aeD6sANf9N4BJw-A@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jul 05, 2019 at 08:29:16AM +0100, Barry Byford wrote:
> Hello John,
> 
> There are various Python examples available in the tree under the test
> directory:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test
> 
> There are a number of Python libraries that have been implemented to
> help with what you are looking to do.
> There is a list of some of them at:
> https://github.com/ukBaz/python-bluezero/wiki
> 
> I hope that helps.
> 
> Regards,
> Barry
>

Thanks a million Barry, yes a great help.

I have used bluepy library to interface to the BTLE Devices but that has
proved unreliable at best. I'm not sure where the problems lie but basically
sometimes to connect I have to disconnect the USB BT Dongle and re-insert it
to get BlurTooth to work. I can scan and find the devices I'm looking for but
as soon as a connection is attempted I just get a null return from the
connection function. At present that means that bluetooth is not ready for
production on the linux device we're using. I'll try get the device into that
state and try connect with command line tools, just in case it gives some
indicaiton of what the problem actually is. At present there's no indication.

I'm sort of hoping that this is an issue with bluepy and I'll move to another
interface and see if that makes this any more reliable. It's for an LE sensor
for IoT in a production line, so unreliable is worst then useless.

Thanks again for your help

John
