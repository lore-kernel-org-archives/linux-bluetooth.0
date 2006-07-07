Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170607071319r24a17342o1c5059086deebef8@mail.gmail.com>
Date: Fri, 7 Jul 2006 17:19:25 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1152295646.5770.20.camel@localhost>
MIME-Version: 1.0
References: <1150746967.5012.13.camel@localhost>
	<44970CBD.8000802@xmission.com> <1152109512.11387.24.camel@localhost>
	<d23110170607070744u5cdc657cy607db2016a887908@mail.gmail.com>
	<1152287304.5770.15.camel@localhost>
	<d23110170607071014p5f60069fj6e6ef41d0034d049@mail.gmail.com>
	<1152295646.5770.20.camel@localhost>
Subject: Re: [Bluez-users] Slow connection to Motorola H500 Headset
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

Hi Christoph,

> Does entering the sniff mode even save power on the notebooks bluetooth
> device?

Yes, it should save power but the sniff mode is more important in
small devices like mobile phones, keyboards, mice, and so on.

> Do you know any possibility to force a smaller sniff interval for this
> device? Something like 250 msec instead of 2.5 sec? That would probably
> be the best solution.

You can try the automatic sniff mode feature that probably is going to
be on Linux kernel 2.6.18 (and it's also present on Marcel Holtmann's
-mh patches). It sniffs the connection after a period of inactivity
and it uses a sniff interval of 500 milliseconds. You can specify the
period of inactivity after which the connection must be sniffed with:

  # echo 6000 > /sys/class/bluetooth/hci0/idle_timeout

This would make an idle ACL connection go to sniff mode after 6
seconds. You can disable this feature (if you need to) with:

  # echo 0 > /sys/class/bluetooth/hci0/idle_timeout

You can play with this idle timeout sysfs entry and see if things get
better for you. :-)

Best regards,

-- Ulisses

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
