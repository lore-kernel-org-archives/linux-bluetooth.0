Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <768ccca40606121319y38801e69h40c9d1a4ecd4aa95@mail.gmail.com>
Date: Mon, 12 Jun 2006 22:19:56 +0200
From: "Eduardo Margallo" <eduardo.margallo@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4483B5E4.7000305@xmission.com>
MIME-Version: 1.0
References: <768ccca40606041514m77eea4cer437d3ea227d3eec8@mail.gmail.com>
	<4483B5E4.7000305@xmission.com>
Subject: Re: [Bluez-devel] Broadcom adapter
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,

well, in fact using the Broadcom Adapter under Windows with
BlueSoleil, I get a perfect audio connection. After pairing, I just
have to press the top button on my Jabra Headset and voil=E0. I have
attached the HCI communication (monitoring usb traffic and decoding
the packages in python) between both devices.

This sequence started when I pressed the connect button with both
devices paired. I stopped it after SCO traffic was going on. If you
need a different connection sequence, I can provide it. It is not a
lot of work now.

Cheers,

Eduardo

------------------------------------------------
UP EVT: Connection Request Event Data =3D D3 73 7C 17 13 00 0C 04 20 01
        BD_ADDR 0x13177C73D3 Class_of_Device 0x20040C Link_Type 0x1
DOWN CMD: Accept Connection Request Command Data =3D 07 D3 73 7C 17 13 00 00
        BD_ADDR 0x13177C73D3 Role 0x0 Remaining Data:  [0]
UP EVT: Command Status Event Data =3D 00 01 09 04
        Status 0x0 Num_HCI_Command_Packets 0x1 Command_Opcode 0x409
UP CMD: Accept Connection Request Command Data =3D 07 D3 73 7C 17 13 00
00 20 00 00 00 00 00 0A 00
        BD_ADDR 0x13177C73D3 Role 0x0 Remaining Data:  [0, 32, 0, 0,
0, 0, 0, 10, 0]
UP EVT: Role Change Event Data =3D 00 D3 73 7C 17 13 00 00
        Status 0x0 BD_ADDR 0x13177C73D3 New_Role 0x0
UP EVT: Link Key Request Event Data =3D D3 73 7C 17 13 00
        BD_ADDR 0x13177C73D3
DOWN CMD: Link Key Request Reply Command Data =3D 16 D3 73 7C 17 13 00
13 80 BA 19 E9 DC B3 A0 E5 8D A3 63 91 A1 BB E9
        BD_ADDR 0x13177C73D3 Link_Key 0xE9BBA19163A38DE5A0B3DCE919BA8013
UP CMD: Link Key Request Reply Command Data =3D 16 D3 73 7C 17 13 00 13
80 BA 19 E9 DC B3 A0 E5 8D A3 63 91 A1 BB E9 20 00 00 00 00 00 19 00
        BD_ADDR 0x13177C73D3 Link_Key
0xE9BBA19163A38DE5A0B3DCE919BA8013 Remaining Data:  [32, 0, 0, 0, 0,
0, 25, 0]
UP EVT: Command Complete Event Data =3D 01 0B 04 00 D3 73 7C 17 13 00
        Num_HCI_Command_Packets 0x1 Command_Opcode 0x0 Remaining Data:
 [1, 11, 4, 0, 211, 115, 124, 23, 19, 0]
UP EVT: Connection Complete Event Data =3D 00 07 00 D3 73 7C 17 13 00 01 01
        Status 0x0 Connection_Handle 0x7 BD_ADDR 0x13177C73D3
Link_Type 0x1 Encryption_Mode 0x1
DOWN CMD: Write Link Policy Settings Command Data =3D 04 07 00 07 00
        Remaining Data:  [7, 0, 7, 0]
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 01 00 02 01 04 00 01 00 61 00
        L2CAP len=3D8 ch=3D1 Command=3DConnection request PSM 0x1 Src ID 0x=
61
UP CMD: Write Link Policy Settings Command Data =3D 04 07 00 07 00 20 00
00 00 00 00 07 00
        Remaining Data:  [7, 0, 7, 0, 32, 0, 0, 0, 0, 0, 7, 0]
UP EVT: Command Complete Event Data =3D 01 0D 08 00 07 00
        Num_HCI_Command_Packets 0x1 Command_Opcode 0x0 Remaining Data:
 [1, 13, 8, 0, 7, 0]
UP ACL: conn=3D7 flags=3D 2 Data =3D  0c 00 01 00 03 01 08 00 42 00 61 00 0=
0 00 00 00
        L2CAP len=3D12 ch=3D1 Command=3DConnection response Dest ID 0x42 Src
