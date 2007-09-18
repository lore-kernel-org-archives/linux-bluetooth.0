Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46EFFE96.3010000@ozob.net>
Date: Tue, 18 Sep 2007 11:36:38 -0500
From: Gene Imes <ebi7@ozob.net>
MIME-Version: 1.0
To: list-bluez-users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] rfcomm
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

I have several bluetooth receivers. In rfcomm.conf I have them listed 
and the one I want to use I uncomment. How do I get rfcomm to pickup the 
changes? I can not seem to get rfcomm to pickup the new device.

Here is the pertinent rfcomm.conf section:

rfcomm0 {
         # Automatically bind the device at startup
         bind yes;

         # Bluetooth address of the device
         #device 00:08:1B:C0:D3:1F;
         #device 00:0B:0D:18:15:4F;
         #GPSlim240
         device 00:0B:0D:6D:E2:E6;

         # RFCOMM channel for the connection
#       channel 1;
}

-- 
Gene Imes ============================= ozob.net

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
