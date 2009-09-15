Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090914211145.GA16947@jh-x301>
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu>
	 <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
	 <87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301>
	 <871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301>
Date: Tue, 15 Sep 2009 07:50:42 -0300
Message-ID: <2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com>
Subject: Re: [PATCH] Add introspection interface to the output of
	introspection calls.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?RISK=D3_Gergely?= <gergely@risko.hu>,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Context Devel mailing list <context-devel@projects.maemo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 14, 2009 at 6:11 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Thanks! The patch has now been pushed upstream.
>
> One thing that came to my mind is that it might be possible to simplify
> the code by making the introspection interface less of a special case
> within gdbus:
>
> Instead of hard coding this XML snippet and handling the Introspect method
> call separately from the rest of the method calls for a particular object
> path gdbus could use its own public interface registration system
> (i.e. g_dbus_register_interface) to implicitly register the Introspectable
> interface as the first interface when creating new object paths. This way
> the existing interface callback mechanism would do most of the work and
> there wouldn't be a need to explicitly add the extra snippet to the XML
> output like your patch now does.
>
> Any thoughts on this?

Yep, that sounds better for me too.

About the qdbus tool, I remember having this issue some time ago, but
it seems that any instance of QDBusInterface triggers introspect, but
qdbus code add another check for Introspectable interface which seems
unnecessary because it does that to call introspect again.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
