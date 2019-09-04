Return-Path: <SRS0=/e8j=W7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E80C3A5A8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 19:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9102077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 19:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="nfpA/Ecq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfIDTZb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:25:31 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:47090 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbfIDTZa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Sep 2019 15:25:30 -0400
Received: by mail-lf1-f53.google.com with SMTP id t8so4403934lfc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Sep 2019 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EBUB/F9qZkCPFULX8oTzpG6R+7yHs0UbmLEJk4iN3HA=;
        b=nfpA/EcqGYVvAg5hp/6LCPcz1dvh4xI6gGPOcQRWtWmODHZJRyNDoZbe628OHC6DEJ
         yYzJ+XFlo51UXJpmHGOcfOHob8jtb/onnFk1o4z1Tl+LmNKh6fGaZv5gUM0oY5MxCAdq
         oNXWwv7I7k8D4cbfbSH9hpoDhPfYXUGPVrKddcTg/BxqgGNra0vt8C7i9sXHO0uYijnX
         E+7bn439U7XYZiscajgwUp+aIPCBUn7OwBTrgjP2OdNCpchjQhucph2JYnDqAXv0wvRV
         T2VhEPap6I9EsgArmKwtxbj58gU8rQ+zZy1KyZo9oCMNI2rpSaqawFNLKq2tsJYsVgHj
         +s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EBUB/F9qZkCPFULX8oTzpG6R+7yHs0UbmLEJk4iN3HA=;
        b=iK5lGVloy3zYW88oE4+T/Et3H8QyjsDrC81Jr5uSpTTlb6/5jJiHPjeQYc/mfgGRnE
         Brb/ONyvf1Xq0q9rAvfX5t4nF+aCS4NBTu2AWKLeMXPm76axnqH6bmHytojLRu/aNuuF
         VuZ7b2wE3UgwzIi/HfyGLLFXvicWyBVnCJ5R0cpbfiiZq1mLrShA/54PqxGgbDnpk2Ke
         q+ch2HlS2rBbn1liwwaCQlHxUut/GDqh9EIay2XrDXQYCozHjeVlhM5DgERQmseYbxA8
         iILXPPlykxDZdXBIQbinISk+XgVXkz8HbWgsuHROLX5SBPskupTZBBynK/g2u+Lc4Tmd
         WCjA==
X-Gm-Message-State: APjAAAWNwj6EVC6rlAG/wAZB/Ldf172ap5BijYTfFy48fGBQZ+7d0t1d
        j3QpwQqBmjb6k8uJZhVa06JgIrMsonk=
X-Google-Smtp-Source: APXvYqyNP9eV0gV/aERjHlta+AkvnPRkXzXGd2x5UWu3r56Uw273Uf7jeJobask3/oa+MAml7VR7rg==
X-Received: by 2002:a19:5f55:: with SMTP id a21mr7802298lfj.56.1567625128391;
        Wed, 04 Sep 2019 12:25:28 -0700 (PDT)
Received: from kynes (apn-95-41-66-58.dynamic.gprs.plus.pl. [95.41.66.58])
        by smtp.gmail.com with ESMTPSA id u21sm2005446lje.92.2019.09.04.12.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 12:25:27 -0700 (PDT)
Date:   Wed, 4 Sep 2019 21:25:25 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Message-ID: <20190904192525.2dqyihabxmigb54m@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830184301.zd3zaqrw7mv6r252@kynes>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On 08/30, Michał Lowas-Rzechonek wrote:
> When trying to use subscriptions in meshd, I've noticed that
> MessageReceived API does not provide the application with destination
> address of the deceived message - instead, it only sends a boolean flag
> saying if the message was part of a model subscription, or not.
> 
> I think this is problematic. There are use cases where a model is
> interested in the destination address of a group subscription. For
> example:

Alright, so it seems that is not as straightforward as I would like it
to be...

First of all, it seems that the specification doesn't *strictly* require
the model to know the value of the destination address of received
messages. The only passage that somewhat relates to that is in Mesh
Models spec v1.0.1, 3.3.2.2.3 "Receiving Generic Delta Set", but at the
moment we think that the requirement about aborting transacations
specified there can be satisfied without knowing the numeric value of a
destination address.

Other things have been neatly summarized by Brian, so I'm gonna respond
as usual.

On 09/04, Gix, Brian wrote:
> Well, what we are trying to balance here is:
>
> 1. Keeping the APIs as simple as possible

Yes, but not simpler...

> 2. Not exposing any information that we don't absolutely need to

And this is the thing I simply don't agree with. Security in mesh is
based on *keys*, not *APIs*.

We discussed access to the keyring before and I kind of agree that
applications don't really need access to key values, as long as various
Import*() methods exist. So keys are covered.

But hiding anything else does not make any sense. Certainly, it doesn't
"increase security" by any means. There is no reason why a model should
not have access to pretty much the whole payload (once it passes all the
layers, subscriptions and bindings are verified etc)., a complete
network layer included.

My primary argument is this: BT mesh is a relatively young standard and
apart from what's in Mesh Models spec we don't see many applications in
the wild. Who knows what the people are going to do with it? One of the
reasons we would like BT mesh to be available as free software is to
enable various people to play with it and invent new, interesting
applications (ideally, they would make it back to SIG and be adopted as
official specification, but that's another story).

In my opinion, keeping that power away from users, because there is no
"official" spec that uses certain information, is harmful.

> 3. Enabling valid use cases.
>
> We also are trying to stay true to the *spirit* of the specifications,
> and so I get a little uncomfortable with arguments like "The spec
> doesn't explicitely disallow it, so we need to support it".

And who gets to decide which use cases are "valid" and "true to the
spirit"?

The two examples I provided are *not* violating the spec in any way.
For the record:
 - a combined server/client sitting on element 1 that receives onoff
   messages and, depending on the destination address, sends a different
   onoff messages to a "regular" onoff server sitting on element 0,
   allowing efficient control over switching scenes involving large
   number of nodes
 - a model that acts as a IPv6 gateway and directly maps virtual
   addresses to IPv6 addresses of nodes living on the other side of the
   gateway

> That said, in this case we are proposing substituting a boolean
> argument (called "subscription", but really just a differentiator
> between a message received as a Unicast message vs a Group or Virtual
> address) with the actual destrination address. If this was as simple
> as a parameter swap, I would say "Go for it", but because of Virtual
> Addresses, it means substituting *two* methods for the one.  Then to
> continue down the rabbit hole, every *App* needs to support both
> methods which increases their complexity as well.

Well, if the application is not using virtual addresses then it doesn't
need to implement the method.

> I remember having this conversation just between Inga and myself when
> designing the interface, which is why we went for the Boolean
> argument...  to keep the API simpler in both the Applications and in
> the Daemon.  But if we are *absolutely sure* that there are valid Use
> Cases that *require* the knowledge of *which* subscription a message
> was received with, then we may have no choice.
>
> Some of the use-cases suggested I believe are invalid...  Multiple
> models on the same element are not allowed to execute the same
> opcode... or at least not ones that change a local state.

Could you elaborate? The two examples above don't require executing the
same opcode on different models.

The first one (in a slightly different form, but the idea is the same)
is already deployed in a production environment.

> This is Inga's area of expertice (both on the App side and the Daemon
> side) so I am inclined to trust her judgement.  But I would *really*
> like to avoid adding yet another MessageRecieved method if possibled.

We could make the address a D-Bus variant. I proposed two methods,
because I find variants somewhat cumbersome, but I have no strong
opinion about that.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
