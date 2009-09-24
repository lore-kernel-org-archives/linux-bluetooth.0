Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Sep 2009 20:22:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?RISK=D3?= Gergely <gergely@risko.hu>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of
	introspection calls.
Message-ID: <20090924172246.GA26933@jh-x301>
References: <87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301> <871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301> <2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com> <87ws40e6iz.fsf@bubble.risko.hu> <20090915152240.GA4378@jh-x301> <87eiq7du6t.fsf@bubble.risko.hu> <20090916113959.GA4314@jh-x301> <8763bjdrlr.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8763bjdrlr.fsf@bubble.risko.hu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 16, 2009, RISKÓ Gergely wrote:
> > That saves you one level of indentation for most of the function and could
> > be considered also esier to read.
> 
> Agree, fixed.
> 
> Gergely
> 
> From 68b79f26969017d62118734ac8f118d973445cf9 Mon Sep 17 00:00:00 2001
> From: Gergely Risko <gergely@risko.hu>
> Date: Tue, 15 Sep 2009 15:23:24 +0300
> Subject: [PATCH] gdbus: handle introspection generally in generic_message.
> 
> Previously it was a specific case, now introspection is just another
> interface, which is always implemented.  It is registered/unregistered
> when an object path is referenced first/last.
> ---
>  gdbus/object.c |  101 ++++++++++++++++++++++++++++++++------------------------
>  1 files changed, 58 insertions(+), 43 deletions(-)

The patch has now been pushed upstream.

Johan
