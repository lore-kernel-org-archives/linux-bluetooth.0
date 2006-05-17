Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060517221929.76231.qmail@web54604.mail.yahoo.com>
From: Peter McClure <mcclurep@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Linux control of bluetooth radio
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
Date: Wed, 17 May 2006 15:19:29 -0700 (PDT)

I have a dual-boot (WinXP and Mandriva w/ 2.6.14) Dell
M70 laptop with an internal Bluetooth daughter card. 
It would seem that I can use WinXP to disable the
radio on the Bluetooth card.  When I then boot into
Linux, the BT card is detected and hci0 is initialised
but Bluetooth doesn't work.

Is there a way to turn the BT radio on and off under
Linux ?  (hciconfig up/down and reloading the kernel
module doesn't seem to work and there's no /proc
interface)



Thanks
Peter


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
