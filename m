Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A1C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC820735
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586798247;
	bh=4Wd97hf+wQn5i3jvKsO0ejVzvaIB/ndD0Adx+D5bqYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxJLHvtHYCK6jPpDQWreLhoBYV95jDBtRVFiJnaHme2gRo0hy+RIAEFjd9MZaB6K6
	 gu+u+tpRmrEY+mj6C3gWpMriGOB+QZaqbbGCmFMYZQWGZoQNdOpK+WJvFhKWjMsESa
	 Tem3DAFZTT8mgrBVEWxdPNJHW+kDjDLWFxhnLmcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbgDMRR0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732592AbgDMRRZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 13:17:25 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0998B2072D;
        Mon, 13 Apr 2020 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586798245;
        bh=4Wd97hf+wQn5i3jvKsO0ejVzvaIB/ndD0Adx+D5bqYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgfglWQn5wPjZsBlxtisU5A1cIfiMJof4BWeQBB6COQs8u3fWH6RhO6lGje2R1apy
         y8PDUfp0ocSN3NTiwPuKskQC+m1Keb7NUkV45f+1ja1/qrVd/oVDUid62Ilyrt5mK9
         Dpg8U1EA/i6x9KjgafB7CGhLHgQmvn5xCHU7/8h0=
Received: by pali.im (Postfix)
        id 0BB88895; Mon, 13 Apr 2020 19:17:22 +0200 (CEST)
Date:   Mon, 13 Apr 2020 19:17:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 1/3] src/profile: Distinguish between zero-set HFP AG
 features and unset HFP AG features
Message-ID: <20200413171722.ilawhisu67onrifn@pali>
References: <20200321195404.fvyku5hmcuqxt7sg@pali>
 <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-2-pali@kernel.org>
 <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
 <20200413165206.xluhkwi76cfpiv7z@pali>
 <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 13 April 2020 09:58:34 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Mon, Apr 13, 2020 at 9:52 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Monday 13 April 2020 09:44:14 Luiz Augusto von Dentz wrote:
> > > On Mon, Apr 13, 2020 at 9:25 AM Pali Rohár <pali@kernel.org> wrote:
> > > > @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(struct btd_service *service)
> > > >  static char *get_hfp_hf_record(struct ext_profile *ext, struct ext_io *l2cap,
> > > >                                                         struct ext_io *rfcomm)
> > > >  {
> > > > +       /* HFP 1.7.2: By default features bitfield is 0b000000 */
> > > >         return g_strdup_printf(HFP_HF_RECORD, rfcomm->chan, ext->version,
> > > > -                                               ext->name, ext->features);
> > > > +                               ext->name,
> > > > +                               ext->have_features ? ext->features : 0x0);
> > > >  }
> > > >
> > > >  static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
> > > >                                                         struct ext_io *rfcomm)
> > > >  {
> > > > +       /* HFP 1.7.2: By default features bitfield is 0b001001 */
> > > >         return g_strdup_printf(HFP_AG_RECORD, rfcomm->chan, ext->version,
> > > > -                                               ext->name, ext->features);
> > > > +                               ext->name,
> > > > +                               ext->have_features ? ext->features : 0x9);
> > >
> > > I wonder why you didn't just initialize the features wiht 0x9 instead
> > > of adding a flag to track it, btw add a define with value 0x09 like
> > > HFP_DEFAULT_FEATURES that way it is clearer why we are doing this.
> >
> > This function get_hfp_ag_record() is for parsing local features. You are
> > right that for local features we do not need a flag to track it.
> >
> > But flag for tracking is needed for parsing remote features. And to have
> > unified code for storing local and remote features it is easier to have
> > always a flag for checking if features were provided or not.
> 
> Im not following you about the remote features beinf different, I
> though both would be could be initialized in the same way and then if
> we read a different value from the SDP record we just overwrite it.

But in this case we put these default remote features to HFP DBus agent
like if they were specified in SDP. Default value is specific for
profile version. And if e.g. new HFP version defines a new bit in
features with its own default value then HFP DBus agent would not be
able to distinguish between state when remote device did not specified
any value (as bluez will put there some defaults) and when remote device
specified same features as bluez has defined in its current default
value.

Before and also after this change remote features are not send to HFP
DBus agent when they were not specified by remote device.

After your suggestion HFP DBus agent would not be able to check if
remote device provided features or not. And this is I think a
regression.

> > I can put these default values in profile-role specific macros e.g.:
> >
> > #define HFP_AG_DEFAULT_FEATURES 0x09
> > #define HFP_HF_DEFAULT_FEATURES 0x00
> > #define HSP_HS_DEFAULT_VOLCNTRL "false"
> 
> Don't bother with default that are 0x00/false, we can assume this is
> implicit when allocating the memory everything is set to 0 so these
> defines wouldn't be needed in the first place.
> 
> > Or do you prefer different names?
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
