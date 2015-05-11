Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 12 May 2015 00:21:35 +0800
Message-ID: <CAAAJ3CJQ5q8zhcQr3LDjUTk_eP3DQuDRtNYqcX2_zN7x1U28ww@mail.gmail.com>
Subject: Can't update remote name in function of "hci_check_pending_name"
 because of discov->state == DISCOVERY_STOPPED
From: Ethan <ethancsge@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, jpawlowski@google.com, mansito@chromium.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a11c1d9aa946e250515d0c537
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11c1d9aa946e250515d0c537
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

We found this issue in Chromebook with kernel 3.14. From btmon, Stack
received event of Remote Name Req Complete with Device name =E2=80=9CName:
VGP-BMS21=E2=80=9D, but it=E2=80=99s after @ Discovering: 0x00 (7).

It means le_scan_disable_work_complete set discover status to STOPPED
for starting new discovery which caused hci_check_pending_name return
without update the name information because discovery status is
STOPPED. Then user space will always get null name, even
hci_remote_name_evt shows everything is correct at HCI layer.



Is it possible setting LE Set Scan Enable to disable after Remote Name Req
Complete? Or adding condition for hci_discovery_set_state(hdev,
DISCOVERY_STOPPED) in function of le_scan_disable_work_complete?





static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,

                                                       u16 opcode)

