Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF932554E
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from pc.interlinx.bc.ca (pc.interlinx.bc.ca [IPv6:fd31:aeb1:48df:0:3b14:e643:83d8:7017])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id 9D0632F7D3
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 12:05:03 -0500 (EST)
Message-ID: <6139bf22f150476acf13a86dc130c5be5749cec1.camel@interlinx.bc.ca>
Subject: Re: chrome passkey communication timing out
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 22 Dec 2023 12:05:02 -0500
In-Reply-To: <CABBYNZJJgYJcswhLcR49H5AE-z7C74HeguwsvHq_BqWr8e3wtw@mail.gmail.com>
References: <6ce4dab33868db0a8c7b93bf58c20aa876d50f21.camel@interlinx.bc.ca>
	 <CABBYNZLbyCkg+heU5gNDooo2w7Uf+P1To0pVnrhS_z7Be3bTYw@mail.gmail.com>
	 <da55cd171a7055f3438447947f36723e9e539547.camel@interlinx.bc.ca>
	 <CABBYNZJJgYJcswhLcR49H5AE-z7C74HeguwsvHq_BqWr8e3wtw@mail.gmail.com>
Autocrypt: addr=brian@interlinx.bc.ca; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-0NRbMSmcp9/pfo7/rotb"
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-0NRbMSmcp9/pfo7/rotb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2023-12-21 at 10:27 -0500, Luiz Augusto von Dentz wrote:
> Hi Brian,

Hi Luiz,


> I think it doesn't support LE thus why it can't discover.

I got a new BT adapter.  btmon looks better, but still does not
complete and times out:

Bluetooth monitor ver 5.71
btmon[2006905]: =3D Note: Linux version 6.6.4-200.fc39.x86_64 (x86_64)     =
                                                                           =
   0.899623
btmon[2006905]: =3D Note: Bluetooth subsystem version 2.22                 =
                                                                           =
   0.899626
=3D New Index: 8C:88:2B:45:A0:8A (Primary,USB,hci0)                        =
                                                                       [hci=
0] 0.899627
=3D Open Index: 8C:88:2B:45:A0:8A                                          =
                                                                       [hci=
0] 0.899628
=3D Index Info: 8C:88:2B:45:A0:8A (Realtek Semiconductor Corporation)      =
                                                                       [hci=
0] 0.899628
bluetoothctl[2000095]: @ MGMT Open: bluetoothctl version 1.22              =
                                                                   {0x0002}=
 0.899629
bluetoothd[1033357]: @ MGMT Open: bluetoothd (privileged) version 1.22     =
                                                                   {0x0001}=
 0.899630
bluetoothd[1033357]: @ MGMT Command: Stop Discovery (0x0024) plen 1        =
                                                            {0x0001} [hci0]=
 4.618617
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0                         =
                                                                  #1 [hci0]=
 4.618650
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                  #2 [hci0]=
 4.715392
      Inquiry Cancel (0x01|0x0002) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                  #3 [hci0]=
 4.715514
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                  #4 [hci0]=
 4.716388
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                            {0x0001} [hci0]=
 4.716427
      Stop Discovery (0x0024) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                            {0x0001} [hci0]=
 4.716432
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
bluetoothd[1033357]: @ MGMT Command: Start Service Discovery (0x003a) plen =
4                                                           {0x0001} [hci0]=
 4.716731
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                                  #5 [hci0]=
 4.716756
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                  #6 [hci0]=
 4.717373
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                  #7 [hci0]=
 4.717403
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                  #8 [hci0]=
 4.718370
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                =
                                                                  #9 [hci0]=
 4.718401
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                 #10 [hci0]=
 4.719366
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                            {0x0001} [hci0]=
 4.719388
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                            {0x0001} [hci0]=
 4.719394
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
> HCI Event: Inquiry Complete (0x01) plen 1                                =
                                                                #11 [hci0] =
15.038405
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                           {0x0001} [hci0] =
15.067415
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                #12 [hci0] =
15.067466
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[1033357]: @ MGMT Command: Start Service Discovery (0x003a) plen =
4                                                          {0x0001} [hci0] =
15.068155
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #13 [hci0] =
15.068377
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                                #14 [hci0] =
15.068403
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #15 [hci0] =
15.069393
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                #16 [hci0] =
15.069426
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #17 [hci0] =
15.070419
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                =
                                                                #18 [hci0] =
15.070465
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                #19 [hci0] =
15.071383
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                           {0x0001} [hci0] =
15.071425
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                           {0x0001} [hci0] =
15.071552
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
> HCI Event: Inquiry Complete (0x01) plen 1                                =
                                                                #20 [hci0] =
