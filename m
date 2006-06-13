Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 13 Jun 2006 13:52:40 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.63.0606131336450.23668@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Subject: [Bluez-devel] RFCOMM TTY behaviour
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Dear all, 

we just had some discussion on the behaviour of the RFCOMM TTY driver with 
some BlueZ users. The problem is that it is not realy possible to have 
RFCOMM server ports when using the TTY driver (/dev/rfcommX). 

The suggested behaviour would be that a /dev/rfcommX device always exists 
(like any normal tty device), no matter if a bluetooth connection to the 
DLC exists or not. This would than much more act like a normal TTY. If 
there is a Bluetooth connection the cable is plugged, if there is no 
Bluetooth connection the cable is unplugged. 

After looking at the source of the RFC tty driver it should be possible to 
make it work like this by a few changes: 
Add a flag to the driver struct to make it a "server" port. 
Change the tty open behaviour.
Modify the tty write / ioctl functions to honour the actual connection 
status (just do nothing / throw write data away if not connected). 

Question: is there anything I missed which would provide from doing a 
described ?? 
Is there any good other reason why the tty driver should act like it 
currently does ?? 

Any input welcome. 

Thank you and best regards, 

Peter 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
