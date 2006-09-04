Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <7f52ac20609031839j72f98969v420375ea7f183b88@mail.gmail.com>
References: <7f52ac20609031839j72f98969v420375ea7f183b88@mail.gmail.com>
Date: Mon, 04 Sep 2006 12:35:21 +0200
Message-Id: <1157366121.32195.39.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Where did encrypt and passkey options go
	in	Bluez-3.4
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

Hi Hentai,

> *offtopic ->*
> i had Debian unstable package of Bluez-3.1, but was forced to build
> 3.4 from scratch, and now things seems to be finally working thanks to
> the undocumented (and secret?) feature of "discovto 0;"
> Why isn't this feauture mentioned on the hcid.conf manual??? It caused
> me sheer hours of pain and terror... and a lot of linux cursing.
> *<- offtopic*

it is basically a missing patch for the manual page. Feel free to
provide one or kick the original author of the patch ;)

> But what i would like to know is how can i encrypt my bluetooth
> communications? The encrypt option went missing - it's stated on the
> Changelog.

Don't confuse this. These options where security mode 3 related and we
actually never advised anybody to use this mode. So it has been finally
removed from the config file. The daemons can set the authentication and
encryption for their sockets by themself.

> On hcid.conf i can only configure the default pin... How can i specify
> a PIN for each BT device?

The passkey option is for incoming connections. This is not a default
passkey for outgoing connection. We don't have these.

> Ideally, i would like to be able to add some lines, on hcid.conf, like this:
> client {
> BDAddress 11:22:33:44:55:66;
> PIN 2006;
> }

Aehm. No. Period. You however can put them into the pincodes file. And
this is a hidden feature that should stay hidden. Use a passkey agent to
enter your PIN codes. Look at bluez-gnome for a nice GTK+ based one or
simply write your own.

> One final question, i know it's silly, but i have to be sure...
> Independently of using authentication or passkeys or not, is there any
> way a BT device (e.g. phone) can issue a command for the computer to
> send file /home/user/abc.txt to the device.
> Is there any security risk like that?

No. There is no such thing that can trigger a remote action. However you
can always implement such stuff.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
