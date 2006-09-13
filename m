Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0609130548h1a6dea73vef4a6a8dc8b08d5e@mail.gmail.com>
Date: Wed, 13 Sep 2006 09:48:46 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <e1effdeb0609130523g204fff2fk80a0786e92f81d89@mail.gmail.com>
MIME-Version: 1.0
References: <c49421c50609120941i26ffb8dauf0ae2c0c31190808@mail.gmail.com>
	<e1effdeb0609130523g204fff2fk80a0786e92f81d89@mail.gmail.com>
Subject: Re: [Bluez-users] restricting inquiry responses
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

On 9/13/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> On 9/12/06, Loreno Oliveira <lorenooliveira@gmail.com> wrote:
> > Hi there,
> >
> > I have different base stations that permanently try to find out new mobile
> > devices on their coverage areas. Once discovered and paired with some BS, I
> > need this device to be able to not answer to that BS inquiries.
> >
> > Is there a solution for this??
> >
> > Regards,
> >
> > Loreno
> _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> Hi Loreno,
>
> You can use the a D-Bus method to switch the device to "Connectable"
> mode. The adapter interface supports the following discoverable modes:
> discoverable: PSCAN ISCAN
> connectable: PSCAN
> off: NOSCAN
>
> Use the gbluezconf(test app) to setup this mode:
> http://www.maemo.org.br/cktakahasi/gbluezconf/gbluezconf-00.32.tar.gz
>
> Or dbus-send:
> $dbus-send --system --type=method_call --print-reply --dest=org.bluez
> /org/bluez/hci0 org.bluez.Adapter.SetDiscoverableTimeout uint32:0
> $dbus-send --system --type=method_call --print-reply --dest=org.bluez
> /org/bluez/hci0 org.bluez.Adapter.SetMode string:discoverable
>
> The default discoverable timeout is 180sec. Setting it to 0 +
> discoverable mode to "discoverable" the device will be always visible.
> Setting the discoverable timeout to X + mode to discoverable, the mode
> will be changed automatically to connectable mode after X seconds.
>
>
> BR,
> Claudio.
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>

Hi Loreno,

Sorry, I misunderstood your question. It's not possible "not answer"
to a specific BS inquiries.

BR,
Claudio.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
