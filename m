Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <db972f4304081918374eb047c6@mail.gmail.com>
From: Ricky Soh <rickysoh@gmail.com>
Reply-To: Ricky Soh <rickysoh@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Newbie2
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
Date: Fri, 20 Aug 2004 09:37:14 +0800

I have bought a bluetooth dongle and is working in linux environment.
However, i have problem getting rfcomm and hcitool to work. I did a
hciconfig and see that the device is up and working. However when i
try to connect to it using

rfcomm -i hciX  connect hci0

I got: can't connect RFcomm socket: Host is down. When i did hcitool cc method:

hcitool -i hci0 cc --role=m 00:01:...
Can't create connection: Connection timed out
or 
Can't create connection: Input/output error

Sorry, i am new in this field. Could anyone give me some pointers?

Sincerely
Ric


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
