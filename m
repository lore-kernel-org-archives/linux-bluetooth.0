Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: acelan@gmail.com
In-Reply-To: <1327948421.1955.143.camel@aeonflux>
References: <1327895375-9162-1-git-send-email-acelan.kao@canonical.com>
	<1327948421.1955.143.camel@aeonflux>
Date: Tue, 31 Jan 2012 11:24:27 +0800
Message-ID: <CAMz9Wg--F=f4eOKpjc0aC4ZR7vcCv7Rj-XGewF1zkA7O4CFY2w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [0cf3:e004]
From: AceLan Kao <acelan.kao@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: multipart/mixed; boundary=f46d040fa1d41eedda04b7ca80f7
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d040fa1d41eedda04b7ca80f7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Marcel,

I just verified that, on 3.0 kernel, the btusb will be loaded after
ath3k. That will lead to the problem.

But, on 3.2 kernel, btusb will be loaded before ath3k.
And I forced it to load ath3k before btusb on 3.2 kernel, and it works
as expected.
So, there is no loading order issue on 3.2 kernel.

I removed the wording about the module loading order and reattach it again.

Best regards,
AceLan Kao.

2012/1/31 Marcel Holtmann <marcel@holtmann.org>:
> Hi AceLan,
>
>> Add another vendor specific ID for Atheros BT device
>>
>> output of usb-devices:
>> T: =A0Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D04 Cnt=3D01 Dev#=3D =A04 Spd=3D=
12 =A0MxCh=3D 0
>> D: =A0Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D =
=A01
>> P: =A0Vendor=3D0cf3 ProdID=3De004 Rev=3D00.02
>> S: =A0Manufacturer=3DAtheros Communications
>> S: =A0Product=3DBluetooth USB Host Controller
>> S: =A0SerialNumber=3DAlaska Day 2006
>> C: =A0#Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>> I: =A0If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>> I: =A0If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>
>> BTW, to enable this device correctly, the btusb module should be loaded
>> before ath3k. So, user should have this line in /etc/modprobe.d/ath3k.co=
nf
>>
>> =A0 =A0install ath3k modprobe btusb; modprobe --ignore-install ath3k;
>
> NAK. Get this fixed properly then.
>
> Regards
>
> Marcel
>
>



--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)

--f46d040fa1d41eedda04b7ca80f7
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Add-support-for-AR3012-0cf3-e004.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Add-support-for-AR3012-0cf3-e004.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gy2d5bfi0

