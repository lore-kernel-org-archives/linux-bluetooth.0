Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF5EEB57B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Sep 2023 16:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjIJQcF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Sep 2023 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjIJQcE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Sep 2023 12:32:04 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E831B5
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Sep 2023 09:31:59 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RkFjd2d59z49Q6T;
        Sun, 10 Sep 2023 19:31:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1694363509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oE426kINNXwP//lJJIg15ibBbSzr86kVoxTG/z8ltOg=;
        b=UmlcZJTiDff9lyv6F8InfzbcqwSZi8urXbamjFbrfMZCq0q7nQ6lsLsO2BVQhu7XTf8hE7
        GimluofgbqMq4dfAlkohEHy041N2VILqqBdGqlwTDT4el5ZxnP/TralHxvnHs/4Qw7pO3p
        /qVz46o5yo/xqvV5oii/16vF9DRH5xHzDsODUauRZw/KVIeUwo7EZ6QqijBerCMIPIDfMB
        REY/pLWmIcsfUktFIJKWiPSNjfIAmfPFw7mM8XVuiRvCm2bH77U6vEY2mrMw8GHbII0nar
        /bGbMmQKvWflf9zx/ZmkpTYmYSU911Y6QODzEMmorKx+L9u2OgXUEF9ZrerBAw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1694363509; a=rsa-sha256;
        cv=none;
        b=c5rtDCI21xLD1kAMZsXoWFv5/k4cm8TvlEFp8v5nJ5BuOq2jausVlwIevxRdNBGC9L+dTm
        8JO8UlQtk+dht8lEj+0TM0dgfQuf96HF9okWr9G+YZAPEufVwg4zG6Dw/tcVEs0HSNkdL3
        Hpfr2YIAjke4y6STOWTIY42MSG6iGiTwQLnrDCFUQ6hG0JFUcPoW+mxalD1pOnZXPPWeTj
        pmowTFOzIfFpxZ6Z5JRKgknNGYjQv2KG0yFXZEZ93ZVHNx/XfUHEgN5nOF6cRh9jV0/5VA
        x4MNB4C4KdIOfZPyeSmaFNwrah2ro7vc8fsZxKDa+WsQAOLtltPjL3eTlJvQxA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1694363509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oE426kINNXwP//lJJIg15ibBbSzr86kVoxTG/z8ltOg=;
        b=nLm2Yv63Sjfu1OEo6vjzsNtYVnZvOo2E70Kd8MbDKZ88lpELCrsJvLwoHrJt1JXyMpQwP/
        YqPhUZE0fhn/J5PK9R/fAzPJvWYwyiBCjLbzXd4R9fvFaRi0LzqgZl+yVNRTm16W3nUdLH
        o85bvd0to+3zIl5myu340retzRkU26KoQt0SyMUGUTNtwJ36DuZuqPbpeImY/2DHLztjQA
        nVZ3g7JI+uTdbQNWGoaQWnPZgsnH+j51l8MVCXoD4iS6Mm8VaOCmSu2u3b5IJQ39KFMmd2
        U26FcWRx81PKGJDFI2DatFiccBwM3FdgeLeg12PG/RcWig6MgDV7YuS+Sf8giQ==
Message-ID: <0711a8538290d26724ca39b684cc064eb89ab185.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: detach io for source ASEs only
 after Stop Ready
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Sun, 10 Sep 2023 19:31:48 +0300
In-Reply-To: <CABBYNZ+7kcMqxMCH+VEJgk3x=37RU2Mchdxn3xFuU2uVp7nsqw@mail.gmail.com>
References: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
         <168858002504.7518.9584432839192702711.git-patchwork-notify@kernel.org>
         <CABBYNZ+7kcMqxMCH+VEJgk3x=37RU2Mchdxn3xFuU2uVp7nsqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

to, 2023-08-31 kello 14:04 -0700, Luiz Augusto von Dentz kirjoitti:
> On Wed, Jul 5, 2023 at 11:18=E2=80=AFAM <patchwork-bot+bluetooth@kernel.o=
rg> wrote:
> >=20
> > Hello:
> >=20
> > This series was applied to bluetooth/bluez.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >=20
> > On Sun,  2 Jul 2023 21:43:04 +0300 you wrote:
> > > The Client may terminate a CIS when sink is in QOS and source in
> > > Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it wh=
en
> > > Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.=
1).
> > >=20
> > > It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiv=
er
> > > Stop Ready command if CIS is already disconnected, and then gets stuc=
k
> > > in disabling state. It works if CIS is disconnected after Receiver St=
op
> > > Ready.
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> >   - [BlueZ,v2,1/2] shared/bap: detach io for source ASEs only after Sto=
p Ready
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7b10e72de6=
f4
> >   - [BlueZ,v2,2/2] bap: wait for CIG to become configurable before recr=
eating CIS
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D8c3170190d=
6f
> >=20
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>=20
> Looks like this one introduces a problem when using the emulator:
>=20
> https://gist.github.com/Vudentz/5c7ef940fc97b054227559dcd47b99f7?permalin=
k_comment_id=3D4677775#gistcomment-4677775
>=20
> If I try to release then acquire then it won't trigger recreate logic,
> I suspect this is due to bap_io_disconnected being called ahead of
> states changes.

Sorry for the delay. Was this fixed by d06b912df5ab ("bap: Fix not
always calling bap_io_close on disconnect")? If not, I'll try to
reproduce.

--=20
Pauli Virtanen
