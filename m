Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP browsing inconsistency on Motorola A1000
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <423191C1.2020107@tomtom.com>
References: <423191C1.2020107@tomtom.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TJ/p8JtFQffND3mCE6yu"
Message-Id: <1110549590.32238.131.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 11 Mar 2005 13:59:50 +0000


--=-TJ/p8JtFQffND3mCE6yu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Dimitry,
I don't know what's causing your problem but I've had a look at the
dumps and it seems that the integer-sequence values being printed out in
error are in fact from the LANG_BASE_ATTR_ID_LIST, which occurs 44 bytes
after the SVCLASS_ID_LIST.=20

Can you step through this in a debugger on the ARM box? Also to check
for memory corruption, can you run it under valgrind on the x86 box?

Finally, are you sure that the text of your sdptool-arm dump is correct?
The data for the record in question seems to be repeated:

[...]
Attribute Identifier : 0x301
  Integer : 0x20
Attribute Identifier : 0x311
  Integer : 0x7

ttribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0x100
[...]

Thanks,
Steve

On Fri, 2005-03-11 at 13:40 +0100, Dimitry Andric wrote:
> Hi,
>=20
> I've just been asked to check out an SDP problem, which occurred with
> a Motorola A1000 phone.  It seems like the phone doesn't return any
> Service Class ID's for its Handsfree Audio Gateway profile.
>=20
> This turns out to be caused by sdp_get_service_classes() failing.  I
> added some debug code to this function (see sdp-dtd-debug.patch, and
> compile with -DSDP_DEBUG), to help diagnose the problem.
>=20
> For some reason, spd_get_service_classes thinks there's a SDP_UINT16
> (0x09) instead of a SDP_UUID16 (0x19) in the Service Class ID list of
> the HF AG record, but here hcidump and sdptool disagree.
>=20
> sdptool says (see sdptool-arm for full dump):
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10003
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     Integer : 0x656e
>     Integer : 0x6a
>     Integer : 0x100
>=20
> while hcidump says (see hcidump-arm.raw):
>=20
>           record #4
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10003
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
>=20
> However, this is all on an ARM platform, while on an x86 platform it
> DOES seem to work correctly!
>=20
> sdptool says on x86 (see sdptool-x86):
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10003
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x111f - HandsfreeAudioGateway
>     UUID16 : 0x1203 - GenericAudio
>=20
> and hcidump says (see hcidump-x86.raw):
>=20
>           record #3
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10003
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
>=20
> So it seems to be another nice alignment problem somewhere in the SDP
> library stuff! (Hi Marcel :P)  If anyone has an idea where this might
> be, please let me know.
> plain text document attachment (sdp-dtd-debug.patch)
> =07&#0;=01&#0;=E2=82=AC=C3=A22Bf=CB=86=0C&#0;=04=0F=04&#0;=01=05=04=0E&#0=
;=01&#0;=C5=A0=C3=A22Bk=C3=82=03&#0;=04=03=0B&#0;.&#0;o=1F=C2=90(
> &#0;=01&#0;	&#0;=01&#0;=C5=A0=C3=A22BK=C3=B1=03&#0;=04=0E=06=01=08&#0;.&#=
0;=07&#0;=01&#0;=C5=A1=C3=A22Bm3=08&#0;=04=0F=04&#0;=01=06=04=07&#0;=01&#0;=
=C5=A1=C3=A22BMb=08&#0;=04=05=04&#0;.&#0;=16=11&#0;&#0;&#0;=C3=97=C3=A22B=
=C3=AF\	&#0;=01=05=04o=1F=C2=90(
> &#0;=18=C3=8C=01&#0;=C3=84=C5=BE=01=07&#0;=01&#0;=C3=97=C3=A22B=C2=90=C2=
=81	&#0;=04=0F=04&#0;=01=05=04=0E&#0;=01&#0;=C3=98=C3=A22Bv=02=0C&#0;=04=03=
=0B&#0;.&#0;o=1F=C2=90(
> &#0;=01&#0;=11&#0;&#0;&#0;=C3=98=C3=A22B=C2=8D=02=0C&#0;=02. =0C&#0;=08&#=
0;=01&#0;=02=01=04&#0;=01&#0;@&#0;=08&#0;&#0;&#0;=C3=98=C3=A22B=E2=80=9C=02=
=0C&#0;=01=08=04.&#0;=0F&#0;=08&#0;=01&#0;=C3=98=C3=A22B=C3=A5=19=0C&#0;=04=
=13=05=01.&#0;=01&#0;=06&#0;=01&#0;=C3=98=C3=A22B=C3=B7@=0C&#0;=04=1B=03.&#=
0;=05	&#0;=01&#0;=C3=98=C3=A22B=C3=BEc=0C&#0;=04=0E=06=01=08&#0;.&#0;=15&#0=
;=01&#0;=C3=98=C3=A22B=C3=A9=E2=80=93=0C&#0;=02. =10&#0;=0C&#0;=01&#0;=03=
=01=08&#0;M&#0;@&#0;=01&#0;=02&#0;=15&#0;=01&#0;=C3=98=C3=A22B&=C2=B6=0C&#0=
;=02. =10&#0;=0C&#0;=01&#0;=03=01=08&#0;M&#0;@&#0;&#0;&#0;&#0;&#0;=11&#0;&#=
0;&#0;=C3=98=C3=A22B4=C2=B6=0C&#0;=02. =0C&#0;=08&#0;=01&#0;=04=02=04&#0;M&=
#0;&#0;&#0;=11&#0;=01&#0;=C3=98=C3=A22B=C3=B6=C5=93=0C&#0;=02. =0C&#0;=08&#=
0;=01&#0;=04=01=04&#0;@&#0;&#0;&#0;=13&#0;&#0;&#0;=C3=98=C3=A22B=04=C5=B8=
=0C&#0;=02. =0E&#0;
> &#0;=01&#0;=05=01=06&#0;M&#0;&#0;&#0;&#0;&#0;=08&#0;=01&#0;=C3=98=C3=A22B=
=C3=85=C3=85=0C&#0;=04=13=05=01.&#0;=01&#0;=08&#0;=01&#0;=C3=98=C3=A22Bc=C3=
=95=0C&#0;=04=13=05=01.&#0;=01&#0;=13&#0;=01&#0;=C3=98=C3=A22B4=C3=9D=0C&#0=
;=02. =0E&#0;
> &#0;=01&#0;=05=02=06&#0;@&#0;&#0;&#0;&#0;&#0;=1D&#0;&#0;&#0;=C3=98=C3=A22=
B=C3=86=C3=9D=0C&#0;=02. =18&#0;=14&#0;M&#0;=06&#0;&#0;&#0;=0F5=03=19=10=02=
=C3=BF=C3=BF5=05
> &#0;&#0;=C3=BF=C3=BF&#0;=08&#0;=01&#0;=C3=98=C3=A22Bw=C3=BC=0C&#0;=04=13=
=05=01.&#0;=01&#0;X=01=01&#0;=C3=98=C3=A22B=C3=B2e&#0;=02. S=01O=02@&#0;=07=
&#0;&#0;=02J=02G6=02D5=E2=80=A2	&#0;&#0;
> &#0;=01&#0;&#0;	&#0;=015=06=19=11=12=19=12=03	&#0;=02
> &#0;&#0;&#0;
> 	&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=02	&#0;=055=03=19=10=02	&#0;=
=065		en	&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=08	=01&#0;	=01&=
#0;%=15Headset Audio Gateway	=01=01%=15Headset Audio Gateway	=01=02%=08Moto=
rola5y	&#0;&#0;
> &#0;=01&#0;=01	&#0;=015=03=19=11=05	&#0;=045=115=03=19=01&#0;5=05=19&#0;=
=03=08=035=03=19&#0;=08	&#0;=055=03=19=10=02	&#0;	5=085=06=19=11=05	=01&#0;=
	=01&#0;%=10OBEX Object Push	=01=01%=10OBEX Object Push	=01=02%=08Motorola	=
