Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6428CC2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 19:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDF8206E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586807489;
	bh=H+4LftfYHBNQRzxOf5D9/bwY0OHFUV7Yb4YXCIOXdi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ICppv46X95oMkjDYwPJ0Mwf2Xa3b59oajUHNVKk/AFB1GXwQdIGVBYeq/bN6HXKPZ
	 /kX0W8S7WSFAdqzrS+m5fD+u8a9asDx9+HyzD7rKHRU3Z3Pr67KMkR0jZbk1qDiN2o
	 g/F5+YI6IBseZ/Qc4gSBohaADhaaNo7AumAYPxXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbgDMTv2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388140AbgDMTv2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 15:51:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0843206DA;
        Mon, 13 Apr 2020 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586807487;
        bh=H+4LftfYHBNQRzxOf5D9/bwY0OHFUV7Yb4YXCIOXdi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKE6tNAsjzEdUd7Vb7LNFhynqkgL9T+VYTJ3AWxFjM5jM62tu+vO3NmLCagCs09AA
         ogwyFu+4d5oG543mBV2A0RhHjoobPZtoWu5PrrEmQ5Pmzq2h3vD1ccEcgKmSYuuhEe
         8nvQ77yYapCVwSKeQvkeej5UkT+sNeJA3m0be8kE=
Received: by pali.im (Postfix)
        id 9678A895; Mon, 13 Apr 2020 21:51:24 +0200 (CEST)
Date:   Mon, 13 Apr 2020 21:51:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 1/3] src/profile: Distinguish between zero-set HFP AG
 features and unset HFP AG features
Message-ID: <20200413195034.2inyau3gkdxjoscu@pali>
References: <20200321195404.fvyku5hmcuqxt7sg@pali>
 <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-2-pali@kernel.org>
 <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
 <20200413165206.xluhkwi76cfpiv7z@pali>
 <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
 <20200413171722.ilawhisu67onrifn@pali>
 <CABBYNZKFGjsnCnBPyw0WFr_aJ2zaYAjLj81t04S=fXaXD9ac+g@mail.gmail.com>
 <20200413175833.di53ucocat5tdrke@pali>
 <CABBYNZL4hr34svvF1Qdz5YA3fWwTex4cyX0PumVL_ARErKBo3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZL4hr34svvF1Qdz5YA3fWwTex4cyX0PumVL_ARErKBo3w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 13 April 2020 12:41:44 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Mon, Apr 13, 2020 at 10:58 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Monday 13 April 2020 10:47:04 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Mon, Apr 13, 2020 at 10:17 AM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Monday 13 April 2020 09:58:34 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Mon, Apr 13, 2020 at 9:52 AM Pali Rohár <pali@kernel.org> wrote:
