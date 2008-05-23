Return-Path: <cyrus@holtmann.org>
Message-ID: <4836F095.1070507@achilles.org>
Date: Fri, 23 May 2008 17:28:05 +0100
From: "R.K. Harle" <robert.harle@achilles.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] L2Ping and RSSI
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


Dear all,

I'm interested in what communication is possible with unpaired bluetooth 
devices.  I am aware that I can ping an unpaired device using L2ping and 
the hardware address of the device.  I'd like to know whether I can get 
any link information from a ping, such as RSSI?  All the HCI tools seem 
to require a 'proper' (authenticated, paired) connection.

And, if anyone has the time, I'd love to better understand the 
difference between an unpaired connection as established by l2ping (I'm 
going by the code) and a full bluetooth HCItool-compatible connection 
which I assume requires pairing.  The official standard is not what I'd 
describe as especially accessible..!

Thanks,
Rob.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
