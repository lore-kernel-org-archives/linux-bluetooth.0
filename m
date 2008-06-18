Return-Path: <cyrus@holtmann.org>
Message-ID: <4858E396.7020208@suse.de>
Date: Wed, 18 Jun 2008 12:29:42 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <3e9cdced0806140254u1fdcc62dq4333252ba2d01662@mail.gmail.com>
In-Reply-To: <3e9cdced0806140254u1fdcc62dq4333252ba2d01662@mail.gmail.com>
Subject: Re: [Bluez-users] different versions of bluez depending on
	distribution
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Fritz Code wrote:
> Well there seem to be different bluez versions depending on the
> distribution. E.g. on my (old) SuSE 10.2 System bluez is installed in
> version 3.7 (its supposed to be newer than the latest official bluez pack=
age
> - strange!) ?
> But the latest release of the public bluez.org download-section is 3.32?

I'd say that 7 < 32.

> Do the the distributors compile their own bluez packages and at the same
> time change the version-number?

I don't

> I also figured out some differences e.g. in the arguments of the request
> message, sent out after a create_bonding.
> Why do they make such changes?

I'm pretty sure i didn't. Probably it's just that 3.7 had different handling
than 3.32 has.

> I think this strategy is sort of confusing because you don't know exactly
> the differences of official bluez packages and the adpated of your
> distribution...

I add only very few patches to the package. Sometimes it's fixes backported
from newer releases after the version freeze for the distribution, sometimes
it's some special stuff needed for interaction with the system, which might
not (yet) be upstream, but that is pretty rare.
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