ID 0x61 Result 0x0 Status 0x0
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 01 00 04 04 04 00 61 00 00 00
        L2CAP len=3D8 ch=3D1 Command=3DConfigure request Dest ID 0x61 Flags=
 0x0
DOWN CMD: Write Link Supervision Timeout Command Data =3D 04 07 00 00 7D
        Remaining Data:  [7, 0, 0, 125]
UP EVT: Command Complete Event Data =3D 01 37 0C 00 07 00
        Num_HCI_Command_Packets 0x1 Command_Opcode 0x0 Remaining Data:
 [1, 55, 12, 0, 7, 0]
UP CMD: Write Link Supervision Timeout Command Data =3D 04 07 00 00 7D
20 00 00 00 00 00 07 00
        Remaining Data:  [7, 0, 0, 125, 32, 0, 0, 0, 0, 0, 7, 0]
DOWN CMD: Read Clock Offset Command Data =3D 02 07 00
        Remaining Data:  [7, 0]
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 02 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x2
UP EVT: Command Status Event Data =3D 00 01 1F 04
        Status 0x0 Num_HCI_Command_Packets 0x1 Command_Opcode 0x41F
UP ACL: conn=3D7 flags=3D 2 Data =3D  0c 00 01 00
UP CMD: Read Clock Offset Command Data =3D 02 07 00 20 00 00 00 00 00 05 00
        Remaining Data:  [7, 0, 32, 0, 0, 0, 0, 0, 5, 0]
UP ACL: conn=3D7 flags=3D 1 Data =3D  04 02 08 00 42 00 00 00 01 02 30 00
UP ACL: conn=3D7 flags=3D 2 Data =3D  0a 00 01 00 05 02 06 00 61 00 00 00 0=
0 00
        L2CAP len=3D10 ch=3D1 Command=3DConfigure response Reason 0x61 Data
0x0 Remaining Data:  [0, 0]
UP ACL: conn=3D7 flags=3D 2 Data =3D  0a 00 01 00 05 04 06 00 42 00 00 00 0=
0 00
        L2CAP len=3D10 ch=3D1 Command=3DConfigure response Reason 0x42 Data
0x0 Remaining Data:  [0, 0]
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP EVT: Read Clock Offset Complete Event Data =3D 00 07 00 FE 0B
        Status 0x0 Connection_Handle 0x7 Clock_Offset 0xBFE
UP ACL: conn=3D7 flags=3D 2 Data =3D  0f 00 42 00
UP ACL: conn=3D7 flags=3D 1 Data =3D  02 00 01 00 0a 35 05 1a 00 00 11 12 0=
0 28 00
UP ACL: conn=3D7 flags=3D 2 Data =3D  0e 00 61 00 03 00 01 00 09 00 01 00 01
00 01 00 13 00
        L2CAP len=3D2 ch=3D1 Command=3DInformation request Info Type 0x0
Remaining Data:  [17, 18, 0, 40, 0, 14, 0, 97, 0, 3, 0, 1, 0, 9, 0, 1,
0, 1, 0, 1, 0, 19, 0]
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP ACL: conn=3D7 flags=3D 2 Data =3D  11 00 42 00 04 00 02 00 0c 00 01 00 13
00 26 35 03 09 00 04 00
UP ACL: conn=3D7 flags=3D 2 Data =3D  1b 00 61 00 05 00 02 00 16 00 13 35 11
09 00 04 35 0c 35 03 19 01 00 35 05 19 00 03 08 07 00
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 01 00 02 03 04 00 03 00 62 00
        L2CAP len=3D8 ch=3D1 Command=3DConnection request PSM 0x3 Src ID 0x=
62
UP ACL: conn=3D7 flags=3D 2 Data =3D  0c 00 01 00 03 03 08 00 43 00 62 00 0=
0 00 00 00
        L2CAP len=3D12 ch=3D1 Command=3DConnection response Dest ID 0x43 Src
ID 0x62 Result 0x0 Status 0x0
UP ACL: conn=3D7 flags=3D 2 Data =3D  0c 00 01 00 04 05 08 00 62 00 00 00 0=
1 02 ae 06
        L2CAP len=3D12 ch=3D1 Command=3DConfigure request Dest ID 0x62 Flags
0x0 Remaining Data:  [1, 2, 174, 6]
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 02 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x2
UP ACL: conn=3D7 flags=3D 2 Data =3D  0c 00 01 00 04 04 08 00 43 00 00 00 0=
1 02 84 00
        L2CAP len=3D12 ch=3D1 Command=3DConfigure request Dest ID 0x43 Flags
