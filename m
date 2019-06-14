Return-Path: <SRS0=cJ+v=UN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00296C31E44
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 07:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2E42133D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 07:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9+ayhA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfFNHQ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:16:28 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40048 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNHQ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jun 2019 03:16:28 -0400
Received: by mail-wm1-f42.google.com with SMTP id v19so1144705wmj.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2019 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bVAjztn4WgDKNgLQRExic9ECI/X5eMVwfyuZMAwh6wE=;
        b=a9+ayhA5zK+Jg8SPV2IwJbEPmZS8/pRds4JpencJnMolDwZM0WfAPDroASuNFXajHJ
         PbufjUL/dkjciNaKTmOOKFjX1uOg146LYC8C8rH7/VJzAxiK5kDxy+0ygwN0ymej80yB
         FUGfE5yTG/Yge4z+PJ7XlB1luhzoVO7xTCETMuMF3Dbmpf+UTnjfz2Gg33nl54se37lW
         0uNrwBUiuB6VOL7k5CWmkg88SVJ5d/zqjx8i+5tfNuxB1RtBD0vilWEuMr60RtyUK1vW
         jTq2e42UyY8D15KxWiHMI5ItV+z7PGp4IMQyQCNdO7MEoNisvoB1FNjRwHOD4Nhsvuk4
         wLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bVAjztn4WgDKNgLQRExic9ECI/X5eMVwfyuZMAwh6wE=;
        b=sLMGQ4XBYzZmVWzYj8j7lwLq04Xa8StIzchvfHcQGmdaaxs2M1WHkZgJOOdCCalOeM
         KA1hwbnlEhl+GNmBbacuw/bXqDep36iGg9VgcTFqy/pEaNfVr6HXSyvI+c/LS9y/E0l3
         8Bsv2rAXX5WOvKbLk/KK4k3s/I58+Oc0NQN+7TVflYSY27LW1NJFg3h6/ontx2NIoBJP
         VDoS5U/frnjMxa4pjjGM0I3KdJ2yzYaOnTFIYHV880iwBXLMfnBVBFAjjUeZK8PPOI0A
         6JArihWXGqmpzsLjUyMy1VAdugaP2x0glMUUueW2mb6GqWw9y3udhsvwfIAEphWp3EAU
         PAHA==
X-Gm-Message-State: APjAAAWzxX5TiniEo7VrofcLxvkjuQZIF6XyXNfQnOczzV2tYBsOaKZU
        rMDvEKM8orO7BI8e3pWM9xavdWWMCac=
X-Google-Smtp-Source: APXvYqxRAMcwT4Y9keCOaME2nwaqKTHKK+MPE3qGucB21EUiUl7B5Nz40N+qonSPOGG0fy+QosSIvw==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr6964425wmc.89.1560496583734;
        Fri, 14 Jun 2019 00:16:23 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u5sm2636928wmc.32.2019.06.14.00.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 00:16:23 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:16:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     =?utf-8?B?RnLDqWTDqXJpYw==?= Danis <frederic.danis.oss@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez A2DP socket reliability
Message-ID: <20190614071622.wyra2hhkpzpt7i4z@pali>
References: <20190518190618.m7rdkthvpz4agxd2@pali>
 <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
 <20190519122223.gabew7qfftihlbic@pali>
 <20190607130021.ntd3dfd6nzmuy3m3@pali>
 <CABBYNZKQ0WYTH4Oa_eFv11Ok8=42oY_GPFzN-D6UqfeNsvaXug@mail.gmail.com>
 <20190610105130.un3muj4knwoua5cb@pali>
 <b7e5978c-7ebc-82ad-2c44-878712cd14cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e5978c-7ebc-82ad-2c44-878712cd14cd@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 10 June 2019 18:06:53 Frédéric Danis wrote:
> Hi,
> 
> Le 10/06/2019 à 12:51, Pali Rohár a écrit :
> > On Friday 07 June 2019 18:23:41 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > > 
> > > On Fri, Jun 7, 2019 at 4:00 PM Pali Rohár<pali.rohar@gmail.com>  wrote:
> > > > On Sunday 19 May 2019 14:22:23 Pali Rohár wrote:
> > > > > On Sunday 19 May 2019 11:13:09 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > > 
> > > > > > On Sat, May 18, 2019 at 11:12 PM Pali Rohár<pali.rohar@gmail.com>  wrote:
> > > > > > > Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
> > > > > > > transfer configured in bluez? It is reliable with big/infinite
> > > > > > > retransmit count? Or in best-effort manner and some packets may be
> > > > > > > dropped? And it is possible to change between these two modes for
> > > > > > > application which uses bluez DBUS API? I'm asking because some A2DP
> > > > > > > audio codecs are designed to deal with packet loss and for those codecs
> > > > > > > it would be probably better to configure L2CAP socket to unreliable
> > > > > > > mode.
> > > > > > We don't use ERTM with AVDTP, both signaling and transport sockets are
> > > > > > using basic mode which don't support retransmissions, there the
> > > > > > concept of flush timeout which iirc we don't currently it.
> > > > > On bluez.org site there is no information how to use bluez sockets and
> > > > > the only documentation/tutorial which I found on internet was this:
> > > > > 
> > > > >    https://people.csail.mit.edu/albert/bluez-intro/x559.html
> > > > > 
> > > > > I do not know how up-to-date it is, but seems that by default bluez
> > > > > L2CAP sockets are reliable and to change them to unreliable mode it is
> > > > > needed to issue OGF_HOST_CTL / OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT (0x28)
> > > > > request. As default is zero = infinity = reliable connection.
> > > > > 
> > > > > I do not understand low level bluetooth details, but is ERTM related to
> > > > > OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT?
> > > > > 
> > > > > So what are default settings for L2CAP socket used by AVDTP/A2DP
> > > > > profiles which are transferred to user application via DBUS?
> > > > Hi! Do you have any idea about OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT? It is
> > > > related to ERTM or not?
> > > The OCF usually describes an HCI command which may affect the entire
> > > ACL connection, ERTM is a L2CAP channel mode that includes
> > > retransmissions. The A2DP stream transport doesn't ERTM so no
> > > retransmissions shall take place.
> > Fine, no retransmission is good for A2DP.
> 
> I am not sure there is no retransmission with current implementation.
> AFAIU, ERTM and automatic flush timeout are not linked. ERTM operates at
> L2CAP level while automatic flush timeout [1] operates at ACL level.
> When I read the automatic flush timeout set for an A2DP SBC connection it
> returns 0, which means that the connection uses an infinite timeout. So,
> even if higher levels set packets as flushable, the ACL policy requests
> baseband to indefinitely try to send data [3]:
>   "The default Flush Timeout shall be infinite,
>     i.e. re-transmissions are carried out until
>     physical link loss occurs. This is also
>     referred to as a 'reliable channel.'"
> 
> [1] Bluetooth core Vol 2, Part E, 6.19
> [2] Bluetooth core Vol 2, Part E, 7.3.29
> [3] Bluetooth core Vol 2, Part B, 7.6.3

Mhm... I feeling quite lost. Is A2DP socket reliable with enabled
retransmission or not?

-- 
Pali Rohár
pali.rohar@gmail.com
