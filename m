Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3616AC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 10:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFBB20720
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 10:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Ojyzao47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgKFKOW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFKOW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 05:14:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49792C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2020 02:14:20 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m16so794988ljo.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2020 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGwZnEkMi0F/dDX4tBoY7EHEj1W1dGm+OTmCZ1P8il4=;
        b=Ojyzao47DKf2Uyaccnw1P8PqV5aR8QuZJLhn+DRyFt9WU4D7fQ+xPlH1D5wOu0tXHU
         9yRtptto4C+5UiF0BbpA09ahjWQ1JZBoPhxC3QWliz89d+FWNUzQR5o/mZURKPPPP82c
         5Ynruq4TJ1f1EwOTQIJO3E+vB9SeIjlHNTMGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGwZnEkMi0F/dDX4tBoY7EHEj1W1dGm+OTmCZ1P8il4=;
        b=E6uTXqQuKLvF1p/9QNkvxJguxx317Oqf0fkjcRPjqazU9CJpF1gouH0vgKWpCR8NsA
         StO9N8MjsU1KNIMG8/0tQLwnzQ2xvdYke9Ybc4W7U3I6OXO4Oo946nRUKzikaNl6C2wy
         mW2ljKsC6l3Q/eFB9VDnmJ/IZs9YHsfVJ9EXXg8G3jjBMI0LOT6IkNWQPm2hNWB9IYT3
         fLLPKZItJxEwDcGhaHNGmihMVHard9W4C9ZqbKiK0A9mKCBLDJXUmfes/yjcVn/CVgPU
         U2ItV7dlWSKp7zF7JqGtdsx9ovCrg9pVMBsjSXd7XGx/V+y9naw6emfOkSaK8M70Du71
         HK4w==
X-Gm-Message-State: AOAM532PNPW/WNZptmTxVfq/+A8BgzShdZ/M6y19+kvSzwJcopI2zglg
        vXvfN5FXQFwmW3sCLuyPCF9t
X-Google-Smtp-Source: ABdhPJypqV3s6FNPmrH3HSi1J8oYeYeHu6gKbbjK1omn2J9opt3DeXqioDFefJ4izkFh/AOvBHEJaw==
X-Received: by 2002:a2e:1607:: with SMTP id w7mr459733ljd.419.1604657658578;
        Fri, 06 Nov 2020 02:14:18 -0800 (PST)
Received: from jimmy-ryzen-home (c-8713e055.76534-0-69706f6e6c79.bbcust.telenor.se. [85.224.19.135])
        by smtp.gmail.com with ESMTPSA id 18sm97270ljq.0.2020.11.06.02.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:14:17 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:14:16 +0100
From:   Jimmy Wahlberg <jimmywa@spotify.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
Message-ID: <20201106101416.GA263905@jimmy-ryzen-home>
References: <20201102132733.GA77385@jimmy-ryzen-home>
 <CABBYNZJV_59_VqF_W5dOo9hQDAjv2T14wQQObwxd7AQ7o=G6qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJV_59_VqF_W5dOo9hQDAjv2T14wQQObwxd7AQ7o=G6qA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Nov 03, 2020 at 01:43:01PM -0800, Luiz Augusto von Dentz wrote:
> Hi Jimmy,
> 
> On Mon, Nov 2, 2020 at 5:33 AM Jimmy Wahlberg <jimmywa@spotify.com> wrote:
> >
> > This test case is meant to verify that multiple
> > unknown options is included in the response.
> >
> > Unknown options shall be in the response if
> > they are not hints according to Bluetooth Core
> > Spec v5.2. See chapter 4.5 L2CAP_CONFIGURATION_RSP
> 
> Can you add the HCI trace (btmon) with and without the patch. Also
> perhaps we should have a comment why this is needed on the code:

Hi, thank you for the feedback. Here is some btmon output without the
patch. 

> ACL Data RX: Handle 11 flags 0x02 dlen 16                #50 [hci0] 72.519062
      L2CAP: Configure Request (0x04) ident 16 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00                                            ..              
