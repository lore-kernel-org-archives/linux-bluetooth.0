Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669C6C282DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 10:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE26206BB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 10:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MClQ4N4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbfFJKve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:51:34 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40578 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389426AbfFJKve (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jun 2019 06:51:34 -0400
Received: by mail-wm1-f48.google.com with SMTP id v19so43943wmj.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2019 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1AprxLh5aOOnhZywN53A2N1mIL16pEeWCtpt7xVlSr8=;
        b=MClQ4N4O3u7TleNmr3+kf9KyEgDL6rPJXrdaT50lRkJpNI1feliLiLVruUFBRYy+y4
         6gLcyXzP5rQEPWqz3jySykR+TU/xVffPTTz9wDA0JfQJTQ6qfP063Ckx7ZEvklIGhvL3
         Rloj494ddqXuJedEDFgJz3GA/qQc5pn9xBHbVB5PDnCpeTcG/LYQOKdXqshXo+CbBg2g
         /TrgueDuP7ELXy+81uGqFVXG2YeoykR89E2gv9QXv7LqT/aYGFBFcVOjJidL6vGyxjUi
         AM+chloliR/fztzrJviZlhdv8iKyci5W770lBUCjLTl4v2ZqR8T/KNEYdGW7XJNEVunv
         jiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1AprxLh5aOOnhZywN53A2N1mIL16pEeWCtpt7xVlSr8=;
        b=XLKUxjLO6WA9xZYj448v5ZjJVG3HWjKfAIG2kT4U6zo+B0MFLEAtntuP6dMw/0XxoY
         Tk43PXNrC/maOFmO49tHuWMTaD19sbTC7A+pf8VbrUkGb127rYGowQJvb4JUeSAV2opw
         RBQlXejDue/u8Gpb5l1rJJREXs4wkU2f6x4m81P+F2liqsPQv75WWqlCL/6VZeR2TAZj
         WsbeebFPaXn94h66A3rGM4ubGbYom7t8mMWjsTZ3gQ/4vDF8hUJMMpom+PvMs9YXrwWm
         drM4ZRDs7CZqLzBvmO+/OH+cLGjMS4sGmJk2NqGJsRRlU8QK+Uzmh0rm/lZKbQ+aaQ2p
         4Ong==
X-Gm-Message-State: APjAAAUx6QnbRRET7OFgwr3b3hJURDhILy4tYXfMxlWfKG64rDQ4huDS
        nt7LpS2NuftAnq50Dwonhm4pFhrRbxk=
X-Google-Smtp-Source: APXvYqzFI0sdjHj6mQayZXaBH1lT+wW1qZxFm3bXjPj6x7ozLzgNNhFiDRfN1en0fWCgizwvHIZxpQ==
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr12812178wmu.80.1560163891772;
        Mon, 10 Jun 2019 03:51:31 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b203sm10912029wmd.41.2019.06.10.03.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 03:51:30 -0700 (PDT)
Date:   Mon, 10 Jun 2019 12:51:30 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez A2DP socket reliability
Message-ID: <20190610105130.un3muj4knwoua5cb@pali>
References: <20190518190618.m7rdkthvpz4agxd2@pali>
 <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
 <20190519122223.gabew7qfftihlbic@pali>
 <20190607130021.ntd3dfd6nzmuy3m3@pali>
 <CABBYNZKQ0WYTH4Oa_eFv11Ok8=42oY_GPFzN-D6UqfeNsvaXug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKQ0WYTH4Oa_eFv11Ok8=42oY_GPFzN-D6UqfeNsvaXug@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 07 June 2019 18:23:41 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Fri, Jun 7, 2019 at 4:00 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Sunday 19 May 2019 14:22:23 Pali Rohár wrote:
> > > On Sunday 19 May 2019 11:13:09 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Sat, May 18, 2019 at 11:12 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > >
> > > > > Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
> > > > > transfer configured in bluez? It is reliable with big/infinite
> > > > > retransmit count? Or in best-effort manner and some packets may be
> > > > > dropped? And it is possible to change between these two modes for
> > > > > application which uses bluez DBUS API? I'm asking because some A2DP
> > > > > audio codecs are designed to deal with packet loss and for those codecs
> > > > > it would be probably better to configure L2CAP socket to unreliable
> > > > > mode.
> > > >
> > > > We don't use ERTM with AVDTP, both signaling and transport sockets are
> > > > using basic mode which don't support retransmissions, there the
> > > > concept of flush timeout which iirc we don't currently it.
> > >
> > > On bluez.org site there is no information how to use bluez sockets and
> > > the only documentation/tutorial which I found on internet was this:
> > >
> > >   https://people.csail.mit.edu/albert/bluez-intro/x559.html
> > >
> > > I do not know how up-to-date it is, but seems that by default bluez
> > > L2CAP sockets are reliable and to change them to unreliable mode it is
> > > needed to issue OGF_HOST_CTL / OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT (0x28)
> > > request. As default is zero = infinity = reliable connection.
> > >
> > > I do not understand low level bluetooth details, but is ERTM related to
> > > OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT?
> > >
> > > So what are default settings for L2CAP socket used by AVDTP/A2DP
> > > profiles which are transferred to user application via DBUS?
> >
> > Hi! Do you have any idea about OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT? It is
> > related to ERTM or not?
> 
> The OCF usually describes an HCI command which may affect the entire
> ACL connection, ERTM is a L2CAP channel mode that includes
> retransmissions. The A2DP stream transport doesn't ERTM so no
> retransmissions shall take place.

Fine, no retransmission is good for A2DP.

And how it is with delivering packets? It is possible that may be
delivered to other side in wrong order?

-- 
Pali Rohár
pali.rohar@gmail.com
