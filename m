Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Bharat Bhusan Panda' <bharat.panda@samsung.com>,
	cpgs@samsung.com,
	'Grzegorz Kolodziejczyk' <grzegorz.kolodziejczyk@tieto.com>
References: <001a01d08bda$91503ab0$b3f0b010$@samsung.com>
 <CABBYNZJ_SJowxX47YGWAvHa5D1a2SwDD5cE90UE6=fHLTwTsTQ@mail.gmail.com>
In-reply-to: <CABBYNZJ_SJowxX47YGWAvHa5D1a2SwDD5cE90UE6=fHLTwTsTQ@mail.gmail.com>
Subject: RE: Query regarding bneptest tool
Date: Mon, 11 May 2015 17:42:12 +0530
Message-id: <001b01d08be3$bcaa7870$35ff6950$@samsung.com>
MIME-version: 1.0
Content-type: multipart/mixed;
 boundary="----=_NextPart_000_001C_01D08C11.D66377C0"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multipart message in MIME format.

------=_NextPart_000_001C_01D08C11.D66377C0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, May 11, 2015 5:06 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Bharat Bhusan Panda;
> cpgs@samsung.com; Grzegorz Kolodziejczyk
> Subject: Re: Query regarding bneptest tool
>=20
> Hi Gowtham,
>=20
> On Mon, May 11, 2015 at 2:06 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi All,
> >
> > I am testing BlueZ bnep test tool (tools/bneptest) using PTS 6.1.0.
> > The BNEP client test cases are not passing in BT_IO_SEC_MEDIUM
> > security level.
> > My PTS PICS and PIXIT are same as android/pixit-bnep.txt,
> > android/pics-bnep.txt.
> > Whereas when the security level is BT_IO_SEC_LOW, it is passing.
> > If it is a valid fix, then I will send a patch for the same.
> > This is tested in Linux, not sure about android.
>=20
> It might be related to pairing then, do you have any agent registered =
in the
> system? Check the HCI logs with btmon, it should tell us what is =
happening.
>=20

I have attached both logs. Below is the procedure I followed.

--------------------------------------------------------------------
PTS output:
Test case : TC_CTRL_BV_02_C started
	- Received passkey: 564246, from: gowtham-ab-0
	- User canceled the current operation MMI.
	- MMI CM_EXIT
	- got an OTHERWISE
	- MTC: Test case ended
	 -Final Verdict: INCONC
TC_CTRL_BV_02_C finished
--------------------------------------------------------------------
BlueZ output:
/latest_bluez/bluez/test$  sudo ./bneptest -c 00:1B:DC:07:33:4E -b pan0 =
-n bnep0
bnep_client_connect
connecting 00:1B:DC:07:33:4E
cannot initiate bnep connection
connected_client_cb
^Cgot sig =3D 2, cleaning up...
cleanup successful - exit
--------------------------------------------------------------------
/latest_bluez/bluez/test$ ./simple-agent=20
Agent registered
Release
gowtham.ab@gowtham-ab:~/latest_bluez/bluez/test$ ./simple-agent=20
Agent registered
RequestConfirmation (/org/bluez/hci0/dev_00_1B_DC_07_33_4E, 564246)
Confirm passkey (yes/no): yes
Release
--------------------------------------------------------------------

After confirming the passkey, it becomes Authentication Failure and =
Remote User Terminated Connection
as captured in  btmon, hcidump logs.
What might be the problem?

> >
> > diff --git a/tools/bneptest.c b/tools/bneptest.c index
> > 98ee9b1..fccecd2 100644
> > --- a/tools/bneptest.c
> > +++ b/tools/bneptest.c
> > @@ -477,7 +477,7 @@ static int bnep_client_connect(void)
> >                                         BT_IO_OPT_SOURCE_BDADDR, =
&src_addr,
> >                                         BT_IO_OPT_DEST_BDADDR, =
&dst_addr,
> >                                         BT_IO_OPT_PSM, BNEP_PSM,
> > -                                       BT_IO_OPT_SEC_LEVEL,
> > BT_IO_SEC_MEDIUM,
> > +                                       BT_IO_OPT_SEC_LEVEL,
> > + BT_IO_SEC_LOW,
> >                                         BT_IO_OPT_OMTU, BNEP_MTU,
> >                                         BT_IO_OPT_IMTU, BNEP_MTU,
> >                                         BT_IO_OPT_INVALID);
> >
> >
> > Regards,
> > Gowtham Anandha Babu
> >
>=20
>=20
>=20
> --
> Luiz Augusto von Dentz
> --