< ACL Data TX: Handle 11 flags 0x00 dlen 15                #51 [hci0] 72.519162
      L2CAP: Configure Response (0x05) ident 16 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        10                                               .               
> ACL Data RX: Handle 11 flags 0x02 dlen 20                #52 [hci0] 72.634066
      L2CAP: Configure Request (0x04) ident 17 len 12
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [hint]
        10 00 11 02 11 00                                ......          
< ACL Data TX: Handle 11 flags 0x00 dlen 15                #53 [hci0] 72.634178
      L2CAP: Configure Response (0x05) ident 17 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        11                                               .               
> HCI Event: Number of Completed Packets (0x13) plen 5     #54 [hci0] 72.656717
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 24                #55 [hci0] 72.764088
      L2CAP: Configure Request (0x04) ident 18 len 16
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00 11 02 11 00 12 02 12 00                    ..........      
< ACL Data TX: Handle 11 flags 0x00 dlen 17                #56 [hci0] 72.764235
      L2CAP: Configure Response (0x05) ident 18 len 9
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x10) [mandatory]
        12

Here is btmon output with the patch. Both outputs are from running the
test case in subject.

> ACL Data RX: Handle 11 flags 0x02 dlen 16               #89 [hci0] 388.666111
      L2CAP: Configure Request (0x04) ident 3 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00                                            ..
< ACL Data TX: Handle 11 flags 0x00 dlen 17               #90 [hci0] 388.666216
      L2CAP: Configure Response (0x05) ident 3 len 9
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x10) [mandatory]
        10                                               .
> HCI Event: Number of Completed Packets (0x13) plen 5    #91 [hci0] 388.804992
        Num handles: 1
        Handle: 11
        Count: 1
> ACL Data RX: Handle 11 flags 0x02 dlen 20               #92 [hci0] 390.763564
      L2CAP: Configure Request (0x04) ident 4 len 12
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [hint]
        10 00 11 02 11 00                                ......
< ACL Data TX: Handle 11 flags 0x00 dlen 17               #93 [hci0] 390.763727
      L2CAP: Configure Response (0x05) ident 4 len 9
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x11) [mandatory]
        11                                               .
> HCI Event: Number of Completed Packets (0x13) plen 5    #94 [hci0] 390.930118
        Num handles: 1
        Handle: 11
        Count: 1
> ACL Data RX: Handle 11 flags 0x02 dlen 24               #95 [hci0] 392.863591
      L2CAP: Configure Request (0x04) ident 5 len 16
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00 11 02 11 00 12 02 12 00                    ..........
< ACL Data TX: Handle 11 flags 0x00 dlen 23               #96 [hci0] 392.863742
      L2CAP: Configure Response (0x05) ident 5 len 15
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x10) [mandatory]
        10 11 01 11 12 01 12

Regarding adding a comment. I will gladly add this comment if you think
it's important. 

> 
>   'On an unknown option failure (Result=0x0003), the option(s) that contain an
>   option type field that is not understood by the recipient of the
>   L2CAP_CONFIGURATION_REQ packet shall be included in the
>   L2CAP_CONFIGURATION_RSP packet unless they are hints.'
> 
> > Signed-off-by: Jimmy Wahlberg <jimmywa@spotify.com>
> > ---
> >  net/bluetooth/l2cap_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 1ab27b90ddcb..16956f323688 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3627,7 +3627,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> >                         if (hint)
> >                                 break;
> >                         result = L2CAP_CONF_UNKNOWN;
> > -                       *((u8 *) ptr++) = type;
> > +                       l2cap_add_conf_opt(&ptr, (u8)type, sizeof(u8), type, endptr - ptr);
> >                         break;
> >                 }
> >         }
> > --
> > 2.25.1
> >
> > Hi,
> >
> > While running tests I encountered this one test that I could not pass. After some troubleshooting I landed in this patch. Please let me know what you think.
> >
> > Best regards
> > Jimmy
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
