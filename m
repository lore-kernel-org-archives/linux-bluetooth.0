Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Some kernel changes
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
In-Reply-To: <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com>
References: <496895AB.4050902@nokia.com>
	 <1231768413.23749.1.camel@californication>
	 <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 13 Jan 2009 20:12:46 +0100
Message-Id: <1231873966.12234.2.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> >> Here is set of unclean patches for discussion. These are still untested
> >> and contain issues, but I would like to know if we should continue with
> >> these or change something radically. Also commit messages are somewhat
> >> misleading in some places.
> >>
> >> Basically idea is to implement connection rejection support for l2cap
> >> and rfcomm sockets. IOW possibility to check initiator bd-address and
> >> ask for authorization before accepting connection.
> >>
> >> Other goal is to fix encryption and authentication levels to fulfill 2.1
> >> requirements.
> >
> > so I pushed my re-worked and pending patches to bluetooth-testing.git
> > now. This adds support for BT_DEFER_SETUP and BT_SECURITY (only the
> > logic and not the actual socket option).
> 
> Ville: thanks for the patches, pausing RFCOMM while encryption is
> disabled is a nice fix.
> 
> I imagine that if encryption is not quickly re-established we need to
> drop the RFCOMM link rather than leaving it paused though.
> 
> We will do some testing of the current rfcomm-pause patches.

so I pushed another set of patches to the bluetooth-testing.git tree and
it should include the full BT_SECURITY implemention, BT_DEFER_SETUP for
RFCOMM and SCO rejection if no listen socket is present.

It currently only drops the connection is encryption is disabled when
using BT_SECURITY_HIGH. That is only used for SAP anyway. For all other
profiles we use BT_SECURITY_MEDIUM.

Regards

Marcel


