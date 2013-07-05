Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1372941783-30657-1-git-send-email-adam.lee@canonical.com>
References: <1372941783-30657-1-git-send-email-adam.lee@canonical.com>
From: Yang Bai <hamo.by@gmail.com>
Date: Fri, 5 Jul 2013 10:37:07 +0800
Message-ID: <CAO_0yfOXfO1ZNTNbYRnuY-CQ44hH+DqoEB5jnCwfhLPTq-RUqQ@mail.gmail.com>
Subject: Re: [PATCH] btusb: fix overflow return values
To: Adam Lee <adam.lee@canonical.com>
Cc: linux-bluetooth@vger.kernel.org,
	Wen-chien Jesse Sung <jesse.sung@canonical.com>, AceLan Kao <acelan.kao@canonical.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>, "Anthony Wong'" <anthony.wong@canonical.com>,
	Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a11c20b065e34d304e0ba93e8
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11c20b065e34d304e0ba93e8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The return value of btusb_setup_intel is compared with 0. Code as:

drivers/bluetooth/btusb.c:
static int btusb_probe(struct usb_interface *intf,
const struct usb_device_id *id)
 if (id->driver_info & BTUSB_INTEL)
 hdev->setup =3D btusb_setup_intel;

net/bluetooth/hci_core.c:
int hci_dev_open(__u16 dev)
if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags))
 ret =3D hdev->setup(hdev);

