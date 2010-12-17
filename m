Return-Path: <cyrus@holtmann.org>
Message-ID: <4D0B92A5.9010503@aircable.net>
Date: Fri, 17 Dec 2010 13:41:09 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: [RFC][PATCH] Re: EDR support
References: <4D03DC83.8010200@aircable.net> <1292585241.2658.0.camel@aeonflux>
In-Reply-To: <1292585241.2658.0.camel@aeonflux>
Content-Type: multipart/mixed;
 boundary="------------080607070206090300040402"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080607070206090300040402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,
> Hi Manuel,
>
>> I was checking the latest BlueZ source code and the kernel source code,
>> and I noticed that by default EDR is disabled, when a dongle is detected
>> net/bluetooth/hci_core.c initializes the packet types with DM1, DH1 and
>> HV1, and then net/bluetooth/hci_event.c does it for DM3-5 DH3-5 and
>> HV3-5, but it never initializes the 2DHx or 3DHx. Was it made on purpose
>> or is it a bug in the code?
> you have read the specification and realized that EDR uses inverse
> values?
I can't find that, but still I could find that according to the 2.1 
specs + EDR when you want to enable EDR is up to the master or slave to 
ask for the package type switch, that means as far as I understand ask 
the other side to enable 2-DH1,2-DH3,2-DH5,3-DH1,3-DH3,3-DH5.

I get from this that from the BlueZ point of view is either the kernel 
that should do that, or the BlueZ daemon or just rely that to the user 
application.

