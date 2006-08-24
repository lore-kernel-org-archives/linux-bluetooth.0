Return-Path: <mab@comnets.uni-bremen.de>
Date: Thu, 24 Aug 2006 12:35:04 +0200 (MEST)
From: Markus Becker <mab@comnets.uni-bremen.de>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] bluez-libs UUID-128 support for Protocol
 Descriptor List
In-Reply-To: <1156354555.4133.42.camel@aeonflux.holtmann.net>
Message-ID: <Pine.LNX.4.21.0608241231400.27134-200000@bugs.comnets.uni-bremen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1720058267-1839369770-1156415704=:27134"
List-ID: <bluez-devel.lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1720058267-1839369770-1156415704=:27134
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Marcel.

On Wed, 23 Aug 2006, Marcel Holtmann wrote:

> Hi Markus,
> 
> > I've created a patch for bluez-libs/src/sdp.c to support the finding of
> > UUID128 encoded protocols. So that also kdebluetooth and others can
> > recognize those protocols. It changes the display of the Protocol
> > Descriptor List for example from:
> > 
> > Service Name: ATEmulator
> > Service RecHandle: 0x10010
> > Service Class ID List:
> >   "Error: This is UUID-128" (0x7dd6b763-99a9-4a92-87b5-bc8efe565c37)
> >   "Error: This is UUID-128" (0x00001101-0000-1000-8000-00805f9b34fb)
> > Protocol Descriptor List:
> >   "Error: " (0x00000100-0000-1000-8000-00805f9b34fb)
> >   "Error: " (0x00000003-0000-1000-8000-00805f9b34fb)
> >     Channel: 25
> > 
> > to:
> > 
> > Service Name: ATEmulator
> > Service RecHandle: 0x10010
> > Service Class ID List:
> >   UUID 128: 7dd6b763-99a9-4a92-87b5-bc8efe565c37
> >   UUID 128: 00001101-0000-1000-8000-00805f9b34fb
> > Protocol Descriptor List:
> >   "L2CAP" (0x00000100-0000-1000-8000-00805f9b34fb)
> >   "RFCOMM" (0x00000003-0000-1000-8000-00805f9b34fb)
> >     Channel: 25
> > 
> > Please consider it for integration into mainline bluez-libs.
> 
> the patch is wrong. Before you are doing a lookup against the short
> UUIDs of Bluetooth you should check if the base UUID is the Bluetooth
> base UUID. Otherwise you can't do the lookup.
> 
OK. I attached a patch that does the whole String_lookup differently and
using sdp_uuid128_to_uuid for 128 bit UUIDs. Unfortunately I had to change
the interface in sdp_lib.h because of "const" not being fulfilled by
sdp_uuid128_to_uuid.

I hope this patch is more to your liking. If not, contact me.

> Regards
> 
> Marcel


Bye,
Markus

--1720058267-1839369770-1156415704=:27134
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sdp.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0608241235040.27134@bugs.comnets.uni-bremen.de>
Content-Description: 
Content-Disposition: attachment; filename="sdp.patch"

