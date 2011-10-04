Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Proposal for GATT Client Dbus API. 
Date: Tue, 4 Oct 2011 13:59:34 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
Content-Type: multipart/mixed;
	boundary="_002_F82830D409D80E4881C83250E051B74B4784BE4Fbanasiexm01ASIA_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_F82830D409D80E4881C83250E051B74B4784BE4Fbanasiexm01ASIA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

This post contains a proposal for the DBUS GATT API(Gatt CLIENT) that enhan=
ces the existing GATT
functionality provided by DBUS APIs interface. Which include Methods,Signal=
s and Properties.=20
Could you please provide your comments and feedback for the same? Or we nee=
d more APIs to cover all GATT Client functionality?

. RegisterCharacteristicsWatcher can be used to monitor specific Characteri=
stic change.=20
. PropertyChanged Signal for the SetProperty().
. ServiceChanged and CharacteristicChanged Signal for Service or Characteri=
stic changes on the server.=20
. New Properties for Permissions and remaining Characteristic Descriptors.=
=20

PFA the updated document "new-attribute-api.txt".

Proposed New API:

Device Characteristic hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Service=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 org.bluez
Interface=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 org.bluez.Characteristic
Object path=A0=A0=A0=A0=A0=A0=A0 [prefix]/{hci0}/{device0}/{service0}/{char=
acteristic0,...}

Methods:
      			RegisterCharacteristicsWatcher(object agent)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Register a watcher to monitor characteristic=
 changes.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 A watcher will be registered for the specifi=
c characteristic and will
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 notify about any changed characteristics.
Signals:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Propert=
yChanged(string name, variant value)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This signal indicates a changed value of the=
 given
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 property.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Servi=
ceChanged (dict values)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This signal indicates service added on serve=
r.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Chara=
cteristicChanged (dict values)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This signal indicates characteristic added o=
n server.

Properties:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint8=
 Property [readonly]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 The characteristic property, format defined =
by GATT spec.=20

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uin=
t16 Configuration [readonly]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Optional field containing the configuration =
value on the server.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uin=
t16 Extended [readonly]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 The characteristic descriptor describing
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the additional Characteristic Properties.=20

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uin=
t16 Aggregate [readonly]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Optional Characteristic descriptor which def=
ines the=20
					      format of an aggregated Characteristic Value.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint1=
6 Custom [readonly]
						Optional Characteristic descriptor which defines profile defined desc=
riptor UUID's.


Thanks,
Vijay


Member of the CSR plc group of companies. CSR plc registered in England and=
 Wales, registered number 4187346, registered office Churchill House, Cambr=
idge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http=
://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

--_002_F82830D409D80E4881C83250E051B74B4784BE4Fbanasiexm01ASIA_
Content-Type: text/plain; name="new-attribute-api.txt"
Content-Description: new-attribute-api.txt
Content-Disposition: attachment; creation-date="Tue, 04 Oct 2011 10:38:48 GMT"; filename="new-attribute-api.txt"; modification-date="Tue, 04 Oct 2011 13:25:02 GMT"; size="6122"
Content-Transfer-Encoding: base64

