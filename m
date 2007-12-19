Return-Path: <cyrus@holtmann.org>
Message-ID: <bd5b16740712190324h51213f0bs8f1eec5aeb624b97@mail.gmail.com>
Date: Wed, 19 Dec 2007 13:24:42 +0200
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: [PATCH 2.6.24][RERESEND] TI's BRF chips: always send explicit wake-up acks
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <tkrat.69449f8105b06085@bencohen.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_19488_33326393.1198063482608"
References: <tkrat.69449f8105b06085@bencohen.org>
List-ID: <bluez-devel.lists.sourceforge.net>

------=_Part_19488_33326393.1198063482608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Still got no response, so I send the patch the third time (now attached).

Marcel - is there a problem with it ?


On 12/11/07, Ohad Ben-Cohen <ohad@bencohen.org> wrote:
> Hi Marcel,
>
> I have posted this 2.6.24 patch weeks ago but got no response,
> and it's already rc5 out there.
>
> This is a small but important fix for the BRF's driver. It has
> been tested extensively on both the BRF6350 and the BRF6300.
>
> Please tell me if there's anything I can do to help
> processing this patch.
>
> Thanks,
> Ohad.
>
> [Bluetooth] TI's BRF chips: always send explicit wake-up acks
>
> In the (rare) event of simultaneous mutual wake up requests,
> do send the chip an explicit wake-up ack. This is required
> for Texas Instruments's BRF6350 chip.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@bencohen.org>
>
> ---
>
>  drivers/bluetooth/hci_ll.c |   23 ++++++++++++++---------
>  1 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 8c3e62a..b91d45a 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -204,6 +204,19 @@ static void ll_device_want_to_wakeup(struct hci_uart *hu)
>         spin_lock_irqsave(&ll->hcill_lock, flags);
>
>         switch (ll->hcill_state) {
> +       case HCILL_ASLEEP_TO_AWAKE:
> +               /*
> +                * This state means that both the host and the BRF chip
> +                * have simultaneously sent a wake-up-indication packet.
> +                * Traditionaly, in this case, receiving a wake-up-indication
> +                * was enough and an additional wake-up-ack wasn't needed.
> +                * This has changed with the BRF6350, which does require an
> +                * explicit wake-up-ack. Other BRF versions, which do not
> +                * require an explicit ack here, do accept it, thus it is
> +                * perfectly safe to always send one.
> +                */
> +               BT_DBG("dual wake-up-indication");
> +               /* deliberate fall-through - do not add break */
>         case HCILL_ASLEEP:
>                 /* acknowledge device wake up */
>                 if (send_hcill_cmd(HCILL_WAKE_UP_ACK, hu) < 0) {
> @@ -211,16 +224,8 @@ static void ll_device_want_to_wakeup(struct hci_uart *hu)
>                         goto out;
>                 }
>                 break;
> -       case HCILL_ASLEEP_TO_AWAKE:
> -               /*
> -                * this state means that a wake-up-indication
> -                * is already on its way to the device,
> -                * and will serve as the required wake-up-ack
> -                */
> -               BT_DBG("dual wake-up-indication");
> -               break;
>         default:
> -               /* any other state are illegal */
> +               /* any other state is illegal */
>                 BT_ERR("received HCILL_WAKE_UP_IND in state %ld", ll->hcill_state);
>                 break;
>         }
> --
> 1.4.4.2
>
>
>
>

------=_Part_19488_33326393.1198063482608
Content-Type: application/octet-stream; name=to-marcel
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fads0f4x
Content-Disposition: attachment; filename=to-marcel

