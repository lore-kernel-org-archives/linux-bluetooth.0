Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2004.08.14.22.56.57.538948@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Need help with PAND between 2  linux boxes
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
Date: Sun, 15 Aug 2004 01:56:58 +0300

Hi,

I have two linux boxes with FedoraCore 2 installed on both.
Both of them have USB bluetooth adapters.
I have tried to connect them in a NAP - PANU config, as indicated in
http://bluez.sourceforge.net/contrib/HOWTO-PAN, but something is not
working and I can't figure out what.
Here are the details:
service bluetooth start
Then I check with hciconfig that both BT are UP.
Then, on both computers I modprobe bnep.
(one note here, ifconfig -a does not show any bnep0 at this moment)
On both of them launch
hcidump in separate windows to see what is going on. 

On one I launch 
pand --listen --role NAP -n --master
and on the other
pand -c 00:20:E0:73:EB:F7 -n --role PANU

and after some messages in hcidump on both sides, I receive:
pand[1431]: Bluetooth PAN daemon
pand[1431]: Connecting to 00:20:E0:73:EB:F7
pand[1431]: Connect to 00:20:E0:73:EB:F7 failed. Function not implemented(38)

I tried both ways, but the behavior is the same.
Then I tried on one side:
strace pand --listen --role NAP -n --master
but when I try to connect from the other side, nothing happens here.

Do I miss something here ?

Thanks,
Paul




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