0x0 Remaining Data:  [1, 2, 132, 0]
UP ACL: conn=3D7 flags=3D 2 Data =3D  0a 00 01 00 05 04 06 00 62 00 00 00 0=
0 00
        L2CAP len=3D10 ch=3D1 Command=3DConfigure response Reason 0x62 Data
0x0 Remaining Data:  [0, 0]
UP ACL: conn=3D7 flags=3D 2 Data =3D  0e 00 01 00 05 05 0a 00 43 00 00 00 00
00 01 02 84 00
        L2CAP len=3D14 ch=3D1 Command=3DConfigure response Reason 0x43 Data
0x0 Remaining Data:  [0, 0, 1, 2, 132, 0]
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP ACL: conn=3D7 flags=3D 2 Data =3D  04 00 43 00 03 3f 01 1c
UP ACL: conn=3D7 flags=3D 2 Data =3D  04 00 62 00 03 73 01 d7
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP ACL: conn=3D7 flags=3D 2 Data =3D  0e 00 43 00 03 ef 15 83 11 0e f0 00 00
7e 00 00 00 70
UP ACL: conn=3D7 flags=3D 2 Data =3D  0e 00 62 00 01 ef 15 81 11 0e e0 00 00
7e 00 00 07 aa
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP ACL: conn=3D7 flags=3D 2 Data =3D  04 00 43 00 3b 3f 01 06
UP ACL: conn=3D7 flags=3D 2 Data =3D  04 00 62 00 3b 73 01 cd
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 62 00 01 ef 09 e3 05 3b 8d aa
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 02 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x2
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 43 00 03 ef 09 e1 05 3b 8d 70
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 43 00 03 ef 09 e3 05 3b 0d 70
UP ACL: conn=3D7 flags=3D 2 Data =3D  05 00 43 00 3b ff 01 0f b9
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 62 00 01 ef 09 e1 05 3b 0d aa
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 01 00 06 05 04 00 42 00 61 00
        L2CAP len=3D8 ch=3D1 Command=3DDisconnection request Src ID 0x42
Flags 0x61 Result 0x0 Config 0x0
UP ACL: conn=3D7 flags=3D 2 Data =3D  08 00 01 00 07 05 04 00 42 00 61 00
        L2CAP len=3D8 ch=3D1 Command=3DDisconnection response Dest ID 0x42
Src ID 0x61 Result 0x0 Status 0x0
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP ACL: conn=3D7 flags=3D 2 Data =3D  10 00 43 00 3b ef 19 41 54 2b 43 4b 50
44 3d 32 30 30 0d a5
UP ACL: conn=3D7 flags=3D 2 Data =3D  0a 00 62 00 39 ef 0d 0d 0a 4f 4b 0d 0=
a 7f
DOWN CMD: Add SCO Connection Command Data =3D 04 07 00 E0 00
        Connection_Handle 0x7 Packet_Type 0xE0
UP CMD: Add SCO Connection Command Data =3D 04 07 00 E0 00 20 00 00 00 00 0=
0 07 00
        Connection_Handle 0x7 Packet_Type 0xE0 Remaining Data:  [32,
0, 0, 0, 0, 0, 7, 0]
UP EVT: Command Status Event Data =3D 00 01 07 04
        Status 0x0 Num_HCI_Command_Packets 0x1 Command_Opcode 0x407
UP EVT: Number Of Completed Packets Event Data =3D 01 07 00 01 00
        Number_of_Handles 0x1 Connection_Handle[0] 0x7
HC_Num_Of_Completed_Packets[0] 0x1
UP EVT: Connection Complete Event Data =3D 00 01 00 D3 73 7C 17 13 00 00 01
        Status 0x0 Connection_Handle 0x1 BD_ADDR 0x13177C73D3
