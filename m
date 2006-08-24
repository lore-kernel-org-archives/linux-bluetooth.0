Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 24 Aug 2006 17:11:34 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060824141134.GA3181@localhost.localdomain>
References: <8712867d0608231353l6aa027bbha331a44392231f92@mail.gmail.com>
	<8712867d0608231418ld76b304oc8ae4ba1d8269d56@mail.gmail.com>
	<1156410090.4133.68.camel@aeonflux.holtmann.net>
	<8712867d0608240646n3ae773d6h271ba57ef06771cf@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <8712867d0608240646n3ae773d6h271ba57ef06771cf@mail.gmail.com>
Subject: Re: [Bluez-users] Fwd: bluez-utils: The inquiry scan (ISCAN) gets
	turned off
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

On Thu, Aug 24, 2006, Jaime Alberto Silva wrote:
> Is there any tool in bluez-utils to achieve that? or some new entries
> in the hcid.conf? so it can be done in an init script.

Adding "discovto 0;" to hcid.conf should do the trick.

You can change the settings from the command line using dbus-send, but I 
don't think it's a good idea to put it into a init script. E.g. the 
following would put the device in discoverable mode:
dbus-send --system --dest=org.bluez /org/bluez/hci0 \
	org.bluez.Adapter.SetMode string:discoverable

Johan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
