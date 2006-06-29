Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 28 Jun 2006 22:03:46 -0300
From: Nelson Murilo <nelson@pangeia.com.br>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060629010346.GA19436@pangeia.com.br>
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
	<43A78D40.7070209@xmission.com>
	<5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>
	<43A9B384.5040202@xmission.com>
	<20060628215123.GA17616@pangeia.com.br>
	<e1effdeb0606281505q5d511234ib20a8d78e4fe71b3@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <e1effdeb0606281505q5d511234ib20a8d78e4fe71b3@mail.gmail.com>
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


Thanks a lot Claudio, but both has the same problem: Don't return the
prompt, and I have use ^C to stop. =


I tried update cvs again and nothing changed.

Regards,

./nelson -murilo

On Wed, Jun 28, 2006 at 07:05:55PM -0300, Claudio Takahasi wrote:
> Hi Nelson,
> =

> There is a simple passkey agent available. You can find it inside the
> "hcid" directory.
> try:
> $passkey-agent --default <PIN>
> =

> or use the following application that I developed for testing purpose:
> http://extindt01.indt.org/connectivity/bluez/gbluezconf-00.30.tar.gz
> =

> BR,
> Claudio.
> =

> -- =

> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
> =

> =

> On 6/28/06, Nelson Murilo <nelson@pangeia.com.br> wrote:
> >
> >
> > After update bluez tree (doc, obex, lib, hcidump and utils), hcid.conf
> > don=B4t have pin_helper any more. Others odds:
> > 1) device is ative, but not visible for any other bluetooth devices.
> > 2) /dev/rfcomm* missing
> > 3) if I try connect other device I get: Can't connect RFCOMM socket: Co=
nnection refused
> >
> > Looking at debug.log I found:
> > Jun 28 18:39:45 localhost hcid[4364]: call_passkey_agent(): no agent re=
gistered
> >
> > Info:
> > Kernel 2.6.17-mh1
> > dbus 0.62-3
> >
> > Any hits?
> >
> > PS: All works fine before update
> >
> > Using Tomcat but need to do more? Need to support web services, securit=
y?
> > Get stuff done quickly with pre-integrated technology to make your job =
easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> =

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
