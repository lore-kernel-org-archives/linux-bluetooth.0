Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sdp (and uclinux)
From: "Jorge A." =?ISO-8859-1?Q?Gonz=E1lez?= <egrojorge@terra.es>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1083877519.4420.78.camel@pegasus>
References: <1083853467.28356.18.camel@pancho>
	 <1083877519.4420.78.camel@pegasus>
Content-Type: text/plain
Message-Id: <1083925117.1946.36.camel@pancho>
Mime-Version: 1.0
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
Date: Fri, 07 May 2004 12:20:01 +0200


> > I think the problem is -lsdp which is not found. How could I get this
> > library??
> 
> if you use bluez-libs prior 2.6 than install bluez-sdp.

Thanks! It was totally my fault for not checking if I had the latest
version...

> > I dont know if this type questions are supposed to be in bluez-users or
> > bluez-devel. If this is no the appropiate list for this questions I
> > would be appreciate to know :D
> 
> For me it doesn't matter as long as you don't start cross-posting ;)

Ok, I will use this list then :D


Anyway, I am porting bluez for uClinux, by now it is working hcid (with
the option -n, as a daemon doesnt work due to the uclinux fork
implementation), hciattach (what a minor modification), hciconfig,
hcitool and rfcomm (the last one is not proved) and now I am trying to
make sdpd and sdptool to work.

My objective is communicate a device running uClinux with a PDA and be
able to transmit serial data via rfcomm and serial port service. If
anyone has any experience with bluez in uclinux or any other embedded
system I would appreciate to interchange ideas and experieces about it.

Thanks again,

Jorge



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
