Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335C7C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 09:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAB02067B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 09:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8kFan9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKMJXB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:23:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51839 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfKMJXB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 04:23:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so1168715wme.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2019 01:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BSymLBinEM8wqh+8W8GSM8zRxC113Tj7nfQja5hFdjE=;
        b=V8kFan9rZmIzLJoSq2MoxbacEZk8n9oquBmKX+FAiOFdf2QWR7Xi/t6qAuNCr1V+11
         PQdsMGKdxjSzNn/EiJzQEGT279aL01A5AowJuBwoS66Q3I9R44mHrm0m7J7TJH+LPS4W
         yMtDCbI2IN/XznmuvA41oms4SxaQcli1Cw0Z7mRmUg26S1WlIMTC2+zAInB9gKLuaT5J
         +gucE8iUbDBR7+KlxoezzggEQphpBISQkVIkWILP6YU741kVpLMqhAs8kwc7hWRN7wzH
         +kOg4Zpyp4Ku3lTlJTsiI64DD5ryHYqLNGejhkVKXVd0piFGVUidD1KBaeOggOEBytZB
         lS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BSymLBinEM8wqh+8W8GSM8zRxC113Tj7nfQja5hFdjE=;
        b=K3wzkzEXfPibk2b8gyfP/ny+vJyKLIosMF0QZ7vBq9oQHz3odYPSqWCOpeqjaLF/Zi
         W5yDpdO8/4S57sd1u4naoJW4yCcbsnAaIoQF09fz/pcFOU3dJP0nkJZpxo1B2jDTJ7kH
         F0LhUWgolzFp3eK/+akEjh7F0/Y2wMIofSDXNISn5qO1pAaGqhKobCVw+XKwU5jXGQq1
         mhudgiOI8BFH0nUL0SYDJlEgqvgXaJEe5CZC21tXGfxPa5QWKNM+tp+n4WdCZg2UcIjx
         MEaNH3LZ3jQzwSCHGT6fvh0qkRf7ovJgfRnusEjdBdLzZoGtNQ9MYUIfvNrZFpRonXeT
         H5Bg==
X-Gm-Message-State: APjAAAWfF9Ep1Z1lPPecs+8vTyT/5/+Nlx++ys0tHmaFR4XuUyuZveol
        Uu7UKcQTpmx42exjFPbRVKf3THim
X-Google-Smtp-Source: APXvYqwAdxvRroW9A0Wk27z3uj4aQcEARqAekvW769burShSx1LyMUDGMA4FRZJpP8fqFhIfofxBJQ==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr1846381wmc.143.1573636978435;
        Wed, 13 Nov 2019 01:22:58 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p14sm2123934wrq.72.2019.11.13.01.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 01:22:57 -0800 (PST)
Date:   Wed, 13 Nov 2019 10:22:56 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191113092256.bxc6ixuk7ctrmt57@pali>
References: <20190519212157.GB31403@amd>
 <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <20191027220945.wmb3g55wtrmqbnmz@pali>
 <20191112210633.cjhpb7eczzta63mf@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191112210633.cjhpb7eczzta63mf@ucw.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 12 November 2019 22:06:33 Pavel Machek wrote:
> Hi!
> 
> > > > >>>>>>>> But for AuriStream I need to set custom SCO parameters as described
> > > > >>>>>>>> below and currently kernel does not support it. This is why I'm asking
> > > > >>>>>>>> how kernel can export for userspace configuration of SCO parameters...
> > > > >>>>>>> 
> > > > >>>>>>> We can always come up with socket options but we got to see the value
> > > > >>>>>>> it would bring since AuriStream don't look that popular among
> > > > >>>>>>> headsets, at least Ive never seem any device advertising it like
> > > > >>>>>>> apt-X, etc.
> > > > >>>>>> 
> > > > >>>>>> Pali clearly has such device and he is willing to work on it. Surely
> > > > >>>>>> that means it is popular enough to be supported...?
> > > > >>>>> 
> > > > >>>>> Just put AT+CSRSF=0,0,0,0,0,7 to google search and you would see that
> > > > >>>>> not only I have such device...
> > > > >>>>> 
> > > > >>>>> So I would really would like to see that kernel finally stops blocking
> > > > >>>>> usage of this AuriStream codec.
> > > > >>>> 
> > > > >>>> we need to figure out on how we do the kernel API to allow you this specific setting.
> > > > >>> 
> > > > >>> Hi Marcel! Kernel API for userspace should be simple. Just add two
> > > > >>> ioctls for retrieving and setting structure with custom parameters:
> > > > >>> 
> > > > >>> syncPktTypes = 0x003F
> > > > >>> bandwidth = 4000
> > > > >>> max_latency = 16
> > > > >>> voice_settings = 0x63
> > > > >>> retx_effort = 2
> > > > >>> 
> > > > >>> Or add more ioctls, one ioctl per parameter. There is already only ioctl
> > > > >>> for voice settings and moreover it is whitelisted only for two values.
> > > > >> 
> > > > >> it is not that simple actually. Most profiles define a certain set of parameters and then they try to configure better settings and only fallback to a specification defined default as last resort.
> > > > > 
> > > > > Ok. I see that there is another "example" configuration for AuriStream
> > > > > with just different syncPktTypes = 0x02BF and bandwidth = 3850.
> > > > > 
> > > > > So it really is not simple as it can be seen.
> > > > 
> > > > currently the stepping for mSBC and CVSD are hard-coded in esco_param_cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the ->setting parameter.
> > > > 
> > > > So either we provide an new socket option (for example BT_VOICE_EXT) or we extend BT_VOICE to allow providing the needed information. However this needs to be flexible array size since we should then be able to encode multiple stepping that are tried in order.
> > > > 
> > > > My preference is that we extend BT_VOICE and not introduce a new socket option. So feel free to propose how we can load the full tables into the SCO socket. I mean we are not really far off actually. The only difference is that currently the tables are in the hci_conn.c file and selected by the provided voice->setting. However nothing really stops us from providing the full table via user space.
> > > 
> > > Ok. I will look at it and I will try to propose how to extend current
> > > BT_VOICE ioctl API for supporting all those new parameters.
> > 
> > Below is inline MIME part with POC patch which try to implement a new
> > IOCTL (currently named BT_VOICE_SETUP) for configuring voice sco
> > settings.
> > 
> > It uses flexible array of parameters <tx_bandwidth, rx_bandwidth,
> > voice_setting, pkt_type, max_latency, retrans_effort>, but with
> > maximally 10 array members (due to usage of static array storage). cvsd
> > codec uses 7 different fallback settings (see voice_setup_cvsd), so for
> > POC 10 should be enough.
> > 
> > Because a new IOCL has different members then old BT_VOICE I rather
> > decided to introduce a new IOCTL and not hacking old IOCTL to accept two
> > different structures.
> > 
> > Please let me know what do you think about this API, if this is a way
> > how to continue or if something different is needed.
> 
> 
> New ioctl sounds like good idea.
> 
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index fabee6db0abb..0e9f4ac07220 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -122,6 +122,19 @@ struct bt_voice {
> >  #define BT_SNDMTU		12
> >  #define BT_RCVMTU		13
> >  
> > +#define BT_VOICE_SETUP		14
> > +#define BT_VOICE_SETUP_ARRAY_SIZE 10
> > +struct bt_voice_setup {
> > +	__u8 sco_capable:1;
> > +	__u8 esco_capable:1;
> > +	__u32 tx_bandwidth;
> > +	__u32 rx_bandwidth;
> > +	__u16 voice_setting;
> > +	__u16 pkt_type;
> > +	__u16 max_latency;
> > +	__u8 retrans_effort;
> > +};
> > +
> 
> Is this the new ioctl? I'd assume it should go to include/user/..
> somewhere to be exported to userspace...?

I put it into same file where is structure for old ioctl BT_VOICE.

> Is it good idea to use __u8 :1 in user<->kernel API?

I do not know. Should it be rather (C99) bool? Or just one __u8?

-- 
Pali Rohár
pali.rohar@gmail.com
