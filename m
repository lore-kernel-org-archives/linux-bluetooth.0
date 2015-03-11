Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACgKv-KJjZ7y=0PeE5rz5NEiPKNFOsJekdyHjz65JN0=LqmNoA@mail.gmail.com>
References: <CACgKv-KJjZ7y=0PeE5rz5NEiPKNFOsJekdyHjz65JN0=LqmNoA@mail.gmail.com>
Date: Wed, 11 Mar 2015 21:46:04 +0200
Message-ID: <CABBYNZL3yRRvy9FXhko+VXJ0d901iUH=W6DM1Lci3zKRJapb_A@mail.gmail.com>
Subject: Re: Missing events after reconnect (BLE)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jacob Siverskog <jacob@teenageengineering.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11c22216912f610511088415
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11c22216912f610511088415
Content-Type: text/plain; charset=UTF-8

Hi Jacob,

On Mon, Mar 9, 2015 at 6:11 PM, Jacob Siverskog
<jacob@teenageengineering.com> wrote:
> Hi!
> We're developing a BLE remote control with a HID profile that goes to
> sleep after being idle some time. It is waken
> up by pressing a button on it, after waking up it performs undirected
> advertising towards the host.
>
> Sometimes we see that the press is not registered by the host. We can
> see the press in btmon but it never ends up in /dev/input/XXX.
> Subsequent presses works fine.
>
> Attached are two btmon logs. What I can see is that the "press event"
> (Handle Value Notification) is received earlier in the working case.
>
> Are we simply sending the event too early? Or is there any other issue?

Sorry for the delay, for some reason this message went to my spam
folder, anyway the problem we have is that we are not processing
notification while MTU exchange is pending, please try with the
attached patch (not tested so it may actually not work).

-- 
Luiz Augusto von Dentz

--001a11c22216912f610511088415
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-core-device-Fix-not-handling-notification.patch"
Content-Disposition: attachment;
	filename="0001-core-device-Fix-not-handling-notification.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i754zxiu2

RnJvbSA1ODg0Y2M0YjBkOGQ4YjgxM2YyYmFlMDM0NjU1YjU0ZGJjNDZjMGViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFdlZCwgMTEgTWFyIDIwMTUgMjE6MjM6NTUgKzAyMDAKU3ViamVj
dDogW1BBVENIIEJsdWVaXSBjb3JlL2RldmljZTogRml4IG5vdCBoYW5kbGluZyBub3RpZmljYXRp
b24KCmF0dGlvIGNhbGxiYWNrcyBuZWVkcyB0byBiZSB0cmlnZ2VyZWQgYXMgc29vbiBhcyBwb3Nz
aWJsZSBvbmNlIGNvbm5lY3RlZApvdGhlcndpc2UgcHJvZmlsZXMgc3VjaCBhcyBIb0cgbWF5IG1p
c3Mgbm90aWZpY2F0aW9uIHRoYXQgYXJlIHNlbnQgd2hpbGUKYnRfZ2F0dF9jbGllbnQgaXMgZG9p
bmcgTVRVIGV4Y2hhbmdlLgotLS0KIHNyYy9kZXZpY2UuYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Rl
dmljZS5jIGIvc3JjL2RldmljZS5jCmluZGV4IDgzMWVmZWEuLjBkYzhjODYgMTAwNjQ0Ci0tLSBh
L3NyYy9kZXZpY2UuYworKysgYi9zcmMvZGV2aWNlLmMKQEAgLTM5ODQsOCArMzk4NCw2IEBAIHN0
YXRpYyB2b2lkIGdhdHRfY2xpZW50X3JlYWR5X2NiKGJvb2wgc3VjY2VzcywgdWludDhfdCBhdHRf
ZWNvZGUsCiAKIAlkZXZpY2VfYWNjZXB0X2dhdHRfcHJvZmlsZXMoZGV2aWNlKTsKIAotCWdfc2xp
c3RfZm9yZWFjaChkZXZpY2UtPmF0dGlvcywgYXR0aW9fY29ubmVjdGVkLCBkZXZpY2UtPmF0dHJp
Yik7Ci0KIAlidGRfZ2F0dF9jbGllbnRfcmVhZHkoZGV2aWNlLT5jbGllbnRfZGJ1cyk7CiB9CiAK
QEAgLTQwMDcsNiArNDAwNSw5IEBAIHN0YXRpYyB2b2lkIGdhdHRfY2xpZW50X2luaXQoc3RydWN0
IGJ0ZF9kZXZpY2UgKmRldmljZSkKIAkJcmV0dXJuOwogCX0KIAorCS8qIE5vdGlmeSBhdHRpbyBz
byBpdCBjYW4gcmVhY3QgdG8gbm90aWZpY2F0aW9ucyAqLworCWdfc2xpc3RfZm9yZWFjaChkZXZp
Y2UtPmF0dGlvcywgYXR0aW9fY29ubmVjdGVkLCBkZXZpY2UtPmF0dHJpYik7CisKIAlpZiAoIWJ0
X2dhdHRfY2xpZW50X3NldF9yZWFkeV9oYW5kbGVyKGRldmljZS0+Y2xpZW50LAogCQkJCQkJCWdh
dHRfY2xpZW50X3JlYWR5X2NiLAogCQkJCQkJCWRldmljZSwgTlVMTCkpIHsKLS0gCjIuMS4wCgo=
--001a11c22216912f610511088415--
