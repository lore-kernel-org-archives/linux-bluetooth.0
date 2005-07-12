Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05071210071d7d599a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] pand D-Bus service
In-Reply-To: <1121117212.5934.34.camel@notepaq>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_401_7949755.1121188070570"
References: <e1effdeb05070811375af87810@mail.gmail.com>
	 <1120849681.7444.1.camel@notepaq>
	 <e1effdeb050711115470809e4a@mail.gmail.com>
	 <1121110034.5934.24.camel@notepaq>
	 <e1effdeb05071113164320e725@mail.gmail.com>
	 <1121117212.5934.34.camel@notepaq>
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
Date: Tue, 12 Jul 2005 14:07:50 -0300

------=_Part_401_7949755.1121188070570
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

The latest patch is available in the address below:

http://www.indt.org.br/maemo/zeroconf/bluez/bluez-dbus-patch-00.04
http://www.indt.org.br/maemo/zeroconf/bluez/libbluezdbus-0.2.tar.gz
Dependencies: dbus, libbdrige, udhcp (under conditional flags)

libbluezdbus-0.2.tar.gz is the library to hide D-Bus message=20
details(d-bus connection, message exchange, ...). Inside this
library there is a test application (sample/client).

For more information read the RELEASE_NOTES file attached.

My next action is implement periodic inquiry. This feature should be=20
provided by bluetoothd. Before integrate this code we have to define
the object path and interface name properly.

Regards,
Claudio.

On 7/11/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > My project goal is provide D-Bus support for pand
> > including automatic bridge creation and integration
> > with udhcp.
> >
> > Setup the bt adapter is a dependency for me. bluetoothd is
> > the daemon that was missing for provide  adapter configuration,
> > periodic inquiry and link setup. Some services(list adapters,
> > search, role switch) are being provided by pand D-Bus.
> > I know that is a incorrect approach, but they are required.
> >
> > I am running behind the schedule, there are a lot projects
> > (UPnP app, games) that require this feature for setup PANs.
> > Is it possible integrate the D-Bus services for pand?
>=20
> as long as you don't introduce too much dependencies, there should be no
> problem to include it. Simple send new versions to the mailing list and
> when I have more time, I review them.
>=20
> > After that can help you moving all code to bluetoothd.
>=20
> I am going to develop it from scratch. I still have to solve some basic
> problem with the new kernel interface.
>=20
> > If you what I can help you developing bluetoothd?
>=20
> Any help is always welcome. I will commit all code and compile it by
> default, but don't install it.
>=20
> > Regarding security, what are exactly the points that need
> > by improved or developed?
>=20
> The PIN code and link key handling for the kernel security manager.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar happen=
ing
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
> core and dual graphics technology at this free one hour event hosted by H=
P,
> AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_401_7949755.1121188070570
Content-Type: application/octet-stream; name="RELEASE_NOTES"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="RELEASE_NOTES"

