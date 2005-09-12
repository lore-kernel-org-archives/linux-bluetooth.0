Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050912140719fc9d3b@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus (Sig Fault)
In-Reply-To: <1126273252.5227.119.camel@blade>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_16129_3196289.1126559274452"
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126220839.5286.57.camel@blade>
	 <5256d0b050909012577fcb19c@mail.gmail.com>
	 <1126258645.5227.16.camel@blade>
	 <20050909132940.GE17543@spring.luon.net>
	 <1126273252.5227.119.camel@blade>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 12 Sep 2005 18:07:54 -0300

------=_Part_16129_3196289.1126559274452
Content-Type: multipart/alternative;
	boundary="----=_Part_16130_32952228.1126559274452"

------=_Part_16130_32952228.1126559274452
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I am sending a new patch that contains the following enhancements:
1. Support multiple D-Bus versions(0.23, 0.30...)=20
2. Fixed error handling ServiceDoesNotExist, NoReply, UnknownService, ...
This condition is causing sig fault due the wrong pin value. Scenario: D-Bu=
s=20
pin helper enabled=20
and an error different than wrong argument triggered.


Regards,
Claudio.

On 9/9/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Sjoerd,
>=20
> > > having 0.33 is better than 0.23 and this is what Debian unstable stil=
l
> > > uses. However lets make a list of the distributions:
> > >
> > > SuSE Linux 10.0 D-Bus 0.35
> > > Fedora Core 4 D-Bus 0.33
> > > Ubuntu Breezy D-Bus 0.36
> > > Debian unstable D-Bus 0.23
> > Debian experimental D-Bus 0.50
>=20
> this is good.
>=20
> > > The only bad guy is Debian unstable and I don't care anymore. They us=
e
> > > Xorg finally and have GCC 4.0 etc., but they can't move over to the=
=20
> next
> > > D-Bus generation. I think that is their problem now and the release o=
f
> > > bluez-utils-0.22 will definitely drop the support for the old D-Bus=
=20
> 0.23
> > > version.
> >
> > D-bus >=3D 0.3x has been in debian experimental for quite some time. Th=
ere=20
> are
> > various transitions going on in debian unstable currently which makes i=
t
> > inappropriate to do a dbus transition now too.
>=20
> Last time I looked at it, the complete KDE part was broken and full of
> wrong dependencies. So breaking D-Bus wouldn't even be notified ;)
>=20
> > > I like to base everything around the current D-Bus 0.50 release,=20
> because
> > > the C API should be quite stable now. I will accept small workarounds=
=20
> to
> > > make D-Bus 0.3x work, but as soon as the distributions update their
> > > D-Bus libraries I will drop them.
> > >
> > > This is not a nice thing to do, I know, but a wrong usage of D-Bus=20
> lets
> > > hcid segfault and this is not what I want.
> >
> > As one of debian's dbus maintainers i would advise to indeed base=20
> everything on
> > dbus >=3D 0.50. Hopefully it won't take too long before we can move the=
=20
> new dbus
> > from experimental to unstable, so the workarounds for old dbus release=
=20
> are just
> > not worth it.
>=20
> This means I will release bluez-utils-2.21 on the weekend, because of
> some memory leak fixes and then I will drop D-Bus 0.23 support. So if
> any patches need to go in before, please send them now.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_16130_32952228.1126559274452
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I am sending a new patch that contains the following enhancements:<br>
1. Support multiple D-Bus versions(0.23, 0.30...) <br>
2. Fixed error handling ServiceDoesNotExist, NoReply, UnknownService, ...<b=
r>
&nbsp;&nbsp; This condition is causing sig fault due the wrong pin value. S=
cenario: D-Bus pin helper enabled <br>
&nbsp;&nbsp; and an error different than wrong argument triggered.<br>
&nbsp;  <br>
<br>
Regards,<br>
Claudio.<br>
<br><div><span class=3D"gmail_quote">On 9/9/05, <b class=3D"gmail_sendernam=
e">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@ho=
ltmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
Hi Sjoerd,<br><br>&gt; &gt; having 0.33 is better than 0.23 and this is wha=
t Debian unstable still<br>&gt; &gt; uses. However lets make a list of the =
distributions:<br>&gt; &gt;<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; SuSE Linux=
 10.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-Bus=20
0.35<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Fedora Core 4&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-Bus 0.33<br>&gt; &gt;&nbsp;&nbsp=
;&nbsp;&nbsp; Ubuntu Breezy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; D-Bus 0.36<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Debian unstabl=
e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-Bus 0.23<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp; Debian experimental D-Bus 0.50<br><br>this is good.
<br><br>&gt; &gt; The only bad guy is Debian unstable and I don't care anym=
ore. They use<br>&gt; &gt; Xorg finally and have GCC 4.0 etc., but they can=
't move over to the next<br>&gt; &gt; D-Bus generation. I think that is the=
ir problem now and the release of
<br>&gt; &gt; bluez-utils-0.22 will definitely drop the support for the old=
 D-Bus 0.23<br>&gt; &gt; version.<br>&gt;<br>&gt; D-bus &gt;=3D 0.3x has be=
en in debian experimental for quite some time. There are<br>&gt; various tr=
ansitions going on in debian unstable currently which makes it
<br>&gt; inappropriate to do a dbus transition now too.<br><br>Last time I =
looked at it, the complete KDE part was broken and full of<br>wrong depende=
ncies. So breaking D-Bus wouldn't even be notified ;)<br><br>&gt; &gt; I li=
ke to base everything around the current D-Bus=20
0.50 release, because<br>&gt; &gt; the C API should be quite stable now. I =
will accept small workarounds to<br>&gt; &gt; make D-Bus 0.3x work, but as =
soon as the distributions update their<br>&gt; &gt; D-Bus libraries I will =
drop them.
<br>&gt; &gt;<br>&gt; &gt; This is not a nice thing to do, I know, but a wr=
ong usage of D-Bus lets<br>&gt; &gt; hcid segfault and this is not what I w=
ant.<br>&gt;<br>&gt; As one of debian's dbus maintainers i would advise to =
indeed base everything on
<br>&gt; dbus &gt;=3D 0.50. Hopefully it won't take too long before we can =
move the new dbus<br>&gt; from experimental to unstable, so the workarounds=
 for old dbus release are just<br>&gt; not worth it.<br><br>This means I wi=