W0JsdWV0b290aF0gVEkncyBCUkYgY2hpcHM6IGFsd2F5cyBzZW5kIGV4cGxpY2l0IHdha2UtdXAg
YWNrcwoKSW4gdGhlIChyYXJlKSBldmVudCBvZiBzaW11bHRhbmVvdXMgbXV0dWFsIHdha2UgdXAg
cmVxdWVzdHMsCmRvIHNlbmQgdGhlIGNoaXAgYW4gZXhwbGljaXQgd2FrZS11cCBhY2suIFRoaXMg
aXMgcmVxdWlyZWQKZm9yIFRleGFzIEluc3RydW1lbnRzJ3MgQlJGNjM1MCBjaGlwLgoKU2lnbmVk
LW9mZi1ieTogT2hhZCBCZW4tQ29oZW4gPG9oYWRAYmVuY29oZW4ub3JnPgoKLS0tCgogZHJpdmVy
cy9ibHVldG9vdGgvaGNpX2xsLmMgfCAgIDIzICsrKysrKysrKysrKysrLS0tLS0tLS0tCiAxIGZp
bGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ibHVldG9vdGgvaGNpX2xsLmMgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfbGwu
YwppbmRleCA4YzNlNjJhLi5iOTFkNDVhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2JsdWV0b290aC9o
Y2lfbGwuYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfbGwuYwpAQCAtMjA0LDYgKzIwNCwx
OSBAQCBzdGF0aWMgdm9pZCBsbF9kZXZpY2Vfd2FudF90b193YWtldXAoc3RydWN0IGhjaV91YXJ0
ICpodSkKIAlzcGluX2xvY2tfaXJxc2F2ZSgmbGwtPmhjaWxsX2xvY2ssIGZsYWdzKTsKIAogCXN3
aXRjaCAobGwtPmhjaWxsX3N0YXRlKSB7CisJY2FzZSBIQ0lMTF9BU0xFRVBfVE9fQVdBS0U6CisJ
CS8qCisJCSAqIFRoaXMgc3RhdGUgbWVhbnMgdGhhdCBib3RoIHRoZSBob3N0IGFuZCB0aGUgQlJG
IGNoaXAKKwkJICogaGF2ZSBzaW11bHRhbmVvdXNseSBzZW50IGEgd2FrZS11cC1pbmRpY2F0aW9u
IHBhY2tldC4KKwkJICogVHJhZGl0aW9uYWx5LCBpbiB0aGlzIGNhc2UsIHJlY2VpdmluZyBhIHdh
a2UtdXAtaW5kaWNhdGlvbgorCQkgKiB3YXMgZW5vdWdoIGFuZCBhbiBhZGRpdGlvbmFsIHdha2Ut
dXAtYWNrIHdhc24ndCBuZWVkZWQuCisJCSAqIFRoaXMgaGFzIGNoYW5nZWQgd2l0aCB0aGUgQlJG
NjM1MCwgd2hpY2ggZG9lcyByZXF1aXJlIGFuCisJCSAqIGV4cGxpY2l0IHdha2UtdXAtYWNrLiBP
dGhlciBCUkYgdmVyc2lvbnMsIHdoaWNoIGRvIG5vdAorCQkgKiByZXF1aXJlIGFuIGV4cGxpY2l0
IGFjayBoZXJlLCBkbyBhY2NlcHQgaXQsIHRodXMgaXQgaXMKKwkJICogcGVyZmVjdGx5IHNhZmUg
dG8gYWx3YXlzIHNlbmQgb25lLgorCQkgKi8KKwkJQlRfREJHKCJkdWFsIHdha2UtdXAtaW5kaWNh
dGlvbiIpOworCQkvKiBkZWxpYmVyYXRlIGZhbGwtdGhyb3VnaCAtIGRvIG5vdCBhZGQgYnJlYWsg
Ki8KIAljYXNlIEhDSUxMX0FTTEVFUDoKIAkJLyogYWNrbm93bGVkZ2UgZGV2aWNlIHdha2UgdXAg
Ki8KIAkJaWYgKHNlbmRfaGNpbGxfY21kKEhDSUxMX1dBS0VfVVBfQUNLLCBodSkgPCAwKSB7CkBA
IC0yMTEsMTYgKzIyNCw4IEBAIHN0YXRpYyB2b2lkIGxsX2RldmljZV93YW50X3RvX3dha2V1cChz
dHJ1Y3QgaGNpX3VhcnQgKmh1KQogCQkJZ290byBvdXQ7CiAJCX0KIAkJYnJlYWs7Ci0JY2FzZSBI
Q0lMTF9BU0xFRVBfVE9fQVdBS0U6Ci0JCS8qCi0JCSAqIHRoaXMgc3RhdGUgbWVhbnMgdGhhdCBh
IHdha2UtdXAtaW5kaWNhdGlvbgotCQkgKiBpcyBhbHJlYWR5IG9uIGl0cyB3YXkgdG8gdGhlIGRl
dmljZSwKLQkJICogYW5kIHdpbGwgc2VydmUgYXMgdGhlIHJlcXVpcmVkIHdha2UtdXAtYWNrCi0J
CSAqLwotCQlCVF9EQkcoImR1YWwgd2FrZS11cC1pbmRpY2F0aW9uIik7Ci0JCWJyZWFrOwogCWRl
ZmF1bHQ6Ci0JCS8qIGFueSBvdGhlciBzdGF0ZSBhcmUgaWxsZWdhbCAqLworCQkvKiBhbnkgb3Ro
ZXIgc3RhdGUgaXMgaWxsZWdhbCAqLwogCQlCVF9FUlIoInJlY2VpdmVkIEhDSUxMX1dBS0VfVVBf
SU5EIGluIHN0YXRlICVsZCIsIGxsLT5oY2lsbF9zdGF0ZSk7CiAJCWJyZWFrOwogCX0KLS0gCjEu
NC40LjIKCgo=
------=_Part_19488_33326393.1198063482608--