25.388387
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                           {0x0001} [hci0] =
25.819382
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                #21 [hci0] =
25.819409
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[1033357]: @ MGMT Command: Start Service Discovery (0x003a) plen =
4                                                          {0x0001} [hci0] =
25.819549
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #22 [hci0] =
25.820386
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                                #23 [hci0] =
25.820435
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #24 [hci0] =
25.821400
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                #25 [hci0] =
25.821454
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #26 [hci0] =
25.822377
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                =
                                                                #27 [hci0] =
25.822397
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                #28 [hci0] =
25.823387
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                           {0x0001} [hci0] =
25.823448
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                           {0x0001} [hci0] =
25.823454
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
> HCI Event: Inquiry Result (0x02) plen 15                                 =
                                                                #29 [hci0] =
28.402386
        Num responses: 1
        Address: 64:A2:F9:1B:1A:C9 (OnePlus Technology (Shenzhen) Co., Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Page scan mode: Mandatory (0x00)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Clock offset: 0x00c8
@ MGMT Event: Device Found (0x0012) plen 19                                =
                                                           {0x0001} [hci0] =
28.402413
        BR/EDR Address: 64:A2:F9:1B:1A:C9 (OnePlus Technology (Shenzhen) Co=
., Ltd)
        RSSI: invalid (0x7f)
        Flags: 0x00000003
          Confirm Name
          Legacy Pairing
        Data length: 5
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
> HCI Event: Inquiry Complete (0x01) plen 1                                =
                                                                #30 [hci0] =
36.139386
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                           {0x0001} [hci0] =
36.571404
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                #31 [hci0] =
36.571427
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[1033357]: @ MGMT Command: Start Service Discovery (0x003a) plen =
4                                                          {0x0001} [hci0] =
36.571564
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #32 [hci0] =
36.572414
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                                #33 [hci0] =
36.572446
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #34 [hci0] =
36.573388
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                                #35 [hci0] =
36.573825
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                #36 [hci0] =
36.575399
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                =
                                                                #37 [hci0] =
36.575432
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                #38 [hci0] =
36.576386
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                           {0x0001} [hci0] =
36.576411
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                           {0x0001} [hci0] =
36.576417
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
> HCI Event: Inquiry Result (0x02) plen 15                                 =
                                                                #39 [hci0] =
38.867399
        Num responses: 1
        Address: 64:A2:F9:1B:1A:C9 (OnePlus Technology (Shenzhen) Co., Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Page scan mode: Mandatory (0x00)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Clock offset: 0x00c8
@ MGMT Event: Device Found (0x0012) plen 19                                =
                                                           {0x0001} [hci0] =
38.867459
        BR/EDR Address: 64:A2:F9:1B:1A:C9 (OnePlus Technology (Shenzhen) Co=
., Ltd)
        RSSI: invalid (0x7f)
        Flags: 0x00000003
          Confirm Name
          Legacy Pairing
        Data length: 5
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
bluetoothd[1033357]: < ACL Data TX: Handle 5 flags 0x00 dlen 7             =
                                                                #40 [hci0] =
41.530706
      Channel: 69 len 3 [PSM 0 mode Basic (0x00)] {chan 65535}
        a2 04 03                                         ...            =
=20
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                #41 [hci0] =
41.631433
        Num handles: 1
        Handle: 5
        Count: 1
bluetoothd[1033357]: < ACL Data TX: Handle 5 flags 0x00 dlen 7             =
                                                                #42 [hci0] =
41.824387
      Channel: 69 len 3 [PSM 0 mode Basic (0x00)] {chan 65535}
        a2 04 01                                         ...            =
=20
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                #43 [hci0] =
41.830391
        Num handles: 1
        Handle: 5
        Count: 1

Anything useful in that output?

Cheers,
b.


--=-0NRbMSmcp9/pfo7/rotb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8B/A+mOVz5cTNBuZ2sHQNBbLyKAFAmWFwb4ACgkQ2sHQNBbL
yKAdeQf/eKwsgIJ7SnebGHSDSCgI+MVDt6YDayKDo/UOjvleMRea3+D3oyw30ndA
xSyyy0P2rz4GCQirRs1NHjhOthvCdfrHa1ApTPqttNB+yk8gh9pK9CkLFD4UmVbM
wYZN3RuoPuqq78VQ1wQczDrEAx/xjGy6uoW5d5PfTAqFgZ+FOyBgdL81YX7JLl2Q
AeTxIbIsMg/6R2+E0Z9iE5nExwh48EsEUwys0vjvE5DVWUKhRu5RqmgH/R7Dinzx
yX89Qn5p00QC4sS2HN+PNzfmnNl8Ft/c+jf+GZNg7eU3aynz2YLkwkKvvNv/tViT
BfL3YD9mAymoCkDPVX1xCSAKDDCq9w==
=q2j2
-----END PGP SIGNATURE-----

--=-0NRbMSmcp9/pfo7/rotb--
