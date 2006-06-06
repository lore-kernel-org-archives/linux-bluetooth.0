Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <549053140606060008t7775903cq93cec01ca1c4cccb@mail.gmail.com>
Date: Tue, 6 Jun 2006 02:08:41 -0500
From: "Carl Karsten" <cfkarsten@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149362263.1977.4.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6198_32728660.1149577721548"
References: <549053140606021732w4263c5c2g93efa4cdf9a7614d@mail.gmail.com>
	<1149362263.1977.4.camel@localhost>
Subject: Re: [Bluez-users] PM325 by LG cell phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

------=_Part_6198_32728660.1149577721548
Content-Type: multipart/alternative;
	boundary="----=_Part_6199_12786675.1149577721548"

------=_Part_6199_12786675.1149577721548
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > carl@asus17:~$ sdptool browse 08:00:37:03:EF:36
> > Browsing 08:00:37:03:EF:36 ...
> > Service Name: WBTEXT
> > Service RecHandle: 0x10000
> > Service Class ID List:
> >   "Error: This is UUID-128" (0xdb1d8f12-95f3-402c-9b97-bc504c9a55c4)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 1
> > Language Base Attr List:
> >   code_ISO639: 0x656e
> >   encoding:    0x6a
> >   base_offset: 0x100
> > Profile Descriptor List:
> >   "Error: This is UUID-128" (0x1cdb1d8f-1295-f340-2c9b-97bc504c9a55)
> >     Version: 0x0100
>
> The WBTEXT service is some LG specific one and I actually like to know
> what you can do with it, but this might be used by LG phones and
> software only. However you might try "sdptool records --raw <bdaddr>"
> and see if you find some more records.
>

im guessing nothing new, but I am not qualified, so here you go...

carl@asus17:~$ sdptool records --raw  08:00:37:03:EF:36
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010000
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID128 db1d8f12-95f3-402c-9b97-bc504c9a55c4
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x01
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID128 1cdb1d8f-1295-f340-2c9b-97bc504c9a55
                                UINT16 0x0100
        Attribute 0x0100
                Data 57 42 54 45 58 54 00
        Attribute 0x8003
                UINT16 0x0001
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010001
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1112 - HeadsetAudioGateway
                        UUID16 0x1203 - GenericAudio
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x02
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x1108 - Headset
                                UINT16 0x0100
        Attribute 0x0100
                Data 4c 47 20 4c 58 33 32 35 20 48 65 61 64 73 65 74 20 41
47 20 53 65 72 76 69 63 65 00
        Attribute 0x0302
                Bool True
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010002
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x111f - HandsfreeAudioGateway
                        UUID16 0x1203 - GenericAudio
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x03
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x111e - Handsfree
                                UINT16 0x0100
        Attribute 0x0100
                Data 4c 47 20 4c 58 33 32 35 20 48 61 6e 64 73 2d 46 72 65
65 20 41 47 20 53 65 72 76 69 63 65 00
        Attribute 0x0301
                UINT8 0x00
        Attribute 0x0311
                UINT16 0x0005
carl@asus17:~$

------=_Part_6199_12786675.1149577721548
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; carl@as=
us17:~$ sdptool browse 08:00:37:03:EF:36<br>&gt; Browsing 08:00:37:03:EF:36=
 ...
<br>&gt; Service Name: WBTEXT<br>&gt; Service RecHandle: 0x10000<br>&gt; Se=
rvice Class ID List:<br>&gt;&nbsp;&nbsp; &quot;Error: This is UUID-128&quot=
; (0xdb1d8f12-95f3-402c-9b97-bc504c9a55c4)<br>&gt; Protocol Descriptor List=
:<br>&gt;&nbsp;&nbsp; &quot;L2CAP&quot; (0x0100)
<br>&gt;&nbsp;&nbsp; &quot;RFCOMM&quot; (0x0003)<br>&gt;&nbsp;&nbsp;&nbsp;&=
nbsp; Channel: 1<br>&gt; Language Base Attr List:<br>&gt;&nbsp;&nbsp; code_=
ISO639: 0x656e<br>&gt;&nbsp;&nbsp; encoding:&nbsp;&nbsp;&nbsp;&nbsp;0x6a<br=
>&gt;&nbsp;&nbsp; base_offset: 0x100<br>&gt; Profile Descriptor List:<br>&g=
t;&nbsp;&nbsp; &quot;Error: This is UUID-128&quot; (0x1cdb1d8f-1295-f340-2c=
9b-97bc504c9a55)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Version: 0x0100<br><br>The WBTEXT service =
is some LG specific one and I actually like to know<br>what you can do with=
 it, but this might be used by LG phones and<br>software only. However you =
