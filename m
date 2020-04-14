Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D780C2BB85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E4C2076A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586851806;
	bh=dt68ti/mVDbz1tH/iR0hYlp4aKyOUWSD802xP0RbfFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ebFyrW7LRcgeP4eBsCvmNyKcZx4+UmlY+YlFzz038egAz96POfQvxVWwRa8UE20l0
	 fwrl7A/fHVFPTvZcPJQjOzynlBwIprM2HnwWSryP7zkEIJD2DO5zwoh17J6w16Wm0h
	 0BGClDP/diN7J/aVncer1C7/JWF8MYeWULhfOlqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407019AbgDNIKD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407009AbgDNIJr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 04:09:47 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B447B2074D;
        Tue, 14 Apr 2020 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586851786;
        bh=dt68ti/mVDbz1tH/iR0hYlp4aKyOUWSD802xP0RbfFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtYQWEaA6b4lj4isotkCIFkoBId/1XaOXryqhhvRfRCmpQUl+Ff87Gm3Y5AHX24x1
         dWHkcFA3VybMZ0hLMzAYUCiu0O+4ZJ6dSZF/eLmSc8V8cJUK9NvOlvz1g/4plSZCHN
         UBG+IyJ/mf7JpJsQrQvTTZmeK1KP4Q/+1dNv3uVk=
Received: by pali.im (Postfix)
        id 521A1770; Tue, 14 Apr 2020 10:09:44 +0200 (CEST)
Date:   Tue, 14 Apr 2020 10:09:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 0/3] bluez: Export SDP "Remote audio volume control" item
 for HSP profile
Message-ID: <20200414080944.gkh4vfgfh3ruts4q@pali>
References: <20200321195404.fvyku5hmcuqxt7sg@pali>
 <20200413162513.2221-1-pali@kernel.org>
 <CABBYNZLvuDMoFhFSFq50hnjG24DatsHDHNiN2axeC75fSmDRsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLvuDMoFhFSFq50hnjG24DatsHDHNiN2axeC75fSmDRsw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 13 April 2020 17:09:42 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Mon, Apr 13, 2020 at 9:25 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > This patch series fixes handling of zero value in feature list and
> > provides Remote audio volume control support for HSP profile in both HS
> > and AG roles.
> >
> > Luiz, you wrote that you do not have time to work on this, so I
> > implemented it myself in this patch series. Could you please find time
> > at least for reviewing and merging these patches? Thanks.
> >
> > Pali Rohár (3):
> >   src/profile: Distinguish between zero-set HFP AG features and unset
> >     HFP AG features
> >   src/profile: Export Remote Audio Volume Control SDP value for HSP HS
> >     role via first bit in features value
> >   src/profile: Add default SDP record for Headset role of HSP 1.2
> >     profile with Erratum 3507
> >
> >  src/profile.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 104 insertions(+), 8 deletions(-)
> >
> > --
> > 2.20.1
> 
> Ive make some changes to remove the need to a flag to detect when the
> features should be added or not, it is now applied, thanks.

Ok, thank you!

In commit you did one mistake:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=040bd56a948f4d1ecd6987cdf0ba51779dc0c02a

+		/* HSP AG role does not provide any features */
+		return 0;

It should return -ENODATA as AG role does not provide any features, so
has_features needs to be set to false.
