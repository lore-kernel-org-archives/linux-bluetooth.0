Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluetooth update for 2.4.23-pre2
From: Marcel Holtmann <marcel@holtmann.org>
To: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.54.999.0310121324110.10464@sibu.dcs.gla.ac.uk>
References: <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
	<5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
	<5.1.0.14.2.20031009103605.05a94590@unixmail.qualcomm.com>
	<1065723861.14514.91.camel@pegasus>
	<Pine.LNX.4.54.999.0310121324110.10464@sibu.dcs.gla.ac.uk>
Content-Type: text/plain
Message-Id: <1066037344.8024.196.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 13 Oct 2003 11:28:58 +0200

Hi Jonathan,

> > the ALSA support is not the point, because you can use the SCO socket
> > for 2.4 for now and it is working fine for me. I think we should drop
> > this for 2.4.23 and wait until 2.4.24-pre.
> 
> Have you had a chance to try or look at my snd-bluez-sco ALSA driver yet?
> I'm interested to hear your thoughts on its design.
> 
> 	http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/

I have looked at your code, but never tested it. However it looks fine
and it seems that some people got success with it. What I don't like is
that it is build on top of the SCO sockets. I raised this a long time
ago and what I expect from a good Bluetooth audio integration is direct
interface to OSS and ALSA. I think of something we have done for RFCOMM,
which means that we integrate all stuff directly into the sco.o module.

	Linux 2.4	SCO socket + OSS interface
	Linux 2.6	SCO socket + OSS/ALSA interface

I am not an audio or ALSA expert, so don't expect to much from me in
this area. And the 2.6 looks like a good starting point to redesign our
SCO interface. I would say that you should go ahead and try to do it ;)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
