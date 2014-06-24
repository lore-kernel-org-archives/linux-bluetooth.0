Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 23 Jun 2014 17:35:06 -0700
Message-ID: <CAGXr9JGd6tsqO4meFhgoZ2FEVXerxfVOLOXGXHhMc+bbBV0F4Q@mail.gmail.com>
Subject: BlueZ 5.19: BLE HoG device reconnect issues
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=20cf3030c3479a56cf04fc8a214c
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf3030c3479a56cf04fc8a214c
Content-Type: text/plain; charset=UTF-8

With BlueZ 5.19 stack and BLE HoG remote controls, I'm seeing 3 different
issues when trying to reconnect a previously paired BLE HoG remote control:

Full log:
[72241.012] bluez: bluetoothd[29263]: src/adapter.c:discovering_callback()
hci0 type 6 discovering 1
[72251.269] bluez: bluetoothd[29263]: src/adapter.c:device_found_callback()
hci0 addr 88:33:14:E6:XX:XX, rssi -81 flags 0x0000 eir_len 16
[72251.270] bluez: bluetoothd[29263]: src/device.c:device_set_legacy()
legacy 0
[72251.270] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning()

[72251.270] bluez: bluetoothd[29263]: src/adapter.c:discovering_callback()
hci0 type 6 discovering 0
[72251.270] bluez: bluetoothd[29263]:
src/adapter.c:trigger_passive_scanning()
[72251.270] bluez: bluetoothd[29263]:
src/adapter.c:stop_passive_scanning_complete() status 0x0b (Rejected)
[72251.270] bluez: bluetoothd[29263]: Stopping passive scanning failed:
Rejected
[72255.015] bluez: bluetoothd[29263]:
src/adapter.c:passive_scanning_complete() status 0x00
[72255.015] bluez: bluetoothd[29263]: src/adapter.c:discovering_callback()
hci0 type 6 discovering 1
[72258.550] bluez: bluetoothd[29263]: src/adapter.c:device_found_callback()
hci0 addr 88:33:14:E6:XX:XX, rssi -76 flags 0x0000 eir_len 16
[72258.551] bluez: bluetoothd[29263]: src/device.c:device_set_legacy()
legacy 0
[72258.551] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning()

[72258.551] bluez: bluetoothd[29263]: src/adapter.c:device_found_callback()
hci0 addr CB:36:E5:F5:XX:XX, rssi -82 flags 0x0000 eir_len 36
[72258.558] bluez: bluetoothd[29263]:
src/adapter.c:stop_passive_scanning_complete() status 0x00 (Success)
[72258.558] bluez: bluetoothd[29263]: src/device.c:device_connect_le()
Connection attempt to: 88:33:14:E6:XX:XX
[72258.558] bluez: bluetoothd[29263]: src/adapter.c:discovering_callback()
hci0 type 6 discovering 0
[72278.629] bluez: bluetoothd[29263]:
src/adapter.c:connect_failed_callback() hci0 88:33:14:E6:XX:XX status 2
[72278.629] bluez: bluetoothd[29263]: plugins/policy.c:conn_fail_cb()
status 2
[72278.629] bluez: bluetoothd[29263]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 88:33:14:E6:XX:XX type
1 status 0x2
[72278.629] bluez: bluetoothd[29263]:
src/device.c:device_bonding_complete() bonding (nil) status 0x02
[72278.629] bluez: bluetoothd[29263]: src/device.c:device_bonding_failed()
status 2
[72278.629] bluez: bluetoothd[29263]: src/adapter.c:resume_discovery()
[72278.629] bluez: bluetoothd[29263]: src/device.c:att_connect_cb() connect
error: Transport endpoint is not connected (134)
[72278.629] bluez: bluetoothd[29263]: src/device.c:att_error_cb() Enabling
automatic connections
[72278.630] bluez: bluetoothd[29263]:
src/adapter.c:adapter_connect_list_add() ignoring already added device
/org/bluez/hci0/dev_88_33_14_E6_XX_XX

