Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4504D825.2020109@xmission.com>
Date: Sun, 10 Sep 2006 21:29:41 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Linux@feline-soul.com, BlueZ users <bluez-users@lists.sourceforge.net>
References: <200609101824.25866.Linux@feline-soul.com>
In-Reply-To: <200609101824.25866.Linux@feline-soul.com>
Subject: Re: [Bluez-users] bluetooth headset: Fuction not Implemented?
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

Bearcat

we all get frustrated with this stuff from time to time. too bad you
haven't made progress... fwiw, I haven't seen anyone report success with
the traveler model so it may be doing something wacky.

> I have the pin code being processed now.  When i try to connect it i see the 
> following:
> btsco 00:0D:44:4F:37:72
> Error: Failed to connect to SDP server: Function not implemented
> Assuming channel 2

if you can't run

sdptool browse 00:0D:44:4F:37:72

and get a list of services then you have a problem that is more
fundamental than just audio. (that is equivalent to what btsco is trying
to do when it prints the sdp error.)

what distro is it again? and what is in /etc/bluetooth/hcid.conf?

(btw, have you fiddled with setting your pin helper or the pin in
/etc/bluetooth/pin?)

brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
