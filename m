Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <413B18F9.6010101@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] no concurrent inquiry / inquiry scan and L2CAP connection as slave
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 05 Sep 2004 15:47:37 +0200

Hi folks,

I'm experiencing the following behavior with BlueZ and L2CAP:

After establishing an L2CAP connection between two nodes, only the 
master of this connection is still able to:

- perform periodic device inquiries (i.e. search other devices
   in 'Periodic_Inquiry_Mode')	
- perform inquiry scans (i.e. be visible for other searching devices)

However, I would like to be able to do this as slave as well (at least, 
to perform inquiry scans as slave).

Now I'm wondering whether:

- this is a restriction of BlueZ		or
- this is a restriction of my BT chipsets	or
- this is a restriction of Bluetooth		or
- I'm doing (configuring) something wrong...

My environment:

SuSE Linux 9.0: kernel 2.4.21, bluez-libs 2.4, bluez-utils-2.3

I have tested and verified this behavior with the BrainBoxes BL-500 and
BL-554 adapters.
I'd be very grateful if someone of you could shed some light on this topic.


Thanks in advance,

Michael

-- 
===========================================
Michael Schmidt
-------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
-------------------------------------------
http:   www.nue.et-inf.uni-siegen.de
===========================================



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