Regards,
Gowtham Anandha Babu

> To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_001C_01D08C11.D66377C0
Content-Type: text/plain;
	name="btmon.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="btmon.txt"

Bluetooth monitor ver 5.30=0A=
=3D New Index: 00:1A:7D:DA:71:13 (BR/EDR,USB,hci0)                [hci0] =
0.818376=0A=
@ Device Removed: 00:1B:DC:07:33:4E (0)=0A=
@ Device Removed: 00:1A:7D:DA:71:13 (0)=0A=
@ Device Removed: 00:02:CA:C0:54:EF (0)=0A=
@ Device Removed: CC:C3:EA:FF:E2:5F (0)=0A=
< HCI Command: Write Extended Inquiry.. (0x03|0x0052) plen 241  [hci0] =
7.860053=0A=
        FEC: Not required (0x00)=0A=
        Name (complete): gowtham-ab-0=0A=
        TX power: 4 dBm=0A=
        Device ID: USB Implementer's Forum assigned (0x0002)=0A=
          Vendor: Linux Foundation (0x1d6b)=0A=
          Product: 0x0246=0A=
          Version: 5.1.14 (0x051e)=0A=
        16-bit Service UUIDs (complete): 2 entries=0A=
          Generic Access Profile (0x1800)=0A=
          Generic Attribute Profile (0x1801)=0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
7.863002=0A=
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1=0A=
        Status: Success (0x00)=0A=
< HCI Command: Write Extended Inquiry.. (0x03|0x0052) plen 241  [hci0] =
8.165743=0A=
        FEC: Not required (0x00)=0A=
        Name (complete): gowtham-ab-0=0A=
        TX power: 4 dBm=0A=
        Device ID: USB Implementer's Forum assigned (0x0002)=0A=
          Vendor: Linux Foundation (0x1d6b)=0A=
          Product: 0x0246=0A=
          Version: 5.1.14 (0x051e)=0A=
        16-bit Service UUIDs (complete): 3 entries=0A=
          Generic Access Profile (0x1800)=0A=
          Generic Attribute Profile (0x1801)=0A=
          A/V Remote Control (0x110e)=0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
8.168976=0A=
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1=0A=
        Status: Success (0x00)=0A=
< HCI Command: Write Extended Inquiry.. (0x03|0x0052) plen 241  [hci0] =
8.180847=0A=
        FEC: Not required (0x00)=0A=
        Name (complete): gowtham-ab-0=0A=
        TX power: 4 dBm=0A=
        Device ID: USB Implementer's Forum assigned (0x0002)=0A=
          Vendor: Linux Foundation (0x1d6b)=0A=
          Product: 0x0246=0A=
          Version: 5.1.14 (0x051e)=0A=
        16-bit Service UUIDs (complete): 4 entries=0A=
          Generic Access Profile (0x1800)=0A=
          Generic Attribute Profile (0x1801)=0A=
          A/V Remote Control (0x110e)=0A=
          A/V Remote Control Target (0x110c)=0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
8.183971=0A=
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1=0A=
        Status: Success (0x00)=0A=
@ Device Unblocked: 00:00:00:00:00:00 (0)=0A=
@ Device Added: CC:C3:EA:FF:E2:5F (0) 1=0A=
@ Device Added: 00:02:CA:C0:54:EF (0) 1=0A=
@ Device Added: 00:1A:7D:DA:71:13 (0) 1=0A=
@ Device Added: 00:1B:DC:07:33:4E (0) 1=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1           [hci0] =
8.203096=0A=
        Scan enable: Page Scan (0x02)=0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
8.203973=0A=
      Write Scan Enable (0x03|0x001a) ncmd 1=0A=
        Status: Success (0x00)=0A=
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32    [hci0] =
8.204000=0A=
        Length: 3=0A=
        TX power: 8 dBm=0A=
