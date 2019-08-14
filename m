Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E08C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB272084D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 07:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="cJdNam5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHNHwE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:52:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36510 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfHNHwE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 03:52:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id u15so8959240ljl.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2019 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bYHUG5j6QiGLWPAItNUfBzdBj12xBwUwd5L+TQ5DQbc=;
        b=cJdNam5d8geDEbCA/qQmUX6F12hDtAszQpnJBs7S3bzDiVnvFBYd9kDveOkffpOg6Q
         lx6NlXiBwh8iqeV6nBO5ldL7ukhJgFCDqRxJmNi7nsC8O43vEGi3RHhH0fRLW3yA4NGs
         /UBX8SRQ8czfQNuR5XdAHQOmeveXjDLjc17wZrFonyHNGvMVCMULGeomkZcYO0AQxxoS
         4PpLoBpFEToxTKMaGaXyipSkIpywpc+8rgPe4sHaqUYJtC/5LhlUGnr2Cah1VDMJx6+a
         miUliNUukY45GV6E+Q4oSLFyk9ijoBiB9IyNWQ2GSxIiiuXeerRNlt1I9Nk88tsZ+3uu
         o9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bYHUG5j6QiGLWPAItNUfBzdBj12xBwUwd5L+TQ5DQbc=;
        b=pcBkDg6vZI0q1F9NcMRhIkEfIN1mmKOQ0dUFMB4sRKrg0XfNDduglg9jsk9qqWjwbX
         mWzK/LkcXWmvR5qE2GFt9sSIEwco/W31jsIHCT8DpmzQCHHQQL41QBeAqrF99g+1+ILx
         a6o1kietlJfGCzbIFcoDtK5XZW3zj5mAFqWWVll/STDBevFy5VpCfrfNcl9gbU8vT4Sr
         RT+7+IDinX023Gofsf+T0y8K+1fzgM+j113tFuHjVajcMtsWd1dMgXmqh2sMdqKmi22y
         XRdyY2HavRmcwudecksVpE60s/zzHEHG+4GlbnNg/PZ8crjQDzlgFZU3wdw02TWRDYaN
         8TMw==
X-Gm-Message-State: APjAAAVgT9m9MTMJtSe8tZ+HkcNhkVau03TrqWPRP7Rce7fo2btBvRvk
        dJt6w0hqkL8tWa+XUy0SIdim0A==
X-Google-Smtp-Source: APXvYqw5J2sPLZwcHuTUD54w2/Lig1CFlto6MEb1ooL7TjfUgM+s4Ftj447Hxfxn174lO+U2agLO/Q==
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr23608220ljk.219.1565769121898;
        Wed, 14 Aug 2019 00:52:01 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y25sm689510ljj.5.2019.08.14.00.52.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 00:52:01 -0700 (PDT)
Date:   Wed, 14 Aug 2019 09:52:00 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ 0/1] mesh: Add D-Bus Security for sensitive data
Message-ID: <20190814075200.j3jmxpto7kszjjkp@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, inga.stotland@intel.com
References: <20190814014357.32453-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190814014357.32453-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 08/13, Brian Gix wrote:
> There are various "security sensitive" pieces of data that need to be
> exchanged between Applications and the Bluetooth Mesh daemon.
> 
> The following items will be encrypted before sending over D-Bus:
> 
> token --  This is used by all nodes.
> 
> net_keys, app_keys, dev_keys -- These will only typically be needed by
> Provisioner/Config Client nodes to extract the keys for purposes of
> Cponfiguration Database transfer.
Please don't.

I don't see any benefit from doing so. D-Bus traffic cannot be sniffed
by an unprivileged user, and privileged user already has access to the
storage and can extract all this information from there.

In my opinion there is little point in encrypting D-Bus traffic. Noone
else does that:

 - ConnMan sends login/password pairs over D-Bus in
   https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/vpn-agent-api.txt
 - BlueZ sends pairing secrets in
   https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/agent-api.txt

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
