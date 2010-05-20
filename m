Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinhPeE2hkL_3j_vwOYmRE_kFauO5EYv0Q9_II0r@mail.gmail.com>
References: <AANLkTilNBHEMhl7rFK7DemxPQu3LN2QGWSsL7b-e9Yl3@mail.gmail.com>
	 <20100516083122.GA21819@vigoh>
	 <AANLkTimyNqIdMoZ6J6InYRzD1JNl1Fsv-CdVpd84pjot@mail.gmail.com>
	 <20100517190607.GA19907@vigoh>
	 <AANLkTilyAbXWIHHB1Ae7GP6xlH7zdzd1QZQzYP-NiMjV@mail.gmail.com>
	 <AANLkTinhPeE2hkL_3j_vwOYmRE_kFauO5EYv0Q9_II0r@mail.gmail.com>
Date: Thu, 20 May 2010 17:40:00 +0300
Message-ID: <AANLkTinVStkcq3ekl6P5n1P0UpsiSuRp0HPUgvgRA_uj@mail.gmail.com>
Subject: Re: [PATCH] Kernel crash when krfcomm is preempted by l2cap tasklet
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>, marcel@holtmann.org
Content-Type: multipart/mixed; boundary=00163646b8b2a0a8230487078c6d
List-ID: <linux-bluetooth.vger.kernel.org>