@ New Settings: 0x0ad1=0A=
            powered bondable ssp br/edr le secure-conn =0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
8.218973=0A=
      LE Set Advertising Data (0x08|0x0008) ncmd 1=0A=
        Status: Success (0x00)=0A=
@ New Settings: 0x0ad3=0A=
            powered connectable bondable ssp br/edr le secure-conn =0A=
< HCI Command: Write Current IAC LAP (0x03|0x003a) plen 4       [hci0] =
8.247932=0A=
        Number of IAC: 1=0A=
        Access code: 0x9e8b33 (General Inquiry)=0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
8.248995=0A=
      Write Current IAC LAP (0x03|0x003a) ncmd 1=0A=
        Status: Success (0x00)=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1           [hci0] =
8.249021=0A=
        Scan enable: Inquiry Scan + Page Scan (0x03)=0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
8.250973=0A=
      Write Scan Enable (0x03|0x001a) ncmd 1=0A=
        Status: Success (0x00)=0A=
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32    [hci0] =
8.251005=0A=
        Length: 6=0A=
        Flags: 0x02=0A=
          LE General Discoverable Mode=0A=
        TX power: 8 dBm=0A=
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] =
8.255980=0A=
      LE Set Advertising Data (0x08|0x0008) ncmd 1=0A=
        Status: Success (0x00)=0A=
@ New Settings: 0x0adb=0A=
            powered connectable discoverable bondable ssp br/edr le =
secure-conn =0A=
< HCI Command: Create Connection (0x01|0x0005) plen 13        [hci0] =
124.720498=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        Packet type: 0xcc18=0A=
          DM1 may be used=0A=
          DH1 may be used=0A=
          DM3 may be used=0A=
          DH3 may be used=0A=
          DM5 may be used=0A=
          DH5 may be used=0A=
        Page scan repetition mode: R2 (0x02)=0A=
        Page scan mode: Mandatory (0x00)=0A=
        Clock offset: 0x0000=0A=
        Role switch: Allow slave (0x01)=0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
124.734081=0A=
      Create Connection (0x01|0x0005) ncmd 1=0A=
        Status: Success (0x00)=0A=
> HCI Event: Connect Complete (0x03) plen 11                  [hci0] =
127.725098=0A=
        Status: Success (0x00)=0A=
        Handle: 70=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        Link type: ACL (0x01)=0A=
        Encryption: Disabled (0x00)=0A=
< HCI Command: Read Remote Supported... (0x01|0x001b) plen 2  [hci0] =
127.725227=0A=
        Handle: 70=0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
127.730074=0A=
      Read Remote Supported Features (0x01|0x001b) ncmd 0=0A=
        Status: Success (0x00)=0A=
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7   [hci0] =
127.735080=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        Page scan repetition mode: R1 (0x01)=0A=
> HCI Event: Max Slots Change (0x1b) plen 3                   [hci0] =
127.738110=0A=
        Handle: 70=0A=
        Max slots: 5=0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
127.751101=0A=
      NOP (0x00|0x0000) ncmd 1=0A=
        Status: Success (0x00)=0A=
> HCI Event: Read Remote Supported Features (0x0b) plen 11    [hci0] =
127.758124=0A=
        Status: Success (0x00)=0A=
        Handle: 70=0A=
        Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87=0A=
          3 slot packets=0A=
          5 slot packets=0A=
          Encryption=0A=
          Slot offset=0A=
          Timing accuracy=0A=
          Role switch=0A=
          Hold mode=0A=
          Sniff mode=0A=
          Park state=0A=
          Power control requests=0A=
          Channel quality driven data rate (CQDDR)=0A=
          SCO link=0A=
          HV2 packets=0A=
          HV3 packets=0A=
          u-law log synchronous data=0A=
          A-law log synchronous data=0A=
          CVSD synchronous data=0A=
          Paging parameter negotiation=0A=
          Power control=0A=
          Transparent synchronous data=0A=
          Broadcast Encryption=0A=
          Enhanced Data Rate ACL 2 Mbps mode=0A=
          Enhanced Data Rate ACL 3 Mbps mode=0A=
          Enhanced inquiry scan=0A=
          Interlaced inquiry scan=0A=
          Interlaced page scan=0A=
          RSSI with inquiry results=0A=
          AFH capable slave=0A=
          AFH classification slave=0A=
          LE Supported (Controller)=0A=
          3-slot Enhanced Data Rate ACL packets=0A=
          5-slot Enhanced Data Rate ACL packets=0A=
          Sniff subrating=0A=
          Pause encryption=0A=
          AFH capable master=0A=
          AFH classification master=0A=
          Extended Inquiry Response=0A=
          Simultaneous LE and BR/EDR (Controller)=0A=
          Secure Simple Pairing=0A=
          Encapsulated PDU=0A=
          Non-flushable Packet Boundary Flag=0A=
          Link Supervision Timeout Changed Event=0A=
          Inquiry TX Power Level=0A=
          Enhanced Power Control=0A=
          Extended features=0A=
