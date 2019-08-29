Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC0C3A5A6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3047522CEA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGZWM/rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfH2V6F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:58:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34997 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfH2V6F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 17:58:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so3820541oii.2;
        Thu, 29 Aug 2019 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JByFaSedVJm/2cv0gwp6K7M2K2CazvyjJt9MUumRGx4=;
        b=PGZWM/rWRRXrT7I69KY9OtlW0+bpycNW2Lz+I6v/54eGdukUFNGSFxX4amcUykbZ5C
         yXWfg7gIlzAspW89k5F1UtF2/SGL1jCmtUd2h8K1yW2PZWXrVTijgCjKzGrPHl62ecRz
         xY+iqnUzV6zlDWJFYn7pojo6jgPm8JlIbKb2NA0l2WSoyAq1owLnDewzvOKlZgvAahvs
         mD5Wp78Mndf3PgCzZn2sgcoYkPKjd2wM0bD5FIjIQHkAxlHIivDVulUBfstRaZXplW1x
         JPfs1lg6Le+b7QZc2MIflRAFQw5+4DsWlCMXDMsquy8GIjuY3whpSX4/5awQLDbTRHTN
         qagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JByFaSedVJm/2cv0gwp6K7M2K2CazvyjJt9MUumRGx4=;
        b=mgOfUjlpDHSmT3WdBHVMtt1bpV06qHiCQplM57pPaR1SHTVMHikoxCtKkZ51M2XPts
         jc82IqKNryHPwU3BVaaLpQWAT+mOxauMixmesvHE86JMU/AzvuwN7BLO/sYff3+Qt/4y
         Zlu8MZDWD+3/R5iI89CWscRtCuI46Gsc7DapPjLN30ph8sD3xeSwePPY7gUXdeq1zFfz
         Tsft8kxg7GADfcrjTj/tTopOKr8SKkbky8KfY4+b6jyJiC1dAf3WjG+nb4+eax31ha0s
         KO7d/FTle9jx4J4Fi4G+rI4E2ctBgS3F2CN0UOit2f5bGwyvYiywur89sWyDCS+bEQMr
         kl4g==
X-Gm-Message-State: APjAAAXUZapGYtDN9WwZwuCs1nrrJ1x9h52906+aUzH6g6zGkneCsxcA
        yDpy3Pt324QeEjK+Y+q03q8McvJfk7NJAxVhifXTifWQ
X-Google-Smtp-Source: APXvYqwBkhrUM1HWtTXSwhVRnycSbQQegydXxuZNDeDizEaJk3f+m/h+FjJ7hFwdpdBlZI4mz4tA2S8roWZpvfZ1IHI=
X-Received: by 2002:aca:4b88:: with SMTP id y130mr8379252oia.157.1567115883743;
 Thu, 29 Aug 2019 14:58:03 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Thu, 29 Aug 2019 17:57:52 -0400
Message-ID: <CAB_54W7h9ca0UJAZtk=ApPX-2ZCvzu4774BTFTaB5mtkobWCtw@mail.gmail.com>
Subject: ANNOUNCE: rpld an another RPL implementation for Linux
To:     "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Cc:     Michael Richardson <mcr@sandelman.ca>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Robert Kaiser <robert.kaiser@hs-rm.de>,
        Martin Gergeleit <martin.gergeleit@hs-rm.de>,
        Kai Beckmann <kai.beckmann@hs-rm.de>, koen@bergzand.net,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        reubenhwk@gmail.com,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        sebastian.meiling@haw-hamburg.de,
        Marcel Holtmann <marcel@holtmann.org>,
        Werner Almesberger <werner@almesberger.net>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I had some free time, I wanted to know how RPL [0] works so I did a
implementation. It's _very_ basic as it only gives you a "routable"
(is that a word?) thing afterwards in a very constrained setup of RPL
messages.

Took ~1 month to implement it and I reused some great code from radvd
[1]. I released it under the same license (BSD?). Anyway, I know there
exists a lot of memory leaks and the parameters are just crazy as not
practical in a real environment BUT it works.

I changed a little bit the dependencies from radvd (because fancy new things):

- lua for config handling
- libev for event loop handling
- libmnl for netlink handling

The code is available at:

https://github.com/linux-wpan/rpld

With a recent kernel (I think 4.19 and above) and necessary user space
dependencies, just build it and run the start script. It will create
some virtual IEEE 802.15.4 6LoWPAN interfaces and you can run
traceroute from namespace ns0 (which is the RPL DODAG root) to any
other node e.g. namespace ns5. With more knowledge of the scripts you
can change the underlying topology, everybody is welcome to improve
them.

I will work more on it when I have time... to have at least something
running means the real fun can begin (but it was already fun before).

The big thing what everybody wants is source routing, which requires
some control plane for RPL into the kernel to say how and when to put
source routing headers in IPv6. I think somehow I know what's
necessary now... but I didn't implemented it, this simple
implementation just filling up routing tables as RPL supports storing
(routing table) or non-storing (source routing) modes. People tells me
to lookup frrouting to look how they do source routing, I will if I
get the chance.

It doesn't run on Bluetooth yet, I know there exists a lack of UAPI to
figure out the linklayer which is used by 6LoWPAN. I need somehow a
SLAVE_INFO attribute in netlink to figure this out and tell me some
6LoWPAN specific attributes. I am sorry Bluetooth people, but I think
you are also more interested in source routing because I heard
somebody saying it's the more common approach outside (but I never saw
any other RPL implementation than unstrung running).

Also I did something in my masters thesis to make a better parent
selection, if this implementation becomes stable I can look to get
this migrated.

Please, radvd maintainer let me know if everything is okay from your
side. As I said I reused some code from radvd. I also operate on
ICMPv6 sockets. The same to Michael Richardson unstrung [2]. If there
is anything to talk or you have complains, I can change it.

Thanks, I really only wanted to get more knowledge about routing
protocols and how to implement such. Besides all known issues, I still
think it's a good starting point.

- Alex

[0] https://tools.ietf.org/html/rfc6550
[1] https://github.com/reubenhwk/radvd
[2] https://github.com/AnimaGUS-minerva/unstrung