Link_Type 0x0 Encryption_Mode 0x1
DOWN SCO:  00 00 00 00 00 00 00 00 40 9d 55 80 40 9d 55 80 ...
DOWN SCO:  00 00 00 00 00 00 00 00 40 94 55 80 00 e1 3f 84 ...
UP SCO:  08 00 08 00 20 00 20 00 18 00 20 00 18 00 30 00 ...
DOWN SCO:  08 00 08 00 20 00 20 00 18 00 20 00 18 00 30 00 ...
UP SCO:  00 00 00 30 00 50 00 38 00 38 00 38 00 38 00 30 ...
DOWN SCO:  00 00 00 30 00 50 00 38 00 38 00 38 00 38 00 30 ...
UP SCO:  00 18 00 30 00 48 00 40 00 20 00 40 00 40 00 20 ...
DOWN SCO:  00 18 00 30 00 48 00 40 00 20 00 40 00 40 00 20 ...
UP SCO:  00 10 00 30 00 40 00 38 00 18 00 30 00 30 00 28 ...
DOWN SCO:  00 10 00 30 00 40 00 38 00 18 00 30 00 30 00 28 ...
UP SCO:  00 18 00 38 00 48 00 48 00 38 00 38 00 30 00 20 ...
DOWN SCO:  00 18 00 38 00 48 00 48 00 38 00 38 00 30 00 20 ...
UP SCO:  00 18 00 40 00 60 00 30 00 10 00 48 00 38 00 20 ...
DOWN SCO:  00 18 00 40 00 60 00 30 00 10 00 48 00 38 00 20 ...
UP SCO:  00 10 00 30 00 38 00 40 00 38 00 30 00 30 00 20 ...
DOWN SCO:  00 10 00 30 00 38 00 40 00 38 00 30 00 30 00 20 ...
UP SCO:  00 10 00 28 00 30 00 40 00 38 00 30 00 30 00 28 ...
DOWN SCO:  00 10 00 28 00 30 00 40 00 38 00 30 00 30 00 28 ...
UP SCO:  00 10 00 38 00 48 00 38 00 28 00 38 00 30 00 20 ...
DOWN SCO:  00 10 00 38 00 48 00 38 00 28 00 38 00 30 00 20 ...
UP SCO:  00 18 00 40 00 50 00 48 00 38 00 38 00 38 00 28 ...
DOWN SCO:  00 18 00 40 00 50 00 48 00 38 00 38 00 38 00 28 ...
UP SCO:  00 10 00 40 00 50 00 48 00 28 00 30 00 30 00 28 ...
DOWN SCO:  00 10 00 40 00 50 00 48 00 28 00 30 00 30 00 28 ...
UP SCO:  00 10 00 40 00 58 00 38 00 20 00 38 00 30 00 30 ...
DOWN SCO:  00 10 00 40 00 58 00 38 00 20 00 38 00 30 00 30 ...
UP EVT: Connection Packet Type Changed Event Data =3D 00 01 00 80 00
        Status 0x0 Connection_Handle 0x1 Packet_Type 0x80
UP SCO:  38 00 30 00 40 00 20 00 28 00 40 00 30 00 40 00 ...
DOWN SCO:  38 00 30 00 40 00 20 00 28 00 40 00 30 00 40 00 ...
UP SCO:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ...
DOWN SCO:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ...
UP SCO:  00 30 00 30 00 30 00 28 00 38 00 30 00 30 00 28 ...
DOWN SCO:  00 30 00 30 00 30 00 28 00 38 00 30 00 30 00 28 ...
UP SCO:  00 48 00 30 00 18 00 28 00 38 00 20 00 28 00 18 ...
DOWN SCO:  00 48 00 30 00 18 00 28 00 38 00 20 00 28 00 18 ...
UP SCO:  00 38 00 40 00 30 00 30 00 30 00 20 00 30 00 28 ...
DOWN SCO:  00 38 00 40 00 30 00 30 00 30 00 20 00 30 00 28 ...
UP ACL: conn=3D7 flags=3D 2 Data =3D  0f 00 43 00 3b ff 15 01 41 54 2b 56 47
53 3d 31 31
UP ACL: conn=3D7 flags=3D 1 Data =3D  0d b9
UP SCO:  00 30 00 40 00 28 00 20 00 40 00 30 00 20 00 18 ...
DOWN SCO:  00 30 00 40 00 28 00 20 00 40 00 30 00 20 00 18 ...




2006/6/5, Brad Midgley <bmidgley@xmission.com>:
> Eduardo
>
> > I have been investigating a bit around the code. I am not familiar
> > with bluez and my knowledge of BT is limited. However, I found that
> > I'm getting -ERESTARTSYS (-512) errors in snd_card_bt_sco_thread
> > coming from bt_sock_recvmsg. It looks like quite an exotic error code
> > to me. Further I have difficulty tracking where it comes from. Is this
> > code normal?
>
> I haven't dug into it like you have, but it's not unexpected to see the
> error happen there. We have no sco data arriving on hci, so recvmsg must
> be interrupted by a signal instead.
>
> I suspect broadcom has an equivalent to csr's nonvolatile setting for
> hci vs. pcm audio delivery. Apparently no one has good enough docs to
> know for sure. It would help if we knew that dongle had been
> successfully used for sco under windows.
>
> Brad
>
>
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
