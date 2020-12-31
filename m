Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA5C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Dec 2020 10:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529BA207A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Dec 2020 10:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgLaKKO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:10:14 -0500
Received: from fgw22-4.mail.saunalahti.fi ([62.142.5.109]:10230 "EHLO
        fgw22-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgLaKKO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Dec 2020 05:10:14 -0500
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 46793271-4b50-11eb-88cb-005056bdf889;
        Thu, 31 Dec 2020 12:09:32 +0200 (EET)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 93DB536C0F6; Thu, 31 Dec 2020 12:09:31 +0200 (EET)
Date:   Thu, 31 Dec 2020 12:09:31 +0200
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201231100930.GK20371@reaktio.net>
References: <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
 <20201222092100.ru5inf45v55qoa4m@pali>
 <BC13598F-C074-4CB3-B24E-10A6E0CF84DB@holtmann.org>
 <20201222101930.awcxtsgltrrde2d3@pali>
 <F698F31D-063A-4A9E-B2BD-D61FA937F561@holtmann.org>
 <20201222114628.pq3lmrvzepel3dj4@pali>
 <FEEDD760-B78B-44F5-9561-A0CFF08AF515@holtmann.org>
 <20201222131749.vhatruzz3ztnw6k5@pali>
 <D4997390-D306-420E-9A4F-6A241EAB0A1E@holtmann.org>
 <20201222211311.2evpy325l6453x5m@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201222211311.2evpy325l6453x5m@pali>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Dec 22, 2020 at 10:13:11PM +0100, Pali Rohár wrote:
> On Tuesday 22 December 2020 22:11:40 Marcel Holtmann wrote:
> > > But at least, please do not blok usage of AuriStream codec by Linux
> > > kernel. People are complaining about bad quality, AuriStream can improve
> > > it, but this decision just say "we do not want improvement".
> > > 
> > > I was open for any discussion how to bring it, but for one year I have
> > > received any positive reaction how to achieve it. I designed API which
> > > would allow it but there was no discussion about it, how to either
> > > improve it or something else.
> > 
> > We can design something to allow tuning transparent setup
> 
> Great! Can we finally move in this direction please?
>

So, Marcel, is this something you're working on, or going to propose?

Or should Pali (or others) propose something for tuning the transparent setup?


Thanks,

-- Pasi

