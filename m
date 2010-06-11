Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinQ_Tr5fwNquGwW9o5LIuqpAGCqHveGuAA1Av3O@mail.gmail.com>
References: <20100610125848.GA28631@botech.co.uk>
	<AANLkTinlsskks35CHsSlDueAGCi4HeicWjHLUTQcfzYC@mail.gmail.com>
	<20100610202023.GC16611@botech.co.uk>
	<AANLkTinQ_Tr5fwNquGwW9o5LIuqpAGCqHveGuAA1Av3O@mail.gmail.com>
Date: Fri, 11 Jun 2010 12:41:54 +0300
Message-ID: <AANLkTilSgydF3eH61rsSZlHILBeW7Yoo-VtpcLzgQUzt@mail.gmail.com>
Subject: Re: bug and possible patch for dbus DiscoverServices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tim Renouf <tpr.vger@botech.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=000e0cd5cf58119ece0488bdf375
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd5cf58119ece0488bdf375
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 11, 2010 at 1:19 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Jun 10, 2010 at 11:20 PM, Tim Renouf <tpr.vger@botech.co.uk> wrot=
e:
>> On Thu, Jun 10, 2010 at 04:48:58PM +0300, Luiz Augusto von Dentz wrote:
>>> I would just rework it a bit to make the tmp_records to always store
>>> the last search, something like the following:
>>>
>>> - =A0 =A0 =A0 if (device->tmp_records && req->records) {
>>> + =A0 =A0 =A0 if (device->tmp_records)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_list_free(device->tmp_records,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (sdp_free_func_t) sdp_record_free);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->tmp_records =3D req->records;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->records =3D NULL;
>>> - =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 device->tmp_records =3D req->records;
>>> + =A0 =A0 =A0 req->records =3D NULL;
>>>
>>> =A0 =A0 =A0 =A0 if (!req->profiles_added && !req->profiles_removed) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("%s: No service update", device->pa=
th);
>>> @@ -1522,7 +1522,7 @@ send_reply:
>>>
>>> =A0 =A0 =A0 =A0 if (dbus_message_is_method_call(req->msg, DEVICE_INTERF=
ACE,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "DiscoverServices"))
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 discover_services_reply(req, err, req->re=
cords);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 discover_services_reply(req, err, device-=
>tmp_records);
>>> =A0 =A0 =A0 =A0 else if (dbus_message_is_method_call(req->msg, ADAPTER_=
INTERFACE,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "CreatePairedDevice"))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 create_device_reply(device, req);
>>>
>>> What do you think?
>>
>> Thanks, that looks good, I'll use that.
>>
>> What is the procedure to get it included in future versions of BlueZ ?
>> Does someone sweep this list for patches to review and possibly
>> include ?
>
> Similar to kernel. git format-patch or git pull request, be sure that
> it applies and compiles cleanly against git master.
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

There were some problems with the changes I suggested previously,
basically  device_probe_drivers was freeing there records before we
return. The following patches should fix this issue and another one
with btd_device_get_record not looking into records storage when it is
missing on temporary cache.

--=20
Luiz Augusto von Dentz
Computer Engineer

--000e0cd5cf58119ece0488bdf375
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-DiscoverServices-not-retrieving-any-records.patch"
Content-Disposition: attachment;
	filename="0001-Fix-DiscoverServices-not-retrieving-any-records.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gaaty8ms0

RnJvbSAyNTk4MmVkMzA5OWY2OGRlMTIwZGRmOGIyMzA4NmUzYWMyODllYmQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IEZyaSwgMTEgSnVuIDIwMTAgMTI6MjQ6MDYgKzAzMDAKU3ViamVj
dDogW1BBVENIIDAxLzEwXSBGaXggRGlzY292ZXJTZXJ2aWNlcyBub3QgcmV0cmlldmluZyBhbnkg
cmVjb3JkcwoKSW4gdGhlIGNhc2UgdGhhdCBkZXZpY2UtPnRtcF9yZWNvcmRzIHdhcyBhbHJlYWR5
IHNldCwgcmVxLT5yZWNvcmRzIHdhcwpiZWluZyBzZXQgdG8gTlVMTCBhbmQgc28gY2F1c2VzIHRo
ZSBlbXB0eSBhcnJheSB0byBiZSByZXR1cm5lZC4KClRvIGZpeCB0aGF0IHRtcF9yZWNvcmRzIG5v
dyBhbHdheXMgaGFzIHRoZSBsYXRlc3QgZGlzY292ZXJlZCByZWNvcmRzIGFuZAppdCBpcyB1c2Vk
IHdoZW4gcmVwbGluZyB0byBEaXNjb3ZlclNlcnZpY2VzLgoKVGhhbmtzIHRvIFRpbSBSZW5vdWYg
PHRwci52Z2VyQGJvdGVjaC5jby51az4gZm9yIGZpZ3VyaW5nIG91dCB3aGVyZSB3YXMKdGhlIHBy
b2JsZW0uCi0tLQogc3JjL2RldmljZS5jIHwgICAxNiArKysrKy0tLS0tLS0tLS0tCiAxIGZpbGVz
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
c3JjL2RldmljZS5jIGIvc3JjL2RldmljZS5jCmluZGV4IDU1ODRkZTkuLjA4NjNhNzkgMTAwNjQ0
Ci0tLSBhL3NyYy9kZXZpY2UuYworKysgYi9zcmMvZGV2aWNlLmMKQEAgLTEyNjcsMTIgKzEyNjcs
NiBAQCBhZGRfdXVpZHM6CiAJCQkJCQlnX3N0cmR1cChsaXN0LT5kYXRhKSwKIAkJCQkJCShHQ29t
cGFyZUZ1bmMpIHN0cmNhc2VjbXApOwogCX0KLQotCWlmIChkZXZpY2UtPnRtcF9yZWNvcmRzKSB7
Ci0JCXNkcF9saXN0X2ZyZWUoZGV2aWNlLT50bXBfcmVjb3JkcywKLQkJCQkoc2RwX2ZyZWVfZnVu
Y190KSBzZHBfcmVjb3JkX2ZyZWUpOwotCQlkZXZpY2UtPnRtcF9yZWNvcmRzID0gTlVMTDsKLQl9
CiB9CiAKIHN0YXRpYyB2b2lkIGRldmljZV9yZW1vdmVfZHJpdmVycyhzdHJ1Y3QgYnRkX2Rldmlj
ZSAqZGV2aWNlLCBHU0xpc3QgKnV1aWRzKQpAQCAtMTQ5MywxMiArMTQ4NywxMiBAQCBzdGF0aWMg
dm9pZCBzZWFyY2hfY2Ioc2RwX2xpc3RfdCAqcmVjcywgaW50IGVyciwgZ3BvaW50ZXIgdXNlcl9k
YXRhKQogCiAJdXBkYXRlX3NlcnZpY2VzKHJlcSwgcmVjcyk7CiAKLQlpZiAoZGV2aWNlLT50bXBf
cmVjb3JkcyAmJiByZXEtPnJlY29yZHMpIHsKKwlpZiAoZGV2aWNlLT50bXBfcmVjb3JkcykKIAkJ
c2RwX2xpc3RfZnJlZShkZXZpY2UtPnRtcF9yZWNvcmRzLAogCQkJCQkoc2RwX2ZyZWVfZnVuY190
KSBzZHBfcmVjb3JkX2ZyZWUpOwotCQlkZXZpY2UtPnRtcF9yZWNvcmRzID0gcmVxLT5yZWNvcmRz
OwotCQlyZXEtPnJlY29yZHMgPSBOVUxMOwotCX0KKworCWRldmljZS0+dG1wX3JlY29yZHMgPSBy
ZXEtPnJlY29yZHM7CisJcmVxLT5yZWNvcmRzID0gTlVMTDsKIAogCWlmICghcmVxLT5wcm9maWxl
c19hZGRlZCAmJiAhcmVxLT5wcm9maWxlc19yZW1vdmVkKSB7CiAJCURCRygiJXM6IE5vIHNlcnZp
Y2UgdXBkYXRlIiwgZGV2aWNlLT5wYXRoKTsKQEAgLTE1MjIsNyArMTUxNiw3IEBAIHNlbmRfcmVw
bHk6CiAKIAlpZiAoZGJ1c19tZXNzYWdlX2lzX21ldGhvZF9jYWxsKHJlcS0+bXNnLCBERVZJQ0Vf
SU5URVJGQUNFLAogCQkJCQkiRGlzY292ZXJTZXJ2aWNlcyIpKQotCQlkaXNjb3Zlcl9zZXJ2aWNl
c19yZXBseShyZXEsIGVyciwgcmVxLT5yZWNvcmRzKTsKKwkJZGlzY292ZXJfc2VydmljZXNfcmVw
bHkocmVxLCBlcnIsIGRldmljZS0+dG1wX3JlY29yZHMpOwogCWVsc2UgaWYgKGRidXNfbWVzc2Fn
ZV9pc19tZXRob2RfY2FsbChyZXEtPm1zZywgQURBUFRFUl9JTlRFUkZBQ0UsCiAJCQkJCQkiQ3Jl
YXRlUGFpcmVkRGV2aWNlIikpCiAJCWNyZWF0ZV9kZXZpY2VfcmVwbHkoZGV2aWNlLCByZXEpOwot
LSAKMS43LjAuNAoK
--000e0cd5cf58119ece0488bdf375
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-Fix-not-looking-into-storage-when-a-record-is-not-fo.patch"
Content-Disposition: attachment;
	filename="0002-Fix-not-looking-into-storage-when-a-record-is-not-fo.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gaatykmo1

RnJvbSA0MGFmYzdkMjljMWE1NmJlNjdlN2ExMTdjMjJkNmRlZmI4M2Y5ZTVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IEZyaSwgMTEgSnVuIDIwMTAgMTI6MTI6MTIgKzAzMDAKU3ViamVj
dDogW1BBVENIIDAyLzEwXSBGaXggbm90IGxvb2tpbmcgaW50byBzdG9yYWdlIHdoZW4gYSByZWNv
cmQgaXMgbm90IGZvdW5kIGluIG1lbW9yeQoKLS0tCiBzcmMvZGV2aWNlLmMgfCAgICA5ICsrKysr
KystLQogMSBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvc3JjL2RldmljZS5jIGIvc3JjL2RldmljZS5jCmluZGV4IDA4NjNhNzkuLjZj
MDg1YTMgMTAwNjQ0Ci0tLSBhL3NyYy9kZXZpY2UuYworKysgYi9zcmMvZGV2aWNlLmMKQEAgLTI0
MTUsOCArMjQxNSwxMyBAQCBjb25zdCBzZHBfcmVjb3JkX3QgKmJ0ZF9kZXZpY2VfZ2V0X3JlY29y
ZChzdHJ1Y3QgYnRkX2RldmljZSAqZGV2aWNlLAogewogCWJkYWRkcl90IHNyYzsKIAotCWlmIChk
ZXZpY2UtPnRtcF9yZWNvcmRzKQotCQlyZXR1cm4gZmluZF9yZWNvcmRfaW5fbGlzdChkZXZpY2Ut
PnRtcF9yZWNvcmRzLCB1dWlkKTsKKwlpZiAoZGV2aWNlLT50bXBfcmVjb3JkcykgeworCQljb25z
dCBzZHBfcmVjb3JkX3QgKnJlY29yZDsKKworCQlyZWNvcmQgPSBmaW5kX3JlY29yZF9pbl9saXN0
KGRldmljZS0+dG1wX3JlY29yZHMsIHV1aWQpOworCQlpZiAocmVjb3JkICE9IE5VTEwpCisJCQly
ZXR1cm4gcmVjb3JkOworCX0KIAogCWFkYXB0ZXJfZ2V0X2FkZHJlc3MoZGV2aWNlLT5hZGFwdGVy
LCAmc3JjKTsKIAotLSAKMS43LjAuNAoK
--000e0cd5cf58119ece0488bdf375--