RnJvbSBlMTBjNTA2MmEzMTExMDNlYTk2MjkxZTMxOGFiNDRlNmU5MWMyZDUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBY2VMYW4gS2FvIDxhY2VsYW4ua2FvQGNhbm9uaWNhbC5jb20+
CkRhdGU6IFR1ZSwgMzEgSmFuIDIwMTIgMTA6MjQ6NTQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBC
bHVldG9vdGg6IEFkZCBzdXBwb3J0IGZvciBBUjMwMTIgWzBjZjM6ZTAwNF0KCkFkZCBhbm90aGVy
IHZlbmRvciBzcGVjaWZpYyBJRCBmb3IgQXRoZXJvcyBBUjMwMTIKCm91dHB1dCBvZiB1c2ItZGV2
aWNlczoKVDogIEJ1cz0wMiBMZXY9MDIgUHJudD0wMiBQb3J0PTA0IENudD0wMSBEZXYjPSAgNCBT
cGQ9MTIgIE14Q2g9IDAKRDogIFZlcj0gMS4xMCBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAx
IE14UFM9NjQgI0NmZ3M9ICAxClA6ICBWZW5kb3I9MGNmMyBQcm9kSUQ9ZTAwNCBSZXY9MDAuMDIK
UzogIE1hbnVmYWN0dXJlcj1BdGhlcm9zIENvbW11bmljYXRpb25zClM6ICBQcm9kdWN0PUJsdWV0
b290aCBVU0IgSG9zdCBDb250cm9sbGVyClM6ICBTZXJpYWxOdW1iZXI9QWxhc2thIERheSAyMDA2
CkM6ICAjSWZzPSAyIENmZyM9IDEgQXRyPWUwIE14UHdyPTEwMG1BCkk6ICBJZiM9IDAgQWx0PSAw
ICNFUHM9IDMgQ2xzPWUwKHdsY29uKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9YnR1c2IKSTogIElm
Iz0gMSBBbHQ9IDAgI0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAxIERyaXZlcj1i
dHVzYgoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvYnVncy85MjI3MTUKClNp
Z25lZC1vZmYtYnk6IEFjZUxhbiBLYW8gPGFjZWxhbi5rYW9AY2Fub25pY2FsLmNvbT4KLS0tCiBk
cml2ZXJzL2JsdWV0b290aC9hdGgzay5jIHwgICAgMiArKwogZHJpdmVycy9ibHVldG9vdGgvYnR1
c2IuYyB8ICAgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYXRoM2suYyBiL2RyaXZlcnMv
Ymx1ZXRvb3RoL2F0aDNrLmMKaW5kZXggMDdmMTRkMS4uYjU1ZmM3NiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ibHVldG9vdGgvYXRoM2suYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9hdGgzay5jCkBA
IC03MSw2ICs3MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2RldmljZV9pZCBhdGgza190YWJsZVtd
ID0gewogCiAJLyogQXRoZXJvcyBBUjMwMTIgd2l0aCBzZmxhc2ggZmlybXdhcmUqLwogCXsgVVNC
X0RFVklDRSgweDBDRjMsIDB4MzAwNCkgfSwKKwl7IFVTQl9ERVZJQ0UoMHgwQ0YzLCAweEUwMDQp
IH0sCiAKIAkvKiBBdGhlcm9zIEFSNUJCVTEyIHdpdGggc2ZsYXNoIGZpcm13YXJlICovCiAJeyBV
U0JfREVWSUNFKDB4MDQ4OSwgMHhFMDJDKSB9LApAQCAtODcsNiArODgsNyBAQCBzdGF0aWMgc3Ry
dWN0IHVzYl9kZXZpY2VfaWQgYXRoM2tfYmxpc3RfdGJsW10gPSB7CiAKIAkvKiBBdGhlcm9zIEFS
MzAxMiB3aXRoIHNmbGFzaCBmaXJtd2FyZSovCiAJeyBVU0JfREVWSUNFKDB4MGNmMywgMHgzMDA0
KSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfQVRIMzAxMiB9LAorCXsgVVNCX0RFVklDRSgweDBjZjMs
IDB4ZTAwNCksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX0FUSDMwMTIgfSwKIAogCXsgfQkvKiBUZXJt
aW5hdGluZyBlbnRyeSAqLwogfTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNi
LmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCmluZGV4IGYwMGY1OTYuLjg4ODIzMGEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMKKysrIGIvZHJpdmVycy9ibHVldG9v
dGgvYnR1c2IuYwpAQCAtMTI2LDYgKzEyNiw3IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2RldmljZV9p
ZCBibGFja2xpc3RfdGFibGVbXSA9IHsKIAogCS8qIEF0aGVyb3MgMzAxMiB3aXRoIHNmbGFzaCBm
aXJtd2FyZSAqLwogCXsgVVNCX0RFVklDRSgweDBjZjMsIDB4MzAwNCksIC5kcml2ZXJfaW5mbyA9
IEJUVVNCX0FUSDMwMTIgfSwKKwl7IFVTQl9ERVZJQ0UoMHgwY2YzLCAweGUwMDQpLCAuZHJpdmVy
X2luZm8gPSBCVFVTQl9BVEgzMDEyIH0sCiAKIAkvKiBBdGhlcm9zIEFSNUJCVTEyIHdpdGggc2Zs
YXNoIGZpcm13YXJlICovCiAJeyBVU0JfREVWSUNFKDB4MDQ4OSwgMHhlMDJjKSwgLmRyaXZlcl9p
bmZvID0gQlRVU0JfSUdOT1JFIH0sCi0tIAoxLjcuOC4zCgo=
--f46d040fa1d41eedda04b7ca80f7--
