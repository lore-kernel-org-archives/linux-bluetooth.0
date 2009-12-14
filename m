Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
Date: Mon, 14 Dec 2009 12:36:21 +0200
Message-ID: <508e92ca0912140236t2c93a8a1q3aae97cf9e7bdfd@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add locking scheme to timeout callbacks.
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, gustavo@padovan.org
Content-Type: multipart/mixed; boundary=0016364c76a7297318047aadd8f7
List-ID: <linux-bluetooth.vger.kernel.org>

--0016364c76a7297318047aadd8f7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 24, 2009 at 5:45 AM, Gustavo F. Padovan
<gustavo@las.ic.unicamp.br> wrote:
> Avoid race conditions when acessing the sock.
>
> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
> ---
> =A0net/bluetooth/l2cap.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index c04526f..efac637 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1192,6 +1192,7 @@ static void l2cap_monitor_timeout(unsigned long arg=
)
> =A0 =A0 =A0 =A0struct sock *sk =3D (void *) arg;
> =A0 =A0 =A0 =A0u16 control;
>
> + =A0 =A0 =A0 bh_lock_sock(sk);
> =A0 =A0 =A0 =A0if (l2cap_pi(sk)->retry_count >=3D l2cap_pi(sk)->remote_ma=
x_tx) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send_disconn_req(l2cap_pi(sk)->conn,=
 sk);

missing unlock ?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -1203,6 +1204,7 @@ static void l2cap_monitor_timeout(unsigned long arg=
)
> =A0 =A0 =A0 =A0control =3D L2CAP_CTRL_POLL;
> =A0 =A0 =A0 =A0control |=3D L2CAP_SUPER_RCV_READY;
> =A0 =A0 =A0 =A0l2cap_send_sframe(l2cap_pi(sk), control);
> + =A0 =A0 =A0 bh_unlock_sock(sk);
> =A0}

Please consider following patch:

--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1208,6 +1208,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
        bh_lock_sock(sk);
        if (l2cap_pi(sk)->retry_count >=3D l2cap_pi(sk)->remote_max_tx) {
                l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk);
+               bh_unlock_sock(sk);
                return;
        }


Also see complete patch attached.

Regards,
Andrei Emeltchenko

--0016364c76a7297318047aadd8f7
Content-Type: application/x-gzip;
	name="0001-Bluetooth-Fix-locking-scheme-regression.patch.gz"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Fix-locking-scheme-regression.patch.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g37406sa0

H4sICLIUJksAAzAwMDEtQmx1ZXRvb3RoLUZpeC1sb2NraW5nLXNjaGVtZS1yZWdyZXNzaW9uLnBh
dGNoAJ1S0W7TMBR9rr/iPLZKkyUhbZcA0wbbhEAgpCHxgFDk2DeNaWMX24FOwL/jZAKkwV6wrJv4
+Ojco3N9bU2Pgsp8k1O7ktQUkrhMUyIh5aZsJa2KTVFmq/VKFnhtNG7ogGyDNK2mjTxNM3YdZCpc
aGlJ4aqnvRcd6Z3BEz5hCf3BzrXZKZ4I05+xS+6pGmWXyApckhjlSmR5lZdV/ghRGs7sZmg+kfAV
Pry9ePf8xUc82w/kjfFdhWt1xN6IndJbuNCgJ1jaWnJOGZ0w9j70/E34yh2U9tbIQZCE7whkrbE4
cN+hsVyLbiJp4+H5jjQLdAMuhBm0T3A1sUdGGwAZxOAO3DqCMDKUjqZGCV4N0jh4w15yrfBG7YY9
D25u1FaTjE3bxs3t/wQWxzGDJn/S/IrgZJ8LfkgEviOsDBELpVV7csEO11uSIdtg1JH1IRI3jxZL
pJC0p7tzvGBMqrZFHG+VBz/5t3zzbzwEJOmIsti0p02TJOvwisrTFlmaroti9PuQIoui6EHV83PE
WZ6eLteIpu8GAXKeeyXwxSiJiVn3RitvbO1VT2bw80G7KeIw8jBvbrcLhlnT1eMLqF0oc7dbPA6Y
ajG/kzioEYvPLHl7W0+DxtlT3L/sjae658faHxf4FhRmdwxHWtZSOWG0ri19vqc6wktMTaPZ6GTQ
f3mZhdaD1ePvD4aQGViWrJM0KRj7CdCWqsKhAwAA
--0016364c76a7297318047aadd8f7--