ll release=20
bluez-utils-2.21 on the weekend, because of<br>some memory leak fixes and t=
hen I will drop D-Bus 0.23 support. So if<br>any patches need to go in befo=
re, please send them now.<br><br>Regards<br><br>Marcel<br><br><br><br><br>
-------------------------------------------------------<br>SF.Net email is =
Sponsored by the Better Software Conference &amp; EXPO<br>September 19-22, =
2005 * San Francisco, CA * Development Lifecycle Practices<br>Agile &amp; P=
lan-Driven Development * Managing Projects &amp; Teams * Testing &amp; QA
<br>Security * Process Improvement &amp; Measurement * <a href=3D"http://ww=
w.sqe.com/bsce5sf">http://www.sqe.com/bsce5sf</a><br>______________________=
_________________________<br>Bluez-devel mailing list<br><a href=3D"mailto:=
Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br>

------=_Part_16130_32952228.1126559274452--

------=_Part_16129_3196289.1126559274452
Content-Type: text/x-patch; name="hcid_dbus_0002.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid_dbus_0002.patch"

LS0tIGJsdWV6LXV0aWxzLTIuMjEub3JpZy9oY2lkL2RidXMtY29tcGF0LmgJMTk2OS0xMi0zMSAy
MTowMDowMC4wMDAwMDAwMDAgLTAzMDAKKysrIGJsdWV6LWhjaWQtMC4wLjMvaGNpZC9kYnVzLWNv
bXBhdC5oCTIwMDUtMDktMTIgMTY6NDI6MjIuMzgyNjMwMzc2IC0wMzAwCkBAIC0wLDAgKzEsMTE0
IEBACisvKgorICoKKyAqICBCbHVlWiAtIEJsdWV0b290aCBwcm90b2NvbCBzdGFjayBmb3IgTGlu
dXgKKyAqCisgKiAgQ29weXJpZ2h0IChDKSAyMDAwLTIwMDEgIFF1YWxjb21tIEluY29ycG9yYXRl
ZAorICogIENvcHlyaWdodCAoQykgMjAwMi0yMDAzICBNYXhpbSBLcmFzbnlhbnNreSA8bWF4a0Bx
dWFsY29tbS5jb20+CisgKiAgQ29weXJpZ2h0IChDKSAyMDAyLTIwMDUgIE1hcmNlbCBIb2x0bWFu
biA8bWFyY2VsQGhvbHRtYW5uLm9yZz4KKyAqCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9u
IDIgYXMKKyAqICBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsKKyAq
CisgKiAgVEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkg
T0YgQU5ZIEtJTkQsIEVYUFJFU1MKKyAqICBPUiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBM
SU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWSwKKyAqICBGSVRORVNT
IEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5UIE9GIFRISVJEIFBB
UlRZIFJJR0hUUy4KKyAqICBJTiBOTyBFVkVOVCBTSEFMTCBUSEUgQ09QWVJJR0hUIEhPTERFUihT
KSBBTkQgQVVUSE9SKFMpIEJFIExJQUJMRSBGT1IgQU5ZCisgKiAgQ0xBSU0sIE9SIEFOWSBTUEVD
SUFMIElORElSRUNUIE9SIENPTlNFUVVFTlRJQUwgREFNQUdFUywgT1IgQU5ZIERBTUFHRVMgCisg
KiAgV0hBVFNPRVZFUiBSRVNVTFRJTkcgRlJPTSBMT1NTIE9GIFVTRSwgREFUQSBPUiBQUk9GSVRT
LCBXSEVUSEVSIElOIEFOIAorICogIEFDVElPTiBPRiBDT05UUkFDVCwgTkVHTElHRU5DRSBPUiBP
VEhFUiBUT1JUSU9VUyBBQ1RJT04sIEFSSVNJTkcgT1VUIE9GIAorICogIE9SIElOIENPTk5FQ1RJ
T04gV0lUSCBUSEUgVVNFIE9SIFBFUkZPUk1BTkNFIE9GIFRISVMgU09GVFdBUkUuCisgKgorICog
IEFMTCBMSUFCSUxJVFksIElOQ0xVRElORyBMSUFCSUxJVFkgRk9SIElORlJJTkdFTUVOVCBPRiBB
TlkgUEFURU5UUywgCisgKiAgQ09QWVJJR0hUUywgVFJBREVNQVJLUyBPUiBPVEhFUiBSSUdIVFMs
IFJFTEFUSU5HIFRPIFVTRSBPRiBUSElTIAorICogIFNPRlRXQVJFIElTIERJU0NMQUlNRUQuCisg
KgorICoKKyAqICAkSWQ6IGRidXMtY29tcGF0LmgsdiAxLjI0IDIwMDUvMDkvMDggMTg6MzI6NDEg
aG9sdG1hbm4gRXhwICQKKyAqLworCisjaWZuZGVmIF9fSF9EQlVTX0NPTVBBVF9IX18KKyNkZWZp
bmUgX19IX0RCVVNfQ09NUEFUX0hfXworCisjaWZkZWYgSEFWRV9DT05GSUdfSAorI2luY2x1ZGUg
PGNvbmZpZy5oPgorI2VuZGlmCisKKyNkZWZpbmUgQ0hFQ0tfREJVU19WRVJTSU9OKG1ham9yLCBt
aW5vcikgXAorCQkoREJVU19NQUpPUl9WRVIgPiAobWFqb3IpIHx8IFwKKwkJIAkoREJVU19NQUpP
Ul9WRVIgPT0gKG1ham9yKSAmJiBEQlVTX01JTk9SX1ZFUiA+PSAobWlub3IpKSkKKwkKKyNpZiBD
SEVDS19EQlVTX1ZFUlNJT04oMCwgMzApCisJLyogRm9yIEQtQnVzIHZlcnNpb24gPj0gMC4zMCAq
LworCS8qKioqKiogcGVuZGluZywgcmVxdWlyZXMgY2huYWdlcyBpbiB0aGUgbWFrZWZpbGUgICoq
KioqLworI2Vsc2UgLyogPCAwLjMwICovCisJLyogRm9yIEQtQnVzIHZlcnNpb24gb2xkZXIgdGhh
biAwLjMwICovCisJCisjZW5kaWYKKworI2lmICBIQVZFX0RCVVNfTUVTU0FHRV9JVEVSX0dFVF9C
QVNJQworCSN3YXJuaW5nICJELUJ1cyA+IDAuMzAiCisJCisJLyogR2V0IGl0ZXJhdG9ycyAqLwor
CSNkZWZpbmUgREJVU19NU0dfSVRFUl9HRVRfU1RSKGl0ZXIsIHJldHZhcikgXAorCQkJZGJ1c19t
ZXNzYWdlX2l0ZXJfZ2V0X2Jhc2ljKChpdGVyKSwgJihyZXR2YXIpKQorCSNkZWZpbmUgREJVU19N
U0dfSVRFUl9HRVRfQllURShpdGVyLCByZXR2YXIpIFwKKwkJCWRidXNfbWVzc2FnZV9pdGVyX2dl
dF9iYXNpYygoaXRlciksICYocmV0dmFyKSkKKwkJCQorCS8qIEFwcGVuZCBpdGVyYXRvcnMgKi8K
KwkjZGVmaW5lIERCVVNfTVNHX0FQUEVORF9JVEVSX0lOSVQoYSwgYikgXAorCQkJZGJ1c19tZXNz
YWdlX2l0ZXJfaW5pdF9hcHBlbmQoYSwgYikJCisJI2RlZmluZSBEQlVTX01TR19JVEVSX0FQUEVO
RF9CWVRFKGl0ZXIsIHZhbCkgXAorCQkJZGJ1c19tZXNzYWdlX2l0ZXJfYXBwZW5kX2Jhc2ljKChp
dGVyKSwgREJVU19UWVBFX0JZVEUsICYodmFsKSkKKwkjZGVmaW5lIERCVVNfTVNHX0lURVJfQVBQ
RU5EX1NUUihpdGVyLCB2YWwpIFwKKwkJCWRidXNfbWVzc2FnZV9pdGVyX2FwcGVuZF9iYXNpYygo
aXRlciksIERCVVNfVFlQRV9TVFJJTkcsICYodmFsKSkKKwkjZGVmaW5lIERCVVNfTVNHX0lURVJf
QVBQRU5EX0JPT0woaXRlciwgdmFsKSBcCisJCQlkYnVzX21lc3NhZ2VfaXRlcl9hcHBlbmRfYmFz
aWMoKGl0ZXIpLCBEQlVTX1RZUEVfQk9PTEVBTiwgJih2YWwpKQorCSNkZWZpbmUgREJVU19NU0df
SVRFUl9BUFBFTkRfSU5UMzIoaXRlciwgdmFsKSBcCisJCQlkYnVzX21lc3NhZ2VfaXRlcl9hcHBl
bmRfYmFzaWMoKGl0ZXIpLCBEQlVTX1RZUEVfSU5UMzIsICYodmFsKSkKKwkjZGVmaW5lIERCVVNf
TVNHX0lURVJfQVBQRU5EX1VJTlQzMihpdGVyLCB2YWwpIFwKKwkJCWRidXNfbWVzc2FnZV9pdGVy
X2FwcGVuZF9iYXNpYygoaXRlciksIERCVVNfVFlQRV9VSU5UMzIsICYodmFsKSkKKworCWlubGlu
ZSB2b2lkIERCVVNfTVNHX0lURVJfQVBQRU5EX0JZVEVfQVJSQVkoREJ1c01lc3NhZ2VJdGVyICpp
dGVyLCB1aW50OF90ICpwdHIsIHVpbnQ4X3Qgc2l6ZSkgCisJeworCQlEQnVzTWVzc2FnZUl0ZXIg
YXJyYXlfaXRlcjsKKwkJY29uc3QgY2hhciBhcnJheV9zaWdbXSA9IERCVVNfVFlQRV9CWVRFX0FT
X1NUUklORzsKKwkJaW50IGk7CisJCQorCQlkYnVzX21lc3NhZ2VfaXRlcl9vcGVuX2NvbnRhaW5l
cihpdGVyLCBEQlVTX1RZUEVfQVJSQVksIGFycmF5X3NpZywgJmFycmF5X2l0ZXIpOworCQlmb3Ig
KCBpID0gMDsgaSA8IHNpemU7IGkrKyApIHsKKwkJCURCVVNfTVNHX0lURVJfQVBQRU5EX0JZVEUo
JmFycmF5X2l0ZXIsIHB0cik7CisJCX0KKwkJZGJ1c19tZXNzYWdlX2l0ZXJfY2xvc2VfY29udGFp
bmVyKGl0ZXIsICZhcnJheV9pdGVyKTsKKwl9CisjZWxzZQorCSN3YXJuaW5nICJELUJ1cyA8IDAu
MzAiCisJCisJLyogR2V0IGl0ZXJhdG9ycyAqLworCSNkZWZpbmUgREJVU19NU0dfSVRFUl9HRVRf
U1RSKGl0ZXIsIHJldHZhcikgXAorCQkJcmV0dmFyID0gZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X3N0
cmluZyhpdGVyKQorCSNkZWZpbmUgREJVU19NU0dfSVRFUl9HRVRfQllURShpdGVyLCByZXR2YXIp
IFwKKwkJCXJldHZhciA9IGRidXNfbWVzc2FnZV9pdGVyX2dldF9ieXRlKGl0ZXIpCisJCQkKKwkv
KiBBcHBlbmQgaXRlcmF0b3JzICovCisJI2RlZmluZSBEQlVTX01TR19BUFBFTkRfSVRFUl9JTklU
KGEsIGIpIFwKKwkJCWRidXNfbWVzc2FnZV9hcHBlbmRfaXRlcl9pbml0KGEsIGIpCisJI2RlZmlu
ZSBEQlVTX01TR19JVEVSX0FQUEVORF9CWVRFKGl0ZXIsIHZhbCkgXAorCQkJZGJ1c19tZXNzYWdl
X2l0ZXJfYXBwZW5kX2J5dGUoKGl0ZXIpLCAodmFsKSkKKwkjZGVmaW5lIERCVVNfTVNHX0lURVJf
QVBQRU5EX1NUUihpdGVyLCB2YWwpIFwKKwkJCWRidXNfbWVzc2FnZV9pdGVyX2FwcGVuZF9zdHJp
bmcoKGl0ZXIpLCAodmFsKSkKKwkjZGVmaW5lIERCVVNfTVNHX0lURVJfQVBQRU5EX0JPT0woaXRl
ciwgdmFsKSBcCisJCQlkYnVzX21lc3NhZ2VfaXRlcl9hcHBlbmRfYm9vbGVhbigoaXRlciksICh2
YWwpKQorCSNkZWZpbmUgREJVU19NU0dfSVRFUl9BUFBFTkRfSU5UMzIoaXRlciwgdmFsKSBcCisJ
CQlkYnVzX21lc3NhZ2VfaXRlcl9hcHBlbmRfaW50MzIoKGl0ZXIpLCAodmFsKSkKKwkjZGVmaW5l
IERCVVNfTVNHX0lURVJfQVBQRU5EX1VJTlQzMihpdGVyLCB2YWwpIFwKKwkJCWRidXNfbWVzc2Fn
ZV9pdGVyX2FwcGVuZF91aW50MzIoKGl0ZXIpLCAodmFsKSkKKwkjZGVmaW5lIERCVVNfTVNHX0lU
RVJfQVBQRU5EX0JZVEVfQVJSQVkoaXRlciwgdmFsLCBzaXplKSBcCisJCWRidXNfbWVzc2FnZV9p
dGVyX2FwcGVuZF9ieXRlX2FycmF5KGl0ZXIsIHZhbCwgc2l6ZSkKKworI2VuZGlmCisKKworCisj
ZW5kaWYgLypfX0hfREJVU19DT01QQVRfSF9fKi8KLS0tIGJsdWV6LXV0aWxzLTIuMjEub3JpZy9o
Y2lkL2RidXMuYwkyMDA1LTA4LTI3IDEwOjM3OjE0LjAwMDAwMDAwMCAtMDMwMAorKysgYmx1ZXot
aGNpZC0wLjAuMy9oY2lkL2RidXMuYwkyMDA1LTA5LTEyIDE3OjE5OjQ0LjM2Mjc5NzU4NCAtMDMw
MApAQCAtNDUsMTUgKzQ1LDIwIEBACiAjaW5jbHVkZSAiZ2xpYi1lY3RvbXkuaCIKIAogI2luY2x1
ZGUgImhjaWQuaCIKKyNpbmNsdWRlICJkYnVzLWNvbXBhdC5oIgogCiBzdGF0aWMgREJ1c0Nvbm5l
Y3Rpb24gKmNvbm5lY3Rpb247CiAKICNkZWZpbmUgVElNRU9VVCAoMzAgKiAxMDAwKQkJLyogMzAg
c2Vjb25kcyAqLwogCi0jZGVmaW5lIFNFUlZJQ0VfTkFNRSAib3JnLmJsdWV6LlBpbkFnZW50Igot
I2RlZmluZSBJTlRFUkZBQ0VfTkFNRSBTRVJWSUNFX05BTUUKLSNkZWZpbmUgUkVRVUVTVF9OQU1F
ICJQaW5SZXF1ZXN0IgotI2RlZmluZSBQQVRIX05BTUUgIi9vcmcvYmx1ZXovUGluQWdlbnQiCisj
ZGVmaW5lIFBJTkFHRU5UX0RCVVNfU0VSVklDRQkJIm9yZy5ibHVlei5QaW5BZ2VudCIKKyNkZWZp
bmUgUElOQUdFTlRfREJVU19JTlRFUkZBQ0UgCVBJTkFHRU5UX0RCVVNfU0VSVklDRQorI2RlZmlu
ZSBQSU5BR0VOVF9EQlVTX1NWQ19OQU1FX1JFUSAJCSJQaW5SZXF1ZXN0IgorI2RlZmluZSBQSU5B
R0VOVF9EQlVTX1BBVEggCQkJIi9vcmcvYmx1ZXovUGluQWdlbnQiCisKKyNkZWZpbmUgSENJX0RC
VVNfU0VSVklDRQkJIm9yZy5ibHVlei5ibHVldG9vdGhkLmhjaSIKKyNkZWZpbmUgSENJX0RCVVNf
SU5URVJGQUNFCQlIQ0lfREJVU19TRVJWSUNFCisjZGVmaW5lIEhDSV9EQlVTX1BBVEgJCQkiL29y
Zy9ibHVlei9ibHVldG9vdGhkL2hjaSIKIAogI2RlZmluZSBXUk9OR19BUkdTX0VSUk9SICJvcmcu
Ymx1ZXouRXJyb3IuV3JvbmdBcmdzIgogCkBAIC02OCwyNiArNzMsMzQgQEAKIAlwaW5fY29kZV9y
ZXBseV9jcCBwcjsKIAlEQnVzTWVzc2FnZSAqbWVzc2FnZTsKIAlEQnVzTWVzc2FnZUl0ZXIgaXRl
cjsKLQlpbnQgdHlwZTsKKwlpbnQgYXJnX3R5cGU7CisJaW50IG1zZ190eXBlOwogCXNpemVfdCBs
ZW47CiAJY2hhciAqcGluOworCWNvbnN0IGNoYXIgKmVycm9yX21zZzsKIAogCW1lc3NhZ2UgPSBk
YnVzX3BlbmRpbmdfY2FsbF9zdGVhbF9yZXBseShjYWxsKTsKKwltc2dfdHlwZSA9IGRidXNfbWVz
c2FnZV9nZXRfdHlwZShtZXNzYWdlKTsKKwlkYnVzX21lc3NhZ2VfaXRlcl9pbml0KG1lc3NhZ2Us
ICZpdGVyKTsKIAotCWlmIChkYnVzX21lc3NhZ2VfaXNfZXJyb3IobWVzc2FnZSwgV1JPTkdfQVJH
U19FUlJPUikpCi0JCWdvdG8gZXJyb3I7CisJaWYobXNnX3R5cGUgPT0gREJVU19NRVNTQUdFX1RZ
UEVfRVJST1IpIHsKKwkJREJVU19NU0dfSVRFUl9HRVRfU1RSKCZpdGVyLCBlcnJvcl9tc2cpOwor
CQkvKiBoYW5kbGluZyBXUk9OR19BUkdTX0VSUk9SLCBEQlVTX0VSUk9SX05PX1JFUExZLCBEQlVT
X0VSUk9SX1NFUlZJQ0VfVU5LTk9XTiAqLworCQlzeXNsb2coTE9HX0VSUiwgIiVzOiAlcyIsIGRi
dXNfbWVzc2FnZV9nZXRfZXJyb3JfbmFtZShtZXNzYWdlKSwgZXJyb3JfbXNnKTsKIAotCWRidXNf
bWVzc2FnZV9pdGVyX2luaXQobWVzc2FnZSwgJml0ZXIpOworCQloY2lfc2VuZF9jbWQocmVxLT5k
ZXYsIE9HRl9MSU5LX0NUTCwKKwkJCSAgICAgT0NGX1BJTl9DT0RFX05FR19SRVBMWSwgNiwgJnJl
cS0+YmRhKTsKKwl9IGVsc2UgeworCQkvKiBjaGVjayBzaWduYXR1cmUgKi8KKwkJYXJnX3R5cGUg
PSBkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYXJnX3R5cGUoJml0ZXIpOwkKKwkJaWYgKGFyZ190eXBl
ICE9IERCVVNfVFlQRV9TVFJJTkcpIHsKKwkJCXN5c2xvZyhMT0dfRVJSLCAiV3JvbmcgcmVwbHkg
c2lnbmF0dXJlOiBleHBlY3RlZCBQSU4iKTsKIAotCXR5cGUgPSBkYnVzX21lc3NhZ2VfaXRlcl9n
ZXRfYXJnX3R5cGUoJml0ZXIpOwotCWlmICh0eXBlICE9IERCVVNfVFlQRV9TVFJJTkcpCi0JCWdv
dG8gZXJyb3I7Ci0KLSNpZmRlZiBIQVZFX0RCVVNfTUVTU0FHRV9JVEVSX0dFVF9CQVNJQwotCWRi
dXNfbWVzc2FnZV9pdGVyX2dldF9iYXNpYygmaXRlciwgJnBpbik7Ci0jZWxzZQotCXBpbiA9IGRi
dXNfbWVzc2FnZV9pdGVyX2dldF9zdHJpbmcoJml0ZXIpOwotI2VuZGlmCisJCQloY2lfc2VuZF9j
bWQocmVxLT5kZXYsIE9HRl9MSU5LX0NUTCwKKwkJCQkgICAgIE9DRl9QSU5fQ09ERV9ORUdfUkVQ
TFksIDYsICZyZXEtPmJkYSk7CisJCX0gZWxzZSB7CisJCQorCQkJREJVU19NU0dfSVRFUl9HRVRf
U1RSKCZpdGVyLCBwaW4pOwogCiAJbGVuID0gc3RybGVuKHBpbik7CiAKQEAgLTk3LDE1ICsxMTAs
MTIgQEAKIAlwci5waW5fbGVuID0gbGVuOwogCWhjaV9zZW5kX2NtZChyZXEtPmRldiwgT0dGX0xJ
TktfQ1RMLCBPQ0ZfUElOX0NPREVfUkVQTFksCiAJCQkJCQlQSU5fQ09ERV9SRVBMWV9DUF9TSVpF
LCAmcHIpOworCQl9CisKKwl9CiAKIAlkYnVzX21lc3NhZ2VfdW5yZWYobWVzc2FnZSk7CiAJZGJ1
c19wZW5kaW5nX2NhbGxfdW5yZWYoY2FsbCk7Ci0KLQlyZXR1cm47Ci0KLWVycm9yOgotCWhjaV9z
ZW5kX2NtZChyZXEtPmRldiwgT0dGX0xJTktfQ1RMLAotCQkJCU9DRl9QSU5fQ09ERV9ORUdfUkVQ
TFksIDYsICZyZXEtPmJkYSk7CiB9CiAKIHN0YXRpYyB2b2lkIGZyZWVfcGluX3JlcSh2b2lkICpy
ZXEpCkBAIC0xMTYsMTYgKzEyNiwxMyBAQAogdm9pZCBoY2lkX2RidXNfcmVxdWVzdF9waW4oaW50
IGRldiwgc3RydWN0IGhjaV9jb25uX2luZm8gKmNpKQogewogCURCdXNNZXNzYWdlICptZXNzYWdl
OwotI2lmZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JBU0lDCiAJdWludDhfdCAqYWRk
ciA9ICh1aW50OF90ICopICZjaS0+YmRhZGRyOwotI2Vsc2UKIAlEQnVzTWVzc2FnZUl0ZXIgaXRl
cjsKLSNlbmRpZgogCURCdXNQZW5kaW5nQ2FsbCAqcGVuZGluZyA9IE5VTEw7CiAJc3RydWN0IHBp
bl9yZXF1ZXN0ICpyZXE7CiAKLQltZXNzYWdlID0gZGJ1c19tZXNzYWdlX25ld19tZXRob2RfY2Fs
bChTRVJWSUNFX05BTUUsIFBBVEhfTkFNRSwKLQkJCQkJCUlOVEVSRkFDRV9OQU1FLCBSRVFVRVNU
X05BTUUpOworCW1lc3NhZ2UgPSBkYnVzX21lc3NhZ2VfbmV3X21ldGhvZF9jYWxsKFBJTkFHRU5U
X0RCVVNfU0VSVklDRSwgUElOQUdFTlRfREJVU19QQVRILAorCQkJCQkJUElOQUdFTlRfREJVU19J
TlRFUkZBQ0UsIFBJTkFHRU5UX0RCVVNfU1ZDX05BTUVfUkVRKTsKIAlpZiAobWVzc2FnZSA9PSBO
VUxMKSB7CiAJCXN5c2xvZyhMT0dfRVJSLCAiQ291bGRuJ3QgYWxsb2NhdGUgRC1CVVMgbWVzc2Fn
ZSIpOwogCQlnb3RvIGZhaWxlZDsKQEAgLTEzNSwxNyArMTQyLDkgQEAKIAlyZXEtPmRldiA9IGRl
djsKIAliYWNweSgmcmVxLT5iZGEsICZjaS0+YmRhZGRyKTsKIAotI2lmZGVmIEhBVkVfREJVU19N
RVNTQUdFX0lURVJfR0VUX0JBU0lDCi0JZGJ1c19tZXNzYWdlX2FwcGVuZF9hcmdzKG1lc3NhZ2Us
IERCVVNfVFlQRV9CT09MRUFOLCAmY2ktPm91dCwKLQkJCURCVVNfVFlQRV9BUlJBWSwgREJVU19U
WVBFX0JZVEUsCi0JCQkmYWRkciwgc2l6ZW9mKGJkYWRkcl90KSwgREJVU19UWVBFX0lOVkFMSUQp
OwotI2Vsc2UKLQlkYnVzX21lc3NhZ2VfYXBwZW5kX2l0ZXJfaW5pdChtZXNzYWdlLCAmaXRlcik7
Ci0KLQlkYnVzX21lc3NhZ2VfaXRlcl9hcHBlbmRfYm9vbGVhbigmaXRlciwgY2ktPm91dCk7Ci0J
ZGJ1c19tZXNzYWdlX2l0ZXJfYXBwZW5kX2J5dGVfYXJyYXkoJml0ZXIsCi0JCQkodW5zaWduZWQg
Y2hhciAqKSAmY2ktPmJkYWRkciwgc2l6ZW9mKGNpLT5iZGFkZHIpKTsKLSNlbmRpZgorCURCVVNf
TVNHX0FQUEVORF9JVEVSX0lOSVQobWVzc2FnZSwgJml0ZXIpOworCURCVVNfTVNHX0lURVJfQVBQ
RU5EX0JPT0woJml0ZXIsIGNpLT5vdXQpOworCURCVVNfTVNHX0lURVJfQVBQRU5EX0JZVEVfQVJS
QVkoJml0ZXIsIGFkZHIsIHNpemVvZihiZGFkZHJfdCkpOwogCiAJaWYgKGRidXNfY29ubmVjdGlv
bl9zZW5kX3dpdGhfcmVwbHkoY29ubmVjdGlvbiwgbWVzc2FnZSwKIAkJCQkJJnBlbmRpbmcsIFRJ
TUVPVVQpID09IEZBTFNFKSB7CkBAIC0xNzEsMzAgKzE3MCwyMSBAQAogdm9pZCBoY2lkX2RidXNf
aW5xdWlyeV9zdGFydChiZGFkZHJfdCAqbG9jYWwpCiB7CiAJREJ1c01lc3NhZ2UgKm1lc3NhZ2U7
Ci0jaWZuZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JBU0lDCiAJREJ1c01lc3NhZ2VJ
dGVyIGl0ZXI7Ci0jZW5kaWYKIAljaGFyICpsb2NhbF9hZGRyOwkKIAliZGFkZHJfdCB0bXA7CiAK
IAliYXN3YXAoJnRtcCwgbG9jYWwpOyBsb2NhbF9hZGRyID0gYmF0b3N0cigmdG1wKTsKIAotCW1l
c3NhZ2UgPSBkYnVzX21lc3NhZ2VfbmV3X3NpZ25hbCgiL29yZy9ibHVlei9EZXZBZ2VudCIsCi0J
CQkJIm9yZy5ibHVlei5EZXZBZ2VudCIsICJJbnF1aXJ5U3RhcnQiKTsKKwltZXNzYWdlID0gZGJ1
c19tZXNzYWdlX25ld19zaWduYWwoSENJX0RCVVNfUEFUSCwKKwkJCQlIQ0lfREJVU19JTlRFUkZB
Q0UsICJJbnF1aXJ5U3RhcnQiKTsKIAlpZiAobWVzc2FnZSA9PSBOVUxMKSB7CiAJCXN5c2xvZyhM
T0dfRVJSLCAiQ2FuJ3QgYWxsb2NhdGUgRC1CVVMgaW5xdWlyeSBzdGFydCBtZXNzYWdlIik7CiAJ
CWdvdG8gZmFpbGVkOwogCX0KIAotI2lmZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JB
U0lDCi0JZGJ1c19tZXNzYWdlX2FwcGVuZF9hcmdzKG1lc3NhZ2UsCi0JCQkJCURCVVNfVFlQRV9T
VFJJTkcsICZsb2NhbF9hZGRyLAotCQkJCQlEQlVTX1RZUEVfSU5WQUxJRCk7Ci0jZWxzZQotCWRi
dXNfbWVzc2FnZV9hcHBlbmRfaXRlcl9pbml0KG1lc3NhZ2UsICZpdGVyKTsKLQotCWRidXNfbWVz
c2FnZV9pdGVyX2FwcGVuZF9zdHJpbmcoJml0ZXIsIGxvY2FsX2FkZHIpOwotI2VuZGlmCisJREJV
U19NU0dfQVBQRU5EX0lURVJfSU5JVChtZXNzYWdlLCAmaXRlcik7CisJREJVU19NU0dfSVRFUl9B
UFBFTkRfU1RSKCZpdGVyLCBsb2NhbF9hZGRyKTsKIAogCWlmIChkYnVzX2Nvbm5lY3Rpb25fc2Vu
ZChjb25uZWN0aW9uLCBtZXNzYWdlLCBOVUxMKSA9PSBGQUxTRSkgewogCQlzeXNsb2coTE9HX0VS
UiwgIkNhbid0IHNlbmQgRC1CVVMgaW5xdWlyeSBzdGFydCBtZXNzYWdlIik7CkBAIC0yMTQsMzAg
KzIwNCwyMSBAQAogdm9pZCBoY2lkX2RidXNfaW5xdWlyeV9jb21wbGV0ZShiZGFkZHJfdCAqbG9j
YWwpCiB7CiAJREJ1c01lc3NhZ2UgKm1lc3NhZ2U7Ci0jaWZuZGVmIEhBVkVfREJVU19NRVNTQUdF
X0lURVJfR0VUX0JBU0lDCiAJREJ1c01lc3NhZ2VJdGVyIGl0ZXI7Ci0jZW5kaWYKIAljaGFyICps
b2NhbF9hZGRyOwogCWJkYWRkcl90IHRtcDsKIAogCWJhc3dhcCgmdG1wLCBsb2NhbCk7IGxvY2Fs
X2FkZHIgPSBiYXRvc3RyKCZ0bXApOwogCi0JbWVzc2FnZSA9IGRidXNfbWVzc2FnZV9uZXdfc2ln
bmFsKCIvb3JnL2JsdWV6L0RldkFnZW50IiwKLQkJCQkib3JnLmJsdWV6LkRldkFnZW50IiwgIklu
cXVpcnlDb21wbGV0ZSIpOworCW1lc3NhZ2UgPSBkYnVzX21lc3NhZ2VfbmV3X3NpZ25hbChIQ0lf
REJVU19QQVRILAorCQkJCUhDSV9EQlVTX0lOVEVSRkFDRSwgIklucXVpcnlDb21wbGV0ZSIpOwog
CWlmIChtZXNzYWdlID09IE5VTEwpIHsKIAkJc3lzbG9nKExPR19FUlIsICJDYW4ndCBhbGxvY2F0
ZSBELUJVUyBpbnF1aXJ5IGNvbXBsZXRlIG1lc3NhZ2UiKTsKIAkJZ290byBmYWlsZWQ7CiAJfQog
Ci0jaWZkZWYgSEFWRV9EQlVTX01FU1NBR0VfSVRFUl9HRVRfQkFTSUMKLQlkYnVzX21lc3NhZ2Vf
YXBwZW5kX2FyZ3MobWVzc2FnZSwKLQkJCQkJREJVU19UWVBFX1NUUklORywgJmxvY2FsX2FkZHIs
Ci0JCQkJCURCVVNfVFlQRV9JTlZBTElEKTsKLSNlbHNlCi0JZGJ1c19tZXNzYWdlX2FwcGVuZF9p
dGVyX2luaXQobWVzc2FnZSwgJml0ZXIpOwotCi0JZGJ1c19tZXNzYWdlX2l0ZXJfYXBwZW5kX3N0
cmluZygmaXRlciwgbG9jYWxfYWRkcik7Ci0jZW5kaWYKKwlEQlVTX01TR19BUFBFTkRfSVRFUl9J
TklUKG1lc3NhZ2UsICZpdGVyKTsKKwlEQlVTX01TR19JVEVSX0FQUEVORF9TVFIoJml0ZXIsIGxv
Y2FsX2FkZHIpOwogCiAJaWYgKGRidXNfY29ubmVjdGlvbl9zZW5kKGNvbm5lY3Rpb24sIG1lc3Nh
Z2UsIE5VTEwpID09IEZBTFNFKSB7CiAJCXN5c2xvZyhMT0dfRVJSLCAiQ2FuJ3Qgc2VuZCBELUJV
UyBpbnF1aXJ5IGNvbXBsZXRlIG1lc3NhZ2UiKTsKQEAgLTI1NywzNyArMjM4LDI1IEBACiB2b2lk
IGhjaWRfZGJ1c19pbnF1aXJ5X3Jlc3VsdChiZGFkZHJfdCAqbG9jYWwsIGJkYWRkcl90ICpwZWVy
LCB1aW50MzJfdCBjbGFzcywgaW50OF90IHJzc2kpCiB7CiAJREJ1c01lc3NhZ2UgKm1lc3NhZ2U7
Ci0jaWZuZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JBU0lDCiAJREJ1c01lc3NhZ2VJ
dGVyIGl0ZXI7Ci0jZW5kaWYKIAljaGFyICpsb2NhbF9hZGRyLCAqcGVlcl9hZGRyOwogCWJkYWRk
cl90IHRtcDsKIAogCWJhc3dhcCgmdG1wLCBsb2NhbCk7IGxvY2FsX2FkZHIgPSBiYXRvc3RyKCZ0
bXApOwogCWJhc3dhcCgmdG1wLCBwZWVyKTsgcGVlcl9hZGRyID0gYmF0b3N0cigmdG1wKTsKIAot
CW1lc3NhZ2UgPSBkYnVzX21lc3NhZ2VfbmV3X3NpZ25hbCgiL29yZy9ibHVlei9EZXZBZ2VudCIs
Ci0JCQkJIm9yZy5ibHVlei5EZXZBZ2VudCIsICJJbnF1aXJ5UmVzdWx0Iik7CisJbWVzc2FnZSA9
IGRidXNfbWVzc2FnZV9uZXdfc2lnbmFsKEhDSV9EQlVTX1BBVEgsCisJCQkJSENJX0RCVVNfSU5U
RVJGQUNFLCAiSW5xdWlyeVJlc3VsdCIpOwogCWlmIChtZXNzYWdlID09IE5VTEwpIHsKIAkJc3lz
bG9nKExPR19FUlIsICJDYW4ndCBhbGxvY2F0ZSBELUJVUyBpbnF1aXJ5IHJlc3VsdCBtZXNzYWdl
Iik7CiAJCWdvdG8gZmFpbGVkOwogCX0KIAotI2lmZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJf
R0VUX0JBU0lDCi0JZGJ1c19tZXNzYWdlX2FwcGVuZF9hcmdzKG1lc3NhZ2UsCi0JCQkJCURCVVNf
VFlQRV9TVFJJTkcsICZsb2NhbF9hZGRyLAotCQkJCQlEQlVTX1RZUEVfU1RSSU5HLCAmcGVlcl9h
ZGRyLAotCQkJCQlEQlVTX1RZUEVfVUlOVDMyLCAmY2xhc3MsCi0JCQkJCURCVVNfVFlQRV9JTlQz
MiwgJnJzc2ksCi0JCQkJCURCVVNfVFlQRV9JTlZBTElEKTsKLSNlbHNlCi0JZGJ1c19tZXNzYWdl
X2FwcGVuZF9pdGVyX2luaXQobWVzc2FnZSwgJml0ZXIpOwotCi0JZGJ1c19tZXNzYWdlX2l0ZXJf
YXBwZW5kX3N0cmluZygmaXRlciwgbG9jYWxfYWRkcik7Ci0JZGJ1c19tZXNzYWdlX2l0ZXJfYXBw
ZW5kX3N0cmluZygmaXRlciwgcGVlcl9hZGRyKTsKLQlkYnVzX21lc3NhZ2VfaXRlcl9hcHBlbmRf
dWludDMyKCZpdGVyLCBjbGFzcyk7Ci0JZGJ1c19tZXNzYWdlX2l0ZXJfYXBwZW5kX2ludDMyKCZp
dGVyLCByc3NpKTsKLSNlbmRpZgorCURCVVNfTVNHX0FQUEVORF9JVEVSX0lOSVQobWVzc2FnZSwg
Jml0ZXIpOworCURCVVNfTVNHX0lURVJfQVBQRU5EX1NUUigmaXRlciwgbG9jYWxfYWRkcik7CisJ
REJVU19NU0dfSVRFUl9BUFBFTkRfU1RSKCZpdGVyLCBwZWVyX2FkZHIpOworCURCVVNfTVNHX0lU
RVJfQVBQRU5EX1VJTlQzMigmaXRlciwgY2xhc3MpOworCURCVVNfTVNHX0lURVJfQVBQRU5EX0lO
VDMyKCZpdGVyLCByc3NpKTsKIAogCWlmIChkYnVzX2Nvbm5lY3Rpb25fc2VuZChjb25uZWN0aW9u
LCBtZXNzYWdlLCBOVUxMKSA9PSBGQUxTRSkgewogCQlzeXNsb2coTE9HX0VSUiwgIkNhbid0IHNl
bmQgRC1CVVMgaW5xdWlyeSByZXN1bHQgbWVzc2FnZSIpOwpAQCAtMzA4LDM1ICsyNzcsMjQgQEAK
IHZvaWQgaGNpZF9kYnVzX3JlbW90ZV9uYW1lKGJkYWRkcl90ICpsb2NhbCwgYmRhZGRyX3QgKnBl
ZXIsIGNoYXIgKm5hbWUpCiB7CiAJREJ1c01lc3NhZ2UgKm1lc3NhZ2U7Ci0jaWZuZGVmIEhBVkVf
REJVU19NRVNTQUdFX0lURVJfR0VUX0JBU0lDCiAJREJ1c01lc3NhZ2VJdGVyIGl0ZXI7Ci0jZW5k
aWYKIAljaGFyICpsb2NhbF9hZGRyLCAqcGVlcl9hZGRyOwogCWJkYWRkcl90IHRtcDsKIAogCWJh
c3dhcCgmdG1wLCBsb2NhbCk7IGxvY2FsX2FkZHIgPSBiYXRvc3RyKCZ0bXApOwogCWJhc3dhcCgm
dG1wLCBwZWVyKTsgcGVlcl9hZGRyID0gYmF0b3N0cigmdG1wKTsKIAotCW1lc3NhZ2UgPSBkYnVz
X21lc3NhZ2VfbmV3X3NpZ25hbCgiL29yZy9ibHVlei9EZXZBZ2VudCIsCi0JCQkJIm9yZy5ibHVl
ei5EZXZBZ2VudCIsICJSZW1vdGVOYW1lIik7CisJbWVzc2FnZSA9IGRidXNfbWVzc2FnZV9uZXdf
c2lnbmFsKEhDSV9EQlVTX1BBVEgsCisJCQkJSENJX0RCVVNfSU5URVJGQUNFLCAiUmVtb3RlTmFt
ZSIpOwogCWlmIChtZXNzYWdlID09IE5VTEwpIHsKIAkJc3lzbG9nKExPR19FUlIsICJDYW4ndCBh
bGxvY2F0ZSBELUJVUyByZW1vdGUgbmFtZSBtZXNzYWdlIik7CiAJCWdvdG8gZmFpbGVkOwogCX0K
IAotI2lmZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JBU0lDCi0JZGJ1c19tZXNzYWdl
X2FwcGVuZF9hcmdzKG1lc3NhZ2UsCi0JCQkJCURCVVNfVFlQRV9TVFJJTkcsICZsb2NhbF9hZGRy
LAotCQkJCQlEQlVTX1RZUEVfU1RSSU5HLCAmcGVlcl9hZGRyLAotCQkJCQlEQlVTX1RZUEVfU1RS
SU5HLCAmbmFtZSwKLQkJCQkJREJVU19UWVBFX0lOVkFMSUQpOwotI2Vsc2UKLQlkYnVzX21lc3Nh
Z2VfYXBwZW5kX2l0ZXJfaW5pdChtZXNzYWdlLCAmaXRlcik7Ci0KLQlkYnVzX21lc3NhZ2VfaXRl
cl9hcHBlbmRfc3RyaW5nKCZpdGVyLCBsb2NhbF9hZGRyKTsKLQlkYnVzX21lc3NhZ2VfaXRlcl9h
cHBlbmRfc3RyaW5nKCZpdGVyLCBwZWVyX2FkZHIpOwotCWRidXNfbWVzc2FnZV9pdGVyX2FwcGVu
ZF9zdHJpbmcoJml0ZXIsIG5hbWUpOwotI2VuZGlmCisJREJVU19NU0dfQVBQRU5EX0lURVJfSU5J
VChtZXNzYWdlLCAmaXRlcik7CisJREJVU19NU0dfSVRFUl9BUFBFTkRfU1RSKCZpdGVyLCBsb2Nh
bF9hZGRyKTsKKwlEQlVTX01TR19JVEVSX0FQUEVORF9TVFIoJml0ZXIsIHBlZXJfYWRkcik7CisJ
REJVU19NU0dfSVRFUl9BUFBFTkRfU1RSKCZpdGVyLCBuYW1lKTsKIAogCWlmIChkYnVzX2Nvbm5l
Y3Rpb25fc2VuZChjb25uZWN0aW9uLCBtZXNzYWdlLCBOVUxMKSA9PSBGQUxTRSkgewogCQlzeXNs
b2coTE9HX0VSUiwgIkNhbid0IHNlbmQgRC1CVVMgcmVtb3RlIG5hbWUgbWVzc2FnZSIpOwo=
------=_Part_16129_3196289.1126559274452--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
