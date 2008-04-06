Return-Path: <cyrus@holtmann.org>
Message-ID: <f3217ae20804051800g66c77965odda1a4747fec4a83@mail.gmail.com>
Date: Sat, 5 Apr 2008 22:00:03 -0300
From: "Alex Castillo" <acastillova@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Mxpwr = 0 in CSR Class 1 and receive problems with
	bcm2035
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

Hi, Everybody,

I am concern, about the information that give me the
/proc/bus/usb/devices, show me MxPwr= 0mA, and I think that should be
MaxPwr = 100mA, I have another one that is Class 2, and should be 10mA
as well.... :(

I have a broadcom bcm2035 Usb, and show me Maxpwr = 100mA, its ok, but
when I do a service discovery, like an sdptool, I never got the
service of the mobile phones.. like obex channel..... class

bcm2035:
hci0:   Type: USB
        BD Address: 00:18:F8:89:7E:CA ACL MTU: 377:10 SCO MTU: 64:8
        Firmware 0.3 / 9
blue2@blue2:~$ hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:18:F8:89:7E:CA ACL MTU: 377:10 SCO MTU: 64:8
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)



someone, can give some information, about this two issues,  CSR: Class
1 with Mxpwr=0mA,
and the problem that i have with the bcm2035

many thanks,

Alex

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