< HCI Command: Read Remote Extended F.. (0x01|0x001c) plen 3  [hci0] =
127.758157=0A=
        Handle: 70=0A=
        Page: 1=0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
127.763096=0A=
      Read Remote Extended Features (0x01|0x001c) ncmd 1=0A=
        Status: Success (0x00)=0A=
> HCI Event: Read Remote Extended Features (0x23) plen 13     [hci0] =
127.770079=0A=
        Status: Success (0x00)=0A=
        Handle: 70=0A=
        Page: 1/1=0A=
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00=0A=
          Secure Simple Pairing (Host Support)=0A=
< HCI Command: Remote Name Request (0x01|0x0019) plen 10      [hci0] =
127.770117=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        Page scan repetition mode: R2 (0x02)=0A=
        Page scan mode: Mandatory (0x00)=0A=
        Clock offset: 0x0000=0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
127.776084=0A=
      Remote Name Request (0x01|0x0019) ncmd 1=0A=
        Status: Success (0x00)=0A=
> HCI Event: Remote Name Req Complete (0x07) plen 255         [hci0] =
127.806077=0A=
        Status: Success (0x00)=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        Name: PTS-BNEP-GOWTHAM-AB=0A=
< HCI Command: Authentication Requested (0x01|0x0011) plen 2  [hci0] =
127.806149=0A=
        Handle: 70=0A=
@ Device Connected: 00:1B:DC:07:33:4E (0) flags 0x0000=0A=
        14 09 50 54 53 2d 42 4e 45 50 2d 47 4f 57 54 48  ..PTS-BNEP-GOWTH=0A=
        41 4d 2d 41 42                                   AM-AB           =0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
127.808035=0A=
      Authentication Requested (0x01|0x0011) ncmd 1=0A=
        Status: Success (0x00)=0A=
> HCI Event: Link Key Request (0x17) plen 6                   [hci0] =
127.809039=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
< HCI Command: Link Key Request Negat.. (0x01|0x000c) plen 6  [hci0] =
127.809070=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
> HCI Event: Command Complete (0x0e) plen 10                  [hci0] =
127.815041=0A=
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1=0A=
        Status: Success (0x00)=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
> HCI Event: IO Capability Request (0x31) plen 6              [hci0] =
127.816039=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
< HCI Command: IO Capability Request... (0x01|0x002b) plen 9  [hci0] =
127.816068=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        IO capability: DisplayYesNo (0x01)=0A=
        OOB data: Authentication data not present (0x00)=0A=
        Authentication: General Bonding - MITM required (0x05)=0A=
> HCI Event: Command Complete (0x0e) plen 10                  [hci0] =
127.820040=0A=
      IO Capability Request Reply (0x01|0x002b) ncmd 1=0A=
        Status: Success (0x00)=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
> HCI Event: IO Capability Response (0x32) plen 9             [hci0] =
127.842137=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        IO capability: DisplayYesNo (0x01)=0A=
        OOB data: Authentication data not present (0x00)=0A=
        Authentication: General Bonding - MITM not required (0x04)=0A=
> HCI Event: User Confirmation Request (0x33) plen 10         [hci0] =
128.242120=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
        Passkey: 564246=0A=
