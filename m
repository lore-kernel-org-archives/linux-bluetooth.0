Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D8EB88.70106@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] alsa plugin progress
References: <43D7270C.5020805@xmission.com> <1138270383.5901.25.camel@localhost>
In-Reply-To: <1138270383.5901.25.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 26 Jan 2006 08:32:24 -0700

Marcel,

I've had this nagging feeling I need to reorganize the btsco project. I
think if you make me a devel on the sourceforge "sbc" project, that
could be the place for sbc with no unnecessary requirements. If you're
willing to, I'd like to strip everything down to the 64-bit fixed-point
implementation (with no assembly). 32 bits would be even better but I
want to get going :)

A clean standalone libsbc would allow me to take a whack at gstreamer
integration. I will come back to alsa-lib work once I have the feeling
again that I'm making some sort of progress on all the other to-do items.

fwiw, gstreamer looks very well engineered. The sbc codec would be one
plugin, A2DP would be another, and they even have a place for controller
plugins like AVRCP.

Brad

> it was working somehow and sometimes I totally messed it up. The ALSA
> plugins are really designed for sound cards and for some options I
> actually have no idea how to translate them correctly into A2DP. Maybe
> you should simply play with different options and then might ask the
> gurus from the ALSA mailing list.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
