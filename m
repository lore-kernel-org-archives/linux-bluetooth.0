Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] encoding delay, librarifying a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41AB9132.10609@xmission.com>
References: <41A936C6.70209@xmission.com>
	 <1101624988.18467.32.camel@pegasus>  <41AB9132.10609@xmission.com>
Content-Type: text/plain
Message-Id: <1101764708.7562.41.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 29 Nov 2004 22:45:08 +0100

Hi Brad,

> > I propose a generic AVDTP library that will handle all AVDTP related
> > things. I checked in some basic code into the avdtp directory. My idea
> > is to make the library look like a socket interface so we can later move
> > things very easy to a kernel AVDTP implementation.
> 
> ok, the avdtp skeleton gives me a good starting point

I have done some more work on it, but not yet comitted.

> > However the final goal should be an ALSA library extension like their
> > JACK plugin. But from my first tests I realized that it is impossible to
> > create such an extension outside the ALSA PCM directory. I must talk
> > with the ALSA developers about that issue.
> 
> I am going to ask at alsa-devel about the userspace plugin. It's hard to 
> tell what is going on in alsa-lib.

it is not that hard, because the initial stuff already works. My problem
is that we must develop inside the ALSA tree.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
