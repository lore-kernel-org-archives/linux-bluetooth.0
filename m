Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4642CD6D.4020904@telnet-ri.es>
Date: Thu, 10 May 2007 09:44:45 +0200
From: David Beamonte <dbeamonte@telnet-ri.es>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] LMX9830 driver
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

We have included a National LMX9830 module in a new design. The 
communication between the chip and the microprocessor is via UART and we 
have also connected the audio channels of the chip to the processor, so 
that we can use the SCO link.

It's the first time we use bluetooth modules in our designs, and so, we 
are open to any kind of suggestion on how to work on this.

At first sight, it seems that we should use the UART(H4) driver, but we 
are not really sure if the commands to communicate to the chip are 
standard or not. I think that we will probably need to develop some kind 
of a driver.

Please, we would really appreciate some help about how to start working 
with this chip.

Regards,

David




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
