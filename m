Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Sep 2009 17:18:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?RISK=D3?= Gergely <gergely@risko.hu>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of
	introspection calls.
Message-ID: <20090914141816.GA17774@jh-x301>
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu> <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com> <87pra9nspo.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87pra9nspo.fsf@bubble.risko.hu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gergely,

On Wed, Sep 02, 2009, RISKÓ Gergely wrote:
> About the other services on my home system:
> 22975@20:39 risko@bubble:~$ qdbus --system | grep -v '^:'
>  org.freedesktop.Avahi
>  org.freedesktop.Hal
>  org.bluez
>  org.freedesktop.ConsoleKit
> org.freedesktop.DBus
> 
> 22978@20:42 risko@bubble:~$ for i in `qdbus --system | grep -v '^:'` ; do QDBUS_DEBUG=1 qdbus --system $i 2>&1| grep -q '<interface.*Introspectable' || echo $i; done
> org.bluez
> 
> So Avahi, Hal, ConsoleKit and even DBus itself exposes the introspection
> API in the introspection API, the only exception is BlueZ.
> 
> And this issue is causing problems for QDBus users everywhere, not just
> for me: https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/371299
> 
> The guy who handled the bug report even thought that BlueZ doesn't
> support introspection because of this.
> 
> I still think that this is bad, because all of the other common services
> behave the other way around and it is incompatible with some silly
> implementations (QtDBus which I know of, probably others).
> 
> If there is any other research I can do, please say so, happy to help,
> Gergely

I agree that it would be good to have this fix in. Since there's no
official guideline for this and neither solution can be said to be
completely incorrect I think that we should go with whatever works best
with existing D-Bus applications, i.e. have the introspection interface
declared as part of the XML. Could you still do the following please:

- Since the added XML content is fixed, use just one
  g_string_append_printf call for it (and split the string into multiple
  lines). Also try to have the lines max 80 columns to adhere to the
  coding style.

- Create a "git am" compatible patch out of the change by commiting it to
  your tree with a descriptive commit message and then use git format-patch

Johan
