Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Graham White <graham@dcs.qmul.ac.uk>
To: Bluez Users <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1118566621.9197.5.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] can't receive files from phone
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 12 Jun 2005 09:57:01 +0100

I have a Thinkpad T42 running Ubuntu Hoary, and a Motorola V547 mobile
phone. I can do almost anything I want with the bluetooth connection
to the mobile: ppp over gprs, send files to the mobile from the
thinkpad, send sms with gnome-phone-manager, and so on. However,
I cannot send files to the thinkpad from the mobile: the mobile
discovers the thinkpad correctly, but when I select it for
file transfer I get a dialogue box on the mobile saying
"Unable to Connect". hcidump -x on the thinkpad shows, for each
failed connection attempt, the following three lines:

> HCI Event: Connect Request (0x04) plen 10
  BF AA 58 8A 12 00 04 22 52 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  21 29 00 BF AA 58 8A 12 00 01 00

This behaviour is exactly the same whether I have gnome-obex-server
running, or obexserver running, or *nothing at all* running. 

And I have the device class correctly set; that is, I have
a line in hcid.conf on the thinkpad saying

        class 0x100100;

(in fact, if I had the device class wrong, the mobile couldn't 
discover the thinkpad, and it can). 

Anyone got any ideas?

Graham White



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
