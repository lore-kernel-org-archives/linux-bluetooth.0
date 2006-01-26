Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] alsa plugin progress
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43D7270C.5020805@xmission.com>
References: <43D7270C.5020805@xmission.com>
Content-Type: text/plain
Message-Id: <1138270383.5901.25.camel@localhost>
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
Date: Thu, 26 Jan 2006 11:13:03 +0100

Hi Brad,

> I've been tweaking the alsa plugin. How close was it when you had it?
> 
> For now, I am setting the socket to nonblocking and polling until the
> connect succeeds (I keep trying when errno is EAGAIN). I can connect and
> things seem to be working but there is no audio. It looks like there's a
> mismatch with audio settings but I'm not sure where that's happening.

it was working somehow and sometimes I totally messed it up. The ALSA
plugins are really designed for sound cards and for some options I
actually have no idea how to translate them correctly into A2DP. Maybe
you should simply play with different options and then might ask the
gurus from the ALSA mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
