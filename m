Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=qB6WcjkQcp0teuL5DTKKBSSK0ydWD1EtwCh=n@mail.gmail.com>
References: <AANLkTi=yuqTG1MiqN3FHM+2m0OX9QNajq8+xJG_D1-EG@mail.gmail.com>
	<AANLkTi=qB6WcjkQcp0teuL5DTKKBSSK0ydWD1EtwCh=n@mail.gmail.com>
Date: Sat, 12 Feb 2011 00:47:58 -0600
Message-ID: <AANLkTinsnjed16owx=JqCCPa3AMC3P_Z9qLNd8AZ4jyf@mail.gmail.com>
Subject: Re: HCI core error recovery.
From: Andrei Warkentin <andreiw@motorola.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=90e6ba53a2fcf2d2b4049c10317f
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--90e6ba53a2fcf2d2b4049c10317f
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 11, 2011 at 5:07 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> Dear List,
>
> I've run into an interesting problem. Excuse me in advance if this was
> already covered here, or for my explanations, since I'm not too
> familiar with overall flow within BlueZ or Bluetooth specifics...
> We've had some hardware config issues that resulted in garbage/malformed
> messages arriving via H4 into the HCI layer. We've since resolved
> these, but it got me thinking. The issues would result in certain HCI
> messages being missed, including occasionally disconnect events being
> missed, and a subsequent connect event would result in a double add.
>
> I was thinking about how to fix at the very least the crash. The sysfs
> object is created as a last step after getting a "connection
> completed" HCI message, I think. What I am unsure about is if it's
> safe to just ignore the add if there is already a sysfs entry...
>
> So I would think the HCI core needs some resiliency against
> bad/malignant bluetooth controllers, and perform error
> recovery/resynchronization. Perhaps maybe there is room for a virtual
> hci controller that just injects various message types to see how well
> the core can cope?
>
> Thanks in advance,
> A

To further explain the issue, here is what was happening -

0) A BT device is paired.
1) Host goes into sleep mode.
2) BT device turns off.
3) Host wakes up due to BT waking the host. Due to UART resume issues,
HCI message corrupted. hci_disconn_complete_evt never gets called.
4) BT device turns on.
5) devref gets incremented in  hci_conn_complete_evt, and is now 2.
6) BT device turns off. hci_disconn_complete_evt is called, conn hash
is deleted, but sysfs entry not cleaned up since
atomic_dec_and_test(&conn->devref) != 0.
7) BT device turns on. sysfs add fails since it never was cleaned up.