=03=035=02=08=C3=BF5=C5=A0	&#0;&#0;
> &#0;=01&#0;=02	&#0;=015=03=19=11=03	&#0;=02
> &#0;&#0;&#0;		&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=01	&#0;=055=03=
=19=10=02=05=01=01&#0;=C3=98=C3=A22B=C2=A9q&#0;=02.=10&#0;=01	&#0;=065		en	=
&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=03	=01&#0;	=01&#0;%=11Di=
alup Networking	=01=01%=11Dialup Networking	=01=02%=08Motorola5=E2=82=AC	&#=
0;&#0;
> &#0;=01&#0;=03	&#0;=015=06=19=11=1F=19=12=03	&#0;=02
> &#0;&#0;&#0;	&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=04	&#0;=055=03=19=
=10=02	&#0;=065		en	&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=1E	=
=01&#0;	=01&#0;%=17Handsfree Audio Gateway	=01=01%=17Handsfree Audio Gatewa=
y	=01=02%=08Motorola	=03=01=08 	=03=11	&#0;=07&#0;=11&#0;&#0;&#0;=C3=98=C3=
=A22B=C6=92r&#0;=02. =0C&#0;=08&#0;=01&#0;=06=03=04&#0;M&#0;@&#0;=08&#0;=01=
&#0;=C3=98=C3=A22B=1B=E2=80=B0&#0;=04=13=05=01.&#0;=01&#0;=11&#0;=01&#0;=C3=
=98=C3=A22B=C3=BB4=0E&#0;=02. =0C&#0;=08&#0;=01&#0;=07=03=04&#0;M&#0;@&#0;=
=07&#0;&#0;&#0;=C3=9A=C3=A22B=C2=B23=0E&#0;=01=06=04=03.&#0;=13=07&#0;=01&#=
0;=C3=9A=C3=A22BvP=0E&#0;=04=0F=04&#0;=01=06=04=07&#0;=01&#0;=C3=9A=C3=A22B=
$=E2=80=A1=0E&#0;=04=05=04&#0;.&#0;=16OBEXObjectPush
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x3
>     Data Sequence
>       UUID16 : 0x0008 - OBEX
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1105 - OBEXObjectPush
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "OBEX Object Push"
> Attribute Identifier : 0x101
>   Text : "OBEX Object Push"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x303
>   Data Sequence
>     Integer : 0xff
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10002
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x1103 - DialupNetworking (DUN)
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0x9
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x1
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
>   Data Sequence
>     Code ISO639 (Integer) : 0x656e
>     Encoding (Integer) : 0x6a
>     Base Offset (Integer) : 0x100
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1103 - DialupNetworking (DUN)
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Dialup Networking"
> Attribute Identifier : 0x101
>   Text : "Dialup Networking"
> Attribute Identifier : 0x102
>   Text : "Motorola"
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10003
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x111f - HandsfreeAudioGateway
>     UUID16 : 0x1203 - GenericAudio
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0xd
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x4
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
>   Data Sequence
>     Code ISO639 (Integer) : 0x656e
>     Encoding (Integer) : 0x6a
>     Base Offset (Integer) : 0x100
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x111e - Handsfree
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x101
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x301
>   Integer : 0x20
> Attribute Identifier : 0x311
>   Integer : 0x7
>=20
> ttribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     Integer : 0x656e
>     Integer : 0x6a
>     Integer : 0x100
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0xd
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x4
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x111e - Handsfree
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x101
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x301
>   Integer : 0x20
> Attribute Identifier : 0x311
>   Integer : 0x7
>=20
> plain text document attachment (sdptool-arm)
> =07&#0;=01&#0;=E2=82=AC=C3=A22Bf=CB=86=0C&#0;=04=0F=04&#0;=01=05=04=0E&#0=
;=01&#0;=C5=A0=C3=A22Bk=C3=82=03&#0;=04=03=0B&#0;.&#0;o=1F=C2=90(
> &#0;=01&#0;	&#0;=01&#0;=C5=A0=C3=A22BK=C3=B1=03&#0;=04=0E=06=01=08&#0;.&#=
0;=07&#0;=01&#0;=C5=A1=C3=A22Bm3=08&#0;=04=0F=04&#0;=01=06=04=07&#0;=01&#0;=
=C5=A1=C3=A22BMb=08&#0;=04=05=04&#0;.&#0;=16=11&#0;&#0;&#0;=C3=97=C3=A22B=
=C3=AF\	&#0;=01=05=04o=1F=C2=90(
> &#0;=18=C3=8C=01&#0;=C3=84=C5=BE=01=07&#0;=01&#0;=C3=97=C3=A22B=C2=90=C2=
=81	&#0;=04=0F=04&#0;=01=05=04=0E&#0;=01&#0;=C3=98=C3=A22Bv=02=0C&#0;=04=03=
=0B&#0;.&#0;o=1F=C2=90(
> &#0;=01&#0;=11&#0;&#0;&#0;=C3=98=C3=A22B=C2=8D=02=0C&#0;=02. =0C&#0;=08&#=
0;=01&#0;=02=01=04&#0;=01&#0;@&#0;=08&#0;&#0;&#0;=C3=98=C3=A22B=E2=80=9C=02=
=0C&#0;=01=08=04.&#0;=0F&#0;=08&#0;=01&#0;=C3=98=C3=A22B=C3=A5=19=0C&#0;=04=
=13=05=01.&#0;=01&#0;=06&#0;=01&#0;=C3=98=C3=A22B=C3=B7@=0C&#0;=04=1B=03.&#=
0;=05	&#0;=01&#0;=C3=98=C3=A22B=C3=BEc=0C&#0;=04=0E=06=01=08&#0;.&#0;=15&#0=
;=01&#0;=C3=98=C3=A22B=C3=A9=E2=80=93=0C&#0;=02. =10&#0;=0C&#0;=01&#0;=03=
=01=08&#0;M&#0;@&#0;=01&#0;=02&#0;=15&#0;=01&#0;=C3=98=C3=A22B&=C2=B6=0C&#0=
;=02. =10&#0;=0C&#0;=01&#0;=03=01=08&#0;M&#0;@&#0;&#0;&#0;&#0;&#0;=11&#0;&#=
0;&#0;=C3=98=C3=A22B4=C2=B6=0C&#0;=02. =0C&#0;=08&#0;=01&#0;=04=02=04&#0;M&=
#0;&#0;&#0;=11&#0;=01&#0;=C3=98=C3=A22B=C3=B6=C5=93=0C&#0;=02. =0C&#0;=08&#=
0;=01&#0;=04=01=04&#0;@&#0;&#0;&#0;=13&#0;&#0;&#0;=C3=98=C3=A22B=04=C5=B8=
=0C&#0;=02. =0E&#0;
> &#0;=01&#0;=05=01=06&#0;M&#0;&#0;&#0;&#0;&#0;=08&#0;=01&#0;=C3=98=C3=A22B=
=C3=85=C3=85=0C&#0;=04=13=05=01.&#0;=01&#0;=08&#0;=01&#0;=C3=98=C3=A22Bc=C3=
=95=0C&#0;=04=13=05=01.&#0;=01&#0;=13&#0;=01&#0;=C3=98=C3=A22B4=C3=9D=0C&#0=
;=02. =0E&#0;
> &#0;=01&#0;=05=02=06&#0;@&#0;&#0;&#0;&#0;&#0;=1D&#0;&#0;&#0;=C3=98=C3=A22=
B=C3=86=C3=9D=0C&#0;=02. =18&#0;=14&#0;M&#0;=06&#0;&#0;&#0;=0F5=03=19=10=02=
=C3=BF=C3=BF5=05
> &#0;&#0;=C3=BF=C3=BF&#0;=08&#0;=01&#0;=C3=98=C3=A22Bw=C3=BC=0C&#0;=04=13=
=05=01.&#0;=01&#0;X=01=01&#0;=C3=98=C3=A22B=C3=B2e&#0;=02. S=01O=02@&#0;=07=
&#0;&#0;=02J=02G6=02D5=E2=80=A2	&#0;&#0;
> &#0;=01&#0;&#0;	&#0;=015=06=19=11=12=19=12=03	&#0;=02
> &#0;&#0;&#0;
> 	&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=02	&#0;=055=03=19=10=02	&#0;=
=065		en	&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=08	=01&#0;	=01&=
#0;%=15Headset Audio Gateway	=01=01%=15Headset Audio Gateway	=01=02%=08Moto=
rola5y	&#0;&#0;
> &#0;=01&#0;=01	&#0;=015=03=19=11=05	&#0;=045=115=03=19=01&#0;5=05=19&#0;=
=03=08=035=03=19&#0;=08	&#0;=055=03=19=10=02	&#0;	5=085=06=19=11=05	=01&#0;=
	=01&#0;%=10OBEX Object Push	=01=01%=10OBEX Object Push	=01=02%=08Motorola	=
