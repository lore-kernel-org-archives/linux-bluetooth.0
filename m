Return-Path: <aford173@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHCN7xLHZmS_3+JygQgRxi_tX0mXL22D1Nj9T8jkrMz3-8eQDg@mail.gmail.com>
References: <20170413150353.7389-1-robh@kernel.org> <20170413150353.7389-2-robh@kernel.org>
 <CAHCN7x+HhwmXGxZn_31LuzdkEdoAnOSxukAdXULrGbSeKmrtRQ@mail.gmail.com> <CAHCN7xLHZmS_3+JygQgRxi_tX0mXL22D1Nj9T8jkrMz3-8eQDg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 16 Apr 2017 09:09:37 -0500
Message-ID: <CAHCN7x+G_jbQTDfyPBZ4Er8vz46tEojrWf29Eztq56c9zBnMeA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add TI WiLink shared transport binding
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	Wei Xu <xuwei5@hisilicon.com>, Eyal Reizer <eyalr@ti.com>, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>, Satish Patel <satish.patel@linaro.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a114763e09dc4e4054d493935
List-ID: <linux-bluetooth.vger.kernel.org>

--001a114763e09dc4e4054d493935
Content-Type: text/plain; charset=UTF-8

On Apr 13, 2017 10:04 AM, "Rob Herring" <robh@kernel.org> wrote:

Add serial slave device binding for the TI WiLink series of Bluetooth/FM/GPS
devices.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
v3:
- rebase on bluetooth-next

 .../devicetree/bindings/net/ti,wilink-st.txt       | 35
++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,wilink-st.txt

diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
new file mode 100644
index 000000000000..cbad73a84ac4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
@@ -0,0 +1,35 @@
+TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices
+
+TI WiLink devices have a UART interface for providing Bluetooth, FM radio,
+and GPS over what's called "shared transport". The shared transport is
+standard BT HCI protocol with additional channels for the other functions.
+
+These devices also have a separate WiFi interface as described in
+wireless/ti,wlcore.txt.
+
+This bindings follows the UART slave device binding in
+../serial/slave-device.txt.
+
+Required properties:
+ - compatible: should be one of the following:
+    "ti,wl1271-st"
+    "ti,wl1273-st"
+    "ti,wl1831-st"
+    "ti,wl1835-st"
+    "ti,wl1837-st"
+


Would you expect the wl1283 chipset too?

I can help test this if you like after the holiday weekend. I have a board
with WL1283 and currently using pdata-quirks to support it.

Adam

+Optional properties:
+ - enable-gpios : GPIO signal controlling enabling of BT. Active high.
+ - vio-supply : Vio input supply (1.8V)
+ - vbat-supply : Vbat input supply (2.9-4.8V)
+
+Example:
+
+&serial0 {
+       compatible = "ns16550a";
+       ...
+       bluetooth {
+               compatible = "ti,wl1835-st";
+               enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+       };
+};
--
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--001a114763e09dc4e4054d493935
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Apr 13, 2017 10:04 AM, &quot;Rob Herring&quot; &lt;<a href=3D"=
mailto:robh@kernel.org">robh@kernel.org</a>&gt; wrote:<br type=3D"attributi=
on"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Add serial slave device binding for the TI WiL=
ink series of Bluetooth/FM/GPS<br>
devices.<br>
<br>
Signed-off-by: Rob Herring &lt;<a href=3D"mailto:robh@kernel.org">robh@kern=
el.org</a>&gt;<br>
Cc: Mark Rutland &lt;<a href=3D"mailto:mark.rutland@arm.com">mark.rutland@a=
rm.com</a>&gt;<br>
Cc: <a href=3D"mailto:netdev@vger.kernel.org">netdev@vger.kernel.org</a><br=
>
Cc: <a href=3D"mailto:devicetree@vger.kernel.org">devicetree@vger.kernel.or=
g</a><br>
---<br>
v3:<br>
- rebase on bluetooth-next<br>
<br>
=C2=A0.../devicetree/bindings/net/<wbr>ti,wilink-st.txt=C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 35 ++++++++++++++++++++++<br>
=C2=A01 file changed, 35 insertions(+)<br>
=C2=A0create mode 100644 Documentation/devicetree/<wbr>bindings/net/ti,wili=
nk-st.txt<br>
<br>
diff --git a/Documentation/devicetree/<wbr>bindings/net/ti,wilink-st.txt b/=
Documentation/devicetree/<wbr>bindings/net/ti,wilink-st.txt<br>
new file mode 100644<br>
index 000000000000..cbad73a84ac4<br>
--- /dev/null<br>
+++ b/Documentation/devicetree/<wbr>bindings/net/ti,wilink-st.txt<br>
@@ -0,0 +1,35 @@<br>
+TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices<br>
+<br>
+TI WiLink devices have a UART interface for providing Bluetooth, FM radio,=
<br>
+and GPS over what&#39;s called &quot;shared transport&quot;. The shared tr=
ansport is<br>
+standard BT HCI protocol with additional channels for the other functions.=
<br>
+<br>
+These devices also have a separate WiFi interface as described in<br>
+wireless/ti,wlcore.txt.<br>
+<br>
+This bindings follows the UART slave device binding in<br>
+../serial/slave-device.txt.<br>
+<br>
+Required properties:<br>
+ - compatible: should be one of the following:<br>
+=C2=A0 =C2=A0 &quot;ti,wl1271-st&quot;<br>
+=C2=A0 =C2=A0 &quot;ti,wl1273-st&quot;<br>
+=C2=A0 =C2=A0 &quot;ti,wl1831-st&quot;<br>
+=C2=A0 =C2=A0 &quot;ti,wl1835-st&quot;<br>
+=C2=A0 =C2=A0 &quot;ti,wl1837-st&quot;<br>
+<br></blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Would you expect the wl1283 chipset too?</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I can help test this if you like after the holiday =
weekend. I have a board with WL1283 and currently using pdata-quirks to sup=
port it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Adam</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
+Optional properties:<br>
+ - enable-gpios : GPIO signal controlling enabling of BT. Active high.<br>
+ - vio-supply : Vio input supply (1.8V)<br>
+ - vbat-supply : Vbat input supply (2.9-4.8V)<br>
+<br>
+Example:<br>
+<br>
+&amp;serial0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;ns16550a&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bluetooth {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quo=
t;ti,wl1835-st&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable-gpios =3D &l=
t;&amp;gpio1 7 GPIO_ACTIVE_HIGH&gt;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+};<br>
<font color=3D"#888888">--<br>
2.11.0<br>
<br>
<br>
______________________________<wbr>_________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kernel@li=
sts.<wbr>infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mailman/=
listinfo/linux-arm-<wbr>kernel</a><br>
</font></blockquote></div><br></div></div></div>

--001a114763e09dc4e4054d493935--
