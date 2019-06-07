Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E7EC2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB82206BB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C82K68eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfFGNAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:00:24 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39913 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfFGNAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 09:00:24 -0400
Received: by mail-wr1-f48.google.com with SMTP id x4so2078419wrt.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Kr5qNrj1U8lY2eMrZQRvJqB88jkRz5SlxohT508ePT0=;
        b=C82K68eb+F+pX4/iIE0Tgx8v4Y04XkostjS57JsNOJwAcLmEcMNnT6UdaOalUHyCFc
         UY4kfq/I3MtBjqyGi3iPBA1sOO2IVcMjSd/gothrO5cORlvFnz1/zIf6TX+Oi2cCHtKy
         4dwtSvyFyxIbwJ+I16d58UHd6chIEgAs4xVUweTH/wl8k64L2jufFuFkBcGkmKrPW0mJ
         YZ5jTvlNlE7Go/gDlHV0kwiclT0Bc3gnGZcI1672p0b2WOYB/sDFGuxge/oAkiJqdv6O
         kYz8QBp5xoKJLcR1p3a/Q42IFTlCGGbnqjSmmu6JzJcFHFP9fVqLiMntZHknTTpwuhm/
         +cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kr5qNrj1U8lY2eMrZQRvJqB88jkRz5SlxohT508ePT0=;
        b=CYDmVNEkpPre5zo/0habdCkU7eW2nD3GjNPWywRuAJy2JTFWVpQ01Vxat9QNBw2Zl/
         lChIXS9Q5zOOD6yFGla+E2qHuKaY3qvL1Hn7bUSolfqV53pIPgsL4QiMiDKVndMGSfqm
         tNWTwD7EfUtjgTi79tR0LWCbiy+tlV/8k5BnrmWZyHGmYoe2lD5XFhU23tbE3JoJBXl9
         bql4qBXGGIjBvrkXnuzA+K1MobUUzWc1nbbeBFM/2k7iM1i0JQXN42ZFnzNe0TSrBhB8
         WN52s1ftNrPv6B6T0NYxDxnvCYXY1Zxb8Cyt0nsMc2IBti6iU8eI1tKmzTeksQVC6Gos
         /rMg==
X-Gm-Message-State: APjAAAW8PxoEbYlpU7ZHUnzrd5TrKaH3Sb451ijeMi2ZYQIQ/22pw1z1
        mf5HYzQEZWyfJE91xdQiUM76rNJQC8Y=
X-Google-Smtp-Source: APXvYqw5rwMha4vwYzeGOaEjvQEcAIbra5UQJLnZpDi3YivfSMbou/ypDBJ7LnUpcoS4gT0NsB3qzA==
X-Received: by 2002:adf:c654:: with SMTP id u20mr7644817wrg.271.1559912423203;
        Fri, 07 Jun 2019 06:00:23 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v15sm2140356wrt.25.2019.06.07.06.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:00:22 -0700 (PDT)
Date:   Fri, 7 Jun 2019 15:00:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: bluez A2DP socket reliability
Message-ID: <20190607130021.ntd3dfd6nzmuy3m3@pali>
References: <20190518190618.m7rdkthvpz4agxd2@pali>
 <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
 <20190519122223.gabew7qfftihlbic@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190519122223.gabew7qfftihlbic@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 19 May 2019 14:22:23 Pali Rohár wrote:
> On Sunday 19 May 2019 11:13:09 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > On Sat, May 18, 2019 at 11:12 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
> > > transfer configured in bluez? It is reliable with big/infinite
> > > retransmit count? Or in best-effort manner and some packets may be
> > > dropped? And it is possible to change between these two modes for
> > > application which uses bluez DBUS API? I'm asking because some A2DP
> > > audio codecs are designed to deal with packet loss and for those codecs
> > > it would be probably better to configure L2CAP socket to unreliable
> > > mode.
> > 
> > We don't use ERTM with AVDTP, both signaling and transport sockets are
> > using basic mode which don't support retransmissions, there the
> > concept of flush timeout which iirc we don't currently it.
> 
> On bluez.org site there is no information how to use bluez sockets and
> the only documentation/tutorial which I found on internet was this:
> 
>   https://people.csail.mit.edu/albert/bluez-intro/x559.html
> 
> I do not know how up-to-date it is, but seems that by default bluez
> L2CAP sockets are reliable and to change them to unreliable mode it is
> needed to issue OGF_HOST_CTL / OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT (0x28)
> request. As default is zero = infinity = reliable connection.
> 
> I do not understand low level bluetooth details, but is ERTM related to
> OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT?
> 
> So what are default settings for L2CAP socket used by AVDTP/A2DP
> profiles which are transferred to user application via DBUS?

Hi! Do you have any idea about OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT? It is
related to ERTM or not?

-- 
Pali Rohár
pali.rohar@gmail.com