=03=035=02=08=C3=BF5=C5=A0	&#0;&#0;
> &#0;=01&#0;=02	&#0;=015=03=19=11=03	&#0;=02
> &#0;&#0;&#0;		&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=01	&#0;=055=03=
=19=10=02=05=01=01&#0;=C3=98=C3=A22B=C2=A9q&#0;=02.=10&#0;=01	&#0;=065		en	=
&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=03	=01&#0;	=01&#0;%=11Di=
alup Networking	=01=01%=11Dialup Networking	=01=02%=08Motorola5=E2=82=AC	&#=
0;&#0;
> &#0;=01&#0;=03	&#0;=015=06=19=11=1F=19=12=03	&#0;=02
> &#0;&#0;&#0;	&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=04	&#0;=055=03=19=
=10=02	&#0;=065		en	&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=1E	=
=01&#0;	=01&#0;%=17Handsfree Audio Gateway	=01=01%=17Handsfree Audio Gatewa=
y	=01=02%=08Motorola	=03=01=08 	=03=11	&#0;=07&#0;=11&#0;&#0;&#0;=C3=98=C3=
=A22B=C6=92r&#0;=02. =0C&#0;=08&#0;=01&#0;=06=03=04&#0;M&#0;@&#0;=08&#0;=01=
&#0;=C3=98=C3=A22B=1B=E2=80=B0&#0;=04=13=05=01.&#0;=01&#0;=11&#0;=01&#0;=C3=
=98=C3=A22B=C3=BB4=0E&#0;=02. =0C&#0;=08&#0;=01&#0;=07=03=04&#0;M&#0;@&#0;=
=07&#0;&#0;&#0;=C3=9A=C3=A22B=C2=B23=0E&#0;=01=06=04=03.&#0;=13=07&#0;=01&#=
0;=C3=9A=C3=A22BvP=0E&#0;=04=0F=04&#0;=01=06=04=07&#0;=01&#0;=C3=9A=C3=A22B=
$=E2=80=A1=0E&#0;=04=05=04&#0;.&#0;=16OBEXObjectPush
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x3
>     Data Sequence
>       UUID16 : 0x0008 - OBEX
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1105 - OBEXObjectPush
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "OBEX Object Push"
> Attribute Identifier : 0x101
>   Text : "OBEX Object Push"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x303
>   Data Sequence
>     Integer : 0xff
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10002
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x1103 - DialupNetworking (DUN)
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0x9
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x1
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
>   Data Sequence
>     Code ISO639 (Integer) : 0x656e
>     Encoding (Integer) : 0x6a
>     Base Offset (Integer) : 0x100
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1103 - DialupNetworking (DUN)
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Dialup Networking"
> Attribute Identifier : 0x101
>   Text : "Dialup Networking"
> Attribute Identifier : 0x102
>   Text : "Motorola"
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10003
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x111f - HandsfreeAudioGateway
>     UUID16 : 0x1203 - GenericAudio
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0xd
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x4
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
>   Data Sequence
>     Code ISO639 (Integer) : 0x656e
>     Encoding (Integer) : 0x6a
>     Base Offset (Integer) : 0x100
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x111e - Handsfree
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x101
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x301
>   Integer : 0x20
> Attribute Identifier : 0x311
>   Integer : 0x7
>=20
> ttribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     Integer : 0x656e
>     Integer : 0x6a
>     Integer : 0x100
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0xd
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x4
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x111e - Handsfree
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x101
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x301
>   Integer : 0x20
> Attribute Identifier : 0x311
>   Integer : 0x7
>=20
> plain text document attachment (sdptool-x86)
> =07&#0;=01&#0;=E2=82=AC=C3=A22Bf=CB=86=0C&#0;=04=0F=04&#0;=01=05=04=0E&#0=
;=01&#0;=C5=A0=C3=A22Bk=C3=82=03&#0;=04=03=0B&#0;.&#0;o=1F=C2=90(
> &#0;=01&#0;	&#0;=01&#0;=C5=A0=C3=A22BK=C3=B1=03&#0;=04=0E=06=01=08&#0;.&#=
0;=07&#0;=01&#0;=C5=A1=C3=A22Bm3=08&#0;=04=0F=04&#0;=01=06=04=07&#0;=01&#0;=
=C5=A1=C3=A22BMb=08&#0;=04=05=04&#0;.&#0;=16=11&#0;&#0;&#0;=C3=97=C3=A22B=
=C3=AF\	&#0;=01=05=04o=1F=C2=90(
> &#0;=18=C3=8C=01&#0;=C3=84=C5=BE=01=07&#0;=01&#0;=C3=97=C3=A22B=C2=90=C2=
=81	&#0;=04=0F=04&#0;=01=05=04=0E&#0;=01&#0;=C3=98=C3=A22Bv=02=0C&#0;=04=03=
=0B&#0;.&#0;o=1F=C2=90(
> &#0;=01&#0;=11&#0;&#0;&#0;=C3=98=C3=A22B=C2=8D=02=0C&#0;=02. =0C&#0;=08&#=
0;=01&#0;=02=01=04&#0;=01&#0;@&#0;=08&#0;&#0;&#0;=C3=98=C3=A22B=E2=80=9C=02=
=0C&#0;=01=08=04.&#0;=0F&#0;=08&#0;=01&#0;=C3=98=C3=A22B=C3=A5=19=0C&#0;=04=
=13=05=01.&#0;=01&#0;=06&#0;=01&#0;=C3=98=C3=A22B=C3=B7@=0C&#0;=04=1B=03.&#=
0;=05	&#0;=01&#0;=C3=98=C3=A22B=C3=BEc=0C&#0;=04=0E=06=01=08&#0;.&#0;=15&#0=
;=01&#0;=C3=98=C3=A22B=C3=A9=E2=80=93=0C&#0;=02. =10&#0;=0C&#0;=01&#0;=03=
=01=08&#0;M&#0;@&#0;=01&#0;=02&#0;=15&#0;=01&#0;=C3=98=C3=A22B&=C2=B6=0C&#0=
;=02. =10&#0;=0C&#0;=01&#0;=03=01=08&#0;M&#0;@&#0;&#0;&#0;&#0;&#0;=11&#0;&#=
0;&#0;=C3=98=C3=A22B4=C2=B6=0C&#0;=02. =0C&#0;=08&#0;=01&#0;=04=02=04&#0;M&=
#0;&#0;&#0;=11&#0;=01&#0;=C3=98=C3=A22B=C3=B6=C5=93=0C&#0;=02. =0C&#0;=08&#=
0;=01&#0;=04=01=04&#0;@&#0;&#0;&#0;=13&#0;&#0;&#0;=C3=98=C3=A22B=04=C5=B8=
=0C&#0;=02. =0E&#0;
> &#0;=01&#0;=05=01=06&#0;M&#0;&#0;&#0;&#0;&#0;=08&#0;=01&#0;=C3=98=C3=A22B=
=C3=85=C3=85=0C&#0;=04=13=05=01.&#0;=01&#0;=08&#0;=01&#0;=C3=98=C3=A22Bc=C3=
=95=0C&#0;=04=13=05=01.&#0;=01&#0;=13&#0;=01&#0;=C3=98=C3=A22B4=C3=9D=0C&#0=
;=02. =0E&#0;
> &#0;=01&#0;=05=02=06&#0;@&#0;&#0;&#0;&#0;&#0;=1D&#0;&#0;&#0;=C3=98=C3=A22=
B=C3=86=C3=9D=0C&#0;=02. =18&#0;=14&#0;M&#0;=06&#0;&#0;&#0;=0F5=03=19=10=02=
=C3=BF=C3=BF5=05
> &#0;&#0;=C3=BF=C3=BF&#0;=08&#0;=01&#0;=C3=98=C3=A22Bw=C3=BC=0C&#0;=04=13=
=05=01.&#0;=01&#0;X=01=01&#0;=C3=98=C3=A22B=C3=B2e&#0;=02. S=01O=02@&#0;=07=
&#0;&#0;=02J=02G6=02D5=E2=80=A2	&#0;&#0;
> &#0;=01&#0;&#0;	&#0;=015=06=19=11=12=19=12=03	&#0;=02
> &#0;&#0;&#0;
> 	&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=02	&#0;=055=03=19=10=02	&#0;=
=065		en	&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=08	=01&#0;	=01&=
#0;%=15Headset Audio Gateway	=01=01%=15Headset Audio Gateway	=01=02%=08Moto=
rola5y	&#0;&#0;
> &#0;=01&#0;=01	&#0;=015=03=19=11=05	&#0;=045=115=03=19=01&#0;5=05=19&#0;=
=03=08=035=03=19&#0;=08	&#0;=055=03=19=10=02	&#0;	5=085=06=19=11=05	=01&#0;=
	=01&#0;%=10OBEX Object Push	=01=01%=10OBEX Object Push	=01=02%=08Motorola	=
