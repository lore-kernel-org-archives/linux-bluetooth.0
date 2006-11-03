Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Reiner Klenk <pdq808@t-online.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <454B3AD7.7080401@gmail.com>
References: <454B3AD7.7080401@gmail.com>
Date: Fri, 03 Nov 2006 17:37:00 +0100
Message-Id: <1162571821.9400.24.camel@grappa.nowhere.de>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluetooth-alsa and HAMA BTH-155
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Freitag, den 03.11.2006, 13:49 +0100 schrieb Christian Mager:
>  Pairing the headset with my cell phone works, but
> it asks for a pin, btsco desn't. Could this cause the problem? In
> /etc/blueooth/hci.conf there is 'pin_helper /usr/bin/bluez-pin;' and 'lm
> accept;'.

I've seen a situation where the window with the pin request didn't come
up because the X-server denied the connection. I had to "xhost +" before
running btsco.

Regards,
Reiner


-- 
Reiner Klenk
debb1046 (jabber.org, ekiga.net, gmail.com, last.fm)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
