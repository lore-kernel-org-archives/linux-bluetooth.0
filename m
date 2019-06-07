Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E32C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76DE206BB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8u8FPH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfFGNCt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:02:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38297 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfFGNCt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 09:02:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so1850288wmh.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/04xWF8uiBqbOq46vhdyqQb0PJjtwc4p0UIug2KYxx0=;
        b=T8u8FPH1xg+ABu8VDgHBZ3Nqrt/7Fgnr07I/bl1MtmxjVj6nEBK6bnV+mlDkTOglBZ
         Y5htUi2lSWlkx+6F/YS0dELfSXljsNCI/OCVnO21+hJ6wqvJmdM5L5HYQZVkz0kWEFkA
         M/rSK6QTaqlMVV4ctrFsp8M7+73dbNtStZFkuciYwDhIXOWtmrilop4febFmZe7IALyH
         yJjfyxrrXDETWzP7bjrsnANNxLbwT4h6fTIw5OljM8zYfXOBgqisAEb/Nl0PeE+2udhY
         4jJqs2CiQBIZzbYKiayt/HjTMP/XKBlb22OY1BQuk7hh15b+3/YDbR+M1pdUoC2snmYH
         EsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/04xWF8uiBqbOq46vhdyqQb0PJjtwc4p0UIug2KYxx0=;
        b=Qgj7/5UqDdTMH765u+KSvU17DAKnKOB/OdgsK6rQfpXhqZNwD486iQlC2HPt4qi+Nv
         QjeSsmc9bSkbzi95i5f5pdMhXZ7c6JA4vViDZwt8CsZDCHW9KyTRmebDzV2niWCslgIZ
         csVpZNVrHRnX0IkDwnqDagQrF7KlkT4eejnHDYNnNvQY9TtflzDsDJ8T2iEvuATjspIA
         1V7XuDeeSJmVktODijXFbXUx/vU9hBlPEwylxpdo/kwJ1JA68aStoBkZjW59SEeX2BGi
         gHQ1Ownlv0Z1353xD/zq3VbhTY7ey7BFazzMVAqy4tmvfvnurr7Z3wn6r9hLXCAcDKYY
         63fg==
X-Gm-Message-State: APjAAAWiN9+uKakL6XwrElATVeUg5LV+flqIurli8WZDodRkAIBH9L60
        V/fhFpwZjcQbYvEfNVwPJp4=
X-Google-Smtp-Source: APXvYqwjbnrDrAav7kKMcj/L2xCh0sX204RUUz9jg6WnBmc6JIPt1oQsMLMUlqgWr3D4JIb/qDnu0g==
X-Received: by 2002:a1c:1d83:: with SMTP id d125mr3580029wmd.63.1559912566854;
        Fri, 07 Jun 2019 06:02:46 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i12sm1268203wrs.43.2019.06.07.06.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:02:45 -0700 (PDT)
Date:   Fri, 7 Jun 2019 15:02:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20190607130245.mv4ch6dxnuptzdki@pali>
References: <20190504171550.llqfv5674gxd3bnn@pali>
 <20190506151651.pu2us2fgsf7w2vos@pali>
 <20190516183429.ql3hxtnmiabcq7tj@pali>
 <CABBYNZLJB0bK7o=Tvf9mhb5U41xAin6SdPY9=76AuEvpEiA_8g@mail.gmail.com>
 <20190519082305.q7y4gpmdhvx3vzvo@pali>
 <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190519212157.GB31403@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 19 May 2019 23:21:58 Pavel Machek wrote:
> Hi!
> 
> > > > to be honest, I would rather see WBS implementation finally
> > > > reach PA before we start digging into this.
> > >
> > > First I want to finish improving A2DP codec support in pulseaudio. Later
> > > I can look at HSP/HFP profiles. Ideally it should have modular/plugin
> > > extensible design. So the aim is that adding new codec would be very
> > > simple, without need to hack something related to mSBC/WBC, AuriStream
> > > or any other codec.
> > 
> > Well HSP don't have support for codec negotiation, but yes a modular
> > design is probably recommended.
> > 
> > > But for AuriStream I need to set custom SCO parameters as described
> > > below and currently kernel does not support it. This is why I'm asking
> > > how kernel can export for userspace configuration of SCO parameters...
> > 
> > We can always come up with socket options but we got to see the value
> > it would bring since AuriStream don't look that popular among
> > headsets, at least Ive never seem any device advertising it like
> > apt-X, etc.
> 
> Pali clearly has such device and he is willing to work on it. Surely
> that means it is popular enough to be supported...?

Just put AT+CSRSF=0,0,0,0,0,7 to google search and you would see that
not only I have such device...

So I would really would like to see that kernel finally stops blocking
usage of this AuriStream codec.

-- 
Pali Rohár
pali.rohar@gmail.com
