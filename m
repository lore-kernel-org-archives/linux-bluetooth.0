Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44EA6D69.1090708@xmission.com>
Date: Mon, 21 Aug 2006 20:35:21 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Linux@feline-soul.com, BlueZ users <bluez-users@lists.sourceforge.net>
References: <200608192203.34883.Linux@feline-soul.com>
In-Reply-To: <200608192203.34883.Linux@feline-soul.com>
Subject: Re: [Bluez-users] Logitech Traveler Headset. Progress but not there
 yet. Advice wanted.
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

> on button to get it to start paring. Then i issue a "hidd --connect 
> 00:0D:44:4F:37:72" After awhile the headset stops blinking and "Can't get 
> device information: Function not implemented" is returned for the 
> hidd --connect.

hidd is for connecting the keyboard/mouse/etc but not the headset. Check
with the docs at bluetooth-alsa.sf.net.

Brad


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
