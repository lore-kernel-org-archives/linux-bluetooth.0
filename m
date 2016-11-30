Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1480498971.2363.1.camel@toniob.net>
References: <1480481503.2256.4.camel@gmail.com> <1480498971.2363.1.camel@toniob.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Nov 2016 16:54:18 +0200
Message-ID: <CABBYNZ+cfdym=m+Xn2kT_E74Vq81XTKB5mzv_JOWa7vvcHXVrg@mail.gmail.com>
Subject: Re: Continuing the Xbox One Bluetooth controller debugging
To: Anthony Bourguignon <contact@toniob.net>
Cc: Cameron Gutman <aicommander@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: multipart/mixed; boundary=001a11412f362d05e1054285e1a5
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11412f362d05e1054285e1a5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 30, 2016 at 11:42 AM, Anthony Bourguignon
<contact@toniob.net> wrote:
> Le mardi 29 novembre 2016 =C3=A0 20:51 -0800, Cameron Gutman a =C3=A9crit=
 :
>> Hi,
>>
>> I'm interesting in continuing the debugging of the Xbox One S
>> controller's issues with the BlueZ stack (original report [0]).
>> I confirmed the issue still affects v4.9-rc7. I've also tried
>> Vinicius's patch from [1] applied on v4.9-rc7 without success.
>>
>> The controller is updated with the latest firmware and connects
>> reliably to (at least) macOS Sierra, Windows 10 14393, Android
>> 6.0.1, 7.0, and 7.1.1 (including devices using 3.10 and 3.18
>> based kernels).
>>
>> I'm happy to collect logs, test other patches, etc.
>
> Steam has made a patch referencing the xbox one S controller :
> https://github.com/ValveSoftware/steamlink-sdk/commit/d6afa93787217033a0f=
0f5db5f557b252c36260e#diff-
> 45ba5a41f43606276c9bf9018eed43c2
>
> You should check this.

That is a big hammer, instead I was thinking in just ignoring the
Unknown option since basic mode is default, so please check with the
following patch.

--=20
Luiz Augusto von Dentz

--001a11412f362d05e1054285e1a5
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-L2CAP-Ignore-Unknown-option-error-for-basi.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-L2CAP-Ignore-Unknown-option-error-for-basi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iw51zf8h0

RnJvbSBjN2U0NzFhMDgyZDZmYzNjYmZmNDJmNmUxOTRmNjRkNzkxYTliMWM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFdlZCwgMzAgTm92IDIwMTYgMTY6NDU6MTMgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBCbHVldG9vdGg6IEwyQ0FQOiBJZ25vcmUgVW5rbm93biBvcHRpb24gZXJyb3Ig
Zm9yIGJhc2ljIG1vZGUKClNvbWUgZGV2aWNlcyBzZW5kIFVua25vd24gb3B0aW9uIGluIGNhc2Ug
aXQgb25seSBzdXBwb3J0IGJhc2ljIG1vZGUKd2hpY2ggd2lsbCBjYXVzZSB0aGUgY2hhbm5lbCB0
aGUgYmUgZGlzY29ubmVjdCwgc28gaW5zdGVhZCB0aGUgY29kZQpub3cganVzdCBjaGVjayBpZiB0
aGUgVW5rbm93biBvcHRpb24gaXMgUkZDIGFuZCB0aGUgY2hhbm5lbCBtb2RlIGlzCmJhc2ljIGFu
ZCBpZ25vcmUgdGhlIGVycm9yLgoKU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3RvIHZvbiBEZW50
eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvbDJjYXBfY29y
ZS5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL2wy
Y2FwX2NvcmUuYwppbmRleCA3NGFiYzUzLi5jMGRkYWNlIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRv
b3RoL2wyY2FwX2NvcmUuYworKysgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYwpAQCAtNDIw
Niw2ICs0MjA2LDE3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGwyY2FwX2NvbmZpZ19yc3Aoc3RydWN0
IGwyY2FwX2Nvbm4gKmNvbm4sCiAJCQlpZiAocmVzdWx0ICE9IEwyQ0FQX0NPTkZfU1VDQ0VTUykK
IAkJCQlnb3RvIGRvbmU7CiAJCQlicmVhazsKKwl9CisKKwljYXNlIEwyQ0FQX0NPTkZfVU5LTk9X
TjoKKwkJLyogSWdub3JlIHVua3dvd24gb3B0aW9uIGZvciBSRkMgaW4gY2FzZSBvZiBiYXNpYyBt
b2RlIGFzIGl0CisJCSAqIGlzIGNvbnNpZGVyZWQgdGhlIGRlZmF1bHQgbW9kZToKKwkJICogQkxV
RVRPT1RIIFNQRUNJRklDQVRJT04gVmVyc2lvbiA0LjIgW1ZvbCAzLCBQYXJ0IEFdIHBhZ2UgOTY6
CisJCSAqIFRoZSBCYXNpYyBMMkNBUCBtb2RlIGlzIHRoZSBkZWZhdWx0LgorCQkgKi8KKwkJaWYg
KHJzcC0+ZGF0YSA9PSBMMkNBUF9DT05GX1JGQyAmJgorCQkgICAgY2hhbi0+bW9kZSA9PSBMMkNB
UF9NT0RFX0JBU0lDKSB7CisJCQlicmVhazsKIAkJfQogCiAJZGVmYXVsdDoKLS0gCjIuOS4zCgo=
--001a11412f362d05e1054285e1a5--
