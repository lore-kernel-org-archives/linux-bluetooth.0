Return-Path: <cyrus@holtmann.org>
From: "Ge, Ethan" <ethan.ge@intel.com>
To: "Ge, Ethan" <ethan.ge@intel.com>, Marcel Holtmann <marcel@holtmann.org>,
	"jpawlowski@google.com" <jpawlowski@google.com>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "armansito@chromium.org" <armansito@chromium.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Can't update remote name in function of
 "hci_check_pending_name" because of discov->state == DISCOVERY_STOPPED
Date: Mon, 11 May 2015 16:47:48 +0000
Message-ID: <86D221DC0B85F94D9B05B97827669A3403C48389@PGSMSX106.gar.corp.intel.com>
References: <86D221DC0B85F94D9B05B97827669A3403C4835E@PGSMSX106.gar.corp.intel.com>
In-Reply-To: <86D221DC0B85F94D9B05B97827669A3403C4835E@PGSMSX106.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Add Arman

Hi,

We found this issue in Chromebook with kernel 3.14. From btmon, Stack recei=
ved event of Remote Name Req Complete with Device name "Name: VGP-BMS21", b=
ut it's after @ Discovering: 0x00 (7). It means le_scan_disable_work_comple=
te set discover status to STOPPED for starting new discovery which caused h=
ci_check_pending_name return without update the name information because di=
scovery status is STOPPED. Then user space will always get null name, even =
hci_remote_name_evt shows everything is correct at HCI layer.

Is it possible setting LE Set Scan Enable to disable after Remote Name Req =
Complete? Or adding condition for hci_discovery_set_state(hdev, DISCOVERY_S=
TOPPED) in function of le_scan_disable_work_complete?

static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,

                                                       u16 opcode)

{
           /* General inquiry access code (GIAC) */

  .....
.......

           case DISCOV_TYPE_INTERLEAVED:

                     hci_dev_lock(hdev);

=20

                     if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,

                                     &hdev->quirks)) {

                                /* If we were running LE only scan, change =
discovery

                                * state. If we were running both LE and BR/=
EDR inquiry

                                * simultaneously, and BR/EDR inquiry is alr=
eady

                                * finished, stop discovery, otherwise BR/ED=
R inquiry

                                * will stop discovery when finished.

                                */

                                if (!test_bit(HCI_INQUIRY, &hdev->flags))

                                           hci_discovery_set_state(hdev,   =
                                  /* <-------------   Here set set discover=
 status to STOPPED */

                                                                           =
DISCOVERY_STOPPED);


static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *c=
onn,
                   bdaddr_t *bdaddr, u8 *name, u8 name_len) {
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

    if (discov->state =3D=3D DISCOVERY_STOPPED)                            =
                       /* <-------------   Return due to  (discov->state =
=3D=3D DISCOVERY_STOPPED) */
        return;


btmon:

@ Discovering: 0x01 (7) =20

...
....       =20
> HCI Event: Inquiry Complete (0x01) plen 1                    [hci0] 39.02=
7238
        Status: Success (0x00)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 39.02=
7342
        Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)
        Page scan repetition mode: R1 (0x01)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x7774
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 39.02=
8072
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0] 39.06=
0051
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 39.06=
2071
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)

@ Discovering: 0x00 (7)


> HCI Event: Remote Host Supported Features (0x3d) plen 14     [hci0] 39.53=
6284
        Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 39.62=
8124
        Status: Success (0x00)
        Address: 90:7F:61:0F:24:41 (OUI 90-7F-61)
        Name: VGP-BMS21
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0] 44.78=
6231
        Address: 24:AF:E7:B5:2D:00 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 44.94=
6206
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0] 44.94=
6270
        Type: Active (0x01)
        Interval: 22.500 msec (0x0024)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 44.94=
7201
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0] 44.94=
7296
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 44.94=
8203
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                    [hci0] 44.94=
8266
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 44.94=
9207
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)


Regards,
Ethan
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in the body of a message to majordomo@vger.kernel.org More majordomo info a=
t  http://vger.kernel.org/majordomo-info.html
