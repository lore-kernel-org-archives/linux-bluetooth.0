Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44A576BB.1000006@xmission.com>
Date: Fri, 30 Jun 2006 13:08:43 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: listen@kapune.de, BlueZ users <bluez-users@lists.sourceforge.net>
References: <1151660752.7416.12.camel@johannes_01.kapune.local>	<1151683090.8460.9.camel@johannes_01.kapune.local>	<44A54DD5.2070505@xmission.com>
	<1151685968.8460.17.camel@johannes_01.kapune.local>
In-Reply-To: <1151685968.8460.17.camel@johannes_01.kapune.local>
Subject: Re: [Bluez-users] a2play will not work
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Johannes

> you think something like this?:
> mpg123 --p - Din_Tei.mp3 | ./a2play 00:0A:94:A0:59:3b

try:
mpg123 - Din_Tei.mp3 | ./a2play -p 00:0A:94:A0:59:3b

a2play used to lock up my itech clip s set but I thought I had fixed the
problem. I thought a2play was sending more stream data after it had
signaled the set to close the stream.

anyway, the ordering might be better using -p but if not you could try
disabling the stream close by changing "#if 1" to "#if 0" in the latest
version from cvs (you might have to give it an hour for anon cvs to
catch up)

Brad

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
