Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 27 Feb 2015 12:08:51 -0800
Message-ID: <CAGXr9JG=izvOEboB7FLL9GZO6=1448gAxi6H59Ux=nb2cqA6iQ@mail.gmail.com>
Subject: HID fast reconnects broken on Linux 3.19 / BlueZ 5.28
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/alternative; boundary=001a11353372ecfd0f0510176f1e
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11353372ecfd0f0510176f1e
Content-Type: text/plain; charset=UTF-8

We recently updated our platform to use Linux 3.19 and BlueZ 5.28.

I immediately noticed that HID remote control reconnects back to BlueZ host
got slower. It would often take 3-5 seconds for the host to see the first
keypress from HID remote.

Running "btmgmt info" reveals that hci0 is no longer "connectable" and
"fast-connectable".

hci0: addr XX:XX:XX:XX:XX:XX version 6 manufacturer 72 class 0x000100
supported settings: powered connectable fast-connectable discoverable
bondable link-security ssp br/edr hs le advertising secure-conn debug-keys
privacy configuration
current settings: powered bondable ssp br/edr le secure-conn
name ...
short name ...

Regardless of the above, a previously paired HID remote is still able to
reconnect, so somewhere in BlueZ code the page scan must be turned on.

I think what is missing from the code is that wherever page scan is turned
on, the page scan interval should be configured as well, when fast
reconnects are desired.

In order to work around this issue, I had to use the following patch in
src/adapter.c to force "connectable" and "fast-connectable" on at all times:

@@ -7142,6 +7143,11 @@ static void read_info_complete(uint8_t status,
uint16_t length,

        if (adapter->current_settings & MGMT_SETTING_POWERED)
                adapter_start(adapter);
+       else
+               set_mode(adapter, MGMT_OP_SET_POWERED, 0x01);
+
+       set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);
+       set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);

Can someone clarify how previously paired BT Classic devices reconnect back
to host when the hci interface is not connectable?

--001a11353372ecfd0f0510176f1e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>We recently updated our platform to use Linux 3.19 an=
d BlueZ 5.28.</div><div><br></div><div>I immediately noticed that HID remot=
e control reconnects back to BlueZ host got slower. It would often take 3-5=
 seconds for the host to see the first keypress from HID remote.</div><div>=
<br></div><div>Running &quot;btmgmt info&quot; reveals that hci0 is no long=
er &quot;connectable&quot; and &quot;fast-connectable&quot;.</div><div><br>=
</div><div><div>hci0:<span class=3D"" style=3D"white-space:pre">	</span>add=
r XX:XX:XX:XX:XX:XX version 6 manufacturer 72 class 0x000100</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>supported settings: powered =
connectable fast-connectable discoverable bondable link-security ssp br/edr=
 hs le advertising secure-conn debug-keys privacy configuration=C2=A0</div>=
<div><span class=3D"" style=3D"white-space:pre">	</span>current settings: p=
owered bondable ssp br/edr le secure-conn=C2=A0</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>name ...</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>short name ...</div></div><div><br></div><div>=
Regardless of the above, a previously paired HID remote is still able to re=
connect, so somewhere in BlueZ code the page scan must be turned on.</div><=
div><br></div><div>I think what is missing from the code is that wherever p=
age scan is turned on, the page scan interval should be configured as well,=
 when fast reconnects are desired.<br></div><div><br></div><div>In order to=
 work around this issue, I had to use the following patch in src/adapter.c =
to force &quot;connectable&quot; and &quot;fast-connectable&quot; on at all=
 times:</div><div><br></div><div><div>@@ -7142,6 +7143,11 @@ static void re=
ad_info_complete(uint8_t status, uint16_t length,</div><div>=C2=A0</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adapter-&gt;current_settings &amp; MGMT_S=
ETTING_POWERED)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 adapter_start(adapter);</div><div>+ =C2=A0 =C2=A0 =C2=A0 else</div><=
div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mode(adapter, MG=
MT_OP_SET_POWERED, 0x01);</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 set_=
mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);</div></div><div>=
<br></div><div>Can someone clarify how previously paired BT Classic devices=
 reconnect back to host when the hci interface is not connectable?</div></d=
iv>

--001a11353372ecfd0f0510176f1e--
