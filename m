Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCFBC001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjHOSbB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbjHOSah (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 14:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BD1FCC
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 11:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D3FD621E1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 18:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD4C433C8;
        Tue, 15 Aug 2023 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692124234;
        bh=t7b2VbdNw/i6NoJ0PKaswwPONEbGDaYAFFU00ewCL0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rCj/2Y6gQzuQUEm4p24rQ8YcdhP7meWTQAd/cdATZRP8uqNPHguPTtQ4sXDLgeaR+
         ikmwQ7QHnQZSmEyPO6xmuBW3dW1gFsIgC3rXOToZLxYzDjSm2FVz6ZhekuI8wRYu4U
         TJpO2KAddd0LGGkFsxbv831BvQpjnUEsEpxuBUtiiJQImJ1Td0joNEv9Pi36dcc2ch
         6+Nr4msXMaSEzw0GHRJkfEZEAC0tYSFJBohrJnxFfcReiQPKcsc2ss5MNjDnFbdOZ5
         456wXDmRXlmODqc86KzNevco7J+Mpe2tm1/hXi6ImyivorOgDnxu6yFZjPAj0S2HtP
         s/mL5iRIiz5FQ==
Date:   Tue, 15 Aug 2023 11:30:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-08-11
Message-ID: <20230815113033.7cdf64ff@kernel.org>
In-Reply-To: <CABBYNZ+mnQ2gKOoezeKfM=CF4ANVGtjM0Zb4a-tnZKYvrw_F5A@mail.gmail.com>
References: <20230811192256.1988031-1-luiz.dentz@gmail.com>
        <20230814164546.71dbc695@kernel.org>
        <CABBYNZJmkOpPgF6oox-JAyGAZRxzX7Kn9JQpLPXi_FR=Cf-FOA@mail.gmail.com>
        <20230815111554.7ff6205e@kernel.org>
        <CABBYNZ+mnQ2gKOoezeKfM=CF4ANVGtjM0Zb4a-tnZKYvrw_F5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 15 Aug 2023 11:18:07 -0700 Luiz Augusto von Dentz wrote:
> On Tue, Aug 15, 2023 at 11:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > On Tue, 15 Aug 2023 10:59:35 -0700 Luiz Augusto von Dentz wrote: =20
> > > Ok, since it has been applied what shall we do? =20
> >
> > Not much we can do now. Make sure you run:
> >
> > https://github.com/kuba-moo/nipa/blob/master/tests/patch/verify_signedo=
ff/verify_signedoff.sh
> >
> > on the next PR. =20
>=20
> Will try to incorporate this into our CI checks, btw any reason why
> this is not done by the likes of checkpatch?

No reason I can think of. The people who usually run this check will
not want to switch to checkpatch because of its high false-positive
rate. So I'm guessing nobody had the motivation to send a patch.