@ User Confirmation Request: 00:1B:DC:07:33:4E (0) hint 0 value 564246=0A=
> HCI Event: Simple Pairing Complete (0x36) plen 7            [hci0] =
158.243129=0A=
        Status: Authentication Failure (0x05)=0A=
        Address: 00:1B:DC:07:33:4E (Vencer Co., Ltd.)=0A=
> HCI Event: Auth Complete (0x06) plen 3                      [hci0] =
158.244139=0A=
        Status: Authentication Failure (0x05)=0A=
        Handle: 70=0A=
@ Authentication Failed: 00:1B:DC:07:33:4E (0) status 0x05=0A=
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2         [hci0] =
158.270357=0A=
        Handle: 70=0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
158.272106=0A=
      Read Clock Offset (0x01|0x001f) ncmd 1=0A=
        Status: Success (0x00)=0A=
< HCI Command: Disconnect (0x01|0x0006) plen 3                [hci0] =
158.272142=0A=
        Handle: 70=0A=
        Reason: Remote User Terminated Connection (0x13)=0A=
> HCI Event: Read Clock Offset Complete (0x1c) plen 5         [hci0] =
158.277091=0A=
        Status: Success (0x00)=0A=
        Handle: 70=0A=
        Clock offset: 0x1f88=0A=
> HCI Event: Command Status (0x0f) plen 4                     [hci0] =
158.278089=0A=
      Disconnect (0x01|0x0006) ncmd 1=0A=
        Status: Success (0x00)=0A=
> HCI Event: Disconnect Complete (0x05) plen 4                [hci0] =
158.356112=0A=
        Status: Success (0x00)=0A=
        Handle: 70=0A=
        Reason: Connection Terminated By Local Host (0x16)=0A=
@ Device Disconnected: 00:1B:DC:07:33:4E (0) reason 2=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1         [hci0] =
174.927620=0A=
        Scan enable: No Scans (0x00)=0A=
> HCI Event: Command Complete (0x0e) plen 4                   [hci0] =
174.929118=0A=
      Write Scan Enable (0x03|0x001a) ncmd 1=0A=
        Status: Success (0x00)=0A=
@ Class of Device Changed: 0x000000=0A=
@ New Settings: 0x0ada=0A=
            connectable discoverable bondable ssp br/edr le secure-conn =0A=

------=_NextPart_000_001C_01D08C11.D66377C0
Content-Type: text/plain;
	name="hcidump.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hcidump.txt"

HCI sniffer - Bluetooth packet analyzer ver 5.30=0A=
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff=0A=
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241=0A=
    fec 0x00=0A=
    Complete local name: 'gowtham-ab-0'=0A=
    TX power level: 4=0A=
    Unknown type 0x10 with 8 bytes data=0A=
    Complete service classes: 0x1800 0x1801=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Extended Inquiry Response (0x03|0x0052) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241=0A=
    fec 0x00=0A=
    Complete local name: 'gowtham-ab-0'=0A=
    TX power level: 4=0A=
    Unknown type 0x10 with 8 bytes data=0A=
    Complete service classes: 0x1800 0x1801 0x110e=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Extended Inquiry Response (0x03|0x0052) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241=0A=
    fec 0x00=0A=
    Complete local name: 'gowtham-ab-0'=0A=
    TX power level: 4=0A=
    Unknown type 0x10 with 8 bytes data=0A=
    Complete service classes: 0x1800 0x1801 0x110e 0x110c=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Extended Inquiry Response (0x03|0x0052) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1=0A=
    enable 2=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Scan Enable (0x03|0x001a) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    LE Set Advertising Data (0x08|0x0008) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Current IAC LAP (0x03|0x003a) plen 4=0A=
    IAC 0x9e8b33 (General Inquiry Access Code)=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Current IAC LAP (0x03|0x003a) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1=0A=
    enable 3=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Scan Enable (0x03|0x001a) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    LE Set Advertising Data (0x08|0x0008) ncmd 1=0A=
    status 0x00=0A=
< HCI Command: Create Connection (0x01|0x0005) plen 13=0A=
    bdaddr 00:1B:DC:07:33:4E ptype 0xcc18 rswitch 0x01 clkoffset 0x0000=0A=
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 =0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Create Connection (0x01|0x0005) status 0x00 ncmd 1=0A=
> HCI Event: Connect Complete (0x03) plen 11=0A=
    status 0x00 handle 70 bdaddr 00:1B:DC:07:33:4E type ACL encrypt 0x00=0A=
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2=0A=
    handle 70=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0=0A=
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7=0A=
    bdaddr 00:1B:DC:07:33:4E mode 1=0A=