The attached patch takes care of that. I'm not too familiar with BlueZ
(or bluetooth :-(), so I would like your feedback. In particular, I am
unsure about sync connections.
The primary issue overall is that HCI core doesn't handle HCI issues
(whether caused by transport issues, or bad/malicious BT controller).
I am curious if there are other ways to break the core.

Thanks,
A

--90e6ba53a2fcf2d2b4049c10317f
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-BlueZ-HCI-Be-more-resilient-to-HCI-protocol-problems.patch"
Content-Disposition: attachment;
	filename="0001-BlueZ-HCI-Be-more-resilient-to-HCI-protocol-problems.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gk27ntlk0

RnJvbSA0MzZiZjY4NGY4YzBiOWM5MmNlN2FhMjFhZjRmNTNmYTU2MjliZjk0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgV2Fya2VudGluIDxhbmRyZWl3QG1vdG9yb2xhLmNv
bT4KRGF0ZTogU2F0LCAxMiBGZWIgMjAxMSAwMToyNToyNSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hd
IEJsdWVaOiBIQ0k6IEJlIG1vcmUgcmVzaWxpZW50IHRvIEhDSSBwcm90b2NvbCBwcm9ibGVtcy4K
CkRvIG5vdCBjb3JydXB0IGtlcm5lbCBzdHJ1Y3RzIG9uIGNvbm5lY3QgbWVzc2FnZSBoYW5kbGlu
ZyBhZnRlcgphIG1pc3NlZCAoZHVlIHRvIEhDSSB0cmFuc3BvcnQgaXNzdWVzIG9yIGJhZCBCVCBj
b250cm9sbGVyKQpkaXNjb25uZWN0IGV2ZW50IG1lc3NhZ2UuCgpDaGFuZ2UtSWQ6IEk4ZjQ2MTA2
ODg5NmY3NDk3ZjFlMDEyN2VhMjJhZTZmMDdhZTg3NmI3ClNpZ25lZC1vZmYtYnk6IEFuZHJlaSBX
YXJrZW50aW4gPGFuZHJlaXdAbW90b3JvbGEuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX2V2
ZW50LmMgfCAgIDIzICsrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290
aC9oY2lfZXZlbnQuYyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMKaW5kZXggYmJiNDQ0MS4u
NWJmNTFmMCAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYworKysgYi9uZXQv
Ymx1ZXRvb3RoL2hjaV9ldmVudC5jCkBAIC04OTUsOCArODk1LDE1IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBoY2lfY29ubl9jb21wbGV0ZV9ldnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBz
a19idWZmICpzCiAJCX0gZWxzZQogCQkJY29ubi0+c3RhdGUgPSBCVF9DT05ORUNURUQ7CiAKLQkJ
aGNpX2Nvbm5faG9sZF9kZXZpY2UoY29ubik7Ci0JCWhjaV9jb25uX2FkZF9zeXNmcyhjb25uKTsK
KwkJLyogV2UgY291bGQgaGF2ZSBzb21laG93IG5vdCBoY2lfY29ubl9kZWwtZXRlZCwgZHVlCisJ
CSAgIHRvIGVycm9ycyBpbiB0aGUgSENJIHRyYW5zcG9ydC4gKi8KKwkJaWYgKGF0b21pY19yZWFk
KCZjb25uLT5kZXZyZWYpID09IDApIHsKKwkJCWhjaV9jb25uX2hvbGRfZGV2aWNlKGNvbm4pOwor
CQkJaGNpX2Nvbm5fYWRkX3N5c2ZzKGNvbm4pOworCQl9IGVsc2UgeworCQkJQlRfRVJSKCJjb25u
ZWN0aW9uIHRvICVzIHdhcyBuZXZlciB0b3JuIGRvd24iLCBiYXRvc3RyKCZldi0+YmRhZGRyKSk7
CisJCQloY2lfcHJvdG9fZGlzY29ubl9jZm0oY29ubiwgMHgxNik7CisJCX0KIAogCQlpZiAodGVz
dF9iaXQoSENJX0FVVEgsICZoZGV2LT5mbGFncykpCiAJCQljb25uLT5saW5rX21vZGUgfD0gSENJ
X0xNX0FVVEg7CkBAIC0xNjk3LDggKzE3MDQsMTYgQEAgc3RhdGljIGlubGluZSB2b2lkIGhjaV9z
eW5jX2Nvbm5fY29tcGxldGVfZXZ0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tfYnUK
IAkJY29ubi0+aGFuZGxlID0gX19sZTE2X3RvX2NwdShldi0+aGFuZGxlKTsKIAkJY29ubi0+c3Rh
dGUgID0gQlRfQ09OTkVDVEVEOwogCi0JCWhjaV9jb25uX2hvbGRfZGV2aWNlKGNvbm4pOwotCQlo
Y2lfY29ubl9hZGRfc3lzZnMoY29ubik7CisJCS8qIFdlIGNvdWxkIGhhdmUgc29tZWhvdyBub3Qg
aGNpX2Nvbm5fZGVsLWV0ZWQsIGR1ZQorCQkgICB0byBlcnJvcnMgaW4gdGhlIEhDSSB0cmFuc3Bv
cnQuICovCisJCWlmIChhdG9taWNfcmVhZCgmY29ubi0+ZGV2cmVmKSA9PSAwKSB7CisJCQloY2lf
Y29ubl9ob2xkX2RldmljZShjb25uKTsKKwkJCWhjaV9jb25uX2FkZF9zeXNmcyhjb25uKTsKKwkJ
fSBlbHNlIHsKKwkJCUJUX0VSUigic3luYyBjb25uZWN0aW9uIHRvICVzIHdhcyBuZXZlciB0b3Ju
IGRvd24iLCBiYXRvc3RyKCZldi0+YmRhZGRyKSk7CisJCQloY2lfcHJvdG9fZGlzY29ubl9jZm0o
Y29ubiwgMHgxNik7CisJCX0KKwogCQlicmVhazsKIAogCWNhc2UgMHgxMDoJLyogQ29ubmVjdGlv
biBBY2NlcHQgVGltZW91dCAqLwotLSAKMS43LjAuNAoK
--90e6ba53a2fcf2d2b4049c10317f--
