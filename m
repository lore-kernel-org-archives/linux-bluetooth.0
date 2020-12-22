Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D222AAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgLVVNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgLVVNz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 16:13:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ADFC21973;
        Tue, 22 Dec 2020 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608671594;
        bh=Gsy2qHO8Bn/jgDy2rTjzQY1eUYpnjbPO0EP3EWDzCmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FA7eqX3gT8fo/AkQfmXwftb5grjVt4O6ot0CzqUcU6+8Y1HIl382k6PPqimyWbOrD
         CjR4Bd4DlEwnQO9/GL3k7HApTPYWDEfwG4MJ9vN2UDfDgJWoK03ff8y9nRl+idsV8C
         p2TLFSZ+OpUxh8aL8VxRWGj2KClgTaBk8DSNh/pyign7oHDsEtHw1WRGgbchG8Gzp7
         UroFVMGY/k63GPbEyaLH2OiXnJijf1Bw7Bm2dgfFCMhL/ZLI5pVm5TiQSQJufP5VLx
         XReyGE/BLfEjgyBmiAI7a1dAI6NSyLQWL+BTw+4Oh7K1awWUk7xPNOT0NuRqHvuaXc
         aD/GnKoL7IRjQ==
Received: by pali.im (Postfix)
        id EDE24848; Tue, 22 Dec 2020 22:13:11 +0100 (CET)
Date:   Tue, 22 Dec 2020 22:13:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201222211311.2evpy325l6453x5m@pali>
References: <20201221211437.4s27cl6t4v27sugh@pali>
 <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
 <20201222092100.ru5inf45v55qoa4m@pali>
 <BC13598F-C074-4CB3-B24E-10A6E0CF84DB@holtmann.org>
 <20201222101930.awcxtsgltrrde2d3@pali>
 <F698F31D-063A-4A9E-B2BD-D61FA937F561@holtmann.org>
 <20201222114628.pq3lmrvzepel3dj4@pali>
 <FEEDD760-B78B-44F5-9561-A0CFF08AF515@holtmann.org>
 <20201222131749.vhatruzz3ztnw6k5@pali>
 <D4997390-D306-420E-9A4F-6A241EAB0A1E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4997390-D306-420E-9A4F-6A241EAB0A1E@holtmann.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 22 December 2020 22:11:40 Marcel Holtmann wrote:
> > But at least, please do not blok usage of AuriStream codec by Linux
> > kernel. People are complaining about bad quality, AuriStream can improve
> > it, but this decision just say "we do not want improvement".
> > 
> > I was open for any discussion how to bring it, but for one year I have
> > received any positive reaction how to achieve it. I designed API which
> > would allow it but there was no discussion about it, how to either
> > improve it or something else.
> 
> We can design something to allow tuning transparent setup

Great! Can we finally move in this direction please?