might try &quot;sdptool records --raw &lt;bdaddr&gt;&quot;
<br>and see if you find some more records.<br></blockquote></div><br>im gue=
ssing nothing new, but I am not qualified, so here you go...<br><br>carl@as=
us17:~$ sdptool records --raw&nbsp; 08:00:37:03:EF:36<br>Sequence<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0000 - ServiceRecordHandle
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; UINT32 0x00010000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Attribute 0x0001 - ServiceClassIDList<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID128 =
db1d8f12-95f3-402c-9b97-bc504c9a55c4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Attribute 0x0004 - ProtocolDescriptorList
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID1=
6 0x0100 - L2CAP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x0003 - R=
FCOMM<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT8 0x01
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0005 - BrowseGro=
upList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x1002 - PublicBrowseGroup<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0006 - LanguageBaseAttributeIDL=
ist<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Sequence
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 =
0x656e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U=
INT16 0x006a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; UINT16 0x0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute =
0x0009 - BluetoothProfileDescriptorList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID128 1cdb1d8f-1295-f340-2c9b-97=
bc504c9a55<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0100<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0100<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dat=
a 57 42 54 45 58 54 00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attrib=
ute 0x8003
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; UINT16 0x0001<br>Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Attribute 0x0000 - ServiceRecordHandle<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
UINT32 0x00010001<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0=
x0001 - ServiceClassIDList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x1112 - HeadsetAudio=
Gateway
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 =
0x1203 - GenericAudio<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribu=
te 0x0004 - ProtocolDescriptorList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x0100 - L2CAP
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequenc=
e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x0003 - RFCOMM<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT8 0x02<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Attribute 0x0005 - BrowseGroupList<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0=
x1002 - PublicBrowseGroup
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0009 - Bluetooth=
ProfileDescriptorList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; UUID16 0x1108 - Headset<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; UINT16 0x0100
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0100<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Data 4c 47 20 4c 58 33 32 35 20 48 65 61 64 73 65 74 20 41 47 20 53=
 65 72 76 69 63 65 00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribu=
te 0x0302<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; Bool True<br>Sequence<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Attribute 0x0000 - ServiceRecordHandle
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; UINT32 0x00010002<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Attribute 0x0001 - ServiceClassIDList<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0=
x111f - HandsfreeAudioGateway<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; UUID16 0x1203 - GenericAudio
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0004 - ProtocolD=
escriptorList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; UUID16 0x0100 - L2CAP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID=
16 0x0003 - RFCOMM
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT8 0x03<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Attribute 0x0005 - BrowseGroupList<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; UUID16 0x1002 - PublicBrowseGroup<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Attribute 0x0009 - BluetoothProfileDescriptorList
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID1=
6 0x111e - Handsfree<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0100<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0100<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Data 4c 47 20 4c 58 33 32 35 20 48 61 6e 64 73 2d 46 72 65 65 20 41 =
47 20 53 65 72 76 69 63 65 00
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0301<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; UINT8 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute =
0x0311<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0005<br>carl@asus17:~$<br><br><br>

------=_Part_6199_12786675.1149577721548--

------=_Part_6198_32728660.1149577721548
Content-Type: text/plain; name=lg325.raw.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eo3wr9j7
Content-Disposition: attachment; filename="lg325.raw.txt"

