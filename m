Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44A54DD5.2070505@xmission.com>
References: <1151660752.7416.12.camel@johannes_01.kapune.local>
	<1151683090.8460.9.camel@johannes_01.kapune.local>
	<44A54DD5.2070505@xmission.com>
Date: Fri, 30 Jun 2006 18:46:08 +0200
Message-Id: <1151685968.8460.17.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: Re: [Bluez-users] a2play will not work
Reply-To: listen@kapune.de, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Am Freitag, den 30.06.2006, 10:14 -0600 schrieb Brad Midgley:
> Johannes
> 
> > after playing one piece of mp3 the headphone stays in a status in which
> > it doesn't want to play another mp3. I only can switch the headphone off
> 
> which headset is this?
This is "HAMA BSH-150"
> 
> are you using a2play from cvs? what does it do when using the -p option?
> 
yes I do.

you think something like this?:
mpg123 --p - Din_Tei.mp3 | ./a2play 00:0A:94:A0:59:3b

that doesn't work
> > Normally when the headphone is idle or working there is a LED blinking,
> > but at the end of one mp3 it is always off or on.
> > 
> > In my kde-kontrol-window for paired devices it is not listed also not
> > when the mp3 is playing. At the end of the mp3 I get this in the hcidump
> > -X -V window:
> 
> What is a2play printing out? Is it trying to close the stream?

I think so:
...
Sent stream start
Got start stream confirm

[3:31] Decoding of Din_Tei.mp3 finished.
ending stream
Sent 9120 packets
Sent stream-close
Got close stream confirm
closing stream
closing control connection


I get the same behavier when I cancel the mp3 with CTRL-C


Thanks for answer

Johannes


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
