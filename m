Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44ED589B.7080101@xmission.com>
Date: Thu, 24 Aug 2006 01:43:23 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Linux@feline-soul.com, bluez-users@lists.sourceforge.net
References: <1597.216.47.59.131.1156371924.squirrel@webmail.feline-soul.net>
	<200608232205.01719.Linux@feline-soul.com>
	<44ED2C3B.9020400@xmission.com>
	<200608232300.58022.Linux@feline-soul.com>
In-Reply-To: <200608232300.58022.Linux@feline-soul.com>
Subject: Re: [Bluez-users] Logitech Traveler Headset. pin never seen and i
 am never asked.
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

> mode?  *These files have never existed and it has never been paired. How do i 
> put it in paired mode?*

most headsets go into pairing mode by holding down the power until the
led flashes red/blue. check your manual if you can find one.

> This is a headset that i ordered from Ebay. A white box.  Do i *know* that the 
> pin is still the default? No. However i should still be asked for the pin at 
> some point.
> 
> Again, when i issue a btsco 00:0D:44:4F:37:72 i get:
> Error: Failed to connect to SDP server: Permission denied
> Assuming channel 2
> 
> Can't connect RFCOMM channel: Permission denied

hmm. yeah this one has come up from time to time. the headset *should*
respond to sdp even when not in pairing mode. sdp shouldn't require the
pin code either. so it's going wrong even before you can start to pair
with it. did you get the address in the first place with hcitool scan?

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
