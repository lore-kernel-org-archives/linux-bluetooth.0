Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A7DC0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 09:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4AF20659
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 09:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="cUA8ozsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfGAJU6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:20:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40401 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfGAJU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 05:20:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so12350374ljh.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2019 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+y2A9ol69Y5aJKhulNZ2ycxsZiWqZMWSSldHnTLqb9U=;
        b=cUA8ozsNh+gfHCn2qr+lSc66V5s51zG9J5Db0V8WSYW3ibPr5RsnGBGJH7FaPpfIBu
         jh/bDgcRnwSqINfH64l0EhyB6V5Bg/2EjIMHJJx98z9UBwVkSOgKIzLHNrBPIrkhMRTf
         nxgnf4CL7MkxMOX97OFeVm4oyGpHjLBRh5UtmVlUibp7dTp3mehTluKtUBu+4KeBBzy0
         HHNz7SA2UIKVp0UBojJuATLyrJibvkv1QFGw/cxKUvRTZjLfLaAauDntr3ka2K7TetYT
         dugx7Bz9YDQzDaJdoXkGzfveZAKsBO87l4YRIwjwkNgHNJKErYx3/VZC1M1E9CU5LnuB
         DqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+y2A9ol69Y5aJKhulNZ2ycxsZiWqZMWSSldHnTLqb9U=;
        b=COgoJA970jYToNtBjOvtqe/vMWBPtrkJy6pqCC/cxF/DEvtEoOmYzJ7LhIp5V3KuKr
         O0JmzmyX8WALCvXuNgC1bTU7yLZjI3U0/J+mpkJ1tWNlBa1aYbLIF0gKwnRYFqFk0tka
         0G/yzlo2fsGTC7/SjXKWqp9xszgcVseJVfKioSYp8eys2z6S5eA6/4f/kNc/YVKJNp5G
         4LN0ZQJsmxGHrIvsznJ/OP6LaXFdJFlDqI54sR5BTHoS29Fsi4VhvG00ZB0KdX8hfBbP
         Rzz0U5+csqOFQwCdh8llF+/eUqM1FPc7hXJ97VoyXLaIJA7c5hDygTUx8Zr5NqyRfQtx
         beeg==
X-Gm-Message-State: APjAAAVIykPlRB1Pte9WaJatD3d1LARquHrkBtzyhQDGS+UAR+lQK0z6
        oJg2R7BynKU9Txe2gc/TF5PnXg==
X-Google-Smtp-Source: APXvYqy2hpQrBrwfIkOa5eW1HhWjV/yWV4i6l8TyeAqmmswrnKk4RP1GKfcGeiHjjbEUHh/EYzD+yw==
X-Received: by 2002:a2e:8613:: with SMTP id a19mr13067875lji.163.1561972855563;
        Mon, 01 Jul 2019 02:20:55 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v139sm2377204lfa.69.2019.07.01.02.20.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 02:20:54 -0700 (PDT)
Date:   Mon, 1 Jul 2019 11:20:52 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: Was: mesh: Added ImportLocalNode call with its API --> Multiple
 Methods?
Message-ID: <20190701092052.24dxntjvvdcylp6r@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190625143855.29889-1-jakub.witowski@silvair.com>
 <1561568468.22940.16.camel@intel.com>
 <14abe0f2129a2334d32aa14f2167380a5208880b.camel@intel.com>
 <CAMCw4t3pXTbtt05RD694jzF_MNT_J9dcFMtA7iuD4ujZT9FDbg@mail.gmail.com>
 <1561660267.7802.29.camel@intel.com>
 <20190627195127.payxcdeexiamsi24@kynes>
 <1561732182.7802.47.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561732182.7802.47.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 06/28, Gix, Brian wrote:
> > The application can do all the configuration using loopback Config
> > Server messages, so I don't think we need a Migrate() call at all. The
> > application already receives current node configuration when
> > Attach()ing, so it can determine if something needs to be reconfigured.
>
> I don't see this actually working very well.  Firstly, these
> "Loop-back" Config Server messages do not all actually work unless the
> node is a Provisioner, which will *not* be required of most nodes.

I don't think this is true. Application can send messages from the
application to its node using straightforward Send() call with key index
0x7fff, and they are processed correctly. While this might be considered
a "hack", you've seen that I am currently working on DevKeySend() API.

As far as I can tell, a node always has its own Device Key in the
keyring, so loopback messaging via DevKeySend() is going to work even on
non-provisioner nodes.

> And However, even if the App went through all of the restoration of
> all the settings under the control of the Provisioner via this Config
> Server loop-back method, there is still the critical issue of Sequence
> numbers.

Indeed. I would propose simply adding starting sequence number to the
dictionary passed to ImportLocalNode() call. It can be made optional,
i.e. when the application doesn't provide it, the imported node starts
counting from 0.

> If we want a single method (avoid API bloat) I don't think we have any
> choice but to use a well developed structure (like JSON or XML) that
> faithfully sets up the node in the state it was in prior to Migration.
>
> We can perhaps "Overload" this functionality by allowing a minimal
> JSON with only Prov Data parts, if we are looking for a Provisioning
> shortcut, and always requiring the ObjectManager calls fetch the
> Composition (if the JSON was minimal) and to Sanity check the
> Composition (if the JSON contains a fully developed/configured
> Migrated node).

Ok, that sounds better. We could start by implementing the "Provisoining
shortcut" variant, and add full-blown migration when it's needed.

Would that be OK from your POV?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
