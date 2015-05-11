Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 12 May 2015 00:39:19 +0800
Message-ID: <CAAAJ3C+iyc+YwWBPpoQnnQKmCb3oJ3weaDtxvEfUb9FwRqWx9Q@mail.gmail.com>
Subject: Can't update remote name in function of "hci_check_pending_name"
 because of discov->state == DISCOVERY_STOPPED
From: Ethan <ethancsge@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, jpawlowski@google.com, armansito@chromium.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=089e0160c42cf52f2c0515d104ca
List-ID: <linux-bluetooth.vger.kernel.org>

--089e0160c42cf52f2c0515d104ca
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

We found this issue in Chromebook with kernel 3.14. From btmon, Stack
received event of Remote Name Req Complete with Device name =E2=80=9CName:
VGP-BMS21=E2=80=9D, but it=E2=80=99s after @ Discovering: 0x00 (7). It mean=
s
le_scan_disable_work_complete set discover status to STOPPED for starting
new discovery which caused hci_check_pending_name return without update the
name information because discovery status is STOPPED. Then user space will
always get null name, even hci_remote_name_evt shows everything is correct
at HCI layer.

Is it possible setting LE Set Scan Enable to disable after Remote Name Req
Complete? Or adding condition for hci_discovery_set_state(hdev,
DISCOVERY_STOPPED) in function of le_scan_disable_work_complete?



static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,

                                                       u16 opcode)

{
           /* General inquiry access code (GIAC) */

  .....
.......

           case DISCOV_TYPE_INTERLEAVED:

                     hci_dev_lock(hdev);



                     if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,

                                     &hdev->quirks)) {

                                /* If we were running LE only scan, change
discovery

                                * state. If we were running both LE and
BR/EDR inquiry

                                * simultaneously, and BR/EDR inquiry is
already

                                * finished, stop discovery, otherwise
BR/EDR inquiry

                                * will stop discovery when finished.

                                */

                                if (!test_bit(HCI_INQUIRY, &hdev->flags))

                                           hci_discovery_set_state(hdev,
                                  /* <-------------   Here set set discover
status to STOPPED */


 DISCOVERY_STOPPED);


static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn
*conn,
                   bdaddr_t *bdaddr, u8 *name, u8 name_len)
{
    struct discovery_state *discov =3D &hdev->discovery;
    struct inquiry_entry *e;

    /* Update the mgmt connected state if necessary. Be careful with
     * conn objects that exist but are not (yet) connected however.
     * Only those in BT_CONFIG or BT_CONNECTED states can be
     * considered connected.
     */
    if (conn &&
        (conn->state =3D=3D BT_CONFIG || conn->state =3D=3D BT_CONNECTED) &=
&
        !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
        mgmt_device_connected(hdev, conn, 0, name, name_len);

    if (discov->state =3D=3D DISCOVERY_STOPPED)
                  /* <-------------   Return due to  (discov->state =3D=3D
DISCOVERY_STOPPED) */
        return;


btmon:

@ Discovering: 0x01 (7)

...
....
> HCI Event: Inquiry Complete (0x01) plen 1                    [hci0]
39.027238
        Status: Success (0x00)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0]
39.027342
        Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)
        Page scan repetition mode: R1 (0x01)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x7774
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
39.028072
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
39.060051
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
39.062071
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)

@ Discovering: 0x00 (7)


> HCI Event: Remote Host Supported Features (0x3d) plen 14     [hci0]
39.536284
        Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0]
39.628124
        Status: Success (0x00)
        Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)
        Name: VGP-BMS21
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
44.786231
        Address: 24:AF:E7:B5:2D:00 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
44.946206
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
44.946270
        Type: Active (0x01)
        Interval: 22.500 msec (0x0024)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
44.947201
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
44.947296
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
44.948203
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                    [hci0]
44.948266
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
44.949207
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)


Regards,
Ethan

--089e0160c42cf52f2c0515d104ca
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>We found this issue in Chromebook with kernel 3=
.14. From btmon, Stack received event of Remote Name Req Complete with Devi=
ce name =E2=80=9CName: VGP-BMS21=E2=80=9D, but it=E2=80=99s after @ Discove=
ring: 0x00 (7). It means le_scan_disable_work_complete set discover status =
to STOPPED for starting new discovery which caused hci_check_pending_name r=
eturn without update the name information because discovery status is STOPP=
ED. Then user space will always get null name, even hci_remote_name_evt sho=
ws everything is correct at HCI layer.<br><br>Is it possible setting LE Set=
 Scan Enable to disable after Remote Name Req Complete? Or adding condition=
 for hci_discovery_set_state(hdev, DISCOVERY_STOPPED) in function of le_sca=