ZGlmZiAtdSBibHVlei1saWJzLTMuMi9zcmMvc2RwLmMgYmx1ZXotbGlicy0z
LjIubW9kL3NyYy9zZHAuYw0KLS0tIGJsdWV6LWxpYnMtMy4yL3NyYy9zZHAu
YwkyMDA2LTA3LTI3IDA2OjM2OjU5LjAwMDAwMDAwMCArMDIwMA0KKysrIGJs
dWV6LWxpYnMtMy4yLm1vZC9zcmMvc2RwLmMJMjAwNi0wOC0yNCAxMjoyOToz
MS4wMDAwMDAwMDAgKzAyMDANCkBAIC0yMDgsMTEgKzIwOCwzNiBAQA0KIAly
ZXR1cm4gIiI7DQogfQ0KIA0KK3N0YXRpYyBjaGFyICpzdHJpbmdfbG9va3Vw
MTYoc3RydWN0IHR1cGxhICpwdDAsIHV1aWRfdCogdXVpZCkNCit7DQorICBy
ZXR1cm4gc3RyaW5nX2xvb2t1cChwdDAsIHV1aWQtPnZhbHVlLnV1aWQxNik7
DQorfQ0KKw0KK3N0YXRpYyBjaGFyICpzdHJpbmdfbG9va3VwMzIoc3RydWN0
IHR1cGxhICpwdDAsIHV1aWRfdCogdXVpZCkNCit7DQorICByZXR1cm4gc3Ry
aW5nX2xvb2t1cChwdDAsIHV1aWQtPnZhbHVlLnV1aWQzMik7DQorfQ0KKw0K
K3N0YXRpYyBjaGFyICpzdHJpbmdfbG9va3VwMTI4KHN0cnVjdCB0dXBsYSAq
cHQwLCB1dWlkX3QqIHV1aWQpDQorew0KKyAgaWYgKHNkcF91dWlkMTI4X3Rv
X3V1aWQodXVpZCkpIHsNCisgICAgaWYgKHV1aWQtPnR5cGUgPT0gU0RQX1VV
SUQxNikgew0KKyAgICAgIHJldHVybiBzdHJpbmdfbG9va3VwKHB0MCwgdXVp
ZC0+dmFsdWUudXVpZDE2KTsNCisgICAgfSBlbHNlIGlmICh1dWlkLT50eXBl
ID09IFNEUF9VVUlEMzIpICB7DQorICAgICAgcmV0dXJuIHN0cmluZ19sb29r
dXAocHQwLCB1dWlkLT52YWx1ZS51dWlkMzIpOw0KKyAgICB9IGVsc2Ugew0K
KyAgICAgIHJldHVybiAiIjsNCisgICAgfQ0KKyAgfSBlbHNlIHsNCisgICAg
cmV0dXJuICIiOw0KKyAgfQ0KK30NCisNCiAvKg0KICAqIFByaW50cyBpbnRv
IGEgc3RyaW5nIHRoZSBQcm90b2NvbCBVVUlEDQogICogY29waW5nIGEgbWF4
aW11bSBvZiBuIGNoYXJhY3RlcnMuDQogICovDQotc3RhdGljIGludCB1dWlk
MnN0cihzdHJ1Y3QgdHVwbGEgKm1lc3NhZ2UsIGNvbnN0IHV1aWRfdCAqdXVp
ZCwgY2hhciAqc3RyLCBzaXplX3QgbikgDQorc3RhdGljIGludCB1dWlkMnN0
cihzdHJ1Y3QgdHVwbGEgKm1lc3NhZ2UsIHV1aWRfdCAqdXVpZCwgY2hhciAq
c3RyLCBzaXplX3QgbikgDQogew0KIAljaGFyICpzdHIyOw0KIA0KQEAgLTIy
MywxNSArMjQ4LDE2IEBADQogDQogCXN3aXRjaCAodXVpZC0+dHlwZSkgew0K
IAljYXNlIFNEUF9VVUlEMTY6DQotCQlzdHIyID0gc3RyaW5nX2xvb2t1cCht
ZXNzYWdlLCB1dWlkLT52YWx1ZS51dWlkMTYpOw0KKwkJc3RyMiA9IHN0cmlu
Z19sb29rdXAxNihtZXNzYWdlLCB1dWlkKTsNCiAJCXNucHJpbnRmKHN0ciwg
biwgc3RyMik7DQogCQlicmVhazsNCiAJY2FzZSBTRFBfVVVJRDMyOg0KLQkJ
c3RyMiA9IHN0cmluZ19sb29rdXAobWVzc2FnZSwgdXVpZC0+dmFsdWUudXVp
ZDMyKTsNCisJCXN0cjIgPSBzdHJpbmdfbG9va3VwMzIobWVzc2FnZSwgdXVp
ZCk7DQogCQlzbnByaW50ZihzdHIsIG4sIHN0cjIpOw0KIAkJYnJlYWs7DQog
CWNhc2UgU0RQX1VVSUQxMjg6DQotCQlzbnByaW50ZihzdHIsIG4sICJFcnJv
cjogVGhpcyBpcyBVVUlELTEyOCIpOw0KKwkJc3RyMiA9IHN0cmluZ19sb29r
dXAxMjgobWVzc2FnZSwgdXVpZCk7DQorCQlzbnByaW50ZihzdHIsIG4sIHN0
cjIpOw0KIAkJcmV0dXJuIC00Ow0KIAlkZWZhdWx0Og0KIAkJc25wcmludGYo
c3RyLCBuLCAiVHlwZSBvZiBVVUlEICgleCkgdW5rbm93bi4iLCB1dWlkLT50
eXBlKTsNCkBAIC0yNDEsMTcgKzI2NywxNyBAQA0KIAlyZXR1cm4gMDsNCiB9
DQogDQotaW50IHNkcF9wcm90b191dWlkMnN0cm4oY29uc3QgdXVpZF90ICp1
dWlkLCBjaGFyICpzdHIsIHNpemVfdCBuKQ0KK2ludCBzZHBfcHJvdG9fdXVp
ZDJzdHJuKHV1aWRfdCAqdXVpZCwgY2hhciAqc3RyLCBzaXplX3QgbikNCiB7
DQogCXJldHVybiB1dWlkMnN0cihQcm90b2NvbCwgdXVpZCwgc3RyLCBuKTsN
CiB9DQogDQotaW50IHNkcF9zdmNsYXNzX3V1aWQyc3Rybihjb25zdCB1dWlk
X3QgKnV1aWQsIGNoYXIgKnN0ciwgc2l6ZV90IG4pDQoraW50IHNkcF9zdmNs
YXNzX3V1aWQyc3Rybih1dWlkX3QgKnV1aWQsIGNoYXIgKnN0ciwgc2l6ZV90
IG4pDQogew0KIAlyZXR1cm4gdXVpZDJzdHIoU2VydmljZUNsYXNzLCB1dWlk
LCBzdHIsIG4pOw0KIH0NCiANCi1pbnQgc2RwX3Byb2ZpbGVfdXVpZDJzdHJu
KGNvbnN0IHV1aWRfdCAqdXVpZCwgY2hhciAqc3RyLCBzaXplX3QgbikNCitp
bnQgc2RwX3Byb2ZpbGVfdXVpZDJzdHJuKHV1aWRfdCAqdXVpZCwgY2hhciAq
c3RyLCBzaXplX3QgbikNCiB7DQogCXJldHVybiB1dWlkMnN0cihQcm9maWxl
LCB1dWlkLCBzdHIsIG4pOw0KIH0NCmRpZmYgLXUgYmx1ZXotbGlicy0zLjIv
aW5jbHVkZS9zZHBfbGliLmggYmx1ZXotbGlicy0zLjIubW9kL2luY2x1ZGUv
c2RwX2xpYi5oDQotLS0gYmx1ZXotbGlicy0zLjIvaW5jbHVkZS9zZHBfbGli
LmgJMjAwNi0wMS0wMyAxMzo1NjowOS4wMDAwMDAwMDAgKzAxMDANCisrKyBi
bHVlei1saWJzLTMuMi5tb2QvaW5jbHVkZS9zZHBfbGliLmgJMjAwNi0wOC0y
NCAxMjoyNTozNi4wMDAwMDAwMDAgKzAyMDANCkBAIC00MzgsOSArNDM4LDkg
QEANCiAjZGVmaW5lIE1BWF9MRU5fUFJPRklMRURFU0NSSVBUT1JfVVVJRF9T
VFIgMjgNCiANCiBpbnQgc2RwX3V1aWQyc3Rybihjb25zdCB1dWlkX3QgKnV1
aWQsIGNoYXIgKnN0ciwgc2l6ZV90IG4pOw0KLWludCBzZHBfcHJvdG9fdXVp
ZDJzdHJuKGNvbnN0IHV1aWRfdCAqdXVpZCwgY2hhciAqc3RyLCBzaXplX3Qg
bik7DQotaW50IHNkcF9zdmNsYXNzX3V1aWQyc3Rybihjb25zdCB1dWlkX3Qg
KnV1aWQsIGNoYXIgKnN0ciwgc2l6ZV90IG4pOw0KLWludCBzZHBfcHJvZmls
ZV91dWlkMnN0cm4oY29uc3QgdXVpZF90ICp1dWlkLCBjaGFyICpzdHIsIHNp
emVfdCBuKTsNCitpbnQgc2RwX3Byb3RvX3V1aWQyc3Rybih1dWlkX3QgKnV1
aWQsIGNoYXIgKnN0ciwgc2l6ZV90IG4pOw0KK2ludCBzZHBfc3ZjbGFzc191
dWlkMnN0cm4odXVpZF90ICp1dWlkLCBjaGFyICpzdHIsIHNpemVfdCBuKTsN
CitpbnQgc2RwX3Byb2ZpbGVfdXVpZDJzdHJuKHV1aWRfdCAqdXVpZCwgY2hh
ciAqc3RyLCBzaXplX3Qgbik7DQogDQogLyoNCiAgKiBJbiBhbGwgdGhlIHNk
cF9nZXRfWFhYKGhhbmRsZSwgWFhYICp4eHgpIGZ1bmN0aW9ucyBiZWxvdywg
DQo=
--1720058267-1839369770-1156415704=:27134--
