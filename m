Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1232536752.26470.1.camel@californication>
References: <496895AB.4050902@nokia.com>
	 <1231873966.12234.2.camel@californication>
	 <ac290f760901151113jfd2d3b2t8bce890dd186ecbd@mail.gmail.com>
	 <1232061946.15331.1.camel@californication>
	 <ac290f760901151552y2b176f0cjf44a29dabfa8e309@mail.gmail.com>
	 <1232099244.27758.4.camel@californication>
	 <ac290f760901201054r804f79dm5b03abf73e2e89cf@mail.gmail.com>
	 <DD78C3E4-03E2-417F-99B9-7D67B311C643@holtmann.org>
	 <ac290f760901201628u7f1f4fc7xf6fe21de90bdc194@mail.gmail.com>
	 <1232536752.26470.1.camel@californication>
Date: Wed, 21 Jan 2009 09:46:09 -0800
Message-ID: <ac290f760901210946m444454b9we16a563c5f040471@mail.gmail.com>
Subject: Re: [RFC] Some kernel changes
From: jaikumar Ganesh <jaikumarg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nick Pelly <npelly@google.com>, Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Content-Type: multipart/mixed; boundary=00151750d940210ee9046101bb80
List-ID: <linux-bluetooth.vger.kernel.org>

--00151750d940210ee9046101bb80
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Marcel,

On Wed, Jan 21, 2009 at 3:19 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaikumar,
>
>> >>>>> why do you wanna set AUTH_PENDING again. That is not needed we only
>> >>>>> wanna know once encryption comes back on. If no in time, then we just
>> >>>>> disconnect the link. That simple.
>> >>>>>
>> >>>>>>  b) I also see that we are not clearing the timer and hence after
>> >>>>>> RFCOMM_AUTH_TIMEOUT period expires we bring down the RFCOMM connection
>> >>>>>> even though the encryption has been established.
>> >>>>>
>> >>>>> Good catch. Fixed it.
>> >>>>
>> >>>> Cool.  Can you upload it to bluetooth-testing git ? I saw a related
>> >>>> problem while looking at the timer issue and wanted to see if the fix
>> >>>> takes care of it.
>> >>>
>> >>> I am in the process in doing so, but there are other important things
>> >>> that need to be done first.
>> >>
>> >> Sorry to push you on this, is this patch been uploaded ?
>> >
>> > since a few days now. Check the bluetooth-testing.git and it is even rebased
>> > against 2.6.29-rc2.
>> >
>> I applied the patches and I see that we actually don't pause the
>> RFCOMM tx traffic because we don't check on
>> the RFCOMM_SEC_PENDING flag when sending the tx packets in rfcomm_process_dlcs.
>> I verified this using the "attest" command - we keep sending RFCOMM
>> traffic even though encryption is off.
>>
>> Please look at the patch attached.
>>
>> Also should we drop the "rx" packets too  when the encryption is dropped ?
>
> can you get me a version with a proper commit message. Just the subject
> is not gonna be good enough.
>

Sorry, its attached. Also like mentioned above the patch checks only
while sending tx packets ?
Should we drop "rx" packets also ?

> Regards
>
> Marcel
>
>
>

--00151750d940210ee9046101bb80
Content-Type: application/octet-stream;
	name="0001-Bluetooth-When-encyption-is-dropped-do-not-send-RF.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-When-encyption-is-dropped-do-not-send-RF.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fq8acb3x0

RnJvbSBlMmVkMWMxMDZkYTlmZTc2NDkyNGQ2NjJhOWJiOGI5ZGRhZDQ5MTRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWlrdW1hciBHYW5lc2ggPGphaWt1bWFyQGdvb2dsZS5jb20+
CkRhdGU6IFdlZCwgMjEgSmFuIDIwMDkgMDk6NDI6MDEgLTA4MDAKU3ViamVjdDogW1BBVENIXSBC
bHVldG9vdGg6IFdoZW4gZW5jeXB0aW9uIGlzIGRyb3BwZWQsIGRvIG5vdCBzZW5kIFJGQ09NTSB0
eCBwYWNrZXRzLgoKV2hlbiBlbmNyeXB0aW9uIGlzIGRyb3BwZWQgUkZDT01NX1NFQ19QRU5ESU5H
IGZsYWcgZ2V0cyBzZXQuCkNoZWNrIHRoaXMgZmxhZyBiZWZvcmUgc2VuZGluZyB0aGUgdHggcGFj
a2V0cy4KClNpZ25lZC1vZmYtYnk6IEphaWt1bWFyIEdhbmVzaCA8amFpa3VtYXJAZ29vZ2xlLmNv
bT4KLS0tCiBuZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMgfCAgICA1ICsrKystCiAxIGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9u
ZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMK
aW5kZXggYWUyZWNhYS4uNzNmZmMwYyAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9yZmNvbW0v
Y29yZS5jCisrKyBiL25ldC9ibHVldG9vdGgvcmZjb21tL2NvcmUuYwpAQCAtMSw0ICsxLDQgQEAK
LS8qCitmKgogICAgUkZDT01NIGltcGxlbWVudGF0aW9uIGZvciBMaW51eCBCbHVldG9vdGggc3Rh
Y2sgKEJsdWVaKS4KICAgIENvcHlyaWdodCAoQykgMjAwMiBNYXhpbSBLcmFzbnlhbnNreSA8bWF4
a0BxdWFsY29tbS5jb20+CiAgICBDb3B5cmlnaHQgKEMpIDIwMDIgTWFyY2VsIEhvbHRtYW5uIDxt
YXJjZWxAaG9sdG1hbm4ub3JnPgpAQCAtMTc1NCw2ICsxNzU0LDkgQEAgc3RhdGljIGlubGluZSB2
b2lkIHJmY29tbV9wcm9jZXNzX2RsY3Moc3RydWN0IHJmY29tbV9zZXNzaW9uICpzKQogCQkJY29u
dGludWU7CiAJCX0KIAorCQlpZiAodGVzdF9iaXQoUkZDT01NX1NFQ19QRU5ESU5HLCAmZC0+Zmxh
Z3MpKQorCQkJY29udGludWU7CisJCQogCQlpZiAodGVzdF9iaXQoUkZDT01NX1RYX1RIUk9UVExF
RCwgJnMtPmZsYWdzKSkKIAkJCWNvbnRpbnVlOwogCi0tIAoxLjUuNC41Cgo=
--00151750d940210ee9046101bb80--