> > > > > >
> > > > > > On Monday 13 April 2020 09:44:14 Luiz Augusto von Dentz wrote:
> > > > > > > On Mon, Apr 13, 2020 at 9:25 AM Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(struct btd_service *service)
> > > > > > > >  static char *get_hfp_hf_record(struct ext_profile *ext, struct ext_io *l2cap,
> > > > > > > >                                                         struct ext_io *rfcomm)
> > > > > > > >  {
> > > > > > > > +       /* HFP 1.7.2: By default features bitfield is 0b000000 */
> > > > > > > >         return g_strdup_printf(HFP_HF_RECORD, rfcomm->chan, ext->version,
> > > > > > > > -                                               ext->name, ext->features);
> > > > > > > > +                               ext->name,
> > > > > > > > +                               ext->have_features ? ext->features : 0x0);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
> > > > > > > >                                                         struct ext_io *rfcomm)
> > > > > > > >  {
> > > > > > > > +       /* HFP 1.7.2: By default features bitfield is 0b001001 */
> > > > > > > >         return g_strdup_printf(HFP_AG_RECORD, rfcomm->chan, ext->version,
> > > > > > > > -                                               ext->name, ext->features);
> > > > > > > > +                               ext->name,
> > > > > > > > +                               ext->have_features ? ext->features : 0x9);
> > > > > > >
> > > > > > > I wonder why you didn't just initialize the features wiht 0x9 instead
> > > > > > > of adding a flag to track it, btw add a define with value 0x09 like
> > > > > > > HFP_DEFAULT_FEATURES that way it is clearer why we are doing this.
> > > > > >
> > > > > > This function get_hfp_ag_record() is for parsing local features. You are
> > > > > > right that for local features we do not need a flag to track it.
> > > > > >
> > > > > > But flag for tracking is needed for parsing remote features. And to have
> > > > > > unified code for storing local and remote features it is easier to have
> > > > > > always a flag for checking if features were provided or not.
> > > > >
> > > > > Im not following you about the remote features beinf different, I
> > > > > though both would be could be initialized in the same way and then if
> > > > > we read a different value from the SDP record we just overwrite it.
> > > >
> > > > But in this case we put these default remote features to HFP DBus agent
> > > > like if they were specified in SDP. Default value is specific for
> > > > profile version. And if e.g. new HFP version defines a new bit in
> > > > features with its own default value then HFP DBus agent would not be
> > > > able to distinguish between state when remote device did not specified
> > > > any value (as bluez will put there some defaults) and when remote device
> > > > specified same features as bluez has defined in its current default
> > > > value.
> > >
> > > Different version may have different defaults but we can initialize
> > > them correctly.
> >
> > But we do not know default values for future versions which have not
> > been released yet. There would be a problem if user run current
> > bluez daemon e.g. in 5 years when new version of HFP profile would be
> > released and remote device would use it.
> 
> We would have to match what is the features that the agent can handle.

But we do not know what features can agent handle. There is no API for
it.

Agent which works in AG role accept connections from remote HF role.
Agent register to bluez with AG role features. HF and AG features are
different and bluez has absolutely no idea what features can agent
accept from remote device.

> > > > Before and also after this change remote features are not send to HFP
> > > > DBus agent when they were not specified by remote device.
> > > >
> > > > After your suggestion HFP DBus agent would not be able to check if
> > > > remote device provided features or not. And this is I think a
> > > > regression.
> > >
> > > I don't think we can consider a regression to always provide features,
> > > besides what would be the reason for the agent to know if the features
> > > were from the SDP record or they are auto initiliazed?
> >
> > Autoinitialized for which version? Bluez has currently defined default
> > values for HFP 1.7. But DBus agent can register HFP profile also for
> > version 1.5 or also 1.8.
> >
> > To which value should it be autoinitialized when remote device announce
> > that is in version 1.8 but does not specify features (= default for
> > version 1.8 should be used)? The only option which make sense is to not
> > autoinitiaze this value as version 1.8 was not released yet and now we
> > do not know what would be the default value.
> 
> We should probably use the mininum version of the client and server,
> so if the device supports 1.8 but our agent is 1.5 it should default
> to 1.5, this actually would have to be done anyway because othewise we
> would make agents duplicating the logic of handling the features
> properly so we might as well try to consolidate this on the daemon and
> only expose the features that can actually be used in the session,
> that means the autoinitilize logic the to take into account both the
> device and agent version.

And what would happen if both agent and remote device supports 1.8?

When remote device do specified features, default one should be used.
So this cannot be solved with some default values in bluez.

> > > I that was
> > > really necessary Id just dump the whole record as a ServiceRecord
> > > option and leave it up to the client to parse it.
> > >
> > > > > > I can put these default values in profile-role specific macros e.g.:
> > > > > >
> > > > > > #define HFP_AG_DEFAULT_FEATURES 0x09
> > > > > > #define HFP_HF_DEFAULT_FEATURES 0x00
> > > > > > #define HSP_HS_DEFAULT_VOLCNTRL "false"
> > > > >
> > > > > Don't bother with default that are 0x00/false, we can assume this is
> > > > > implicit when allocating the memory everything is set to 0 so these
> > > > > defines wouldn't be needed in the first place.
> > > > >
> > > > > > Or do you prefer different names?
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
