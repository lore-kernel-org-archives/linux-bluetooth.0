Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <DD78C3E4-03E2-417F-99B9-7D67B311C643@holtmann.org>
References: <496895AB.4050902@nokia.com>
	 <1231768413.23749.1.camel@californication>
	 <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com>
	 <1231873966.12234.2.camel@californication>
	 <ac290f760901151113jfd2d3b2t8bce890dd186ecbd@mail.gmail.com>
	 <1232061946.15331.1.camel@californication>
	 <ac290f760901151552y2b176f0cjf44a29dabfa8e309@mail.gmail.com>
	 <1232099244.27758.4.camel@californication>
	 <ac290f760901201054r804f79dm5b03abf73e2e89cf@mail.gmail.com>
	 <DD78C3E4-03E2-417F-99B9-7D67B311C643@holtmann.org>
Date: Tue, 20 Jan 2009 16:28:46 -0800
Message-ID: <ac290f760901201628u7f1f4fc7xf6fe21de90bdc194@mail.gmail.com>
Subject: Re: [RFC] Some kernel changes
From: jaikumar Ganesh <jaikumarg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nick Pelly <npelly@google.com>, Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Content-Type: multipart/mixed; boundary=000e0cd6b21a26c2ba0460f33d45
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd6b21a26c2ba0460f33d45
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Marcel

On Tue, Jan 20, 2009 at 12:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
>>>>> why do you wanna set AUTH_PENDING again. That is not needed we only
>>>>> wanna know once encryption comes back on. If no in time, then we just
>>>>> disconnect the link. That simple.
>>>>>
>>>>>>  b) I also see that we are not clearing the timer and hence after
>>>>>> RFCOMM_AUTH_TIMEOUT period expires we bring down the RFCOMM connection
>>>>>> even though the encryption has been established.
>>>>>
>>>>> Good catch. Fixed it.
>>>>
>>>> Cool.  Can you upload it to bluetooth-testing git ? I saw a related
>>>> problem while looking at the timer issue and wanted to see if the fix
>>>> takes care of it.
>>>
>>> I am in the process in doing so, but there are other important things
>>> that need to be done first.
>>
>> Sorry to push you on this, is this patch been uploaded ?
>
> since a few days now. Check the bluetooth-testing.git and it is even rebased
> against 2.6.29-rc2.
>
> Regards
>
> Marcel
>
>
I applied the patches and I see that we actually don't pause the
RFCOMM tx traffic because we don't check on
the RFCOMM_SEC_PENDING flag when sending the tx packets in rfcomm_process_dlcs.
I verified this using the "attest" command - we keep sending RFCOMM
traffic even though encryption is off.

Please look at the patch attached.

Also should we drop the "rx" packets too  when the encryption is dropped ?

Thanks
Jaikumar

--000e0cd6b21a26c2ba0460f33d45
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-When-encryption-is-off-do-not-send-RFCOM.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-When-encryption-is-off-do-not-send-RFCOM.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fq79b8ak0

RnJvbSA1NzRmMzk0MzgwOGIyNDlmZGI4OWFjNDdlMThhZTliZWQwZDA5MzMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWlrdW1hciBHYW5lc2ggPGphaWt1bWFyQGdvb2dsZS5jb20+
CkRhdGU6IFR1ZSwgMjAgSmFuIDIwMDkgMTY6MjY6MzEgLTA4MDAKU3ViamVjdDogW1BBVENIXSBC
bHVldG9vdGg6IFdoZW4gZW5jcnlwdGlvbiBpcyBvZmYsIGRvIG5vdCBzZW5kIFJGQ09NTSB0eCBw
YWNrZXRzLgoKU2lnbmVkLW9mZi1ieTogSmFpa3VtYXIgR2FuZXNoIDxqYWlrdW1hckBnb29nbGUu
Y29tPgotLS0KIG5ldC9ibHVldG9vdGgvcmZjb21tL2NvcmUuYyB8ICAgIDMgKysrCiAxIGZpbGVz
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9u
ZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMK
aW5kZXggYWUyZWNhYS4uZThhYWY3OCAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9yZmNvbW0v
Y29yZS5jCisrKyBiL25ldC9ibHVldG9vdGgvcmZjb21tL2NvcmUuYwpAQCAtMTc1NCw2ICsxNzU0
LDkgQEAgc3RhdGljIGlubGluZSB2b2lkIHJmY29tbV9wcm9jZXNzX2RsY3Moc3RydWN0IHJmY29t
bV9zZXNzaW9uICpzKQogCQkJY29udGludWU7CiAJCX0KIAorCQlpZiAodGVzdF9iaXQoUkZDT01N
X1NFQ19QRU5ESU5HLCAmZC0+ZmxhZ3MpKQorCQkJY29udGludWU7CisKIAkJaWYgKHRlc3RfYml0
KFJGQ09NTV9UWF9USFJPVFRMRUQsICZzLT5mbGFncykpCiAJCQljb250aW51ZTsKIAotLSAKMS41
LjQuNQoK
--000e0cd6b21a26c2ba0460f33d45--
