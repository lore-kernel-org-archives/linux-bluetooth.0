Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1401600034-16687-1-git-send-email-kiran.kumar@linaro.org>
References: <1401600034-16687-1-git-send-email-kiran.kumar@linaro.org>
Date: Mon, 9 Jun 2014 11:38:34 +0530
Message-ID: <CA+RfmHZr+NDNheW6Ki7N7BGw7PBT8jsip0k1m1opo+Y8C8zgiQ@mail.gmail.com>
Subject: Re: [RFC v3] Bluetooth: Keep master role when SCO or eSCO is active
From: Kiran Raparthy <kiran.kumar@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: "hyungseoung.yoo" <hyungseoung.yoo@samsung.com>, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>,
	John Stultz <john.stultz@linaro.org>, Jaikumar Ganesh <jaikumarg@android.com>,
	Kiran Raparthy <kiran.kumar@linaro.org>
Content-Type: multipart/alternative; boundary=001a11c13db295e8d004fb610a9f
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11c13db295e8d004fb610a9f
Content-Type: text/plain; charset=UTF-8

Just a reminder.
Regards,
Kiran


On 1 June 2014 10:50, Kiran Kumar Raparthy <kiran.kumar@linaro.org> wrote:

> From: "hyungseoung.yoo" <hyungseoung.yoo@samsung.com>
>
> Preserve the master role when SCO or eSCO is active
> as this improves compatability with lots of
> headset and chipset combinations.
>
> This is one of the number of patches from the Android AOSP
> common.git tree, which is used on almost all Android devices.
> It looks like it would improve support for compatibility with
> lot of headset,so I wanted to submit it for review to see
> if it should go upstream.
>
> v3: Fixed formatting issues pointed by Sergei
>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: hyungseoung.yoo <hyungseoung.yoo@samsung.com>
> Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
> [kiran: Added context to commit message]
> Signed-off-by: Kiran Raparthy <kiran.kumar@linaro.org>
> ---
>  net/bluetooth/hci_event.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 15010a2..cfb1355 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1915,6 +1915,14 @@ unlock:
>         hci_conn_check_pending(hdev);
>  }
>
> +static inline bool is_sco_active(struct hci_dev *hdev)
> +{
> +       if (hci_conn_hash_lookup_state(hdev, SCO_LINK, BT_CONNECTED) ||
> +           hci_conn_hash_lookup_state(hdev, ESCO_LINK, BT_CONNECTED))
> +               return true;
> +       return false;
> +}
> +
>  static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff
> *skb)
>  {
>         struct hci_ev_conn_request *ev = (void *) skb->data;
> @@ -1961,7 +1969,9 @@ static void hci_conn_request_evt(struct hci_dev
> *hdev, struct sk_buff *skb)
>
>                         bacpy(&cp.bdaddr, &ev->bdaddr);
>
> -                       if (lmp_rswitch_capable(hdev) && (mask &
> HCI_LM_MASTER))
> +                       if (lmp_rswitch_capable(hdev) &&
> +                           ((mask & HCI_LM_MASTER) ||
> +                           is_sco_active(hdev)))
>                                 cp.role = 0x00; /* Become master */
>                         else
>                                 cp.role = 0x01; /* Remain slave */
> --
> 1.8.2.1
>
>

--001a11c13db295e8d004fb610a9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just a reminder.<div style>Regards,</div><div style>Kiran<=
/div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On=
 1 June 2014 10:50, Kiran Kumar Raparthy <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:kiran.kumar@linaro.org" target=3D"_blank">kiran.kumar@linaro.org</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">From: &quot;hyungseoung.yoo&quot; &lt;<a hre=
f=3D"mailto:hyungseoung.yoo@samsung.com">hyungseoung.yoo@samsung.com</a>&gt=
;<br>

<br>
Preserve the master role when SCO or eSCO is active<br>
as this improves compatability with lots of<br>
headset and chipset combinations.<br>
<br>
This is one of the number of patches from the Android AOSP<br>
common.git tree, which is used on almost all Android devices.<br>
It looks like it would improve support for compatibility with<br>
lot of headset,so I wanted to submit it for review to see<br>
if it should go upstream.<br>
<br>
v3: Fixed formatting issues pointed by Sergei<br>
<br>
Cc: Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtm=
ann.org</a>&gt;<br>
Cc: Gustavo Padovan &lt;<a href=3D"mailto:gustavo@padovan.org">gustavo@pado=
van.org</a>&gt;<br>
Cc: Johan Hedberg &lt;<a href=3D"mailto:johan.hedberg@gmail.com">johan.hedb=
erg@gmail.com</a>&gt;<br>
Cc: &quot;David S. Miller&quot; &lt;<a href=3D"mailto:davem@davemloft.net">=
davem@davemloft.net</a>&gt;<br>
Cc: <a href=3D"mailto:linux-bluetooth@vger.kernel.org">linux-bluetooth@vger=
.kernel.org</a><br>
Cc: <a href=3D"mailto:netdev@vger.kernel.org">netdev@vger.kernel.org</a><br=
>
Cc: <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kerne=
l.org</a><br>
Cc: Android Kernel Team &lt;<a href=3D"mailto:kernel-team@android.com">kern=
el-team@android.com</a>&gt;<br>
Cc: John Stultz &lt;<a href=3D"mailto:john.stultz@linaro.org">john.stultz@l=
inaro.org</a>&gt;<br>
Signed-off-by: hyungseoung.yoo &lt;<a href=3D"mailto:hyungseoung.yoo@samsun=
g.com">hyungseoung.yoo@samsung.com</a>&gt;<br>
Signed-off-by: Jaikumar Ganesh &lt;<a href=3D"mailto:jaikumarg@android.com"=
>jaikumarg@android.com</a>&gt;<br>
[kiran: Added context to commit message]<br>
Signed-off-by: Kiran Raparthy &lt;<a href=3D"mailto:kiran.kumar@linaro.org"=
>kiran.kumar@linaro.org</a>&gt;<br>
---<br>
=C2=A0net/bluetooth/hci_event.c | 12 +++++++++++-<br>
=C2=A01 file changed, 11 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c<br>
index 15010a2..cfb1355 100644<br>
--- a/net/bluetooth/hci_event.c<br>
+++ b/net/bluetooth/hci_event.c<br>
@@ -1915,6 +1915,14 @@ unlock:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_conn_check_pending(hdev);<br>
=C2=A0}<br>
<br>
+static inline bool is_sco_active(struct hci_dev *hdev)<br>
+{<br>
+ =C2=A0 =C2=A0 =C2=A0 if (hci_conn_hash_lookup_state(hdev, SCO_LINK, BT_CO=
NNECTED) ||<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_conn_hash_lookup_state(hdev, ESCO_=
LINK, BT_CONNECTED))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+ =C2=A0 =C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
=C2=A0static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff=
 *skb)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hci_ev_conn_request *ev =3D (void *) skb=
-&gt;data;<br>
@@ -1961,7 +1969,9 @@ static void hci_conn_request_evt(struct hci_dev *hdev=
, struct sk_buff *skb)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bacpy(&amp;cp.bdaddr, &amp;ev-&gt;bdaddr);<br>
<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (lmp_rswitch_capable(hdev) &amp;&amp; (mask &amp; HCI_LM_MASTER))<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (lmp_rswitch_capable(hdev) &amp;&amp;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ((mask &amp; HCI_LM_MASTER) ||<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 is_sco_active(hdev)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp.role =3D 0x00; /* Become master *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp.role =3D 0x01; /* Remain slave */=
<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.2.1<br>
<br>
</font></span></blockquote></div><br></div>

--001a11c13db295e8d004fb610a9f--
