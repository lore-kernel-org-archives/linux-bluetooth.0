Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AB9132.10609@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] encoding delay, librarifying a2play
References: <41A936C6.70209@xmission.com> <1101624988.18467.32.camel@pegasus>
In-Reply-To: <1101624988.18467.32.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 29 Nov 2004 14:14:26 -0700

Marcel

> I propose a generic AVDTP library that will handle all AVDTP related
> things. I checked in some basic code into the avdtp directory. My idea
> is to make the library look like a socket interface so we can later move
> things very easy to a kernel AVDTP implementation.

ok, the avdtp skeleton gives me a good starting point

by the way, I was hoping to avoid monitoring but my headset gets very 
confused when I interrupt the audio stream from linux with a cellphone 
call. one time the headset locked up. I wish I knew exactly what was 
happening when the dongle gets interrupted by a cell call and then resumes.

> The a2play is then only a frontend for the AVDTP library, SBC library
> and some audio input library (libmad for exmaple). And I think we should
> also include the rcplay stuff into it and provide an alternate RFCOMM
> streaming with an extra parameter.

yes. I am interested in keeping something around that can do low-latency 
encoding in userspace.

> However the final goal should be an ALSA library extension like their
> JACK plugin. But from my first tests I realized that it is impossible to
> create such an extension outside the ALSA PCM directory. I must talk
> with the ALSA developers about that issue.

I am going to ask at alsa-devel about the userspace plugin. It's hard to 
tell what is going on in alsa-lib.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
