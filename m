Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0702090241w797ff03fk8dc41eb2e8881015@mail.gmail.com>
Date: Fri, 9 Feb 2007 11:41:04 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] phone model and link manager version
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

I wonder if there is any correlation between the Link Manager Protocol
(LMP) Subversion and the model of a bluetooth phone. I mean, if I find
out the LMP subversion of a remote device with for example hcitool,
like this:

sudo hcitool info <bdaddr>

Requesting information ...
...
LMP Version: 1.2 (0x2) LMP Subversion: 0x41c

Can this subversion be used to identify the model of the phone?

If not, can it be used to suggest that the phone is any of a small set
of models?

If firmware updates are being made on the phone, will that affect the
LMP subversion?

What process inside a phone manufacturer company decide that a
Bluetooth chip with a certain LMP subversion ends up in a specific
model? Is it just related to when the phone happened to be produced or
is it somehow related to the model?

Thanks in advance!

-- Mikael

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