Issues 1 and 2:
[72251.270] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning()

[72251.270] bluez: bluetoothd[29263]: src/adapter.c:discovering_callback()
hci0 type 6 discovering 0
[72251.270] bluez: bluetoothd[29263]:
src/adapter.c:trigger_passive_scanning()
[72251.270] bluez: bluetoothd[29263]:
src/adapter.c:stop_passive_scanning_complete() status 0x0b (Rejected)
[72251.270] bluez: bluetoothd[29263]: Stopping passive scanning failed:
Rejected

1) device_found_callback() -> update_found_devices() ->
stop_passive_scanning() needs to stop passive scanning because BlueZ is
about to connect to previously paired BLE device. But,
discovering_callback() doesn't take the pending BLE connection into account
and still calls trigger_passive_scanning() when it shouldn't.

2) stop_passive_scanning() can actually fail because passive scanning was
already stopped in kernel due to passive scan timer expiring. But,
stop_passive_scanning_complete() handles the Reject case as an error and
never attempts the pending BLE connection in that case.

Issue 3:
[72278.629] bluez: bluetoothd[29263]: src/device.c:att_connect_cb() connect
error: Transport endpoint is not connected (134)
[72278.629] bluez: bluetoothd[29263]: src/device.c:att_error_cb() Enabling
automatic connections
[72278.630] bluez: bluetoothd[29263]:
src/adapter.c:adapter_connect_list_add() ignoring already added device
/org/bluez/hci0/dev_88_33_14_E6_XX_XX

If there is an error connecting to BLE device, att_error_cb() adds the
failed device back to adapter connect list, but if it is already there, no
code actually calls trigger_passive_scanning(). So, from this point on, no
BLE device is ever going to reconnect back to BlueZ, because the passive
scanning is disabled and nothing will re-enable it.


