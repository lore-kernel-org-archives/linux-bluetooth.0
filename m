Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Igor Luiz Oliveira de Souza <igorluiz@magiclink.com.br>
Reply-To: igorluiz@magiclink.com.br
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1074635052.4824.10.camel@emerald>
Mime-Version: 1.0
Subject: [Bluez-users] BT3030...
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
Date: 20 Jan 2004 19:44:12 -0200

Hello all,

I'm trying to make my USB Dongle BT3030 works on linux...
I'm almost getting crazy trying this without success...
Can you give me some help?

I'm using slackware 9.0, kernel 2.4.20 (have tried 2.4.24 too, no
success)... 
I've download all the bluez packages, configured the kernel, recompile
it...
So, the modules seems to load correctly... see what I get after this
loading modules sequence:

usbcore
bluez
hci_usb
uhci

in /var/log/syslog:

Jan 14 15:13:42 emerald kernel: usb.c: USB device 2 (vend/prod
0xa5c/0x2033) is not claimed by any active driver.

in /var/log/messages:

Jan 14 15:13:42 emerald kernel: hub.c: 2 ports detected
Jan 14 15:13:42 emerald kernel: hub.c: new USB device 00:07.2-1,
assigned address 2
Jan 14 15:13:45 emerald /etc/hotplug/usb.agent: ... no modules for USB
product 0/0/0
Jan 14 15:13:45 emerald /etc/hotplug/usb.agent: ... no modules for USB
product 0/0/0
Jan 14 15:13:45 emerald /etc/hotplug/usb.agent: Setup hci_usb for USB
product a5c/2033/a0
Jan 14 15:13:45 emerald /etc/hotplug/usb.agent: Setup bluefw for USB
product a5c/2033/a0
Jan 14 15:13:45 emerald /etc/hotplug/usb.agent: Module setup bluefw for
USB product a5c/2033/a0

After that, that is no /proc/bus/usb...

Trying hciconfig, I've got nothing... just like this:
root@emerald:/usr/src/linux# hciconfig -a
root@emerald:/usr/src/linux#
root@emerald:/usr/src/linux# hcitool dev
Devices:
root@emerald:/usr/src/linux#

Sorry about the big mail...
So, can you give me some help... 
What can I be forgetting or any special detail?

Thanks in advance!
-- 
Igor Luiz Oliveira de Souza
Magiclink Solucoes Internet
Analista de TI - 88657412
Salvador / BA   -  Brasil



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
