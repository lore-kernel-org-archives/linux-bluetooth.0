Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1265228415.31341.135.camel@localhost.localdomain>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	<1258082098.7715.7.camel@violet> <35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
	<1258084357.7715.26.camel@violet> <35c90d960911161055y695933fdjd221ad3b689ae3cf@mail.gmail.com>
	<1265228415.31341.135.camel@localhost.localdomain>
From: Nick Pelly <npelly@google.com>
Date: Wed, 3 Feb 2010 16:59:34 -0800
Message-ID: <35c90d961002031659v2a58a80cwdd86c17dc093a07d@mail.gmail.com>
Subject: Re: What is the motivation for conn->power_save
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=000e0cd17fe49483d9047ebbda2d
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd17fe49483d9047ebbda2d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 3, 2010 at 12:20 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Nick,
>
>> >> >> If I understand correctly, conn->power_save prevents the host stac=
k
>> >> >> from requesting active mode if it was not the host stack that
>> >> >> requested sniff mode.
>> >> >>
>> >> >> I don't understand the motivation for this. If we have ACL data to
>> >> >> send, then it seems like a good idea for the host stack to explici=
tly
>> >> >> request active mode, regardless of the reason that we entered snif=
f
>> >> >> mode.
>> >> >>
>> >> >> We want to enter active mode more aggressively when setting up SCO
>> >> >> connections, to avoid a 5 second delay with certain sniff modes. B=
ut
>> >> >> the conn->power_save code is getting in the way and doesn't appear=
 to
>> >> >> be useful in the first place.
>> >> >
>> >> > we have discussed this a few times. And if you lock through the cod=
e
>> >> > history then you see that initially we just took devices out of sni=
ff
>> >> > mode if we had to send data. However with HID devices this falls fl=
at on
>> >> > its face. They need to stay in control of sniff mode if they initia=
ted
>> >> > it. Some of them crash and others just drain the battery. With snif=
f
>> >> > mode you can send small amounts of data even while in sniff and for=
 HID
>> >> > that is sometimes used. So the remote side better not interfere.
>> >> >
>> >> > What we really need is a socket option where we can control this on=
 a
