Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68528C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7812089E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8F0AUe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFGPTr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:19:47 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:35312 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfFGPTr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 11:19:47 -0400
Received: by mail-oi1-f172.google.com with SMTP id y6so1705329oix.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1tg/BnA7l4Mv0d8lztmSv9zS9svBmRA93p6cON7qybY=;
        b=n8F0AUe6AntdtuatpVmKCkAEDCemrAetMVc3R4gRNo+pwiiNZ0Gnufq23OlwwtGnxY
         vR071tAFAN/y1re5h49SoILpcGMzv47gu2ByIzXXV31diZV+7wKTxz1+kSc7FaY+aXK+
         RDqyY40aSgU6HQKEKsENSljoPPcSj/v0VVDttVh2D7tEu8aqauf1SjT/nNxuN/YNbEZz
         scrjysPXbo+re3ElZogrErT9wcukqAtnXpCDMBdsDgIgPUZkuaK4/1FApa5mGQcogodv
         bUA81Jph5E8w1I6/WZ8oDc6rRik/yeJ4uqcaAV4xI6t/MbBUZR/QTi5gmY1V20EobAyk
         ynCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1tg/BnA7l4Mv0d8lztmSv9zS9svBmRA93p6cON7qybY=;
        b=nh1ihrMYmulUi+/HdSrCF7Xv7uGNqsOFPzlfq8r7Exa0D+avlJVcUSav0yP1U36Y8B
         LPBhKZ+dSVm0UOlmz/a4JoLve6mvh3IbFmlVUpFbqbghjeNiO4noW0ZoCImqSWA3Bvni
         VEKgpdL9KEzpExGZNl61rAj3IubtydkbSSq5Zk/S+V0S0LbUC9HrV3vb00ONHb6RJefU
         bBVyKrb2Ed0QeJ/EaAYrhNlwgg9J+LN2UsYYOuHypsP7YxI99doFHh67B6EshoNgutnz
         eIsiaGScgYhHTYJ2Ez65qO178CdaHCFJyCsabjcr2twKgVMabqO+sJdsNofp2MobrXiA
         phDg==
X-Gm-Message-State: APjAAAXxCNPxVDyzquOPQYox3VPf5/PlyBDRRhG5pWMC8msylZjPIUuE
        f6PlD9KqgHBy4MWv7Q3VfyEc24OH6X88RVncZEM=
X-Google-Smtp-Source: APXvYqw2+XwKnxJRONaO1bwS0TtbtLPy8S+Bzdxgx+p0Rw8VYXidKCeP0kqGxMEs5VWAOtEbUYIXvkb7ka03Hl+nw3E=
X-Received: by 2002:aca:62c2:: with SMTP id w185mr4289129oib.110.1559920786749;
 Fri, 07 Jun 2019 08:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190504171550.llqfv5674gxd3bnn@pali> <20190506151651.pu2us2fgsf7w2vos@pali>
 <20190516183429.ql3hxtnmiabcq7tj@pali> <CABBYNZLJB0bK7o=Tvf9mhb5U41xAin6SdPY9=76AuEvpEiA_8g@mail.gmail.com>
 <20190519082305.q7y4gpmdhvx3vzvo@pali> <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd> <20190607130245.mv4ch6dxnuptzdki@pali>
In-Reply-To: <20190607130245.mv4ch6dxnuptzdki@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jun 2019 18:19:37 +0300
Message-ID: <CABBYNZKXGX7r-kfdxXocv8oDh2tofWgnTe_LpxcR4WiCsen0rw@mail.gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Jun 7, 2019 at 4:02 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Sunday 19 May 2019 23:21:58 Pavel Machek wrote:
> > Hi!
> >
> > > > > to be honest, I would rather see WBS implementation finally
> > > > > reach PA before we start digging into this.
> > > >
> > > > First I want to finish improving A2DP codec support in pulseaudio. =
Later
> > > > I can look at HSP/HFP profiles. Ideally it should have modular/plug=
in
> > > > extensible design. So the aim is that adding new codec would be ver=
y
> > > > simple, without need to hack something related to mSBC/WBC, AuriStr=
eam
> > > > or any other codec.
> > >
> > > Well HSP don't have support for codec negotiation, but yes a modular
> > > design is probably recommended.
> > >
> > > > But for AuriStream I need to set custom SCO parameters as described
> > > > below and currently kernel does not support it. This is why I'm ask=
ing
> > > > how kernel can export for userspace configuration of SCO parameters=
...
> > >
> > > We can always come up with socket options but we got to see the value
> > > it would bring since AuriStream don't look that popular among
> > > headsets, at least Ive never seem any device advertising it like
> > > apt-X, etc.
> >
> > Pali clearly has such device and he is willing to work on it. Surely
> > that means it is popular enough to be supported...?
>
> Just put AT+CSRSF=3D0,0,0,0,0,7 to google search and you would see that
> not only I have such device...
>
> So I would really would like to see that kernel finally stops blocking
> usage of this AuriStream codec.

Well I guess it is up to you to make the changes then.


--=20
Luiz Augusto von Dentz