> HCI Event: Max Slots Change (0x1b) plen 3=0A=
    handle 70 slots 5=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Unknown (0x00|0x0000) status 0x00 ncmd 1=0A=
> HCI Event: Read Remote Supported Features (0x0b) plen 11=0A=
    status 0x00 handle 70=0A=
    Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87=0A=
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3=0A=
    handle 70 page 1=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1=0A=
> HCI Event: Read Remote Extended Features (0x23) plen 13=0A=
    status 0x00 handle 70 page 1 max 1=0A=
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00=0A=
< HCI Command: Remote Name Request (0x01|0x0019) plen 10=0A=
    bdaddr 00:1B:DC:07:33:4E mode 2 clkoffset 0x0000=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1=0A=
> HCI Event: Remote Name Req Complete (0x07) plen 255=0A=
    status 0x00 bdaddr 00:1B:DC:07:33:4E name 'PTS-BNEP-GOWTHAM-AB'=0A=
< HCI Command: Authentication Requested (0x01|0x0011) plen 2=0A=
    handle 70=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1=0A=
> HCI Event: Link Key Request (0x17) plen 6=0A=
    bdaddr 00:1B:DC:07:33:4E=0A=
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6=0A=
    bdaddr 00:1B:DC:07:33:4E=0A=
> HCI Event: Command Complete (0x0e) plen 10=0A=
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1=0A=
    status 0x00 bdaddr 00:1B:DC:07:33:4E=0A=
> HCI Event: IO Capability Request (0x31) plen 6=0A=
    bdaddr 00:1B:DC:07:33:4E=0A=
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9=0A=
    bdaddr 00:1B:DC:07:33:4E capability 0x01 oob 0x00 auth 0x05=0A=
    Capability: DisplayYesNo (OOB data not present)=0A=
    Authentication: General Bonding (MITM Protection)=0A=
> HCI Event: Command Complete (0x0e) plen 10=0A=
    IO Capability Request Reply (0x01|0x002b) ncmd 1=0A=
    status 0x00 bdaddr 00:1B:DC:07:33:4E=0A=
> HCI Event: IO Capability Response (0x32) plen 9=0A=
    bdaddr 00:1B:DC:07:33:4E capability 0x01 oob 0x00 auth 0x04=0A=
    Capability: DisplayYesNo (OOB data not present)=0A=
    Authentication: General Bonding (No MITM Protection)=0A=
> HCI Event: User Confirmation Request (0x33) plen 10=0A=
    bdaddr 00:1B:DC:07:33:4E passkey 564246=0A=
> HCI Event: Simple Pairing Complete (0x36) plen 7=0A=
    status 0x05 bdaddr 00:1B:DC:07:33:4E=0A=
    Error: Authentication Failure=0A=
> HCI Event: Auth Complete (0x06) plen 3=0A=
    status 0x05 handle 70=0A=
    Error: Authentication Failure=0A=
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2=0A=
    handle 70=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Read Clock Offset (0x01|0x001f) status 0x00 ncmd 1=0A=
< HCI Command: Disconnect (0x01|0x0006) plen 3=0A=
    handle 70 reason 0x13=0A=
    Reason: Remote User Terminated Connection=0A=
> HCI Event: Read Clock Offset Complete (0x1c) plen 5=0A=
    status 0x00 handle 70 clkoffset 0x1f88=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Disconnect (0x01|0x0006) status 0x00 ncmd 1=0A=
> HCI Event: Disconn Complete (0x05) plen 4=0A=
    status 0x00 handle 70 reason 0x16=0A=
    Reason: Connection Terminated by Local Host=0A=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1=0A=
    enable 0=0A=
> HCI Event: Command Complete (0x0e) plen 4=0A=
    Write Scan Enable (0x03|0x001a) ncmd 1=0A=
    status 0x00=0A=

------=_NextPart_000_001C_01D08C11.D66377C0--

