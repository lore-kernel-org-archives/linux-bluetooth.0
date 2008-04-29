Return-Path: <cyrus@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <3088.1209057777@foxharp.boston.ma.us> 
References: <3088.1209057777@foxharp.boston.ma.us>
MIME-Version: 1.0
Date: Tue, 29 Apr 2008 09:02:39 -0400
Message-ID: <8453.1209474159@foxharp.boston.ma.us>
From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: [Bluez-users] large latency with rfcomm serial?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

i sent this several days ago -- are there really no opinions
on whether the linux BT stack could introduce 2-3 second
character latencies for serial data?

i'll start debugging it soon, i guess.

paul

paul wrote:
 > hi --
 > 
 > i'm new to bluetooth.
 > 
 > i have a dbt-120 bluetooth receiver dongle that i'm using to
 > connect to a gps unit (for the record, an i-blue 737).  i'm
 > running fc7.
 > 
 > i'm seeing large latency values (2 to 3 seconds) on character
 > delivery.  are there any well-known gotcha's i should be aware
 > of that might cause this kind of thing?
 > 
 > here's the scenario:
 > 
 > i have two GPS devices.  one's a direct USB plug-in, the other is
 > the bluetooth device mentioned above.
 > 
 > the direct plugin unit works fine.  when tracking motion, it
 > tends to lag about a second behind "real-time", which is normal
 > for gps.
 > 
 > the BT device, however, lags real-time by a full 3 or 4 seconds --
 > long enough that it can cause real confusion while navigating.
 > (i.e., it says you're coming up to a turn 4 seconds after you've
 > passed it.)
 > 
 > if i connect both devices at once, and simply watch the output
 > from each (by connecting directly to their respective tty device
 > nodes), it's clear that the output from the BT unit is way
 > behind.  the devices are stationary, so the positions aren't
 > changing, but the GPS timestamps that come across in the BT data
 > are 3 or 4 seconds behind those from the non-BT device.
 > 
 > since they clearly both get the same time from the satellites,
 > the time skew is happening either withing the GPS receiver, or
 > within the bluetooth stack.  to try and determine which, i
 > figured out how use a windows box (same dbt-120 dongle, same gps
 > unit), and did the comparison again.  the BT device was on windows,
 > the direct-connect device still on linux.  the timestamps in the
 > messages coming from the two seemed pretty much in sync.
 > 
 > so my current feeling is that i'm losing 2 to 3 seconds in the
 > bluetooth stack.  any ideas?  any config values to check?
 > 
 > paul
 > 
 > p.s. vital statistics:
 >     machine is an OLPC XO laptop.  
 >     kernel is OLPC-built 2.6.22
 >     modules were built later, from a matching kernel tree.
 >     yum bluez packages:
 > 	bluez-gnome.i386  0.8-2.fc7
 > 	bluez-libs.i386   3.9-1.fc7
 > 	bluez-utils.i386  3.9-2.fc7
 > 
 > =---------------------
 >  paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 66.6 degrees)
 > 
 > -------------------------------------------------------------------------
 > This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
 > Don't miss this year's exciting event. There's still time to save $100. 
 > Use priority code J8TL2D2. 
 > http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
 > _______________________________________________
 > Bluez-users mailing list
 > Bluez-users@lists.sourceforge.net
 > https://lists.sourceforge.net/lists/listinfo/bluez-users

=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 53.6 degrees)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