Sequence
=09Attribute 0x0000 - ServiceRecordHandle
=09=09UINT32 0x00010000
=09Attribute 0x0001 - ServiceClassIDList
=09=09Sequence
=09=09=09UUID128 db1d8f12-95f3-402c-9b97-bc504c9a55c4
=09Attribute 0x0004 - ProtocolDescriptorList
=09=09Sequence
=09=09=09Sequence
=09=09=09=09UUID16 0x0100 - L2CAP
=09=09=09Sequence
=09=09=09=09UUID16 0x0003 - RFCOMM
=09=09=09=09UINT8 0x01
=09Attribute 0x0005 - BrowseGroupList
=09=09Sequence
=09=09=09UUID16 0x1002 - PublicBrowseGroup
=09Attribute 0x0006 - LanguageBaseAttributeIDList
=09=09Sequence
=09=09=09UINT16 0x656e
=09=09=09UINT16 0x006a
=09=09=09UINT16 0x0100
=09Attribute 0x0009 - BluetoothProfileDescriptorList
=09=09Sequence
=09=09=09Sequence
=09=09=09=09UUID128 1cdb1d8f-1295-f340-2c9b-97bc504c9a55
=09=09=09=09UINT16 0x0100
=09Attribute 0x0100
=09=09Data 57 42 54 45 58 54 00
=09Attribute 0x8003
=09=09UINT16 0x0001
Sequence
=09Attribute 0x0000 - ServiceRecordHandle
=09=09UINT32 0x00010001
=09Attribute 0x0001 - ServiceClassIDList
=09=09Sequence
=09=09=09UUID16 0x1112 - HeadsetAudioGateway
=09=09=09UUID16 0x1203 - GenericAudio
=09Attribute 0x0004 - ProtocolDescriptorList
=09=09Sequence
=09=09=09Sequence
=09=09=09=09UUID16 0x0100 - L2CAP
=09=09=09Sequence
=09=09=09=09UUID16 0x0003 - RFCOMM
=09=09=09=09UINT8 0x02
=09Attribute 0x0005 - BrowseGroupList
=09=09Sequence
=09=09=09UUID16 0x1002 - PublicBrowseGroup
=09Attribute 0x0009 - BluetoothProfileDescriptorList
=09=09Sequence
=09=09=09Sequence
=09=09=09=09UUID16 0x1108 - Headset
=09=09=09=09UINT16 0x0100
=09Attribute 0x0100
=09=09Data 4c 47 20 4c 58 33 32 35 20 48 65 61 64 73 65 74 20 41 47 20 53 6=
5 72 76 69 63 65 00
=09Attribute 0x0302
=09=09Bool True
Sequence
=09Attribute 0x0000 - ServiceRecordHandle
=09=09UINT32 0x00010002
=09Attribute 0x0001 - ServiceClassIDList
=09=09Sequence
=09=09=09UUID16 0x111f - HandsfreeAudioGateway
=09=09=09UUID16 0x1203 - GenericAudio
=09Attribute 0x0004 - ProtocolDescriptorList
=09=09Sequence
=09=09=09Sequence
=09=09=09=09UUID16 0x0100 - L2CAP
=09=09=09Sequence
=09=09=09=09UUID16 0x0003 - RFCOMM
=09=09=09=09UINT8 0x03
=09Attribute 0x0005 - BrowseGroupList
=09=09Sequence
=09=09=09UUID16 0x1002 - PublicBrowseGroup
=09Attribute 0x0009 - BluetoothProfileDescriptorList
=09=09Sequence
=09=09=09Sequence
=09=09=09=09UUID16 0x111e - Handsfree
=09=09=09=09UINT16 0x0100
=09Attribute 0x0100
=09=09Data 4c 47 20 4c 58 33 32 35 20 48 61 6e 64 73 2d 46 72 65 65 20 41 4=
7 20 53 65 72 76 69 63 65 00
=09Attribute 0x0301
=09=09UINT8 0x00
=09Attribute 0x0311
=09=09UINT16 0x0005

------=_Part_6198_32728660.1149577721548
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_6198_32728660.1149577721548
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_Part_6198_32728660.1149577721548--
