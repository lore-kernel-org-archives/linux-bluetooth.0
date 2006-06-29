Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0606291051t567f7ccfod6acb4ac833dba03@mail.gmail.com>
Date: Thu, 29 Jun 2006 14:51:43 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060629170818.GB22212@pangeia.com.br>
MIME-Version: 1.0
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
	<43A78D40.7070209@xmission.com>
	<5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>
	<43A9B384.5040202@xmission.com>
	<20060628215123.GA17616@pangeia.com.br>
	<1151596908.14964.28.camel@localhost>
	<20060629170818.GB22212@pangeia.com.br>
Subject: Re: [Bluez-devel] pin_helper missing?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Nelson,

On 6/29/06, Nelson Murilo <nelson@pangeia.com.br> wrote:
> On Thu, Jun 29, 2006 at 06:01:48PM +0200, Marcel Holtmann wrote:
> > Hi Nelson,
>
> Hi Marcel,
>
> > you need to set the discoverable timeout to zero. Otherwise it will set
> > the device back to invisible at some point.
>
> How I do this without use gblueconf?  Sorry for this but I don=B4t found
> any info about it.

To read the current mode:
$dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez --print-reply
/org/bluez/hci0 org.bluez.Adapter.GetMode

To set a new value:
$dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez --print-reply
/org/bluez/hci0 org.bluez.Adapter.SetMode string:discoverable

To read the timeout value:
$dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez --print-reply
/org/bluez/hci0 org.bluez.Adapter.GetDiscoverableTimeout

To set a new value:
$dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez --print-reply
/org/bluez/hci0 org.bluez.Adapter.SetDiscoverableTimeout uint32:0
(for always visible or enter how many seconds you want)

Claudio.

>
> > They are created when you bind a device or connect a TTY.
>
> Great.
>
> > The PIN helper stuff is gone. We have the concept of passkey agents now.
>
> I will read the code, but if I=B4d like use different PINs for diffs devi=
ces?
>
>
> > I chose the new major version, because it breaks something.
>
> I agree.
>
> Best regards,
>
> ./nelson -murilo
>
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-- =

---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