Qmx1ZVogRC1CdXMgQXR0cmlidXRlIEFQSSBkZXNjcmlwdGlvbg0KKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KDQpDb3B5cmlnaHQg
KEMpIDIwMDQtMjAxMCAgTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1h
bm4ub3JnPg0KDQpTZXJ2aWNlIGRldGFpbHMNCi0tLS0tLS0tLS0tLS0tLQ0K
DQpPbmUgc2VydmljZSBvYmplY3QgcGF0aCBmb3IgZXZlcnkgcmVtb3RlIFNE
UCByZWNvcmQgb3Igc2VydmljZSBpbiB0aGUNCmF0dHJpYnV0ZSBkYXRhYmFz
ZS4gT25lIHNlcnZpY2Ugb2JqZWN0IHBhdGggZm9yIGV2ZXJ5IGxvY2FsIFNE
UCByZWNvcmQNCm9yIHNlcnZpY2UgZnJvbSBhdHRyaWJ1dGUgZGF0YWJhc2Uu
DQoNCkxvY2FsIHNlcnZpY2VzIGFyZSBjaGlsZHJlbiBvZiB0aGUgYWRhcHRl
ciBvYmplY3QgcGF0aC4gUmVtb3RlIHNlcnZpY2VzDQphcmUgY2hpbGRyZW4g
b2YgdGhlIHJlbW90ZSBkZXZpY2Ugb2JqZWN0IHBhdGguIFRoaXMgZG9lc24n
dCBzb2x2ZSB0aGUNCnByb2JsZW0gd2hlcmUgbG9jYWwgYXR0cmlidXRlcyBj
YW4gaGF2ZSBkaWZmZXJlbnQgaW5zdGFuY2VzIGJhc2VkIG9uDQp0aGUgcmVt
b3RlIGRldmljZS4NCg0KSW4gZ2VuZXJhbCB0aGUgaWRlYSBpcyB0byBhbHNv
IHJlcHJlc2VudCBTRFAgcmVjb3JkcyBhcyBzZXJ2aWNlcyBzbyB0aGF0DQpu
ZXcgc3R5bGUgYXBwbGljYXRpb24gY2FuIGp1c3QgdXNlIHRoZSBzZXJ2aWNl
IGludGVyZmFjZXMgdG8gcmV0cmlldmUgdGhlDQpuZWVkZWQgaW5mb3JtYXRp
b24uIFRoYXQgd2F5IHRoZSB1c2FnZSBvZiBTRFAgYW5kIEdBVFQgd291bGQg
YmUgbW9zdGx5DQpmdWxseSB0cmFuc3BhcmVudCBhbmQgYSBkaWZmZXJlbnRp
YXRpb24gYmVjb21lcyB1bmltcG9ydGFudCBpbiB0aGUgZnV0dXJlLg0KDQpB
IHNlcnZpY2UgY29uc2lzdHMgb2Ygc29tZSBnZW5lcmljIHNlcnZpY2UgaW5m
b3JtYXRpb24gYW5kIGEgc2V0IG9mDQpjaGFyYWN0ZXJpc3RpY3MuIEFsbCBj
aGFyYWN0ZXJpc3RpYyBhcmUgcHJlc2VudGVkIGFzIG9iamVjdCBwYXRoIGFz
IHdlbGwuDQoNCg0KTG9jYWwgU2VydmljZSBoaWVyYXJjaHkNCj09PT09PT09
PT09PT09PT09PT09PT09DQoNClNlcnZpY2UJCW9yZy5ibHVleg0KSW50ZXJm
YWNlCW9yZy5ibHVlei5TZXJ2aWNlDQoJCW9yZy5ibHVlei5DaGFyYWN0ZXJp
c3RpYw0KT2JqZWN0IHBhdGgJW3ByZWZpeF0ve2hjaTB9L3tzZXJ2aWNlMCwg
c2VydmljZTEsIC4uLn0NCg0KTWV0aG9kcw0KDQpQcm9wZXJ0aWVzDQoNCg0K
RGV2aWNlIFNlcnZpY2UgaGllcmFyY2h5DQo9PT09PT09PT09PT09PT09PT09
PT09PT0NCg0KU2VydmljZQkJb3JnLmJsdWV6DQpJbnRlcmZhY2UJb3JnLmJs
dWV6LkNoYXJhY3RlcmlzdGljDQpPYmplY3QgcGF0aAlbcHJlZml4XS97aGNp
MH0ve2RldmljZTB9L3tzZXJ2aWNlMCwgc2VydmljZTEsIC4uLn0NCgkJW3By
ZWZpeF0ve2hjaTB9L3tkZXZpY2UxfS97c2VydmljZTAsIHNlcnZpY2UxLCAu
Li59DQoNCk1ldGhvZHMgCWRpY3QgR2V0UHJvcGVydGllcygpDQoNCgkJCVJl
dHVybnMgYWxsIHByb3BlcnRpZXMgZm9yIHRoZSBpbnRlcmZhY2UuIFNlZSB0
aGUNCgkJCVByb3BlcnRpZXMgc2VjdGlvbiBmb3IgdGhlIGF2YWlsYWJsZSBw
cm9wZXJ0aWVzLg0KDQoJCWFycmF5e29iamVjdH0gRGlzY292ZXJDaGFyYWN0
ZXJpc3RpY3MoKQ0KDQoJCQlEaXNjb3ZlciBhbGwgY2hhcmFjdGVyaXN0aWNz
IHRoYXQgYmVsb25ncyBpbiB0aGlzIHNlcnZpY2UuDQoJCQlXaGVuIGl0IHJl
dHVybnMgYWxsIHRoZSBjaGFyYWN0ZXJpc3RpY3MgcGF0aHMgd2lsbCBiZQ0K
CQkJYWxyZWFkeSByZWdpc3RlcmVkLiBJdCB3aWxsIHJldHVybiB0aGUgY2hh
cmFjdGVyaXN0aWNzIHBhdGhzDQoJCQlhcyBzb29uIGFzIHRoZXkgYXJlIGRp
c2NvdmVyZWQuIEFmdGVyIHRoYXQgaXQgd2lsbCB0cnkgdG8NCgkJCXJlYWQg
YWxsIHZhbHVlcy4NCg0KCQlSZWdpc3RlckNoYXJhY3RlcmlzdGljc1dhdGNo
ZXIob2JqZWN0IGFnZW50KQ0KDQoJCQlSZWdpc3RlciBhIHdhdGNoZXIgdG8g
bW9uaXRvciBjaGFyYWN0ZXJpc3RpYyBjaGFuZ2VzLg0KCQkJQSB3YXRjaGVy
IHdpbGwgYmUgcmVnaXN0ZXJlZCBmb3IgdGhpcyBzZXJ2aWNlIGFuZCB3aWxs
DQoJCQlub3RpZnkgYWJvdXQgYW55IGNoYW5nZWQgY2hhcmFjdGVyaXN0aWNz
IGluIHRoZSBzZXJ2aWNlLg0KCQkJVGhpcyBhbHNvIG5vdGlmaWVzIGFib3V0
IGFueSBpbmNsdWRlZCBjaGFyYWN0ZXJpc3RpY3MuDQoNCgkJVW5yZWdpc3Rl
ckNoYXJhY3RlcmlzdGljc1dhdGNoZXIob2JqZWN0IGFnZW50KQ0KDQoJCQlV
bnJlZ2lzdGVyIGEgd2F0Y2hlci4NCg0KUHJvcGVydGllcwlzdHJpbmcgTmFt
ZSAobWFuZGF0b3J5KSBbcmVhZG9ubHldDQoNCgkJCUdlbmVyYWwgbmFtZSBv
ZiBzZXJ2aWNlDQoNCgkJc3RyaW5nIERlc2NyaXB0aW9uIChvcHRpb25hbCkg
W3JlYWRvbmx5XQ0KDQoJCQlEZXNjcmlwdGlvbiBvZiBzZXJ2aWNlDQoNCgkJ
c3RyaW5nIFVVSUQgKG1hbmRhdG9yeSkgW3JlYWRvbmx5XQ0KDQoJCQlVVUlE
IG9mIHNlcnZpY2UuIFNlcnZpY2UgY2xhc3MgdmFsdWUgZm9yIFNEUCBhbmQg
R0FUVA0KCQkJVVVJRCBmb3IgYXR0cmlidXRlIGJhc2VkIHNlcnZpY2VzLg0K
DQoJCWFycmF5e29iamVjdH0gQ2hhcmFjdGVyaXN0aWNzIFtyZWFkb25seV0N
Cg0KCQkJVGhpcyBsaXN0IGNvbnRhaW5zIHRoZSBjaGFyYWN0ZXJpc3RpY3Mg
b3duZWQgYnkgdGhpcw0KCQkJc3BlY2lmaWMgc2VydmljZSBhbmQgb3RoZXIg
Y2hhcmFjdGVyaXN0aWNzIGZyb20gc2VydmljZQ0KCQkJaW5jbHVkZXMuIFRo
YXQgd2F5IG5vIGNvbXBsaWNhdGVkIHNlcnZpY2UgaW5jbHVkZXMgYXJyYXkN
CgkJCWlzIG5lZWRlZC4NCg0KDQpEZXZpY2UgQ2hhcmFjdGVyaXN0aWMgaGll
cmFyY2h5DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNClNl
cnZpY2UJCW9yZy5ibHVleg0KSW50ZXJmYWNlCW9yZy5ibHVlei5DaGFyYWN0
ZXJpc3RpYw0KT2JqZWN0IHBhdGgJW3ByZWZpeF0ve2hjaTB9L3tkZXZpY2Uw
fS97c2VydmljZTB9L3tjaGFyYWN0ZXJpc3RpYzAsLi4ufQ0KCQlbcHJlZml4
XS97aGNpMH0ve2RldmljZTB9L3tzZXJ2aWNlMX0ve2NoYXJhY3RlcmlzdGlj
MCwuLi59DQoNCk1ldGhvZHMJZGljdCBHZXRQcm9wZXJ0aWVzKCkNCg0KCQkJ
UmV0dXJucyBhbGwgcHJvcGVydGllcyBmb3IgdGhlIGNoYXJhY3RlcmlzdGlj
LiBTZWUgdGhlDQoJCQlwcm9wZXJ0aWVzIHNlY3Rpb24gZm9yIGF2YWlsYWJs
ZSBwcm9wZXJ0aWVzLg0KDQoJCXZvaWQgU2V0UHJvcGVydHkoc3RyaW5nIG5h
bWUsIHZhcmlhbnQgdmFsdWUpDQoNCgkJCUNoYW5nZXMgdGhlIHZhbHVlIG9m
IHRoZSBzcGVjaWZpZWQgcHJvcGVydHkuIE9ubHkNCgkJCXJlYWQtd3JpdGUg
cHJvcGVydGllcyBjYW4gYmUgY2hhbmdlZC4gT24gc3VjY2Vzcw0KCQkJdGhp
cyB3aWxsIGVtaXQgYSBQcm9wZXJ0eUNoYW5nZWQgc2lnbmFsLg0KDQogICAg
UmVnaXN0ZXJDaGFyYWN0ZXJpc3RpY3NXYXRjaGVyKG9iamVjdCBhZ2VudCkN
Cg0KCQkJUmVnaXN0ZXIgYSB3YXRjaGVyIHRvIG1vbml0b3IgY2hhcmFjdGVy
aXN0aWMgY2hhbmdlcy4NCgkJCUEgd2F0Y2hlciB3aWxsIGJlIHJlZ2lzdGVy
ZWQgZm9yIHRoZSBjaGFyYWN0ZXJpc3RpYyBhbmQgd2lsbA0KCQkJbm90aWZ5
IGFib3V0IGFueSBjaGFuZ2VkIGNoYXJhY3RlcmlzdGljcy4NCg0KCQkJUG9z
c2libGUgRXJyb3JzOiBvcmcuYmx1ZXouRXJyb3IuSW52YWxpZEFyZ3VtZW50
cw0KDQpTaWduYWxzCQlQcm9wZXJ0eUNoYW5nZWQoc3RyaW5nIG5hbWUsIHZh
cmlhbnQgdmFsdWUpDQoJCQlUaGlzIHNpZ25hbCBpbmRpY2F0ZXMgYSBjaGFu
Z2VkIHZhbHVlIG9mIHRoZSBnaXZlbg0KCQkJcHJvcGVydHkuDQoJCQkNCgkJ
CVNlcnZpY2VDaGFuZ2VkIChkaWN0IHZhbHVlcykNCgkJCVRoaXMgc2lnbmFs
IGluZGljYXRlcyBzZXJ2aWNlIGFkZGVkIG9uIHNlcnZlci4NCg0KICAJCUNo
YXJhY3RlcmlzdGljQ2hhbmdlZCAoZGljdCB2YWx1ZXMpDQoJCQlUaGlzIHNp
Z25hbCBpbmRpY2F0ZXMgY2hhcmFjdGVyaXN0aWMgYWRkZWQgb24gc2VydmVy
Lg0KDQoNClByb3BlcnRpZXMgCXN0cmluZyBVVUlEIFtyZWFkb25seV0NCgkJ
CVVVSUQxMjggb2YgdGhpcyBjaGFyYWN0ZXJpc3RpYy4NCg0KCQlzdHJpbmcg
TmFtZSBbcmVhZG9ubHldDQoJCQlPcHRpb25hbCBmaWVsZCBjb250YWluaW5n
IGEgZnJpZW5kbHkgbmFtZSBmb3IgdGhlDQoJCQlDaGFyYWN0ZXJpc3RpYyBV
VUlELg0KDQoJCXVpbnQ4IFByb3BlcnR5IFtyZWFkb25seV0NCgkJCVRoZSBj
aGFyYWN0ZXJpc3RpYyBwcm9wZXJ0eSwgZm9ybWF0IGRlZmluZWQgYnkgR0FU
VCBzcGVjLiANCg0KCQl1aW50MTYgQ29uZmlndXJhdGlvbiBbcmVhZG9ubHld
DQoJCQlPcHRpb25hbCBmaWVsZCBjb250YWluaW5nIHRoZSBjb25maWd1cmF0
aW9uIHZhbHVlIG9uIHRoZSBzZXJ2ZXIuDQoNCgkJdWludDE2IEV4dGVuZGVk
IFtyZWFkb25seV0NCgkJCVRoZSBjaGFyYWN0ZXJpc3RpYyBkZXNjcmlwdG9y
IGRlc2NyaWJpbmcNCgkJCXRoZSBhZGRpdGlvbmFsIENoYXJhY3RlcmlzdGlj
IFByb3BlcnRpZXMuIA0KDQoJCXVpbnQxNiBBZ2dyZWdhdGUgW3JlYWRvbmx5
XQ0KCQkJT3B0aW9uYWwgQ2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvciB3aGlj
aCBkZWZpbmVzIHRoZSANCiAgICAgIAkJCWZvcm1hdCBvZiBhbiBhZ2dyZWdh
dGVkIENoYXJhY3RlcmlzdGljIFZhbHVlLg0KICAgICAgCQkJDQogICAgdWlu
dDE2IEN1c3RvbSBbcmVhZG9ubHldDQoJCQlPcHRpb25hbCBDaGFyYWN0ZXJp
c3RpYyBkZXNjcmlwdG9yIHdoaWNoIGRlZmluZXMgcHJvZmlsZSBkZWZpbmVk
IGRlc2NyaXB0b3IgVVVJRJJzLg0KICAgICAgDQoJCXN0cmluZyBEZXNjcmlw
dGlvbiBbcmVhZG9ubHldDQoJCQlUZXh0dWFsIG9wdGlvbmFsIGNoYXJhY3Rl
cmlzdGljIGRlc2NyaXB0b3IgZGVzY3JpYmluZw0KCQkJdGhlIENoYXJhY3Rl
cmlzdGljIFZhbHVlLg0KDQoJCXN0cnVjdCBGb3JtYXQgW3JlYWRvbmx5XQ0K
DQoJCQlPcHRpb25hbCBDaGFyYWN0ZXJpc3RpYyBkZXNjcmlwdG9yIHdoaWNo
IGRlZmluZXMgdGhlDQoJCQlmb3JtYXQgb2YgdGhlIENoYXJhY3RlcmlzdGlj
IFZhbHVlLiBGb3IgbnVtZXJpYw0KCQkJdmFsdWVzLCB0aGUgYWN0dWFsIHZh
bHVlIGNhbiBiZSB2YWx1ZSAqIDEwXkV4cG9uZW50Lg0KCQkJTmFtZVNwYWNl
IGFuZCBEZXNjcmlwdGlvbiBhcmUgZGVmaW5lZCBvbiB0aGUgQXNzaWduZWQN
CgkJCU51bWJlciBTcGVjaWZpY2F0aW9uLg0KDQoJCQkgIHVpbnQ4ICB8IEZv
cm1hdDogZm9ybWF0IG9mIHRoZSB2YWx1ZQ0KCQkJICB1aW50OCAgfCBFeHBv
bmVudDogRmllbGQgdG8gZGV0ZXJtaW5lIGhvdyB0aGUgdmFsdWUgaXMNCgkJ
CSAgICAgICAgIHwgZnVydGhlciBmb3JtYXR0ZWQuDQoJCQkgIHVpbnQxNiB8
IFVuaXQ6IHVuaXQgb2YgdGhlIGNoYXJhY3RlcmlzdGljDQoJCQkgIHVpbnQ4
ICB8IE5hbWVTcGFjZTogTmFtZSBzcGFjZSBvZiBkZXNjcmlwdGlvbi4NCgkJ
CSAgdWludDE2IHwgRGVzY3JpcHRpb246IERlc2NyaXB0aW9uIG9mIHRoZSBj
aGFyYWN0ZXJpc3RpYyBkZWZpbmVkDQoJCQkgICAgICAgICB8IGluIGEgaGln
aCBsYXllciBwcm9maWxlLg0KDQoJCWFycmF5e2J5dGV9IFZhbHVlIFtyZWFk
d3JpdGVdDQoNCgkJCVJhdyB2YWx1ZSBvZiB0aGUgQ2hhcmFjdGVyaXN0aWMg
VmFsdWUgYXR0cmlidXRlLg0KDQoJCXN0cmluZyBSZXByZXNlbnRhdGlvbiAo
b2YgdGhlIGJpbmFyeSBWYWx1ZSkgW3JlYWRvbmx5XQ0KDQoJCQlGcmllbmRs
eSByZXByZXNlbnRhdGlvbiBvZiB0aGUgQ2hhcmFjdGVyaXN0aWMgVmFsdWUN
CgkJCWJhc2VkIG9uIHRoZSBmb3JtYXQgYXR0cmlidXRlLg0KDQoNCkNoYXJh
Y3RlcmlzdGljIFdhdGNoZXIgaGllcmFyY2h5DQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQoNClNlcnZpY2UJCXVuaXF1ZSBuYW1lDQpJbnRl
cmZhY2UJb3JnLmJsdWV6LldhdGNoZXINCk9iamVjdCBwYXRoCWZyZWVseSBk
ZWZpbmFibGUNCg0KTWV0aG9kcwkJdm9pZCBWYWx1ZUNoYW5nZWQob2JqZWN0
IGNoYXJhY3RlcmlzdGljLCBhcnJheXtieXRlfSkNCg0KCQkJTmV3IHJhdyB2
YWx1ZSBvZiB0aGUgQ2hhcmFjdGVyaXN0aWMgVmFsdWUgYXR0cmlidXRlLg0K
DQo=

--_002_F82830D409D80E4881C83250E051B74B4784BE4Fbanasiexm01ASIA_--
