Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4246DF1F.4020408@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP btsco support
References: <200503261356.57766.mh@intellinetservices.net> <1111894787.9195.213.camel@pegasus> <20050327154013.GC26485@externe.net>
In-Reply-To: <20050327154013.GC26485@externe.net>
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
Date: Sun, 27 Mar 2005 09:28:15 -0700

Guylhem

> I recommand keeping standalone sbc encoder and a2play, at least for
> those who want to use such headphones with linux PDAs (I do !)

the problem here is there is one way to fix timing issues in a2play and 
a different solution for timing issues in an alsa userspace plugin. if 
it's important to someone, it will be maintained of course.

i've been hoping a company would see potential in this stuff and throw 
in some resources. during the .com boom it would have happened :(

> BTW I did report somes bug and proposed fixes when I was compiling
> with gcc 2.95 for ARM. Did they make it in?

i think so. check cvs to see if it all looks good.

thanks
brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