>> >> > per socket basis if we take devices out of sniff mode. And one extr=
a
>> >> > case might be when we try to establish a SCO channel, because then =
it is
>> >> > clearly not an HID device. However even A2DP has this sort of probl=
ems
>> >> > sometimes where the stream setup takes time.
>> >>
>> >> Makes sense. Thanks for the explanation.
>> >
>> > this means you will be working on a patch for this :)
>> >
>> >> > Not sure if we have to make SCO setup special. The only reason woul=
d be
>> >> > if there is a case where we don't get an AT command before SCO need=
s to
>> >> > be established.
>> >>
>> >> If you are in-call, and transfer audio from handset to BT headset,
>> >> then there is SCO setup without any AT command.
>> >
>> > Fair enough.
>> >
>> >> I think for the SCO setup case we would always want to enter active
>> >> mode. I could modify enter_active_mode() to take a parameter like 'in=
t
>> >> force' that would force us to enter active mode regardless of the
>> >> state of power_save, and use this when setting up SCO. What do you
>> >> think?
>> >
>> > Actually when you leave sniff mode, then all bets for the power_save
>> > value are off again. So you better set power_save and just call
>> > enter_active_mode. Something like this:
>> >
>> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> > index a975098..e4591e0 100644
>> > --- a/net/bluetooth/hci_conn.c
>> > +++ b/net/bluetooth/hci_conn.c
>> > @@ -376,6 +376,9 @@ struct hci_conn *hci_connect(struct hci_dev *hdev,=
 int type,
>> >
>> > =A0 =A0 =A0 =A0if (acl->state =3D=3D BT_CONNECTED &&
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(sco->state =3D=3D BT_O=
PEN || sco->state =3D=3D BT_CLOSED)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acl->power_save =3D 1;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(acl);
>> > +
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (lmp_esco_capable(hdev))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_setup_sync(sco, acl=
->handle);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> >
>> > Alternatively we could create hci_conn_force_active_mode() or just
>> > implement a proper per socket sniff/active policy.
>> >
>>
>> Patch submitted to Android tree as:
>>
>> http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dcommit;h=3D201a=
c2f225a31dffcb05f1db4d609c467c9c694c
>
> can you please send a version to the mailing list so I can easily apply
> it and also have it here for reference in the archives.

Patch attached.

Nick

--000e0cd17fe49483d9047ebbda2d
Content-Type: application/octet-stream;
	name="0001-Bluetooth-Enter-active-mode-before-establishing-a-SC.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Enter-active-mode-before-establishing-a-SC.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g58uajvz0

RnJvbSA3ODZkOWE0ODg2MzM4ZTgwYzExNjE1ZGE4MDkxZTZjNTc4NzZhZWYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNrIFBlbGx5IDxucGVsbHlAZ29vZ2xlLmNvbT4KRGF0ZTog
RnJpLCAxMyBOb3YgMjAwOSAxNDoxNjozMiAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEJsdWV0b290
aDogRW50ZXIgYWN0aXZlIG1vZGUgYmVmb3JlIGVzdGFibGlzaGluZyBhIFNDTyBsaW5rLgoKV2hl
biBpbiBzbmlmZiBtb2RlIHdpdGggYSBsb25nIGludGVydmFsIHRpbWUgKDEuMjhzKSBpdCBjYW4g
dGFrZSA0KyBzZWNvbmRzIHRvCmVzdGFibGlzaCBhIFNDTyBsaW5rLiBGaXggYnkgcmVxdWVzdGlu
ZyBhY3RpdmUgbW9kZSBiZWZvcmUgcmVxdWVzdGluZyBTQ08KY29ubmVjdGlvbi4gVGhpcyBpbXBy
b3ZlcyBTQ08gc2V0dXAgdGltZSB0byB+NTAwbXMuCgpCbHVldG9vdGggaGVhZHNldHMgdGhhdCB1
c2UgYSBsb25nIGludGVydmFsIHRpbWUsIGFuZCBleGhpYml0IHRoZSBsb25nIFNDTwpjb25uZWN0
aW9uIHRpbWUgaW5jbHVkZSBNb3Rvcm9sYSBINzkwLCBIWDEgYW5kIEgxNy4gVGhleSBoYXZlIGEg
Q1NSIDIuMSBjaGlwc2V0CgpWZXJpZmllZCB0aGlzIGJlaGF2aW9yIGFuZCBmaXggd2l0aCBob3N0
IEJsdWV0b290aCBjaGlwc2V0czogQkNNNDMyOSBhbmQKVEkxMjcxLgoKMjAwOS0xMC0xMyAxNDox
Nzo0Ni4xODM3MjIgPiBIQ0kgRXZlbnQ6IE1vZGUgQ2hhbmdlICgweDE0KSBwbGVuIDYKICAgIHN0
YXR1cyAweDAwIGhhbmRsZSAxIG1vZGUgMHgwMiBpbnRlcnZhbCAyMDQ4CiAgICBNb2RlOiBTbmlm
ZgoyMDA5LTEwLTEzIDE0OjE3OjUzLjQzNjI4NSA8IEhDSSBDb21tYW5kOiBTZXR1cCBTeW5jaHJv
bm91cyBDb25uZWN0aW9uCiAgICAgICAgKDB4MDF8MHgwMDI4KSBwbGVuIDE3CiAgICBoYW5kbGUg
MSB2b2ljZSBzZXR0aW5nIDB4MDA2MAoyMDA5LTEwLTEzIDE0OjE3OjUzLjQ0NTU5MyA+IEhDSSBF
dmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNAogICAgU2V0dXAgU3luY2hyb25vdXMg
Q29ubmVjdGlvbiAoMHgwMXwweDAwMjgpIHN0YXR1cyAweDAwIG5jbWQgMQoyMDA5LTEwLTEzIDE0
OjE3OjU3Ljc4ODg1NSA+IEhDSSBFdmVudDogU3luY2hyb25vdXMgQ29ubmVjdCBDb21wbGV0ZQog
ICAgICAgICgweDJjKSBwbGVuIDE3CiAgICBzdGF0dXMgMHgwMCBoYW5kbGUgMjU3IGJkYWRkciAw
MDoxQTowRTpGMTpBNDo3RiB0eXBlIGVTQ08KICAgIEFpciBtb2RlOiBDVlNECgpTaWduZWQtb2Zm
LWJ5OiBOaWNrIFBlbGx5IDxucGVsbHlAZ29vZ2xlLmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL2hj
aV9jb25uLmMgfCAgICAzICsrKwogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfY29ubi5jIGIvbmV0
L2JsdWV0b290aC9oY2lfY29ubi5jCmluZGV4IGI3YzQyMjQuLmIxMGUzY2QgMTAwNjQ0Ci0tLSBh
L25ldC9ibHVldG9vdGgvaGNpX2Nvbm4uYworKysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMK
QEAgLTM3Nyw2ICszNzcsOSBAQCBzdHJ1Y3QgaGNpX2Nvbm4gKmhjaV9jb25uZWN0KHN0cnVjdCBo
Y2lfZGV2ICpoZGV2LCBpbnQgdHlwZSwgYmRhZGRyX3QgKmRzdCwgX191OAogCiAJaWYgKGFjbC0+
c3RhdGUgPT0gQlRfQ09OTkVDVEVEICYmCiAJCQkoc2NvLT5zdGF0ZSA9PSBCVF9PUEVOIHx8IHNj
by0+c3RhdGUgPT0gQlRfQ0xPU0VEKSkgeworCQlhY2wtPnBvd2VyX3NhdmUgPSAxOworCQloY2lf
Y29ubl9lbnRlcl9hY3RpdmVfbW9kZShhY2wpOworCiAJCWlmIChsbXBfZXNjb19jYXBhYmxlKGhk
ZXYpKQogCQkJaGNpX3NldHVwX3N5bmMoc2NvLCBhY2wtPmhhbmRsZSk7CiAJCWVsc2UKLS0gCjEu
Ni41LjMKCg==
--000e0cd17fe49483d9047ebbda2d--
