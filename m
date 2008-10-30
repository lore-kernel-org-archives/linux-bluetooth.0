Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300810301148s6afa46a0v2bd8ce1ed844a60e@mail.gmail.com>
Date: Thu, 30 Oct 2008 12:48:37 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1225380052.4626.8.camel@hoene-desktop>
MIME-Version: 1.0
References: <001d01c93a9f$6f2c8710$4d859530$@de>
	<1225380052.4626.8.camel@hoene-desktop>
Subject: Re: [Bluez-devel] FW: REALLY Bad encoding performance of Linux SBC
	audio codec
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Christian

> the sound quality got better. Still, both encoder and decoder are not as
> good as the reference.

It would be ideal to have automated tests for codec quality that don't
require windows and that we could run before commits to track our
progress. We could prepare some encoding/decoding samples with the
reference codec and store them in the project or somewhere online. The
one test we couldn't do this way is to encode with our codec and
decode with the reference.

Are there free tools for checking the quality and for comparing
signal/noise and overall volume? If you can detail the process you use
that would help.

thanks
Brad

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