n_disable_work_complete?<br><br>=C2=A0<br><br>static void le_scan_disable_w=
ork_complete(struct hci_dev *hdev, u8 status,<br><br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 opcode)<br><br>{<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* General inquiry access code (GIAC) */<br><br>=C2=A0 ...=
..<br>.......<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case DISCOV_T=
YPE_INTERLEAVED:<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0hci_dev_lock(hdev);<br><br>=C2=A0<br><br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (te=
st_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;hdev-&gt;quirks)) {<br><br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If we were running LE only scan, change disc=
overy<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * state. If we were runni=
ng both LE and BR/EDR inquiry<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
 simultaneously, and BR/EDR inquiry is already<br><br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 * finished, stop discovery, otherwise BR/EDR inquiry<br><=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * will stop discovery when finish=
ed.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br><br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (!test_bit(HCI_INQUIRY, &amp;hdev-&gt;flags))<b=
r><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hci_discovery_set_state(hdev, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* &lt;------------- =C2=A0 Here set set discover status =
to STOPPED */<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DISCOVERY=
_STOPPED);<br><br><br>static void hci_check_pending_name(struct hci_dev *hd=
ev, struct hci_conn *conn,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bdaddr_t *bdaddr, u8 *name, u8 name_len)<br>{<br>=
=C2=A0 =C2=A0 struct discovery_state *discov =3D &amp;hdev-&gt;discovery;<b=
r>=C2=A0 =C2=A0 struct inquiry_entry *e;<br><br>=C2=A0 =C2=A0 /* Update the=
 mgmt connected state if necessary. Be careful with<br>=C2=A0 =C2=A0 =C2=A0=
* conn objects that exist but are not (yet) connected however.<br>=C2=A0 =
=C2=A0 =C2=A0* Only those in BT_CONFIG or BT_CONNECTED states can be<br>=C2=
=A0 =C2=A0 =C2=A0* considered connected.<br>=C2=A0 =C2=A0 =C2=A0*/<br>=C2=
=A0 =C2=A0 if (conn &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 (conn-&gt;sta=
te =3D=3D BT_CONFIG || conn-&gt;state =3D=3D BT_CONNECTED) &amp;&amp;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &amp=
;conn-&gt;flags))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 mgmt_device_connected(hdev=
, conn, 0, name, name_len);<br><br>=C2=A0 =C2=A0 if (discov-&gt;state =3D=
=3D DISCOVERY_STOPPED) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* &lt;------------- =C2=
=A0 Return due to =C2=A0(discov-&gt;state =3D=3D DISCOVERY_STOPPED) */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br><br><br>btmon:<br><br>@ Discovering:=
 0x01 (7) =C2=A0<br><br>...<br>.... =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>&gt; HCI=
 Event: Inquiry Complete (0x01) plen 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 39.027238<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Status: Success (0x00)<br>&lt; HCI Command: Remote Name Request (0x0=
1|0x0019) plen 10 =C2=A0 =C2=A0 =C2=A0 [hci0] 39.027342<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Page scan repetition mode: R1 (0x01)<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Page scan mode: Mandatory (0x00)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Cloc=
k offset: 0x7774<br>&gt; HCI Event: Command Status (0x0f) plen 4 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 39=
.028072<br>=C2=A0 =C2=A0 =C2=A0 Remote Name Request (0x01|0x0019) ncmd 1<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)<br>&lt; HCI Command: LE=
 Set Scan Enable (0x08|0x000c) plen 2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hci0] 39=
.060051<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Scanning: Disabled (0x00)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Filter duplicates: Disabled (0x00)<br>&gt; HCI Event: =
Command Complete (0x0e) plen 4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 39.062071<br>=C2=A0 =C2=A0 =C2=A0 LE Set =
Scan Enable (0x08|0x000c) ncmd 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Suc=
cess (0x00)<br><br>@ Discovering: 0x00 (7)<br><br><br>&gt; HCI Event: Remot=
e Host Supported Features (0x3d) plen 14 =C2=A0 =C2=A0 [hci0] 39.536284<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x=
00<br>&gt; HCI Event: Remote Name Req Complete (0x07) plen 255 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 39.628124<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sta=
tus: Success (0x00)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 90:7F:61:0F:24:=
41 (OUI 90-7F-61)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name: VGP-BMS21<br>&lt; HC=
I Command: LE Set Random Address (0x08|0x0005) plen 6 =C2=A0 =C2=A0 =C2=A0[=
hci0] 44.786231<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 24:AF:E7:B5:2D:00 (=
Non-Resolvable)<br>&gt; HCI Event: Command Complete (0x0e) plen 4 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 44.946=
206<br>=C2=A0 =C2=A0 =C2=A0 LE Set Random Address (0x08|0x0005) ncmd 1<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)<br>&lt; HCI Command: LE =
Set Scan Parameters (0x08|0x000b) plen 7 =C2=A0 =C2=A0 [hci0] 44.946270<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Type: Active (0x01)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Interval: 22.500 msec (0x0024)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Window: 1=
1.250 msec (0x0012)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Own address type: Random=
 (0x01)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Filter policy: Accept all advertisem=
ent (0x00)<br>&gt; HCI Event: Command Complete (0x0e) plen 4 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 44.947201<br>=
=C2=A0 =C2=A0 =C2=A0 LE Set Scan Parameters (0x08|0x000b) ncmd 1<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)<br>&lt; HCI Command: LE Set Sca=
n Enable (0x08|0x000c) plen 2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hci0] 44.947296<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Scanning: Enabled (0x01)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Filter duplicates: Enabled (0x01)<br>&gt; HCI Event: Command =
Complete (0x0e) plen 4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0[hci0] 44.948203<br>=C2=A0 =C2=A0 =C2=A0 LE Set Scan Enabl=
e (0x08|0x000c) ncmd 2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00=
)<br>&lt; HCI Command: Inquiry (0x01|0x0001) plen 5 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 44.948266<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Access code: 0x9e8b33 (General Inquiry)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Length: 10.24s (0x08)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Num =
responses: 0<br>&gt; HCI Event: Command Status (0x0f) plen 4 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 44.949=
207<br>=C2=A0 =C2=A0 =C2=A0 Inquiry (0x01|0x0001) ncmd 2<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Status: Success (0x00)<br><br><br>Regards,<br>Ethan<br></div>

--089e0160c42cf52f2c0515d104ca--