CkQtQlVTIHNlcnZpY2UgUmVsZWFzZSBOb3RlcyBmb3IgUEFOIGRhZW1vbiBvZiBibHVlei11dGls
cwoKYmx1ZXotdXRpbHMgdmVyc2lvbjogMi4xOAoKKioqKiogQWRkZWQgZmVhdHVyZXM6CkluaXRp
YWwgdmVyc2lvbi4gQWRkZWQgdGhlIGluaXRpYWwgRC1CdXMgc2VydmljZXMKZm9yIGJsdWV6IHBh
bmQuIFRoZSBmb2xsb3dpbmcgc2VydmljZXMgYXJlIHByb3ZpZGVkOgotIGRhZW1vbiBzdGFydC9z
dG9wCi0gY29ubmVjdC9kaXNjb25uZWN0Ci0gc2VhcmNoCi0gbGlzdGVuIHN0YXJ0L3N0b3AKLSB1
ZGhjcCBpbnRlZ3JhdGlvbiBmb3IgbG9jYWwgbGluayBhZGRyZXNzIGFzc2lnbWVudC4KICBTZWUg
YWRkaXRpb25hbCBjb21tZW50IGF0IGVuZCBvZiB0aGlzIGRvY3VtZW50LgotIGF1dG9tYXRpYyBi
cmlkZ2UgY3JlYXRpb24uIAogIFNlZSBhZGRpdGlvbmFsIGNvbW1lbnQgYXQgZW5kIG9mIHRoaXMg
ZG9jdW1lbnQuCgogIAoqKioqKiBGaXhlZCBCdWdzOgoKYnVnICMxIHR5cGU6IGRlZmVjdApUaGUg
YWN0aXZhdGUgc2VydmljZSBpcyBub3Qgd29ya2luZyBpbiB0aGUgc3lzdGVtIGJ1cwpmaXhlZCB2
ZXJzaW9uOiBibHVlei1kYnVzLXBhdGNoLTAwLjA0CgpidWcgIzQ6ICB0eXBlOiBlbmhhbmNlbWVu
dApBdXRvbWF0aWMgYnJpZGdlIGNyZWF0aW9uCi0gRW5hYmxlIGF1dG9tYXRpYyBicmlkZ2UgY3Jl
YXRpb24gb24gbGlzdGVuIHNlcnZpY2UKZml4ZWQgdmVyc2lvbjogYmx1ZXotZGJ1cy1wYXRjaC0w
MC4wNAoKYnVnICMxMDogdHlwZTogZW5oYW5jZW1lbnQKVURIQ1AgaW50ZWdyYXRpb24uIENhbGwg
dWRoY3AgZGFlbW9uIGZvciB0aGUKYnJpZGdlIChwYW5YKSBpbnRlcmZhY2UuCmZpeGVkIHZlcnNp
b246IGJsdWV6LWRidXMtcGF0Y2gtMDAuMDQKCioqKiogS25vd24gQnVnczoKCmJ1ZyAjMiB0eXBl
OiBkZWZlY3QKdGhlIHNlYXJjaCBzZXJ2aWNlIGlzIGJsb2NraW5nLCB0aGUgcGFuZCBELUJVUyBz
ZXJ2aWNlIAptdXN0IGJlIGNoYW5nZWQuIEEgY2FsbGJhY2sgZnVuY3Rpb24gc2hvdWxkIGJlIHVz
ZWQuCmZpeGVkIHZlcnNpb246CgpidWcgIzM6IHR5cGU6IGVuaGFuY2VtZW50CkFkZCBzaWduYWwg
c3VwcG9ydAogLSBzaWduYWwgZm9yIG5vdGlmeSBkaXNjb25uZWN0aW9uCiAtIHNpZ25hbCBmb3Ig
bm90aWZ5IG5ldyBkZXZpY2UgZm91bmQKZml4ZWQgdmVyc2lvbjoKIAoKYnVnICM1OiB0eXBlOiBl
bmhhbmNlbWVudApQZXJpb2RpYyBpbnF1aXJ5CmZpeGVkIHZlcnNpb246CgpidWcgIzY6IHR5cGU6
IGVuaGFuY2VtZW50CkRldmVsb3AgYSBiZXR0ZXIgVUkgZm9yIHRoZSBjbGllbnQgYXBwCmZpeGVk
IHZlcnNpb246CgpidWcgIzc6IHR5cGU6IGVuaGFuY2VtZW50CkFkZCBhIHBhcmFtZXRlciB0byBz
ZWFyY2ggc2VydmljZXMgb24gc3BlY2lmaWMgCmRldmljZSBjbGFzcyAoZGVza3RvcCBvbmx5LCBt
b2JpbGUgcGhvbmVzIG9ubHksIC4uLikKZml4ZWQgdmVyc2lvbjoKCmJ1ZyAjODogdHlwZTogZW5o
YW5jZW1lbnQKQWRkIEQtQlVTIHNlcnZpY2UgZm9yIGR1bmQKZml4ZWQgdmVyc2lvbjoKCmJ1ZyAj
OTogdHlwZTogZW5oYW5jZW1lbnQKQWRkIEQtQlVTIHNlcnZpY2UgZm9yIGhpZGQKZml4ZWQgdmVy
c2lvbjoKCmJ1ZyAjMTE6IHR5cGU6IGVuaGFuY2VtZW50Ck1ha2VmaWxlIG11c3QgYmUgY2hhbmdl
ZCB0byBpbnN0YWxsCmFsbCBELUJ1cyBjb25maWd1cmF0aW9uIGZpbGVzCmZpeGVkIHZlcnNpb246
CgpidWcgIzEyOiB0eXBlOiBkZWZlY3QKYm5lcFggaW50ZXJmYWNlcyBtdXN0IGJlIHJlbW92ZWQg
d2hlbgp0aGUgZGFlbW9uIGV4aXRzLgpmaXhlZCB2ZXJzaW9uOgoKCioqKioqIEFkZGl0aW9uYWwg
Q29tbWVudHM6CgoxLiBIb3cgdXNlIGxpbmsgbG9jYWwgYWRkcmVzcyBkYWVtb24oVURIQ1Agd2l0
aCBaZXJvY29uZiBzdXBwb3J0KT8KVGhlcmUgaXMgcGF0Y2ggVURIQ1AgdmVyc2lvbiB3aXRoIFpl
cm9jb25mIHN1cHBvcnQKaHR0cDovL3d3dy5pbmR0Lm9yZy5ici9tYWVtby96ZXJvY29uZi91ZGhj
cGMvCiAgLSBydW4tdWRoY3Agc2NyaXB0CiAgdGhpcyBzY3JpcHQgbXVzdCBiZSBjb3BpZWQgdG8g
L2V0Yy9ibHVldG9vdGgvcGFuCiAgY2hlY2sgaWYgdGhlcmUgaXMgZXhlY3V0aW9uIHBlcm1pc3Np
b24KCjIuIEJyaWRnZSBjb21tZW50cwpObyBtYXR0ZXIgdGhlIGRldmljZSBzZXJ2aWNlKE5BUCxQ
QU5VLCBHTikgb25seSBvbmUgYnJpZGdlIGludGVyZmFjZSAKcGFuMCB3aWxsIGJlIGNyZWF0ZWQg
b24gZWFjaCBkZXZpY2UuIEluY29tbWluZyBhbmQgb3V0Z29pbmcgY29ubmVjdGlvbnMKd2lsbCBi
ZSBhZGRlZCB0byB0aGUgc2FtZSBicmlkZ2UKCgozLiBELUJ1cyBzdGFydCBzZXJ2aWNlIApJbiBv
cmRlciBlbmFibGUgc3RhcnQgcGFuZCB1c2luZyBhIGRidXMgY2xpZW50IGl0IGlzIG5lY2Vzc2Fy
eQpwZXJmb3JtIGNvbmZpZ3VyYXRpb25zLgogIC0gc2VjdXJpdHkgcG9saWN5IGZpbGUgdGhlIGRp
cmVjdG9yeSAvZXRjL2RidXMtMS9zeXN0ZW0uZC8KICBDb3B5IHRoZSBmaWxlIHBhbnouY29uZiB0
byB0aGUgZGlyZWN0b3J5IC9ldGMvZGJ1cy0xL3N5c3RlbS5kLwoKCTwhLS0gVGhpcyBjb25maWd1
cmF0aW9uIGZpbGUgc3BlY2lmaWVzIHRoZSByZXF1aXJlZCBzZWN1cml0eSBwb2xpY2llcwoJZm9y
IGJsdWV6LXBhbmQgdG8gd29yay4gLS0+CgkKCTwhRE9DVFlQRSBidXNjb25maWcgUFVCTElDICIt
Ly9mcmVlZGVza3RvcC8vRFREIEQtQlVTIEJ1cyBDb25maWd1cmF0aW9uIDEuMC8vRU4iCgkiaHR0
cDovL3d3dy5mcmVlZGVza3RvcC5vcmcvc3RhbmRhcmRzL2RidXMvMS4wL2J1c2NvbmZpZy5kdGQi
PgoJPGJ1c2NvbmZpZz4KCQoJPCEtLSAuLi9zeXN0ZW0uY29uZiBoYXZlIGRlbmllZCBldmVyeXRo
aW5nLCBzbyB3ZSBqdXN0IHB1bmNoIHNvbWUgaG9sZXMgLS0+CgkKCTxwb2xpY3kgY29udGV4dD0i
ZGVmYXVsdCI+Cgk8YWxsb3cgb3duPSJvcmcuYmx1ZXoucGFuZCIvPgoJCgk8YWxsb3cgc2VuZF9k
ZXN0aW5hdGlvbj0ib3JnLmJsdWV6LnBhbmQiLz4KCTxhbGxvdyByZWNlaXZlX3NlbmRlcj0ib3Jn
LmJsdWV6LnBhbmQiLz4KCQoJPGFsbG93IHNlbmRfcGF0aD0iL29yZy9ibHVlei9wYW5kIi8+Cgk8
L3BvbGljeT4KCQoJPC9idXNjb25maWc+ICAKICAKICAtIGNoZWNrIHNlcnZpY2UgZmlsZSBkaXIK
ICBvcGVuIHRoZSBELUJ1cyBzeXN0ZW0uY29uZiBmaWxlIGFuZCBjaGVjawogIGlmIHRoZSBpcyBh
IGVudHJ5IGZvciBzZXJ2aWNlZGlyOgogICI8c2VydmljZWRpcj4vdXNyL3NoYXJlL2RidXMtMS9z
ZXJ2aWNlcy9zeXN0ZW08L3NlcnZpY2VkaXI+IgogIAogIC0gcGFuei5zZXJ2aWNlCiAgY29weSB0
aGlzIGZpbGUgdG8gdGhlIHN5c3RlbSBzZXJ2aWNlIGRpcmVjdG9yeSAiPHNlcnZpY2VkaXI+Igog
ICMgU2VydmljZSBkZXNjcmlwdGlvbiBmaWxlCglbRC1CVVMgU2VydmljZV0KCU5hbWU9b3JnLmJs
dWV6LnBhbmQKCUV4ZWM9L2V0Yy9ibHVldG9vdGgvcGFuL3J1bi1wYW5kLnNoCgogIC0gcnVuLXBh
bmQuc2ggCiAgdGhpcyBzY3JpcHQgc2hvdWx0IGJlIGNvcGllZCB0byAvZXRjL2JsdWV0b290aC9w
YW4gZGlyZWN0b3J5IAogIGFkZCBleGVjdXRpb24gcGVybWlzc2lvbgoJIyEvYmluL3NoCglwYW5k
IC0tZGJ1cwoJCgkKSE9XVE8gc2V0dXAgREJVUyBlbnZpcm9ubWVudAoKMS4gY2hlY2tpbmcgZGJ1
cy1kYWVtb24KICAgdHlwZTogJHBzIC1lZiB8IGdyZXAgZGJ1cwogICAiZGJ1cy1kYWVtb24gLS1z
eXN0ZW0iICBzaG91bGQgYmUgZGlzcGxheWVkCiAgIAoyLiBjaGVjayBwYW5kIGRidXMgc2Vydmlj
ZSBwb2xpY3kgZmlsZSAocGFuei5jb25mKQogICBUaGUgZmlsZSBwYW56LmNvbmYgbXVzdCBiZSBs
b2NhdGVkIGF0OiAvZXRjL2RidXMtMS9zeXN0ZW0uZC8KICAgCjMuIGNoZWNrIHBhbmQgc2Vydmlj
ZSBmaWxlIChwYW56LnNlcnZpY2UpCiAgIENoZWNrIHRoZSA8c2VydmljZWRpcj4gYXR0cmlidXRl
IGluIHRoZSBzeXN0ZW0uY29uZiAKICAgc3VnZ2VzdGlvbjogL3Vzci9zaGFyZS9kYnVzLTEvc2Vy
dmljZXMvc3lzdGVtCiAgIAo0LiBjaGVjayB0aGUgcnVuLXBhbmQuc2gKICAgQ2hlY2sgaWYgdGhp
cyBzY3JpcHQgaXMgbG9jYXRlZCBhdCAvZXRjL2JsdWV0b290aC9wYW4vCiAgIAo1LiBDbGllbnQg
Y2FuIGluaXRpYWxpemUgdGhlIHBhbmQgc2VydmljZSB1c2luZwogICBELUJVUyBzdGFydCBtZXRo
b2Qgb3IgdHlwaW5nICJwYW5kIC0tZGJ1cyIgb24KICAgYSByb290IHRlcm1pbmFsLgogICAK
------=_Part_401_7949755.1121188070570--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
