Return-Path: <cyrus@holtmann.org>
Message-Id: <0FA03047-ABCC-476A-824D-BA5A2D1831FE@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47EBC8ED.1010301@wurmsdobler.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 27 Mar 2008 17:24:48 +0100
References: <47EBC8ED.1010301@wurmsdobler.org>
Subject: Re: [Bluez-users] Could not find org.bluez interface
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

Hi Peter,

> I am running a Qtopia 4.3 simulation on my Linux host. In addition, I
> have a USB Bluetooth dongle plugged in and hciconfig tells me that
> "hci0" is up and running. On the shell I can scan for devices, find  
> some
> and query the respective device info. All well so far.
>
> Now, during the Qtopia startup, a bluetooth local device manager  
> gets in
> touch with the hci0 adatpter by creating an instance of a dbus  
> interface
> with "org.bluez", "/org/bluez", and "org.bluez.Manager" as parameters
> (the redundancy in these values still astonishes me). Unfortunately,  
> the
> return is "Could not find org.bluez interface".
>
> Could this be due to a security setting, or some other access  
> problems?

might be, but I don't have enough information to tell you. Can you get  
the full error message. Or test it with a simple Python script.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