But I think there are a few of non covered issues here, first when you 
attach an EDR dongle which has the EDR (this means is capable of doing 
2mbps and 3mbps acl connections the kernel side doesn't show this to the 
userland (hciconfig), I made a patch that does exactly that, during the 
device recognition of the kernel just read the features provided and or 
that to the pkt_type flag. This helps a lot, now my dongle shows it can 
do EDR:
EDR compatible:
         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 2-DH1 2-DH3 
2-DH5 3-DH1 3-DH3 3-DH5

EDR not compatible:
         Features: 0xff 0xff 0x8f 0xf8 0x1b 0xf8 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

If you think the patch is sane to be included then I format it properly 
so far I made it against compat-wireless-2.6.36-4 but it wouldn't be an 
issue to make it against the current kernel source.

Next thing was playing with hcitool cpt and that did work, I get speed 
improvements, from ~ 60KBs I get up to 100KBs to the same device, just 
by forcing it to only do 3-DH5 (which I know is not a good idea, because 
it's best for both radios to adapt, based on the environment).

I think it's a good idea to rely EDR "enabling" to the user space, 
otherwise connection complexity on the kernel well be way harder to 
keep. I think the best would be to add some stuff to the DBUS so first 
let the user know which packet types are available, second to allow it 
to change on a new connection.

Please let me know what you think about it,

Manuel

--------------080607070206090300040402
Content-Type: text/plain;
 name="enableEDR.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="enableEDR.patch"

ZGlmZiAtdXByTiBjb21wYXQtd2lyZWxlc3MtMi42LjM2LTQvaW5jbHVkZS9uZXQvYmx1ZXRv
b3RoL2hjaS5oIGNvbXBhdC13aXJlbGVzcy0yLjYuMzYtNC5taW5lLy9pbmNsdWRlL25ldC9i
bHVldG9vdGgvaGNpLmgKLS0tIGNvbXBhdC13aXJlbGVzcy0yLjYuMzYtNC9pbmNsdWRlL25l
dC9ibHVldG9vdGgvaGNpLmgJMjAxMC0xMS0wOCAyMjowMDo1MS4wMDAwMDAwMDAgLTAzMDAK
KysrIGNvbXBhdC13aXJlbGVzcy0yLjYuMzYtNC5taW5lLy9pbmNsdWRlL25ldC9ibHVldG9v
dGgvaGNpLmgJMjAxMC0xMi0xMSAxOToxMzoxNC4wMDAwMDAwMDAgLTAzMDAKQEAgLTEsNiAr
MSw3IEBACiAvKiAKICAgIEJsdWVaIC0gQmx1ZXRvb3RoIHByb3RvY29sIHN0YWNrIGZvciBM
aW51eAogICAgQ29weXJpZ2h0IChDKSAyMDAwLTIwMDEgUXVhbGNvbW0gSW5jb3Jwb3JhdGVk
CisgICBDb3B5cmlnaHQgKEMpIDIwMTAgTmFyYW5qbyBNYW51ZWwgRnJhbmNpc2NvIDxtYW51
ZWxAYWlyY2FibGUubmV0PgogCiAgICBXcml0dGVuIDIwMDAsMjAwMSBieSBNYXhpbSBLcmFz
bnlhbnNreSA8bWF4a0BxdWFsY29tbS5jb20+CiAKQEAgLTEyMCwxNyArMTIxLDMxIEBAIGVu
dW0gewogI2RlZmluZSBIQ0lfVkVORE9SX1BLVAkJMHhmZgogCiAvKiBIQ0kgcGFja2V0IHR5
cGVzICovCisjZGVmaW5lIEhDSV8yREgxCTB4MDAwMgorI2RlZmluZSBIQ0lfM0RIMQkweDAw
MDQKICNkZWZpbmUgSENJX0RNMQkJMHgwMDA4Ci0jZGVmaW5lIEhDSV9ETTMJCTB4MDQwMAot
I2RlZmluZSBIQ0lfRE01CQkweDQwMDAKICNkZWZpbmUgSENJX0RIMQkJMHgwMDEwCisjZGVm
aW5lIEhDSV8yREgzCTB4MDEwMAorI2RlZmluZSBIQ0lfM0RIMwkweDAyMDAKKyNkZWZpbmUg
SENJX0RNMwkJMHgwNDAwCiAjZGVmaW5lIEhDSV9ESDMJCTB4MDgwMAorI2RlZmluZSBIQ0lf
MkRINQkweDEwMDAKKyNkZWZpbmUgSENJXzNESDUJMHgyMDAwCisjZGVmaW5lIEhDSV9ETTUJ
CTB4NDAwMAogI2RlZmluZSBIQ0lfREg1CQkweDgwMDAKIAogI2RlZmluZSBIQ0lfSFYxCQkw
eDAwMjAKICNkZWZpbmUgSENJX0hWMgkJMHgwMDQwCiAjZGVmaW5lIEhDSV9IVjMJCTB4MDA4
MAogCisjZGVmaW5lIEhDSV9FVjMJCTB4MDAwOAorI2RlZmluZSBIQ0lfRVY0CQkweDAwMTAK
KyNkZWZpbmUgSENJX0VWNQkJMHgwMDIwCisjZGVmaW5lIEhDSV8yRVYzCTB4MDA0MAorI2Rl
ZmluZSBIQ0lfM0VWMwkweDAwODAKKyNkZWZpbmUgSENJXzJFVjUJMHgwMTAwCisjZGVmaW5l
IEhDSV8zRVY1CTB4MDIwMAorCiAjZGVmaW5lIFNDT19QVFlQRV9NQVNLCShIQ0lfSFYxIHwg
SENJX0hWMiB8IEhDSV9IVjMpCiAjZGVmaW5lIEFDTF9QVFlQRV9NQVNLCSh+U0NPX1BUWVBF
X01BU0spCiAKQEAgLTE4Myw2ICsxOTgsMTIgQEAgZW51bSB7CiAjZGVmaW5lIExNUF9QU0NI
RU1FCTB4MDIKICNkZWZpbmUgTE1QX1BDT05UUk9MCTB4MDQKIAorI2RlZmluZSBMTVBfRURS
X0FDTF8yTQkweDAyCisjZGVmaW5lIExNUF9FRFJfQUNMXzNNCTB4MDQKKyNkZWZpbmUgTE1Q
X0VOSF9JU0NBTgkweDA4CisjZGVmaW5lIExNUF9JTEFDRV9JU0NBTgkweDEwCisjZGVmaW5l
IExNUF9JTEFDRV9QU0NBTgkweDIwCisjZGVmaW5lIExNUF9SU1NJX0lOUQkweDQwCiAjZGVm
aW5lIExNUF9FU0NPCTB4ODAKIAogI2RlZmluZSBMTVBfRVY0CQkweDAxCmRpZmYgLXVwck4g
Y29tcGF0LXdpcmVsZXNzLTIuNi4zNi00L25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgY29t
cGF0LXdpcmVsZXNzLTIuNi4zNi00Lm1pbmUvL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMK
LS0tIGNvbXBhdC13aXJlbGVzcy0yLjYuMzYtNC9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5j
CTIwMTAtMTEtMDggMjI6MDA6NTEuMDAwMDAwMDAwIC0wMzAwCisrKyBjb21wYXQtd2lyZWxl
c3MtMi42LjM2LTQubWluZS8vbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYwkyMDEwLTEyLTEx
IDE5OjEzOjQ2LjAwMDAwMDAwMCAtMDMwMApAQCAtMSw2ICsxLDcgQEAKIC8qCiAgICBCbHVl
WiAtIEJsdWV0b290aCBwcm90b2NvbCBzdGFjayBmb3IgTGludXgKICAgIENvcHlyaWdodCAo
YykgMjAwMC0yMDAxLCAyMDEwLCBDb2RlIEF1cm9yYSBGb3J1bS4gQWxsIHJpZ2h0cyByZXNl
cnZlZC4KKyAgIENvcHlyaWdodCAoYykgMjAxMCBOYXJhbmpvIE1hbnVlbCBGcmFuY2lzY28g
PG1hbnVlbEBhaXJjYWJsZS5uZXQ+CiAKICAgIFdyaXR0ZW4gMjAwMCwyMDAxIGJ5IE1heGlt
IEtyYXNueWFuc2t5IDxtYXhrQHF1YWxjb21tLmNvbT4KIApAQCAtNDc4LDYgKzQ3OSwyNiBA
QCBzdGF0aWMgdm9pZCBoY2lfY2NfcmVhZF9sb2NhbF9mZWF0dXJlcyhzCiAJaWYgKGhkZXYt
PmZlYXR1cmVzWzNdICYgTE1QX0VTQ08pCiAJCWhkZXYtPmVzY29fdHlwZSB8PSAoRVNDT19F
VjMpOwogCisJaWYgKGhkZXYtPmZlYXR1cmVzWzNdICYgTE1QX0VEUl9BQ0xfMk0peworCQlo
ZGV2LT5wa3RfdHlwZSB8PSAoSENJXzJESDEpOworCisJCWlmIChoZGV2LT5mZWF0dXJlc1sw
XSAmIExNUF8zU0xPVCkKKwkJICAgIGhkZXYtPnBrdF90eXBlIHw9IChIQ0lfMkRIMyk7CisK
KwkJaWYgKGhkZXYtPmZlYXR1cmVzWzBdICYgTE1QXzVTTE9UKQorCQkgICAgaGRldi0+cGt0
X3R5cGUgfD0gKEhDSV8yREg1KTsKKwl9CisKKwlpZiAoaGRldi0+ZmVhdHVyZXNbM10gJiBM
TVBfRURSX0FDTF8zTSl7CisJCWhkZXYtPnBrdF90eXBlIHw9IChIQ0lfM0RIMSk7CisKKwkJ
aWYgKGhkZXYtPmZlYXR1cmVzWzBdICYgTE1QXzNTTE9UKQorCQkgICAgaGRldi0+cGt0X3R5
cGUgfD0gKEhDSV8zREgzKTsKKworCQlpZiAoaGRldi0+ZmVhdHVyZXNbMF0gJiBMTVBfNVNM
T1QpCisJCSAgICBoZGV2LT5wa3RfdHlwZSB8PSAoSENJXzNESDUpOworCX0KKwogCWlmICho
ZGV2LT5mZWF0dXJlc1s0XSAmIExNUF9FVjQpCiAJCWhkZXYtPmVzY29fdHlwZSB8PSAoRVND
T19FVjQpOwogCg==
--------------080607070206090300040402--