{

           /* General inquiry access code (GIAC) */

           u8 lap[3] =3D { 0x33, 0x8b, 0x9e };

           struct hci_cp_inquiry cp;

           int err;



           if (status) {

                     BT_ERR("Failed to disable LE scanning: status %d",
status);

                     return;

           }



           hdev->discovery.scan_start =3D 0;



           switch (hdev->discovery.type) {

           case DISCOV_TYPE_LE:

                     hci_dev_lock(hdev);

                     hci_discovery_set_state(hdev, DISCOVERY_STOPPED);

                     hci_dev_unlock(hdev);

                     break;



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

--001a11c1d9aa946e250515d0c537
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJv
dHRvbToxMnB0Ij48c3BhbiBsYW5nPSJFTi1VUyI+SGksPC9zcGFuPjwvcD4NCg0KPHByZSBzdHls
ZT0iYmFja2dyb3VuZC1pbWFnZTppbml0aWFsO2JhY2tncm91bmQtcmVwZWF0OmluaXRpYWwiPjxz
cGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxzYW5zLXNlcmlmO2Jh
Y2tncm91bmQtaW1hZ2U6aW5pdGlhbDtiYWNrZ3JvdW5kLXJlcGVhdDppbml0aWFsIj5XZSBmb3Vu
ZCB0aGlzIGlzc3VlIGluIENocm9tZWJvb2sgd2l0aMKga2VybmVsIDMuMTQuIEZyb20gYnRtb24s
IDwvc3Bhbj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmksc2Fu
cy1zZXJpZjtjb2xvcjpibGFjayI+U3RhY2sgcmVjZWl2ZWQgZXZlbnQgb2YgPC9zcGFuPjxzcGFu
IGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxzYW5zLXNlcmlmIj5SZW1v
dGUgTmFtZSBSZXEgQ29tcGxldGUgd2l0aCBEZXZpY2UgbmFtZSDigJxOYW1lOiBWR1AtQk1TMjHi
gJ08L3NwYW4+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LWZhbWlseTpDYWxpYnJpLHNh
bnMtc2VyaWY7Y29sb3I6YmxhY2siPiwgYnV0IGl04oCZcyBhZnRlciA8L3NwYW4+PHNwYW4gbGFu
Zz0iRU4tVVMiIHN0eWxlPSJmb250LWZhbWlseTpDYWxpYnJpLHNhbnMtc2VyaWYiPkAgRGlzY292
ZXJpbmc6IDB4MDAgKDcpLjwvc3Bhbj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtZmFt
aWx5OkNhbGlicmksc2Fucy1zZXJpZiI+PC9zcGFuPjwvcHJlPjxwcmUgc3R5bGU9ImJhY2tncm91
bmQtaW1hZ2U6aW5pdGlhbDtiYWNrZ3JvdW5kLXJlcGVhdDppbml0aWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyIgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmksc2Fucy1zZXJpZiI+SXQgbWVhbnMgPC9z
cGFuPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxzYW5zLXNl
cmlmO2NvbG9yOmJsYWNrIj5sZV9zY2FuX2Rpc2FibGVfd29ya19jb21wbGV0ZSBzZXQgZGlzY292
ZXIgc3RhdHVzIHRvIFNUT1BQRUQgZm9yIHN0YXJ0aW5nIG5ldyBkaXNjb3Zlcnkgd2hpY2ggY2F1
c2VkIGhjaV9jaGVja19wZW5kaW5nX25hbWUgcmV0dXJuIHdpdGhvdXQgdXBkYXRlIHRoZSBuYW1l
IGluZm9ybWF0aW9uIGJlY2F1c2UgZGlzY292ZXJ5IHN0YXR1cyBpcyBTVE9QUEVELiBUaGVuIHVz
ZXIgc3BhY2Ugd2lsbCBhbHdheXMgZ2V0IG51bGwgbmFtZSwgZXZlbiBoY2lfcmVtb3RlX25hbWVf
ZXZ0IHNob3dzIGV2ZXJ5dGhpbmcgaXMgY29ycmVjdCBhdCBIQ0kgbGF5ZXIuIDwvc3Bhbj48L3By
ZT4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPsKgPC9zcGFuPjwv
cD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPklzDQppdCBwb3Nz
aWJsZSBzZXR0aW5nIExFIFNldCBTY2FuIEVuYWJsZSB0byBkaXNhYmxlIGFmdGVyIFJlbW90ZSBO
YW1lIFJlcQ0KQ29tcGxldGU/IE9yIGFkZGluZyBjb25kaXRpb24gZm9yIGhjaV9kaXNjb3Zlcnlf
c2V0X3N0YXRlKGhkZXYsDQpESVNDT1ZFUllfU1RPUFBFRCkgaW4gZnVuY3Rpb24gb2YgbGVfc2Nh
bl9kaXNhYmxlX3dvcmtfY29tcGxldGU/PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB0Ij48L3Nw
YW4+PC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMi
IHN0eWxlPSJmb250LXNpemU6MTFwdCI+wqA8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZToxMXB0Ij7CoDwvc3Bhbj48
L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj5zdGF0aWMNCnZv
aWQgbGVfc2Nhbl9kaXNhYmxlX3dvcmtfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4
IHN0YXR1cyw8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCsKg
IHUxNiBvcGNvZGUpPC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFu
Zz0iRU4tVVMiPns8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5n
PSJFTi1VUyI+wqDCoMKgwqDCoMKgwqDCoMKgwqANCi8qIEdlbmVyYWwgaW5xdWlyeSBhY2Nlc3Mg
Y29kZSAoR0lBQykgKi88L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBs
YW5nPSJFTi1VUyI+wqDCoMKgwqDCoMKgwqDCoMKgwqANCnU4IGxhcFszXSA9IHsgMHgzMywgMHg4
YiwgMHg5ZSB9Ozwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9
IkVOLVVTIj7CoMKgwqDCoMKgwqDCoMKgwqDCoA0Kc3RydWN0IGhjaV9jcF9pbnF1aXJ5IGNwOzwv
c3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj7CoMKg
wqDCoMKgwqDCoMKgwqDCoA0KaW50IGVycjs8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+wqA8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+wqDCoMKgwqDCoMKgwqDCoMKgwqANCmlmIChzdGF0dXMp
IHs8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KQlRfRVJSKCZxdW90O0Zh
aWxlZCB0byBkaXNhYmxlIExFIHNjYW5uaW5nOiBzdGF0dXMgJWQmcXVvdDssIHN0YXR1cyk7PC9z
cGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCnJldHVybjs8L3NwYW4+PC9wPg0K
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+wqDCoMKgwqDCoMKgwqDC
oMKgwqANCn08L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyI+wqA8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyI+wqDCoMKgwqDCoMKgwqDCoMKgwqANCmhkZXYtJmd0O2Rpc2NvdmVyeS5zY2FuX3N0YXJ0
ID0gMDs8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1V
UyI+wqA8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1V
UyI+wqDCoMKgwqDCoMKgwqDCoMKgwqANCnN3aXRjaCAoaGRldi0mZ3Q7ZGlzY292ZXJ5LnR5cGUp
IHs8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+
wqDCoMKgwqDCoMKgwqDCoMKgwqANCmNhc2UgRElTQ09WX1RZUEVfTEU6PC9zcGFuPjwvcD4NCg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCmhjaV9kZXZfbG9jayhoZGV2KTs8L3NwYW4+PC9wPg0K
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KaGNpX2Rpc2NvdmVyeV9zZXRfc3RhdGUoaGRldiwg
RElTQ09WRVJZX1NUT1BQRUQpOzwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIGxhbmc9IkVOLVVTIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
DQpoY2lfZGV2X3VubG9jayhoZGV2KTs8L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBsYW5nPSJFTi1VUyI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoA0KYnJlYWs7PC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFu
Zz0iRU4tVVMiPsKgPC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFu
Zz0iRU4tVVMiPsKgwqDCoMKgwqDCoMKgwqDCoMKgDQpjYXNlIERJU0NPVl9UWVBFX0lOVEVSTEVB
VkVEOjwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVT
Ij7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQpoY2lfZGV2X2xvY2so
aGRldik7PC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4t
VVMiPsKgPC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4t
VVMiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCmlmICh0ZXN0X2Jp
dChIQ0lfUVVJUktfU0lNVUxUQU5FT1VTX0RJU0NPVkVSWSw8L3NwYW4+PC9wPg0KDQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCsKgwqDCoMKgICZhbXA7aGRl
di0mZ3Q7cXVpcmtzKSkgezwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IGxhbmc9IkVOLVVTIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoA0KLyogSWYgd2Ugd2VyZSBydW5uaW5nIExFIG9ubHkgc2Nhbiwg
Y2hhbmdlIGRpc2NvdmVyeTwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IGxhbmc9IkVOLVVTIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoA0KKiBzdGF0ZS4gSWYgd2Ugd2VyZSBydW5uaW5nIGJvdGggTEUg
YW5kIEJSL0VEUiBpbnF1aXJ5PC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gbGFuZz0iRU4tVVMiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgDQoqIHNpbXVsdGFuZW91c2x5LCBhbmQgQlIvRURSIGlucXVp
cnkgaXMgYWxyZWFkeTwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxh
bmc9IkVOLVVTIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoA0KKiBmaW5pc2hlZCwgc3RvcCBkaXNjb3ZlcnksIG90aGVyd2lzZSBC
Ui9FRFIgaW5xdWlyeTwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxh
bmc9IkVOLVVTIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoA0KKiB3aWxsIHN0b3AgZGlzY292ZXJ5IHdoZW4gZmluaXNoZWQuPC9z
cGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
DQoqLzwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVT
Ij7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoA0KaWYgKCF0ZXN0X2JpdChIQ0lfSU5RVUlSWSwgJmFtcDtoZGV2LSZndDtmbGFncykp
PC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KaGNpX2Rpc2NvdmVyeV9zZXRfc3RhdGUoaGRldiw8
L3NwYW4+PC9wPg0KDQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KRElTQ09WRVJZX1NUT1BQRUQpOzxicj4N
Cjxicj4NCjxicj4NCnN0YXRpYyB2b2lkIGhjaV9jaGVja19wZW5kaW5nX25hbWUoc3RydWN0IGhj
aV9kZXYgKmhkZXYsIHN0cnVjdCBoY2lfY29ubiAqY29ubiw8YnI+DQrCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqANCsKgwqAgYmRhZGRyX3QgKmJkYWRkciwgdTggKm5hbWUsIHU4IG5hbWVfbGVu
KTxicj4NCns8YnI+DQrCoMKgwqAgc3RydWN0IGRpc2NvdmVyeV9zdGF0ZSAqZGlzY292ID0gJmFt
cDtoZGV2LSZndDtkaXNjb3Zlcnk7PGJyPg0KwqDCoMKgIHN0cnVjdCBpbnF1aXJ5X2VudHJ5ICpl
Ozxicj4NCjxicj4NCsKgwqDCoCAvKiBVcGRhdGUgdGhlIG1nbXQgY29ubmVjdGVkIHN0YXRlIGlm
IG5lY2Vzc2FyeS4gQmUgY2FyZWZ1bA0Kd2l0aDxicj4NCsKgwqDCoCDCoCogY29ubiBvYmplY3Rz
IHRoYXQgZXhpc3QgYnV0IGFyZSBub3QgKHlldCkgY29ubmVjdGVkDQpob3dldmVyLjxicj4NCsKg
wqDCoCDCoCogT25seSB0aG9zZSBpbiBCVF9DT05GSUcgb3IgQlRfQ09OTkVDVEVEIHN0YXRlcyBj
YW4NCmJlPGJyPg0KwqDCoMKgIMKgKiBjb25zaWRlcmVkIGNvbm5lY3RlZC48YnI+DQrCoMKgwqAg
wqAqLzxicj4NCsKgwqDCoCBpZiAoY29ubiAmYW1wOyZhbXA7PGJyPg0KwqDCoMKgIMKgwqDCoCAo
Y29ubi0mZ3Q7c3RhdGUgPT0gQlRfQ09ORklHIHx8DQpjb25uLSZndDtzdGF0ZSA9PSBCVF9DT05O
RUNURUQpICZhbXA7JmFtcDs8YnI+DQrCoMKgwqAgwqDCoMKgDQohdGVzdF9hbmRfc2V0X2JpdChI
Q0lfQ09OTl9NR01UX0NPTk5FQ1RFRCwgJmFtcDtjb25uLSZndDtmbGFncykpPGJyPg0KwqDCoMKg
IMKgwqDCoCBtZ210X2RldmljZV9jb25uZWN0ZWQoaGRldiwgY29ubiwgMCwNCm5hbWUsIG5hbWVf
bGVuKTs8YnI+DQo8YnI+DQrCoMKgwqAgaWYgKGRpc2Nvdi0mZ3Q7c3RhdGUgPT0gRElTQ09WRVJZ
X1NUT1BQRUQpPGJyPg0KwqDCoMKgIMKgwqDCoCByZXR1cm47PGJyPg0KPGJyPg0KPGJyPmJ0bW9u
Ojxicj4NCjxicj4NCjwvc3Bhbj48c3BhbiBsYW5nPSJFTi1VUyI+PGZvbnQgc2l6ZT0iNCI+QCBE
aXNjb3ZlcmluZzoNCjB4MDEgKDcpPC9mb250Pjwvc3Bhbj48c3BhbiBsYW5nPSJFTi1VUyI+PGZv
bnQgc2l6ZT0iNCI+wqDCoDwvZm9udD48YnI+DQo8YnI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
MXB0Ij4NCi4uLjwvc3Bhbj48YnI+DQouLi4uIMKgwqDCoMKgwqDCoMKgwqA8YnI+DQomZ3Q7IEhD
SSBFdmVudDogSW5xdWlyeSBDb21wbGV0ZSAoMHgwMSkgcGxlbg0KMcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgDQpbaGNpMF0gMzkuMDI3MjM4PGJyPg0KwqDCoMKgwqDCoMKg
wqAgU3RhdHVzOiBTdWNjZXNzICgweDAwKTxicj4NCiZsdDsgSENJIENvbW1hbmQ6IFJlbW90ZSBO
YW1lIFJlcXVlc3QgKDB4MDF8MHgwMDE5KSBwbGVuDQoxMMKgwqDCoMKgwqDCoCBbaGNpMF0gMzku
MDI3MzQyPGJyPg0KwqDCoMKgwqDCoMKgwqAgQWRkcmVzczogOTA6N0Y6NjE6MEY6MjQ6NDEgKE9V
SQ0KOTAtN0YtNjEpPGJyPg0KwqDCoMKgwqDCoMKgwqAgUGFnZSBzY2FuIHJlcGV0aXRpb24gbW9k
ZTogUjEgKDB4MDEpPGJyPg0KwqDCoMKgwqDCoMKgwqAgUGFnZSBzY2FuIG1vZGU6IE1hbmRhdG9y
eSAoMHgwMCk8YnI+DQrCoMKgwqDCoMKgwqDCoCBDbG9jayBvZmZzZXQ6IDB4Nzc3NDxicj4NCiZn
dDsgSENJIEV2ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbg0KNMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KW2hjaTBdIDM5LjAyODA3Mjxicj4NCsKgwqDC
oMKgwqAgUmVtb3RlIE5hbWUgUmVxdWVzdCAoMHgwMXwweDAwMTkpIG5jbWQgMTxicj4NCsKgwqDC
oMKgwqDCoMKgIFN0YXR1czogU3VjY2VzcyAoMHgwMCk8YnI+DQombHQ7IEhDSSBDb21tYW5kOiBM
RSBTZXQgU2NhbiBFbmFibGUgKDB4MDh8MHgwMDBjKSBwbGVuDQoywqDCoMKgwqDCoMKgwqDCoCBb
aGNpMF0gMzkuMDYwMDUxPGJyPg0KwqDCoMKgwqDCoMKgwqAgU2Nhbm5pbmc6IERpc2FibGVkICgw
eDAwKTxicj4NCsKgwqDCoMKgwqDCoMKgIEZpbHRlciBkdXBsaWNhdGVzOiBEaXNhYmxlZCAoMHgw
MCk8YnI+DQomZ3Q7IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxlbg0KNMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQpbaGNpMF0gMzkuMDYyMDcxPGJy
Pg0KwqDCoMKgwqDCoCBMRSBTZXQgU2NhbiBFbmFibGUgKDB4MDh8MHgwMDBjKSBuY21kIDI8YnI+
DQrCoMKgwqDCoMKgwqDCoCBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApPGJyPg0KPGJyPg0KPC9zcGFu
PjxzcGFuIGxhbmc9IkVOLVVTIj48Zm9udCBzaXplPSI0Ij5AIERpc2NvdmVyaW5nOg0KMHgwMCAo
Nyk8L2ZvbnQ+PC9zcGFuPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOjExcHQi
Pjwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj48
YnI+DQomZ3Q7IEhDSSBFdmVudDogUmVtb3RlIEhvc3QgU3VwcG9ydGVkIEZlYXR1cmVzICgweDNk
KSBwbGVuDQoxNMKgwqDCoMKgIFtoY2kwXSAzOS41MzYyODQ8YnI+DQrCoMKgwqDCoMKgwqDCoCBB
ZGRyZXNzOiA5MDo3Rjo2MTowRjoyNDo0MSAoT1VJDQo5MC03Ri02MSk8YnI+DQrCoMKgwqDCoMKg
wqDCoCBGZWF0dXJlczogMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwDQoweDAwIDB4MDAgMHgwMDxi
cj4NCjwvc3Bhbj48c3BhbiBsYW5nPSJFTi1VUyI+PGZvbnQgc2l6ZT0iNCI+Jmd0OyBIQ0kgRXZl
bnQ6DQpSZW1vdGUgTmFtZSBSZXEgQ29tcGxldGUgKDB4MDcpIHBsZW4NCjI1NcKgwqDCoMKgwqDC
oMKgwqDCoCBbaGNpMF0gMzkuNjI4MTI0PGJyPg0KwqDCoMKgwqDCoMKgwqAgU3RhdHVzOiBTdWNj
ZXNzICgweDAwKTxicj4NCsKgwqDCoMKgwqDCoMKgIEFkZHJlc3M6IDkwOjdGOjYxOjBGOjI0OjQx
IChPVUkNCjkwLTdGLTYxKTxicj4NCsKgwqDCoMKgwqDCoMKgIE5hbWU6IFZHUC1CTVMyMTwvZm9u
dD48L3NwYW4+PHNwYW4gbGFuZz0iRU4tVVMiPjxicj4NCiZsdDsgSENJIENvbW1hbmQ6IExFIFNl
dCBSYW5kb20gQWRkcmVzcyAoMHgwOHwweDAwMDUpIHBsZW4NCjbCoMKgwqDCoMKgIFtoY2kwXSA0
NC43ODYyMzE8YnI+DQrCoMKgwqDCoMKgwqDCoCBBZGRyZXNzOiAyNDpBRjpFNzpCNToyRDowMA0K
KE5vbi1SZXNvbHZhYmxlKTxicj4NCiZndDsgSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRlICgw
eDBlKSBwbGVuDQo0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCltoY2kw
XSA0NC45NDYyMDY8YnI+DQrCoMKgwqDCoMKgIExFIFNldCBSYW5kb20gQWRkcmVzcyAoMHgwOHww
eDAwMDUpIG5jbWQgMTxicj4NCsKgwqDCoMKgwqDCoMKgIFN0YXR1czogU3VjY2VzcyAoMHgwMCk8
YnI+DQombHQ7IEhDSSBDb21tYW5kOiBMRSBTZXQgU2NhbiBQYXJhbWV0ZXJzICgweDA4fDB4MDAw
YikgcGxlbg0KN8KgwqDCoMKgIFtoY2kwXSA0NC45NDYyNzA8YnI+DQrCoMKgwqDCoMKgwqDCoCBU
eXBlOiBBY3RpdmUgKDB4MDEpPGJyPg0KwqDCoMKgwqDCoMKgwqAgSW50ZXJ2YWw6IDIyLjUwMCBt
c2VjICgweDAwMjQpPGJyPg0KwqDCoMKgwqDCoMKgwqAgV2luZG93OiAxMS4yNTAgbXNlYyAoMHgw
MDEyKTxicj4NCsKgwqDCoMKgwqDCoMKgIE93biBhZGRyZXNzIHR5cGU6IFJhbmRvbSAoMHgwMSk8
YnI+DQrCoMKgwqDCoMKgwqDCoCBGaWx0ZXIgcG9saWN5OiBBY2NlcHQgYWxsDQphZHZlcnRpc2Vt
ZW50ICgweDAwKTxicj4NCiZndDsgSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRlICgweDBlKSBw
bGVuDQo0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCltoY2kwXSA0NC45
NDcyMDE8YnI+DQrCoMKgwqDCoMKgIExFIFNldCBTY2FuIFBhcmFtZXRlcnMgKDB4MDh8MHgwMDBi
KSBuY21kIDE8YnI+DQrCoMKgwqDCoMKgwqDCoCBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApPGJyPg0K
Jmx0OyBIQ0kgQ29tbWFuZDogTEUgU2V0IFNjYW4gRW5hYmxlICgweDA4fDB4MDAwYykgcGxlbg0K
MsKgwqDCoMKgwqDCoMKgwqAgW2hjaTBdIDQ0Ljk0NzI5Njxicj4NCsKgwqDCoMKgwqDCoMKgIFNj
YW5uaW5nOiBFbmFibGVkICgweDAxKTxicj4NCsKgwqDCoMKgwqDCoMKgIEZpbHRlciBkdXBsaWNh
dGVzOiBFbmFibGVkICgweDAxKTxicj4NCiZndDsgSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRl
ICgweDBlKSBwbGVuDQo0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANClto
Y2kwXSA0NC45NDgyMDM8YnI+DQrCoMKgwqDCoMKgIExFIFNldCBTY2FuIEVuYWJsZSAoMHgwOHww
eDAwMGMpIG5jbWQgMjxicj4NCsKgwqDCoMKgwqDCoMKgIFN0YXR1czogU3VjY2VzcyAoMHgwMCk8
YnI+DQombHQ7IEhDSSBDb21tYW5kOiBJbnF1aXJ5ICgweDAxfDB4MDAwMSkgcGxlbg0KNcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQpbaGNpMF0gNDQuOTQ4MjY2PGJyPg0K
wqDCoMKgwqDCoMKgwqAgQWNjZXNzIGNvZGU6IDB4OWU4YjMzIChHZW5lcmFsDQpJbnF1aXJ5KTxi
cj4NCsKgwqDCoMKgwqDCoMKgIExlbmd0aDogMTAuMjRzICgweDA4KTxicj4NCsKgwqDCoMKgwqDC
oMKgIE51bSByZXNwb25zZXM6IDA8YnI+DQomZ3Q7IEhDSSBFdmVudDogQ29tbWFuZCBTdGF0dXMg
KDB4MGYpIHBsZW4NCjTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAN
CltoY2kwXSA0NC45NDkyMDc8YnI+DQrCoMKgwqDCoMKgIElucXVpcnkgKDB4MDF8MHgwMDAxKSBu
Y21kIDI8YnI+DQrCoMKgwqDCoMKgwqDCoCBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApPC9zcGFuPjwv
cD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPsKgPC9zcGFuPjwv
cD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPlJlZ2FyZHMsPC9z
cGFuPjwvcD4NCg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPkV0aGFu
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB0Ij48L3NwYW4+PC9zcGFuPjwvcD48L2Rpdj48L2Rp
dj4NCg==
--001a11c1d9aa946e250515d0c537--
