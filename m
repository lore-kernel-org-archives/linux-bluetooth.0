Return-Path: <cyrus@holtmann.org>
Message-ID: <47EBC8ED.1010301@wurmsdobler.org>
Date: Thu, 27 Mar 2008 16:18:53 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Could not find org.bluez interface
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

Hello,

I am running a Qtopia 4.3 simulation on my Linux host. In addition, I 
have a USB Bluetooth dongle plugged in and hciconfig tells me that 
"hci0" is up and running. On the shell I can scan for devices, find some 
and query the respective device info. All well so far.

Now, during the Qtopia startup, a bluetooth local device manager gets in 
touch with the hci0 adatpter by creating an instance of a dbus interface 
with "org.bluez", "/org/bluez", and "org.bluez.Manager" as parameters 
(the redundancy in these values still astonishes me). Unfortunately, the 
return is "Could not find org.bluez interface".

Could this be due to a security setting, or some other access problems?

Any hints are very much appreciated,
peter


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
