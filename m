Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4500A483.5050400@xmission.com>
Date: Thu, 07 Sep 2006 17:00:19 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44EC8877.8050200@palmsource.com>	<44F5A472.30003@xmission.com>	<44F7088F.6090606@palmsource.com>	<44F9ABCF.1020706@xmission.com>	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E91@eumonex01.palmsource.com>	<44FE477D.9090307@xmission.com>
	<44FE8C5B.8060306@palmsource.com>
In-Reply-To: <44FE8C5B.8060306@palmsource.com>
Subject: Re: [Bluez-devel] RE :  Big patch to a2dpd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

>> Have you looked into using dbus for communicating with the running
>> a2dpd? I think I read that ALP is going to use dbus for things like this.
>>   =

> We still need data persistency, so It would need to
> 1) listen dbus
> 2) rewrite the file

sure... I do like how dbus integration would also allow us to have
another manager app changing settings.

btw, would it be hard to have wired output by default as long as a2dpd
isn't running?

>> fyi, if interference makes the stream get behind, the rate of the stream
>> gets a little wacky for a while and the pitch wanders around for a few
>> seconds before settling down. fwiw, this is on a machine with intel i810
>> graphics which seems to "behave" better than nvidia with regard to
>> interrupt masking.
>>   =

> What do you call interference?

if you walk too far from the transmitter, you get this. also if there's
a bluetooth device scan or motion from my bluetooth mouse things stop.
not much we can do except try to get back to normal as soon as possible
when this stuff happens.

brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