--00163646b8b2a0a8230487078c6d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2010 at 5:13 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi All,
>
> I have done second =A0experimental version of the patch.
>
> Main difference is that when sk is owned by user I do not run
> "l2cap_chan_del" example below:
>
> + =A0 =A0 =A0 /* don't delete l2cap channel if sk is owned by user */
> + =A0 =A0 =A0 if (sock_owned_by_user(sk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_state =3D BT_DISCONN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_sock_clear_timer(sk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_sock_set_timer(sk, HZ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
>
> I start timer which will run this function. I do also the same check
> in timer context.
>
> + =A0 =A0 =A0 if (sock_owned_by_user(sk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* sk is owned by user. Try again later */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_sock_set_timer(sk, HZ * 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sock_put(sk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }

Little modification to the second patch attached.

-- Regards, Andrei

--00163646b8b2a0a8230487078c6d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-Bluetooth-timer-check-sk-is-not-owned-before-freeing.patch"
Content-Disposition: attachment;
	filename="0002-Bluetooth-timer-check-sk-is-not-owned-before-freeing.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9foswvm2

RnJvbSA5OWYzYzk2YjQzMmMyNzMyZGNlOGQ4NDE1NWE4YmUzNDZlNjMzYTU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IFRodSwgMjAgTWF5IDIwMTAgMTY6NTI6MTkgKzAzMDAKU3ViamVj
dDogW1BBVENIdjIgMi8yXSBCbHVldG9vdGg6IHRpbWVyIGNoZWNrIHNrIGlzIG5vdCBvd25lZCBi
ZWZvcmUgZnJlZWluZwoKSW4gdGltZXIgY29udGV4dCB3ZSBtaWdodCBkZWxldGUgbDJjYXAgY2hh
bm5lbCB1c2VkIGJ5IGtyZmNvbW1kLgpUaGUgY2hlY2sgbWFrZXMgc3VyZSB0aGF0IHNrIGlzIG5v
dCBvd25lZC4KClNpZ25lZC1vZmYtYnk6IEFuZHJlaSBFbWVsdGNoZW5rbyA8YW5kcmVpLmVtZWx0
Y2hlbmtvQG5va2lhLmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL2wyY2FwLmMgfCAgIDMyICsrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbDJjYXAu
YyBiL25ldC9ibHVldG9vdGgvbDJjYXAuYwppbmRleCAxMTA2MGQ2Li4xYTZjNWJiIDEwMDY0NAot
LS0gYS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmMKKysrIGIvbmV0L2JsdWV0b290aC9sMmNhcC5jCkBA
IC04NCw2ICs4NCwxOCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKmwyY2FwX2J1aWxkX2NtZChz
dHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwKIAkJCQl1OCBjb2RlLCB1OCBpZGVudCwgdTE2IGRsZW4s
IHZvaWQgKmRhdGEpOwogCiAvKiAtLS0tIEwyQ0FQIHRpbWVycyAtLS0tICovCitzdGF0aWMgdm9p
ZCBsMmNhcF9zb2NrX3NldF90aW1lcihzdHJ1Y3Qgc29jayAqc2ssIGxvbmcgdGltZW91dCkKK3sK
KwlCVF9EQkcoInNrICVwIHN0YXRlICVkIHRpbWVvdXQgJWxkIiwgc2ssIHNrLT5za19zdGF0ZSwg
dGltZW91dCk7CisJc2tfcmVzZXRfdGltZXIoc2ssICZzay0+c2tfdGltZXIsIGppZmZpZXMgKyB0
aW1lb3V0KTsKK30KKworc3RhdGljIHZvaWQgbDJjYXBfc29ja19jbGVhcl90aW1lcihzdHJ1Y3Qg
c29jayAqc2spCit7CisJQlRfREJHKCJzb2NrICVwIHN0YXRlICVkIiwgc2ssIHNrLT5za19zdGF0
ZSk7CisJc2tfc3RvcF90aW1lcihzaywgJnNrLT5za190aW1lcik7Cit9CisKIHN0YXRpYyB2b2lk
IGwyY2FwX3NvY2tfdGltZW91dCh1bnNpZ25lZCBsb25nIGFyZykKIHsKIAlzdHJ1Y3Qgc29jayAq
c2sgPSAoc3RydWN0IHNvY2sgKikgYXJnOwpAQCAtOTMsNiArMTA1LDE0IEBAIHN0YXRpYyB2b2lk
IGwyY2FwX3NvY2tfdGltZW91dCh1bnNpZ25lZCBsb25nIGFyZykKIAogCWJoX2xvY2tfc29jayhz
ayk7CiAKKwlpZiAoc29ja19vd25lZF9ieV91c2VyKHNrKSkgeworCQkvKiBzayBpcyBvd25lZCBi
eSB1c2VyLiBUcnkgYWdhaW4gbGF0ZXIgKi8KKwkJbDJjYXBfc29ja19zZXRfdGltZXIoc2ssIEha
ICogMik7CisJCWJoX3VubG9ja19zb2NrKHNrKTsKKwkJc29ja19wdXQoc2spOworCQlyZXR1cm47
CisJfQorCiAJaWYgKHNrLT5za19zdGF0ZSA9PSBCVF9DT05ORUNURUQgfHwgc2stPnNrX3N0YXRl
ID09IEJUX0NPTkZJRykKIAkJcmVhc29uID0gRUNPTk5SRUZVU0VEOwogCWVsc2UgaWYgKHNrLT5z
a19zdGF0ZSA9PSBCVF9DT05ORUNUICYmCkBAIC0xMDksMTggKzEyOSw2IEBAIHN0YXRpYyB2b2lk
IGwyY2FwX3NvY2tfdGltZW91dCh1bnNpZ25lZCBsb25nIGFyZykKIAlzb2NrX3B1dChzayk7CiB9
CiAKLXN0YXRpYyB2b2lkIGwyY2FwX3NvY2tfc2V0X3RpbWVyKHN0cnVjdCBzb2NrICpzaywgbG9u
ZyB0aW1lb3V0KQotewotCUJUX0RCRygic2sgJXAgc3RhdGUgJWQgdGltZW91dCAlbGQiLCBzaywg
c2stPnNrX3N0YXRlLCB0aW1lb3V0KTsKLQlza19yZXNldF90aW1lcihzaywgJnNrLT5za190aW1l
ciwgamlmZmllcyArIHRpbWVvdXQpOwotfQotCi1zdGF0aWMgdm9pZCBsMmNhcF9zb2NrX2NsZWFy
X3RpbWVyKHN0cnVjdCBzb2NrICpzaykKLXsKLQlCVF9EQkcoInNvY2sgJXAgc3RhdGUgJWQiLCBz
aywgc2stPnNrX3N0YXRlKTsKLQlza19zdG9wX3RpbWVyKHNrLCAmc2stPnNrX3RpbWVyKTsKLX0K
LQogLyogLS0tLSBMMkNBUCBjaGFubmVscyAtLS0tICovCiBzdGF0aWMgc3RydWN0IHNvY2sgKl9f
bDJjYXBfZ2V0X2NoYW5fYnlfZGNpZChzdHJ1Y3QgbDJjYXBfY2hhbl9saXN0ICpsLCB1MTYgY2lk
KQogewotLSAKMS43LjAuNAoK
--00163646b8b2a0a8230487078c6d--
