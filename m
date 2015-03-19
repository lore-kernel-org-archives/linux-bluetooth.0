Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL-_mTC+jNfN=8qHWi=zJ4t4u8+dU5wfBcebdQ3fj_uSA@mail.gmail.com>
References: <1426712691-5048-1-git-send-email-luiz.dentz@gmail.com>
	<1426712691-5048-6-git-send-email-luiz.dentz@gmail.com>
	<550A7C86.8050403@ubnt.com>
	<CABBYNZL-_mTC+jNfN=8qHWi=zJ4t4u8+dU5wfBcebdQ3fj_uSA@mail.gmail.com>
Date: Thu, 19 Mar 2015 12:56:52 +0200
Message-ID: <CABBYNZ+3zdW1z2xjcyO6pmeU3-9C7Bw1Kh8kAxoHFCfFY_iWCA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] shared/gatt-client: Fix service discovery
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11c34c54bb99010511a20e93
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11c34c54bb99010511a20e93
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andrejs,

On Thu, Mar 19, 2015 at 12:17 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrejs,
>
> On Thu, Mar 19, 2015 at 9:36 AM, Andrejs Hanins <andrejs.hanins@ubnt.com>=
 wrote:
>> Hi Luiz
>>
>> On 2015.03.18. 23:04, Luiz Augusto von Dentz wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> The code should proceed to discover all descriptors before moving to
>>> next service otherwise it may attempt to insert characteristics in the
>>> wrong service which would probably fail.
>>> ---
>>>  src/shared/gatt-client.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>>> index 3e28c6e..729bd87 100644
>>> --- a/src/shared/gatt-client.c
>>> +++ b/src/shared/gatt-client.c
>>> @@ -690,13 +690,13 @@ static void discover_descs_cb(bool success, uint8=
_t att_ecode,
>>>                       goto failed;
>>>       }
>>>
>>> +next:
>>>       if (!discover_descs(op, &discovering))
>>>               goto failed;
>>>
>>>       if (discovering)
>>>               return;
>>>
>>> -next:
>>>       /* Done with the current service */
>>>       gatt_db_service_set_active(op->cur_svc, true);
>>>
>>>
>>
>> I tested this new patch-set and and results are the following:
>> 1. Three characteristics (GAP, GATT and custom) do appear on D-BUs. This=
 was not the case before.
>> 2. CCC descriptor still does not appear on D-Bus. If I change handles on=
 the peripheral back to sequential, then CCC appears on D-Bus also.
>> 3. Reading of any characteristic times out with 'g-io-error-quark: Timeo=
ut was reached (24)'. Logs attached. Based on HCI dumps the ATT reading is =
OK, but for some reason result is not propagated to the D-Bus level, so D-D=
bus method times out. With sequential handles reading works fine.
>
> Strange for me it is working normally:
>
> [NEW] Service /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011
> Battery Service (Primary)
> [NEW] Characteristic
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012 Battery
> Level
> [NEW] Descriptor
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
> Client Characteristic Configuration
> [Arc Touch Mouse SE]# select-attribute
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012
> [Arc Touch Mouse SE:/service0011/char0012]# read
> Attempting to read /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char=
0012
> [CHG] Attribute
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012 Value: 0x5d
>   5d                                               ]
> [Arc Touch Mouse SE:/service0011/char0012]# select-attribute
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
> [Arc Touch Mouse SE:/service0011/char0012/desc0014]# read
> Attempting to read
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
> [CHG] Attribute
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
> Value: 0x00
> [CHG] Attribute
> /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
> Value: 0x00
>   00 00
>
> But perhaps this is because the handles are in sequence as you said,
> can you try with the following changes:
>
> http://fpaste.org/199962/67601931/

See if the attachment works.


--=20
Luiz Augusto von Dentz

--001a11c34c54bb99010511a20e93
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-core-gatt-Fix-not-replying-if-db-operation-fail.patch"
Content-Disposition: attachment;
	filename="0001-core-gatt-Fix-not-replying-if-db-operation-fail.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i7g1ma9i0

