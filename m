Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <cb1138d80608121115p3cccdf36m16541c0e832707ec@mail.gmail.com>
Date: Sat, 12 Aug 2006 13:15:29 -0500
From: "Philip Mateescu" <philipmateescu@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] HID create error 13 (Permission denied)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I'm running 2.6.15 (Ubuntu) and I'm trying to get my MX900 to work
with my laptop (using the built-in BT receiver not the Logitech
craddle).

My box seems to detect the mouse as hcidump shows activity when I move
the mouse.
However, everytime i move the mouse I also I keep getting these
message in daemon.log:
hidd[7264]: New HID device 00:07:61:14:CC:73 (Logitech Bluetooth Mouse)
hidd[7264]: HID create error 13 (Permission denied)


I've noticed that when starting the bluez-utils service I get these
entries in daemon.log:
hcid[8528]: Bluetooth HCI daemon
hcid[8528]: Can't get system message bus name: Connection ":1.11" is
not allowed to own the service "org.bluez" due to security policies in
the configuration file
hcid[8528]: Starting security manager 0
sdpd[8533]: Bluetooth SDP daemon

I suspect they're somehow connected...

There's a lot on configuration files involved which I haven't really
touched, save for /etc/bluetooth/pin which I tried changing from 1234
to 0000 to no change in messages. I'd be more than happy to post any
relevant config file in here.

Any help would be tremendously appreciated.
Thanks
philip

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