=03=035=02=08=C3=BF5=C5=A0	&#0;&#0;
> &#0;=01&#0;=02	&#0;=015=03=19=11=03	&#0;=02
> &#0;&#0;&#0;		&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=01	&#0;=055=03=
=19=10=02=05=01=01&#0;=C3=98=C3=A22B=C2=A9q&#0;=02.=10&#0;=01	&#0;=065		en	=
&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=03	=01&#0;	=01&#0;%=11Di=
alup Networking	=01=01%=11Dialup Networking	=01=02%=08Motorola5=E2=82=AC	&#=
0;&#0;
> &#0;=01&#0;=03	&#0;=015=06=19=11=1F=19=12=03	&#0;=02
> &#0;&#0;&#0;	&#0;=045=0C5=03=19=01&#0;5=05=19&#0;=03=08=04	&#0;=055=03=19=
=10=02	&#0;=065		en	&#0;j	=01&#0;	&#0;=08=08=C3=BF	&#0;	5=085=06=19=11=1E	=
=01&#0;	=01&#0;%=17Handsfree Audio Gateway	=01=01%=17Handsfree Audio Gatewa=
y	=01=02%=08Motorola	=03=01=08 	=03=11	&#0;=07&#0;=11&#0;&#0;&#0;=C3=98=C3=
=A22B=C6=92r&#0;=02. =0C&#0;=08&#0;=01&#0;=06=03=04&#0;M&#0;@&#0;=08&#0;=01=
&#0;=C3=98=C3=A22B=1B=E2=80=B0&#0;=04=13=05=01.&#0;=01&#0;=11&#0;=01&#0;=C3=
=98=C3=A22B=C3=BB4=0E&#0;=02. =0C&#0;=08&#0;=01&#0;=07=03=04&#0;M&#0;@&#0;=
=07&#0;&#0;&#0;=C3=9A=C3=A22B=C2=B23=0E&#0;=01=06=04=03.&#0;=13=07&#0;=01&#=
0;=C3=9A=C3=A22BvP=0E&#0;=04=0F=04&#0;=01=06=04=07&#0;=01&#0;=C3=9A=C3=A22B=
$=E2=80=A1=0E&#0;=04=05=04&#0;.&#0;=16OBEXObjectPush
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x3
>     Data Sequence
>       UUID16 : 0x0008 - OBEX
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1105 - OBEXObjectPush
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "OBEX Object Push"
> Attribute Identifier : 0x101
>   Text : "OBEX Object Push"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x303
>   Data Sequence
>     Integer : 0xff
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10002
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x1103 - DialupNetworking (DUN)
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0x9
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x1
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
>   Data Sequence
>     Code ISO639 (Integer) : 0x656e
>     Encoding (Integer) : 0x6a
>     Base Offset (Integer) : 0x100
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1103 - DialupNetworking (DUN)
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Dialup Networking"
> Attribute Identifier : 0x101
>   Text : "Dialup Networking"
> Attribute Identifier : 0x102
>   Text : "Motorola"
>=20
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10003
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x111f - HandsfreeAudioGateway
>     UUID16 : 0x1203 - GenericAudio
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0xd
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x4
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
>   Data Sequence
>     Code ISO639 (Integer) : 0x656e
>     Encoding (Integer) : 0x6a
>     Base Offset (Integer) : 0x100
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x111e - Handsfree
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x101
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x301
>   Integer : 0x20
> Attribute Identifier : 0x311
>   Integer : 0x7
>=20
> ttribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     Integer : 0x656e
>     Integer : 0x6a
>     Integer : 0x100
> Attribute Identifier : 0x2 - ServiceRecordState
>   Integer : 0xd
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x4
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x8 - ServiceAvailability
>   Integer : 0xff
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x111e - Handsfree
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x101
>   Text : "Handsfree Audio Gateway"
> Attribute Identifier : 0x102
>   Text : "Motorola"
> Attribute Identifier : 0x301
>   Integer : 0x20
> Attribute Identifier : 0x311
>   Integer : 0x7
>=20

--=-TJ/p8JtFQffND3mCE6yu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCMaRWlgMqgVzLyWcRAg2kAJ4jlJhFza9hRetsINiJauuutmnSYgCfRnep
f1YAzcF9o2f0Ia4URyHmwYc=
=mNDA
-----END PGP SIGNATURE-----

--=-TJ/p8JtFQffND3mCE6yu--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