RnJvbSBkYmFkMDNiZjE0MzJmMWVlYzMyNjBmNmRiNzdjMDhhY2E1OGUyNTc1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFRodSwgMTkgTWFyIDIwMTUgMTI6NTI6NDcgKzAyMDAKU3ViamVj
dDogW1BBVENIIEJsdWVaXSBjb3JlL2dhdHQ6IEZpeCBub3QgcmVwbHlpbmcgaWYgZGIgb3BlcmF0
aW9uIGZhaWwKCi0tLQogc3JjL2dhdHQtY2xpZW50LmMgfCAyOSArKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NyYy9nYXR0LWNsaWVudC5jIGIvc3JjL2dhdHQtY2xpZW50LmMK
aW5kZXggYTg1YjlkMi4uODBiOWY0NyAxMDA2NDQKLS0tIGEvc3JjL2dhdHQtY2xpZW50LmMKKysr
IGIvc3JjL2dhdHQtY2xpZW50LmMKQEAgLTc3OCwyMCArNzc4LDE5IEBAIHN0YXRpYyB2b2lkIGNo
cmNfcmVhZF9jYihib29sIHN1Y2Nlc3MsIHVpbnQ4X3QgYXR0X2Vjb2RlLCBjb25zdCB1aW50OF90
ICp2YWx1ZSwKIAlzdHJ1Y3QgYXN5bmNfZGJ1c19vcCAqb3AgPSB1c2VyX2RhdGE7CiAJc3RydWN0
IGNoYXJhY3RlcmlzdGljICpjaHJjID0gb3AtPmRhdGE7CiAJc3RydWN0IHNlcnZpY2UgKnNlcnZp
Y2UgPSBjaHJjLT5zZXJ2aWNlOworCURCdXNNZXNzYWdlICpyZXBseTsKIAotCWlmICghc3VjY2Vz
cykgewotCQlEQnVzTWVzc2FnZSAqcmVwbHkgPSBjcmVhdGVfZ2F0dF9kYnVzX2Vycm9yKG9wLT5t
c2csIGF0dF9lY29kZSk7Ci0KLQkJY2hyYy0+cmVhZF9pZCA9IDA7Ci0JCWdfZGJ1c19zZW5kX21l
c3NhZ2UoYnRkX2dldF9kYnVzX2Nvbm5lY3Rpb24oKSwgcmVwbHkpOwotCQlyZXR1cm4gOwotCX0K
KwlpZiAoIXN1Y2Nlc3MpCisJCWdvdG8gZmFpbDsKIAogCWlmICghb3AtPm9mZnNldCkKIAkJZ2F0
dF9kYl9hdHRyaWJ1dGVfcmVzZXQoY2hyYy0+YXR0cik7CiAKLQlnYXR0X2RiX2F0dHJpYnV0ZV93
cml0ZShjaHJjLT5hdHRyLCBvcC0+b2Zmc2V0LCB2YWx1ZSwgbGVuZ3RoLCAwLCBOVUxMLAotCQkJ
CQkJd3JpdGVfY2hhcmFjdGVyaXN0aWNfY2IsIGNocmMpOworCWlmICghZ2F0dF9kYl9hdHRyaWJ1
dGVfd3JpdGUoY2hyYy0+YXR0ciwgb3AtPm9mZnNldCwgdmFsdWUsIGxlbmd0aCwgMCwKKwkJCQkJ
TlVMTCwgd3JpdGVfY2hhcmFjdGVyaXN0aWNfY2IsIGNocmMpKSB7CisJCWVycm9yKCJGYWlsZWQg
dG8gc3RvcmUgYXR0cmlidXRlIik7CisJCWdvdG8gZmFpbDsKKwl9CiAKIAkvKgogCSAqIElmIHRo
ZSB2YWx1ZSBsZW5ndGggaXMgZXhhY3RseSBNVFUtMSwgdGhlbiB3ZSBtYXkgbm90IGhhdmUgcmVh
ZCB0aGUKQEAgLTgxNCw3ICs4MTMsMTcgQEAgc3RhdGljIHZvaWQgY2hyY19yZWFkX2NiKGJvb2wg
c3VjY2VzcywgdWludDhfdCBhdHRfZWNvZGUsIGNvbnN0IHVpbnQ4X3QgKnZhbHVlLAogCWNocmMt
PnJlYWRfaWQgPSAwOwogCiAJLyogUmVhZCB0aGUgc3RvcmVkIGRhdGEgZnJvbSBkYiAqLwotCWdh
dHRfZGJfYXR0cmlidXRlX3JlYWQoY2hyYy0+YXR0ciwgMCwgMCwgTlVMTCwgcmVhZF9vcF9jYiwg
b3ApOworCWlmICghZ2F0dF9kYl9hdHRyaWJ1dGVfcmVhZChjaHJjLT5hdHRyLCAwLCAwLCBOVUxM
LCByZWFkX29wX2NiLCBvcCkpIHsKKwkJZXJyb3IoIkZhaWxlZCB0byByZWFkIGRhdGFiYXNlIik7
CisJCWdvdG8gZmFpbDsKKwl9CisKKwlyZXR1cm47CisKK2ZhaWw6CisJcmVwbHkgPSBjcmVhdGVf
Z2F0dF9kYnVzX2Vycm9yKG9wLT5tc2csIGF0dF9lY29kZSk7CisJY2hyYy0+cmVhZF9pZCA9IDA7
CisJZ19kYnVzX3NlbmRfbWVzc2FnZShidGRfZ2V0X2RidXNfY29ubmVjdGlvbigpLCByZXBseSk7
CiB9CiAKIHN0YXRpYyBEQnVzTWVzc2FnZSAqY2hhcmFjdGVyaXN0aWNfcmVhZF92YWx1ZShEQnVz
Q29ubmVjdGlvbiAqY29ubiwKLS0gCjIuMS4wCgo=
--001a11c34c54bb99010511a20e93--