Here is my proposed diff for fixing these issues:
@@ -1228,7 +1228,7 @@ static void stop_passive_scanning_complete(uint8_t
status, uint16_t length,
        dev = adapter->connect_le;
        adapter->connect_le = NULL;

-       if (status != MGMT_STATUS_SUCCESS) {
+       if (status != MGMT_STATUS_SUCCESS && status !=
MGMT_STATUS_REJECTED) {
                error("Stopping passive scanning failed: %s",

mgmt_errstr(status));
                return;

@@ -1500,6 +1500,10 @@ static void discovering_callback(uint16_t index,
uint16_t length,
         * passive scanning attempt.
         */
        if (!adapter->discovery_list) {
+               if (adapter->connect_le) {
+                       DBG("LE connect pending, skip
trigger_passive_scanning");
+                       return;
+               }
                trigger_passive_scanning(adapter);
                return;
        }

@@ -3675,6 +3676,7 @@ static void att_error_cb(const GError *gerr, gpointer
user_data)
        if (device_get_auto_connect(device)) {
                DBG("Enabling automatic connections");
                adapter_connect_list_add(device->adapter, device);
+               trigger_passive_scanning(device->adapter);
        }
 }


Let me know if this looks good. I'll then e-mail proper patch for review.

-- Petri

--20cf3030c3479a56cf04fc8a214c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>With BlueZ 5.19 stack and BLE HoG remote controls, I&=
#39;m seeing 3 different issues when trying to reconnect a previously paire=
d BLE HoG remote control:<br></div><div><br></div><div>Full log:</div><div>
<div>[72241.012] bluez: bluetoothd[29263]: src/adapter.c:discovering_callba=
ck() hci0 type 6 discovering 1</div><div>[72251.269] bluez: bluetoothd[2926=
3]: src/adapter.c:device_found_callback() hci0 addr 88:33:14:E6:XX:XX, rssi=
 -81 flags 0x0000 eir_len 16</div>
<div>[72251.270] bluez: bluetoothd[29263]: src/device.c:device_set_legacy()=
 legacy 0</div><div>[72251.270] bluez: bluetoothd[29263]: src/adapter.c:sto=
p_passive_scanning() =C2=A0 =C2=A0</div><div>[72251.270] bluez: bluetoothd[=
29263]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0</div=
>
<div>[72251.270] bluez: bluetoothd[29263]: src/adapter.c:trigger_passive_sc=
anning() =C2=A0 =C2=A0</div><div>[72251.270] bluez: bluetoothd[29263]: src/=
adapter.c:stop_passive_scanning_complete() status 0x0b (Rejected)</div><div=
>[72251.270] bluez: bluetoothd[29263]: Stopping passive scanning failed: Re=
jected</div>
<div>[72255.015] bluez: bluetoothd[29263]: src/adapter.c:passive_scanning_c=
omplete() status 0x00</div><div>[72255.015] bluez: bluetoothd[29263]: src/a=
dapter.c:discovering_callback() hci0 type 6 discovering 1</div><div>[72258.=
550] bluez: bluetoothd[29263]: src/adapter.c:device_found_callback() hci0 a=
ddr 88:33:14:E6:XX:XX, rssi -76 flags 0x0000 eir_len 16</div>
<div>[72258.551] bluez: bluetoothd[29263]: src/device.c:device_set_legacy()=
 legacy 0</div><div>[72258.551] bluez: bluetoothd[29263]: src/adapter.c:sto=
p_passive_scanning() =C2=A0 =C2=A0</div><div>[72258.551] bluez: bluetoothd[=
29263]: src/adapter.c:device_found_callback() hci0 addr CB:36:E5:F5:XX:XX, =
rssi -82 flags 0x0000 eir_len 36</div>
<div>[72258.558] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scann=
ing_complete() status 0x00 (Success)</div><div>[72258.558] bluez: bluetooth=
d[29263]: src/device.c:device_connect_le() Connection attempt to: 88:33:14:=
E6:XX:XX</div>
<div>[72258.558] bluez: bluetoothd[29263]: src/adapter.c:discovering_callba=
ck() hci0 type 6 discovering 0</div><div>[72278.629] bluez: bluetoothd[2926=
3]: src/adapter.c:connect_failed_callback() hci0 88:33:14:E6:XX:XX status 2=
</div>
<div>[72278.629] bluez: bluetoothd[29263]: plugins/policy.c:conn_fail_cb() =
status 2</div><div>[72278.629] bluez: bluetoothd[29263]: src/adapter.c:bond=
ing_attempt_complete() hci0 bdaddr 88:33:14:E6:XX:XX type 1 status 0x2</div=
>
<div>[72278.629] bluez: bluetoothd[29263]: src/device.c:device_bonding_comp=
lete() bonding (nil) status 0x02</div><div>[72278.629] bluez: bluetoothd[29=
263]: src/device.c:device_bonding_failed() status 2</div><div>[72278.629] b=
luez: bluetoothd[29263]: src/adapter.c:resume_discovery() =C2=A0 =C2=A0</di=
v>
<div>[72278.629] bluez: bluetoothd[29263]: src/device.c:att_connect_cb() co=
nnect error: Transport endpoint is not connected (134)</div><div>[72278.629=
] bluez: bluetoothd[29263]: src/device.c:att_error_cb() Enabling automatic =
connections</div>
<div>[72278.630] bluez: bluetoothd[29263]: src/adapter.c:adapter_connect_li=
st_add() ignoring already added device /org/bluez/hci0/dev_88_33_14_E6_XX_X=
X</div></div><div><br></div><div>Issues 1 and 2:</div><div><div>[72251.270]=
 bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning() =C2=A0 =C2=
=A0</div>
<div>[72251.270] bluez: bluetoothd[29263]: src/adapter.c:discovering_callba=
ck() hci0 type 6 discovering 0</div><div>[72251.270] bluez: bluetoothd[2926=
3]: src/adapter.c:trigger_passive_scanning() =C2=A0 =C2=A0</div><div>[72251=
.270] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning_complet=
e() status 0x0b (Rejected)</div>
<div>[72251.270] bluez: bluetoothd[29263]: Stopping passive scanning failed=
: Rejected</div></div><div><br></div><div>1) device_found_callback() -&gt; =
update_found_devices() -&gt; stop_passive_scanning() needs to stop passive =
scanning because BlueZ is about to connect to previously paired BLE device.=
 But, discovering_callback() doesn&#39;t take the pending BLE connection in=
to account and still calls=C2=A0trigger_passive_scanning() when it shouldn&=
#39;t.</div>
<div><br></div><div>2) stop_passive_scanning() can actually fail because pa=
ssive scanning was already stopped in kernel due to passive scan timer expi=
ring. But, stop_passive_scanning_complete() handles the Reject case as an e=
rror and never attempts the pending BLE connection in that case.</div>
<div><br></div><div>Issue 3:</div><div><div>[72278.629] bluez: bluetoothd[2=
9263]: src/device.c:att_connect_cb() connect error: Transport endpoint is n=
ot connected (134)</div><div>[72278.629] bluez: bluetoothd[29263]: src/devi=
ce.c:att_error_cb() Enabling automatic connections</div>
<div>[72278.630] bluez: bluetoothd[29263]: src/adapter.c:adapter_connect_li=
st_add() ignoring already added device /org/bluez/hci0/dev_88_33_14_E6_XX_X=
X</div></div><div><br></div><div>If there is an error connecting to BLE dev=
ice,=C2=A0att_error_cb() adds the failed device back to adapter connect lis=
t, but if it is already there, no code actually calls=C2=A0trigger_passive_=
scanning(). So, from this point on, no BLE device is ever going to reconnec=
t back to BlueZ, because the passive scanning is disabled and nothing will =
re-enable it.</div>
<div><br></div><div><br></div><div>Here is my proposed diff for fixing thes=
e issues:</div><div><div>@@ -1228,7 +1228,7 @@ static void stop_passive_sca=
nning_complete(uint8_t status, uint16_t length,</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev =3D adapter-&gt;connect_le;</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 adapter-&gt;connect_le =3D NULL;</div><div=
>=C2=A0</div><div>- =C2=A0 =C2=A0 =C2=A0 if (status !=3D MGMT_STATUS_SUCCES=
S) {</div><div>+ =C2=A0 =C2=A0 =C2=A0 if (status !=3D MGMT_STATUS_SUCCESS &=
amp;&amp; status !=3D MGMT_STATUS_REJECTED) {</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&quot;Stopping passive scannin=
g failed: %s&quot;,</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mgmt_errstr(status));<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;</=
div></div><div><br></div><div><div>@@ -1500,6 +1500,10 @@ static void disco=
vering_callback(uint16_t index, uint16_t length,</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* passive scanning attempt.</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!adapter-&gt;discovery_list) {</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (adapter-&gt;connect_le) {</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&=
quot;LE connect pending, skip trigger_passive_scanning&quot;);</div>
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
trigger_passive_scanning(adapter);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
</div></div><div><br></div><div><div>@@ -3675,6 +3676,7 @@ static void att_=
error_cb(const GError *gerr, gpointer user_data)</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (device_get_auto_connect(device)) {</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&quot;En=
abling automatic connections&quot;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adapter_connect_list_add(device-&gt;adapter, de=
vice);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trigger=
_passive_scanning(device-&gt;adapter);</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>=C2=A0}</div></div><div><br></=
div><div><br></div><div>Let me know if this looks good. I&#39;ll then e-mai=
l proper patch for review.</div><div><br></div><div>-- Petri</div><div><br>=
</div></div>

--20cf3030c3479a56cf04fc8a214c--
