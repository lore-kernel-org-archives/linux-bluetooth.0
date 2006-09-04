Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7f52ac20609031839j72f98969v420375ea7f183b88@mail.gmail.com>
Date: Mon, 4 Sep 2006 02:39:49 +0100
From: "Hentai Pantsu" <sugoi.sama@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Where did encrypt and passkey options go in Bluez-3.4
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

Hi,

*offtopic ->*
i had Debian unstable package of Bluez-3.1, but was forced to build
3.4 from scratch, and now things seems to be finally working thanks to
the undocumented (and secret?) feature of "discovto 0;"
Why isn't this feauture mentioned on the hcid.conf manual??? It caused
me sheer hours of pain and terror... and a lot of linux cursing.
*<- offtopic*



But what i would like to know is how can i encrypt my bluetooth
communications? The encrypt option went missing - it's stated on the
Changelog.

On hcid.conf i can only configure the default pin... How can i specify
a PIN for each BT device?
Ideally, i would like to be able to add some lines, on hcid.conf, like this:
client {
BDAddress 11:22:33:44:55:66;
PIN 2006;
}



One final question, i know it's silly, but i have to be sure...
Independently of using authentication or passkeys or not, is there any
way a BT device (e.g. phone) can issue a command for the computer to
send file /home/user/abc.txt to the device.
Is there any security risk like that?


Thank you for your help.
(it isn't easy being a linux newbie)

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
