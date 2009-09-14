Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Sep 2009 00:11:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?RISK=D3?= Gergely <gergely@risko.hu>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of
	introspection calls.
Message-ID: <20090914211145.GA16947@jh-x301>
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu> <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com> <87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301> <871vm9fuis.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <871vm9fuis.fsf@bubble.risko.hu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gergely,

On Mon, Sep 14, 2009, RISKÓ Gergely wrote:
> Thank you for all of your advise, here is the result.
> 
> BR,
> Gergely
> 
> From 91b64b5cd3b174317bde5f9ccf4cc1d420086eb7 Mon Sep 17 00:00:00 2001
> From: Gergely Risko <gergely@risko.hu>
> Date: Mon, 14 Sep 2009 17:46:29 +0300
> Subject: [PATCH] Add introspection interface description into the DBus introspection replies.
> 
> ---
>  gdbus/object.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

Thanks! The patch has now been pushed upstream.

One thing that came to my mind is that it might be possible to simplify
the code by making the introspection interface less of a special case
within gdbus:

Instead of hard coding this XML snippet and handling the Introspect method
call separately from the rest of the method calls for a particular object
path gdbus could use its own public interface registration system
(i.e. g_dbus_register_interface) to implicitly register the Introspectable
interface as the first interface when creating new object paths. This way
the existing interface callback mechanism would do most of the work and
there wouldn't be a need to explicitly add the extra snippet to the XML
output like your patch now does.

Any thoughts on this?

Johan
