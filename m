Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 May 2008 17:23:43 +0300
From: Heikki Orsila <heikki.orsila@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080513142343.GG28808@jolt.modeemi.cs.tut.fi>
MIME-Version: 1.0
Subject: [Bluez-devel] On fast device discovery
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

Our project needs a fast method for device discovery. We are only 
interested in specific kind of devices. They are custom class devices.
The only information that needs to be transmitted over 
Bluetooth is the presence of such a device. After that the real
communication takes place with other methods (not over bluetooth).

I've read the discovery HOWTO already (
http://wiki.bluez.org/wiki/HOWTO/DiscoveringDevices ).

What is the fastest way to detect presence of one class of devices?

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