if (!ret) {


Thanks,
Yang



On Thu, Jul 4, 2013 at 8:43 PM, Adam Lee <adam.lee@canonical.com> wrote:

> PTR_ERR() returns a long type value, but btusb_setup_intel() and
> btusb_setup_intel_patching() should return an int type value.
>
> This bug makes the judgement "if (ret < 0)" not working on x86_64
> architecture systems, leading to failure as below, even panic.
>
> [   12.958920] Bluetooth: hci0 command 0xfc8e tx timeout
> [   14.961765] Bluetooth: hci0 command 0xfc8e tx timeout
> [   16.964688] Bluetooth: hci0 command 0xfc8e tx timeout
> [   20.954501] Bluetooth: hci0 sending Intel patch command (0xfc8e) faile=
d
> (-110)
> [   22.957358] Bluetooth: hci0 command 0xfc8e tx timeout
> [   30.948922] Bluetooth: hci0 sending Intel patch command (0xfc8e) faile=
d
> (-110)
> [   32.951780] Bluetooth: hci0 command 0xfc8e tx timeout
> [   40.943359] Bluetooth: hci0 sending Intel patch command (0xfc8e) faile=
d
> (-110)
> [   42.946219] Bluetooth: hci0 command 0xfc8e tx timeout
> [   50.937812] Bluetooth: hci0 sending Intel patch command (0xfc8e) faile=
d
> (-110)
> [   52.940670] Bluetooth: hci0 command 0xfc8e tx timeout
> [   60.932236] Bluetooth: hci0 sending Intel patch command (0xfc8e) faile=
d
> (-110)
> [   62.935092] Bluetooth: hci0 command 0xfc8e tx timeout
> [   70.926688] Bluetooth: hci0 sending Intel patch command (0xfc8e) faile=
d
> (-110)
> [   72.929545] Bluetooth: hci0 command 0xfc8e tx timeout
> [   80.921111] Bluetooth: hci0 sending Intel patch command (0xfc8e) faile=
d
> (-110)
> [   82.923969] Bluetooth: hci0 command 0xfc2f tx timeout
> [   90.915542] Bluetooth: hci0 sending Intel patch command (0xfc2f) faile=
d
> (-110)
> [   92.918406] Bluetooth: hci0 command 0xfc11 tx timeout
> [  100.909955] Bluetooth: hci0 sending Intel patch command (0xfc11) faile=
d
> (-110)
> [  102.912858] Bluetooth: hci0 command 0xfc60 tx timeout
> [  110.904394] Bluetooth: hci0 sending Intel patch command (0xfc60) faile=
d
> (-110)
> [  112.907293] Bluetooth: hci0 command 0xfc11 tx timeout
> [  120.898831] Bluetooth: hci0 exiting Intel manufacturer mode failed
> (-110)
> [  120.904757] bluetoothd[1030]: segfault at 4 ip 00007f8b2eb55236 sp
> 00007fff53ff6920 error 4 in bluetoothd[7f8b2eaff000+cb000]
>
> For not affecting other modules, I choose to modify the return values
> but not extend btusb_setup_intel() and btusb_setup_intel_patching()'s
> return types. This is harmless, because the return values were only
> used to comparing number 0.
>
> Signed-off-by: Adam Lee <adam.lee@canonical.com>
> ---
>  drivers/bluetooth/btusb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7a7e5f8..0fb2799 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1092,7 +1092,7 @@ static int btusb_setup_intel_patching(struct hci_de=
v
> *hdev,
>         if (IS_ERR(skb)) {
>                 BT_ERR("%s sending Intel patch command (0x%4.4x) failed
> (%ld)",
>                        hdev->name, cmd->opcode, PTR_ERR(skb));
> -               return -PTR_ERR(skb);
> +               return -EFAULT;
>         }
>
>         /* It ensures that the returned event matches the event data read
> from
> @@ -1144,7 +1144,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>         if (IS_ERR(skb)) {
>                 BT_ERR("%s sending initial HCI reset command failed (%ld)=
",
>                        hdev->name, PTR_ERR(skb));
> -               return -PTR_ERR(skb);
> +               return -EFAULT;
>         }
>         kfree_skb(skb);
>
> @@ -1158,7 +1158,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>         if (IS_ERR(skb)) {
>                 BT_ERR("%s reading Intel fw version command failed (%ld)"=
,
>                        hdev->name, PTR_ERR(skb));
> -               return -PTR_ERR(skb);
> +               return -EFAULT;
>         }
>
>         if (skb->len !=3D sizeof(*ver)) {
> @@ -1216,7 +1216,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>                 BT_ERR("%s entering Intel manufacturer mode failed (%ld)"=
,
>                        hdev->name, PTR_ERR(skb));
>                 release_firmware(fw);
> -               return -PTR_ERR(skb);
> +               return -EFAULT;
>         }
>
>         if (skb->data[0]) {
> @@ -1273,7 +1273,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>         if (IS_ERR(skb)) {
>                 BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
>                        hdev->name, PTR_ERR(skb));
> -               return -PTR_ERR(skb);
> +               return -EFAULT;
>         }
>         kfree_skb(skb);
>
> @@ -1289,7 +1289,7 @@ exit_mfg_disable:
>         if (IS_ERR(skb)) {
>                 BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
>                        hdev->name, PTR_ERR(skb));
> -               return -PTR_ERR(skb);
> +               return -EFAULT;
>         }
>         kfree_skb(skb);
>
> @@ -1307,7 +1307,7 @@ exit_mfg_deactivate:
>         if (IS_ERR(skb)) {
>                 BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
>                        hdev->name, PTR_ERR(skb));
> -               return -PTR_ERR(skb);
> +               return -EFAULT;
>         }
>         kfree_skb(skb);
>
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



--=20
    """
    Keep It Simple,Stupid.
    """

Chinese Name: =E7=99=BD=E6=9D=A8
Nick Name: Hamo
Homepage: http://hamobai.com/
GPG KEY ID: 0xA4691A33
Key fingerprint =3D 09D5 2D78 8E2B 0995 CF8E  4331 33C4 3D24 A469 1A33

--001a11c20b065e34d304e0ba93e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The return value of=C2=A0<span style=3D"font-family:arial,=
sans-serif;font-size:13px">btusb_setup_intel is compared with 0. Code as:</=
span><div><span style=3D"font-family:arial,sans-serif;font-size:13px"><br><=
/span></div>

<div><font face=3D"arial, sans-serif">drivers/bluetooth/btusb.c:</font><br>=
</div><div><font face=3D"arial, sans-serif"><div>static int btusb_probe(str=
uct usb_interface *intf,</div><div><span class=3D"" style=3D"white-space:pr=
e">				</span>const struct usb_device_id *id)</div>

</font></div><div><div style=3D"font-family:arial,sans-serif;font-size:13px=
"><span class=3D"" style=3D"white-space:pre">	</span>if (id-&gt;driver_info=
 &amp; BTUSB_INTEL)</div><div style=3D"font-family:arial,sans-serif;font-si=
ze:13px">

<span class=3D"" style=3D"white-space:pre">		</span>hdev-&gt;setup =3D btus=
b_setup_intel;</div><div style=3D"font-family:arial,sans-serif;font-size:13=
px"><br></div><div style=3D"font-family:arial,sans-serif;font-size:13px">ne=
t/bluetooth/hci_core.c:</div>

<div><div><font face=3D"arial, sans-serif">int hci_dev_open(__u16 dev)</fon=
t></div><div><div><font face=3D"arial, sans-serif"><span class=3D"" style=
=3D"white-space:pre">	</span>if (hdev-&gt;setup &amp;&amp; test_bit(HCI_SET=
UP, &amp;hdev-&gt;dev_flags))</font></div>

<div><font face=3D"arial, sans-serif"><span class=3D"" style=3D"white-space=
:pre">		</span>ret =3D hdev-&gt;setup(hdev);</font></div><div><font face=3D=
"arial, sans-serif"><br></font></div><div><font face=3D"arial, sans-serif">=
<span class=3D"" style=3D"white-space:pre">	</span>if (!ret) {</font></div>

<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div></div>=
</div><div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div>=
<div style=3D"font-family:arial,sans-serif;font-size:13px">Thanks,</div><di=
v style=3D"font-family:arial,sans-serif;font-size:13px">

Yang</div><div style=3D"font-family:arial,sans-serif;font-size:13px"><br></=
div></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quot=
e">On Thu, Jul 4, 2013 at 8:43 PM, Adam Lee <span dir=3D"ltr">&lt;<a href=
=3D"mailto:adam.lee@canonical.com" target=3D"_blank">adam.lee@canonical.com=
</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">PTR_ERR() returns a long type value, but btu=
sb_setup_intel() and<br>
btusb_setup_intel_patching() should return an int type value.<br>
<br>
This bug makes the judgement &quot;if (ret &lt; 0)&quot; not working on x86=
_64<br>
architecture systems, leading to failure as below, even panic.<br>
<br>
[ =C2=A0 12.958920] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 14.961765] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 16.964688] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 20.954501] Bluetooth: hci0 sending Intel patch command (0xfc8e) fa=
iled (-110)<br>
[ =C2=A0 22.957358] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 30.948922] Bluetooth: hci0 sending Intel patch command (0xfc8e) fa=
iled (-110)<br>
[ =C2=A0 32.951780] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 40.943359] Bluetooth: hci0 sending Intel patch command (0xfc8e) fa=
iled (-110)<br>
[ =C2=A0 42.946219] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 50.937812] Bluetooth: hci0 sending Intel patch command (0xfc8e) fa=
iled (-110)<br>
[ =C2=A0 52.940670] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 60.932236] Bluetooth: hci0 sending Intel patch command (0xfc8e) fa=
iled (-110)<br>
[ =C2=A0 62.935092] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 70.926688] Bluetooth: hci0 sending Intel patch command (0xfc8e) fa=
iled (-110)<br>
[ =C2=A0 72.929545] Bluetooth: hci0 command 0xfc8e tx timeout<br>
[ =C2=A0 80.921111] Bluetooth: hci0 sending Intel patch command (0xfc8e) fa=
iled (-110)<br>
[ =C2=A0 82.923969] Bluetooth: hci0 command 0xfc2f tx timeout<br>
[ =C2=A0 90.915542] Bluetooth: hci0 sending Intel patch command (0xfc2f) fa=
iled (-110)<br>
[ =C2=A0 92.918406] Bluetooth: hci0 command 0xfc11 tx timeout<br>
[ =C2=A0100.909955] Bluetooth: hci0 sending Intel patch command (0xfc11) fa=
iled (-110)<br>
[ =C2=A0102.912858] Bluetooth: hci0 command 0xfc60 tx timeout<br>
[ =C2=A0110.904394] Bluetooth: hci0 sending Intel patch command (0xfc60) fa=
iled (-110)<br>
[ =C2=A0112.907293] Bluetooth: hci0 command 0xfc11 tx timeout<br>
[ =C2=A0120.898831] Bluetooth: hci0 exiting Intel manufacturer mode failed =
(-110)<br>
[ =C2=A0120.904757] bluetoothd[1030]: segfault at 4 ip 00007f8b2eb55236 sp =
00007fff53ff6920 error 4 in bluetoothd[7f8b2eaff000+cb000]<br>
<br>
For not affecting other modules, I choose to modify the return values<br>
but not extend btusb_setup_intel() and btusb_setup_intel_patching()&#39;s<b=
r>
return types. This is harmless, because the return values were only<br>
used to comparing number 0.<br>
<br>
Signed-off-by: Adam Lee &lt;<a href=3D"mailto:adam.lee@canonical.com">adam.=
lee@canonical.com</a>&gt;<br>
---<br>
=C2=A0drivers/bluetooth/btusb.c | 14 +++++++-------<br>
=C2=A01 file changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
index 7a7e5f8..0fb2799 100644<br>
--- a/drivers/bluetooth/btusb.c<br>
+++ b/drivers/bluetooth/btusb.c<br>
@@ -1092,7 +1092,7 @@ static int btusb_setup_intel_patching(struct hci_dev =
*hdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(skb)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR(&quot;%s sen=
ding Intel patch command (0x%4.4x) failed (%ld)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hdev-&gt;name, cmd-&gt;opcode, PTR_ERR(skb));<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -PTR_ERR(skb);<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* It ensures that the returned event matches t=
he event data read from<br>
@@ -1144,7 +1144,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(skb)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR(&quot;%s sen=
ding initial HCI reset command failed (%ld)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hdev-&gt;name, PTR_ERR(skb));<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -PTR_ERR(skb);<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree_skb(skb);<br>
<br>
@@ -1158,7 +1158,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(skb)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR(&quot;%s rea=
ding Intel fw version command failed (%ld)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hdev-&gt;name, PTR_ERR(skb));<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -PTR_ERR(skb);<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (skb-&gt;len !=3D sizeof(*ver)) {<br>
@@ -1216,7 +1216,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR(&quot;%s ent=
ering Intel manufacturer mode failed (%ld)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hdev-&gt;name, PTR_ERR(skb));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_firmware(fw=
);<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -PTR_ERR(skb);<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (skb-&gt;data[0]) {<br>
@@ -1273,7 +1273,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(skb)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR(&quot;%s exi=
ting Intel manufacturer mode failed (%ld)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hdev-&gt;name, PTR_ERR(skb));<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -PTR_ERR(skb);<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree_skb(skb);<br>
<br>
@@ -1289,7 +1289,7 @@ exit_mfg_disable:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(skb)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR(&quot;%s exi=
ting Intel manufacturer mode failed (%ld)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hdev-&gt;name, PTR_ERR(skb));<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -PTR_ERR(skb);<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree_skb(skb);<br>
<br>
@@ -1307,7 +1307,7 @@ exit_mfg_deactivate:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(skb)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR(&quot;%s exi=
ting Intel manufacturer mode failed (%ld)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hdev-&gt;name, PTR_ERR(skb));<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -PTR_ERR(skb);<br=
>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree_skb(skb);<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.8.3.2<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>=C2=A0 =C2=A0 &quot;&quot;&quot;<br>=C2=A0 =C2=A0 Keep It Simple,Stupid.=
=C2=A0 <br>=C2=A0 =C2=A0 &quot;&quot;&quot; <br><br>Chinese Name: =E7=99=BD=
=E6=9D=A8<br>Nick Name: Hamo<br>Homepage: <a href=3D"http://hamobai.com/">h=
ttp://hamobai.com/</a><br>

GPG KEY ID: 0xA4691A33<br>Key fingerprint =3D 09D5 2D78 8E2B 0995 CF8E=C2=
=A0 4331 33C4 3D24 A469 1A33<br>
</div>

--001a11c20b065e34d304e0ba93e8--
