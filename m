Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <f9d4bd31001261033g2d23a089r21069797fea38d9b@mail.gmail.com>
References: <f9d4bd31001251014w1caaa753v39254c3031f5db0e@mail.gmail.com>
	 <2d5a2c101001260309h4464805eg3e52ace6dd28f677@mail.gmail.com>
	 <f9d4bd31001261033g2d23a089r21069797fea38d9b@mail.gmail.com>
Date: Wed, 27 Jan 2010 10:21:27 +0200
Message-ID: <2d5a2c101001270021m54f3e905rfeac8c2b8bc8156f@mail.gmail.com>
Subject: Re: bluetoothd bug
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Johan Hedberg <johan.hedberg@nokia.com>, luiz.dentz-von@nokia.com,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=0016e6d97682c2f995047e2116ec
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6d97682c2f995047e2116ec
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Tue, Jan 26, 2010 at 8:33 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> On Tue, Jan 26, 2010 at 9:09 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Claudio,
>>
>> On Mon, Jan 25, 2010 at 8:14 PM, Claudio Takahasi
>> <claudio.takahasi@openbossa.org> wrote:
>>> Hi Johan/Luiz,
>>>
>>> I found an error "invalid read". The pastebin log shows a PBAP
>>> connection in the RFCOMM channel 15. See line 195 of the first log,
>>> when the connection is refused the "temporary" device is being
>>> removed, however it seems that the "reverse" SDP query still active.
>>> PTS is establishing RFCOMM connection before "Encrypt Change" event,
>>> but this wrong procedure should not "harm" bluetoothd. In some cases I
>>> noticed segmentation fault, probably due this error.
>>>
>>> http://pastebin.com/m308f85ef
>>> http://pastebin.com/m2d80dd71
>>
>> Does this fix the problem:
>>
>> diff --git a/src/device.c b/src/device.c
>> index a2730ab..dfdacd8 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -239,6 +239,9 @@ static void device_free(gpointer user_data)
>> =A0 =A0 =A0 =A0if (device->disconn_timer)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g_source_remove(device->disconn_timer);
>>
>> + =A0 =A0 =A0 if (device->discov_timer)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_source_remove(device->discov_timer);
>> +
>> =A0 =A0 =A0 =A0debug("device_free(%p)", device);
>>
>> =A0 =A0 =A0 =A0g_free(device->authr);
>>
>>
>> --
>> Luiz Augusto von Dentz
>> Engenheiro de Computa=E7=E3o
>>
>
> Hi Luiz,
>
> yep, it is working perfectly: no warning/no segmentation fault.
>
> Claudio.
>

Great, not sure how PTS was able to trigger it since it seems to be
passing bonding phase without resetting temporary flag which would
mean bonding fails and would not even schedule the reversal service
discovery, but a segfault is always a bug no matter what stupid things
PTS is doing.

Proper git patch attached.

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

--0016e6d97682c2f995047e2116ec
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-possible-invalid-read-when-removing-a-temporary-.patch"
Content-Disposition: attachment;
	filename="0001-Fix-possible-invalid-read-when-removing-a-temporary-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4xuj4e00

RnJvbSBiZTBjMTM3MzQ5OWJiYzQ4MDI5ODQyOTEwOTEyNGVmYmJlNDlmMTVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IFR1ZSwgMjYgSmFuIDIwMTAgMTY6MTc6MjEgKzAyMDAKU3ViamVj
dDogW1BBVENIIDEvNl0gRml4IHBvc3NpYmxlIGludmFsaWQgcmVhZCB3aGVuIHJlbW92aW5nIGEg
dGVtcG9yYXJ5IGRldmljZQoKQW4gaW52YWxpZCByZWFkIG1heSBoYXBwZW5zIHdoZW4gZG9pbmcg
dGhlIHJldmVyc2Ugc2VydmljZSBkaXNjb3ZlcnkgYnV0CmZvciBzb21lIHJlYXNvbiB0aGUgZGV2
aWNlIGRpc2Nvbm5lY3RzIHdpdGggdGhlIHRlbXBvcmFyeSBmbGFnIHNldCB3aGljaAp3aWxsIG1h
a2UgdGhlIGRldmljZSB0byBiZSByZW1vdmVkIHdpdGhvdXQgY2FuY2VsbGluZyB0aGUgc2Vydmlj
ZS4KLS0tCiBzcmMvZGV2aWNlLmMgfCAgICAzICsrKwogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2RldmljZS5jIGIvc3Jj
L2RldmljZS5jCmluZGV4IGEyNzMwYWIuLmRmZGFjZDggMTAwNjQ0Ci0tLSBhL3NyYy9kZXZpY2Uu
YworKysgYi9zcmMvZGV2aWNlLmMKQEAgLTIzOSw2ICsyMzksOSBAQCBzdGF0aWMgdm9pZCBkZXZp
Y2VfZnJlZShncG9pbnRlciB1c2VyX2RhdGEpCiAJaWYgKGRldmljZS0+ZGlzY29ubl90aW1lcikK
IAkJZ19zb3VyY2VfcmVtb3ZlKGRldmljZS0+ZGlzY29ubl90aW1lcik7CiAKKwlpZiAoZGV2aWNl
LT5kaXNjb3ZfdGltZXIpCisJCWdfc291cmNlX3JlbW92ZShkZXZpY2UtPmRpc2Nvdl90aW1lcik7
CisKIAlkZWJ1ZygiZGV2aWNlX2ZyZWUoJXApIiwgZGV2aWNlKTsKIAogCWdfZnJlZShkZXZpY2Ut
PmF1dGhyKTsKLS0gCjEuNi4zLjMKCg==
--0016e6d97682c2f995047e2116ec--
