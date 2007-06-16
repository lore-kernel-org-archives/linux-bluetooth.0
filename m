Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <467148C3.4070409@gmail.com>
References: <467148C3.4070409@gmail.com>
Date: Sat, 16 Jun 2007 09:36:13 +0200
Message-Id: <1181979373.6846.58.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] A slave device wont re-connect
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

Hi Mikko,

> I have two devices that can act as Bluetooth master (A and B) and a 
> single device that can act only as a Slave (C). The slave can 
> communicate only using the RFCOMM profile. The devices A and B are 
> actually Linux boxes with D-Link DBT-122 BT USB dongles. The device C is 
> a sensor device that I have no control over (I can just switch it on and 
> off).
> 
> I've been trying to implement a software on the devices A and B which 
> would do the following:
> 
> 1) make periodic BT scans
> 2) if it finds the device C in these scans, it would create an RFCOMM 
> connection to the device C and simply read the data that it is sending
> 3) when the device C moves out of the range say device A to the coverage 
> area of device B the device B should then discover device C and create 
> the connection (roaming)
> 
> My application is threaded where thread 1 periodically creates a BT 
> socket, mekes a BT scan and closes the socket. Thread number 2 is 
> created when the first thread discovers the device C. This thread does 
> the following:
> 1) create a BT socket
> 2) binds the socket to a local BT address
> 3) connects to the discovered device C
> 4) read data from socket
> 5) close socket
> 
> This all goes just fine. If the device C first connects to device A and 
> then moves to lose connection with it, the device B can discover it and 
> the connection succeeds. The problem comes when the device C loses the 
> connection to B. Even though the device A can discover C again, the 
> connect() _always_ fails.
> 
> I have even tried to close the connection using RFCOMMRELEASEDEV ioctl.
> 
> My question is that have I missed something that I should do in order to 
> shutdown the BT connection properly so that the device C would be ready 
> for a new connection from another device?

first of all threading is not buying you anything. You run an inquiry
and page another device at the same time. That is a chip limitation and
that is true for all chips. Period.

Second of all, I need to see the source, hciconfig -a settings and a
hcidump -X -V for that situation.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
