Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sf.net
Date: Thu, 24 Aug 2006 10:10:14 -0400
MIME-Version: 1.0
Message-Id: <200608241010.15024.akohlsmith-bluez@benshaw.com>
Subject: [Bluez-users] dumb questions (hopefully)
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

I'm playing around with a cell phone, a headset and a PDA.

The phone: Nokia 6265i
The headset: Sony-Ericson HBH-662 and Motorola HS-850
The PDA: Tungsten T|X

(I'm foregoing the PDA for my Linux laptop running Bluez and a USB BT dongle 
(DBT-122)).

I want to do what Bluetooth promised us ages ago: Use the PDA (laptop) to dial 
the phone, then have the conversation using the headset.

I can connect to the RFCOMM channel of the Audio Gateway or Voice Gateway 
profiles of the phone and issue "ATD5551212;" to cause the phone to place a 
voice call.  (I can't use the DUN profile or it's *always* a data call, which 
in hindsight makes sense.)

If I connect to the AG profile, the phone wants to route audio to the laptop.  
Again, this makes sense according to the BT spec.  I use the VG profile 
instead.  Using the VG profile lets me use the laptop to dial and audio is 
still available on the phone's normal earpiece.

Where this all falls down is when I actually have the headset on.  Every phone 
I've tried so far (Motorola RAZR, Nokia 6265i, Motorola v190) seems to 
completely disappear from the BT network when the headset is on (not 
necessarily transferring audio, but just on).  I understand that audio and 
SCO channel data can be very taxing on a phone's processor and that as a 
result when audio is *active* that it may drop out of the network, but when 
the audio channel is "idle" I can't imagine why the phone wouldn't listen on 
its other channels.

It's been suggested that it may be possible to have the phone be a master to 
the headset, and the laptop or PDA be a master to the phone, but I'm at a 
loss as to how to go about doing this.

Has anyone managed to use a laptop or PDA to use a phone to dial a number and 
carry on the resultant conversation on a headset? 

-A.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
