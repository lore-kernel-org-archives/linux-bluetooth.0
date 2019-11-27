Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA887C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF35220665
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 16:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqfmzx7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK0QHY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:07:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44219 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfK0QHY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 11:07:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so27278828wrn.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IW1sqGfC6vXMelL4BLqghDYpqEmp8oxzICtmPpFpi2k=;
        b=Dqfmzx7/Mmp3ZbiLa19s4HN08CdPq1tOYeXooUUmG7IvOxWotQQCIzedgndjTPLGpv
         VbV5iqEFcxi947yM1N09vtTNYIKgg4NG0gvvY7LeLH+EzDKjXlbBcgHNzGbGe84Iv6aL
         SbAauPnUNFLas3XC8ZIqulFvRBDmRfCx+EWUT6L1WyDT4nuIbO/1Xs5NHPxseXUwcv25
         1RbWa3Fz/WqZsEDKUafu8Jyny6uUOxFEJbforgK/IFLuhn5BaqwtkGYm6qOmxgoEPTPH
         O64VkyAbA2dru/DkOKKpL5HjBdRjUgNAFCfCuLuJYc6RtntrBvhRFfI9gNcc3pVXscde
         rDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IW1sqGfC6vXMelL4BLqghDYpqEmp8oxzICtmPpFpi2k=;
        b=gJbtmSZvMD3LHYlL2UOwF9oYrc+3zlBNegX5LyavNiS3vPL4nvHcZ0ZwoSrsr+XrW8
         Ka7AXGrdH4Wl0BGdxivVa466mFaLrhiJ3pmMaKWwTfTs8aN/xnEkVP7NMx4LhxMWae1c
         /ArbLuTqMEFGoE6jnjWE/y227qXGGzCFknY3ILiVSDtf9Yk9Qo3ktQpdIIy0E2hadZrt
         iIRrzIHz7q7H39aCR70MMomDC6/tjL+w2sy3JZKW+teKHR7FUNNeGHOGqU6edC5BRilW
         JbnnpM/kzBzVTE1xfDoOzJFHCl45d8vA5/+8bHf91G63eOSxLzsw4EHp9SRgMPME1o2I
         /nAg==
X-Gm-Message-State: APjAAAVFgXBUNmni1uad9OpQGhdXUVu7xvV3lXdUwOLT8bF0n6kJGodM
        wk2Y67Je6oYOlhllDlJItx092UBD
X-Google-Smtp-Source: APXvYqx4wAdATBDviWoVNgYfF7jjROm1j829+OxtF0hi71l7M1kv7Z5hKtWl5okQZ2Gnz6T6OtACjw==
X-Received: by 2002:adf:f850:: with SMTP id d16mr34666737wrq.161.1574870841971;
        Wed, 27 Nov 2019 08:07:21 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s19sm2940466wmc.4.2019.11.27.08.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 08:07:21 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:07:20 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avctp: Set more descriptive name for uinput device
Message-ID: <20191127160720.aleatv6l4swopg57@pali>
References: <20191126212753.18455-1-pali.rohar@gmail.com>
 <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi!

On Wednesday 27 November 2019 17:50:40 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Tue, Nov 26, 2019 at 11:31 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > ---
> >  profiles/audio/avctp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> > index 70a3e40b2..ae53587ad 100644
> > --- a/profiles/audio/avctp.c
> > +++ b/profiles/audio/avctp.c
> > @@ -1181,8 +1181,7 @@ static int uinput_create(char *name)
> >         }
> >
> >         memset(&dev, 0, sizeof(dev));
> > -       if (name)
> > -               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
> > +       snprintf(dev.name, sizeof(dev.name), "Bluetooth Audio/Video Remote Control%s%s", name ? " " : "", name ? name : "");
> >
> >         dev.id.bustype = BUS_BLUETOOTH;
> >         dev.id.vendor  = 0x0000;
> > --
> > 2.11.0
> 
> It is already setting a bustype to BUS_BLUETOOTH why do you need to
> make it more specific,

Because more tools shows only device name. Also in kernel dmesg is only
device name. And MAC address is really something which does not say
anything about device...

For this reason also older input devices (implemented in kernel) exports
more descriptive names, e.g. "AT Translated Set 2 keyboard" or "ETPS/2
Elantech TrackPoint" or "Integrated IR Camera".

> btw it needs to be limited to UINPUT_MAX_NAME_SIZE.

Is not this implicitly defined by sizeof()?

> Id say if we want to make it declare the connection type

Yes, connection type would be really useful.

Now I'm playing with exporting "button press even" from HSP profile via
uinput device too and therefore connection type should be there.

> that probably something that needs to be encoded in
> the bus itself, like BUS_BLUETOOTH_AVCTP, BUS_BLUETOOTH_HOG, etc.

But bus type is kernel API and there is no such AVCTP or HOG. So we need
to stick with BUS_BLUETOOH.

Other kernel devices also put protocol information into name (e.g.
touchpad / trackpoints), so it is ideal place also for bluetooth
devices.

And probably most userspace devices are mapped to BUS_VIRTUAL. There
are no subtypes.

-- 
Pali Rohár
pali.rohar@gmail.com
