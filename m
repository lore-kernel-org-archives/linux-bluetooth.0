Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at> <200402222254.53781.bluez-devel@schaettgen.de> <1077487210.2832.25.camel@pegasus>
In-Reply-To: <1077487210.2832.25.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200402222335.37053.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 22 Feb 2004 23:35:37 +0100

On Sunday 22 February 2004 23:00, Marcel Holtmann wrote:
> > The rfcomm stuff isn't performance critical at all, so there is need for
> > it to go into an alsa driver.
>
> the headset profile will never be in kernel space, because profiles are
> application specific. An ALSA Bluetooth driver should map between a SCO
> channel and an audio device, so that you can for example use XMMS or
> GnomeMeeting with your Bluetooth headset.
..
> You always have a control application on an ACL link before any SCO
> channel will be open.

Sure. I was just worried that with the alsa driver a userspace application 
might loose control over how SCO connections are handled. 
I don't want to be able to tell alsa that it should accept SCO connections on 
its own, instead I still want to accept it myself without having to resort to 
alsa functions and only optionally pass the socket (or whatever) to alsa to 
create a new device. Maybe it's supposed to work like that anyway, it was 
just not clear to me.

greetings
Fred


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
