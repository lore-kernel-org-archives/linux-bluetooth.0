Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C3C43217
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 07:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKIHaO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiKIHaM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 02:30:12 -0500
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A131E193D8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Nov 2022 23:30:10 -0800 (PST)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id E0E1960132
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 16:30:08 +0900 (JST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by gw.atmark-techno.com (Postfix) with ESMTPS id A78A060138
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 16:30:06 +0900 (JST)
Received: by mail-pf1-f200.google.com with SMTP id s11-20020a056a00178b00b0056cb4545c3fso8393646pfg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Nov 2022 23:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkV6CPfdFGVjPpghLvJtNFPDkktXoQm93iA3ev5ef2A=;
        b=UgEYb/LA8/RAhNeI4x/ziQddlDne2Cwq6qrTci2zs49KpRXwX58kVblJ4fXSsEJ+Wc
         cBnlI3nYOuuJl5vjG3z3o1wPAtwUGR1hvTsvRzvnzhwBGlS3GrL8f7Au1shxsZlx8gjH
         LFYL40Im5RGtOjDT+3H4WknMX1Qn/Qw7sLqCy5RxVanqNnhsKe9QPxIS8EfYu2WZ3HAM
         K4fz6SkfVw+eha/euZTVRnlxuVBDmXPrwVXHUCFwbgEYuTcOLp4F1M+PaBsF9in2g+R3
         jDyPAdqj5PKIVnrUjBTk0Sgy9xSSMJkpfhzu9UfCy3VuHwGwQl456VvFLGNfZzhD7PTP
         qW+g==
X-Gm-Message-State: ANoB5pk/PsudVTtRaWRJ43aZ149YhE05Gmnv3zg+8OVFz/kUxWu57oik
        Pr6geZa0Ph8MXz/uCb0EhcdlUnYiNjXkH4SiizsSUaV4sFjKEFvfYcg1d07xXcd+FHPnZL7Z7XD
        0iHx9JQEB19JkLBqqzazzAKjj0LsC+OLr
X-Received: by 2002:a17:902:cf03:b0:179:b7fe:dc90 with SMTP id i3-20020a170902cf0300b00179b7fedc90mr8963569plg.112.1667979004659;
        Tue, 08 Nov 2022 23:30:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6FLsf7+45mbMx7ILZrcvfGJp5vcQmaIT620Rjw295aA7uZKazLCzKceVCNRsLqHiFhZv0ihw==
X-Received: by 2002:a17:902:cf03:b0:179:b7fe:dc90 with SMTP id i3-20020a170902cf0300b00179b7fedc90mr8963543plg.112.1667979004304;
        Tue, 08 Nov 2022 23:30:04 -0800 (PST)
Received: from pc-zest.atmarktech (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056164b52bd8sm7607836pfk.32.2022.11.08.23.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 23:30:03 -0800 (PST)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1osfX8-00EHb8-1s;
        Wed, 09 Nov 2022 16:30:02 +0900
Date:   Wed, 9 Nov 2022 16:29:52 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>, mizo@atmark-techno.com
Subject: Re: [RFC PATCH 1/2] dt-bindings: net: h4-bluetooth: add new bindings
 for hci_h4
Message-ID: <Y2tW8EMmhTpCwitM@atmark-techno.com>
References: <CAL_JsqKCb2ZA+CLTVnGBMjp6zu0yw-rSFjWRg2S3hA7S6h-XEA@mail.gmail.com>
 <6a4f7104-8b6f-7dcd-a7ac-f866956e31d6@linaro.org>
 <Y2rsQowbtvOdmQO9@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2rsQowbtvOdmQO9@atmark-techno.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dominique Martinet wrote on Wed, Nov 09, 2022 at 08:54:42AM +0900:
> This is a pretty terrible design, as the Bluetooth side cannot actually
> know when the device is ready as the initialization takes place, but
> that means there really aren't any property to give here
> 
> (I haven't reproduced during normal boot, but in particular if I run
> bluetoothd before loading the wifi driver, I need to unbind/bind the
> serial device from the hci_uart_h4 driver to recover bluetooth...
> With that in mind it might actually be best to try to coordinate this
> from userspace with btattach after all, and I'd be happy with that if I
> didn't have to fight our init system so much, but as things stand having
> it autoloaded by the kernel is more convenient for us... Which is
> admitedly a weak reason for you all, feel free to tell me this isn't
> viable)

This actually hasn't taken long to bite us: while the driver does work,
we get error messages early on before the firmware is loaded.
(In hindsight, I probably should have waited a few days before sending
this...)


My current workaround is to return EPROBE_DEFER until we can find a
netdev with a known name in the init namespace, but that isn't really
something I'd consider upstreamable for obvious reasons (interfaces can
be renamed or moved to different namespaces so this is inherently racy
and it's just out of place in BT code)

That makes these two patches on their own rather useless as well, so
unless one of you have an idea that's less ugly I'd guess just dropping
this is the way to go, as much as I dislike the idea of adding more
non-upstream code than we already have :(

Thank you both for your time, the replies have been very helpful and
I'll remember for next time I try to submit something!

And if you have a suggestion, I'll be happy to do some legwork to clean
this mess, so feel free to ask :)


Thanks,
-- 
Dominique


