Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 4 Nov 2011 16:44:31 +0800
Subject: RFC for Virtual AMP Controller 
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD70ABDD61@shsmsx501.ccr.corp.intel.com>
Content-Type: multipart/mixed;
	boundary="_002_FC2FB65B4D919844ADE4BE3C2BB739AD70ABDD61shsmsx501ccrcor_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_FC2FB65B4D919844ADE4BE3C2BB739AD70ABDD61shsmsx501ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all:
I have spent some efforts to find the suitable device to test and develop t=
he Bluetooth-3.0 HS implementation, but failed. So I'd like to work out a V=
irtual PAL as the virtual AMP controller to facilitate the 3.0 development =
work. Below is the RFC of VPAL. Any suggestions are welcome. :-)


VPAL(Virtual PAL) is an user space daemon, working as PAL of AMP Controller=
. It talks to virtual MAC 802.11 engine and translate the Mac802.11 data to=
 AMP HCI. The main target of Virtual PAL is to provide virtual AMP controll=
er for the development of Bluetooth-3.0 HS. In the future it can also talk =
to WPA_s or nl802.11 and use physical 802.11 stack direct.

The Framework of VPAL is showed at Figure 1(see attachment)

1. Virtual AMP HCI:
Vhci driver in kernel can be used directly to provide HCI interface to Blue=
tooth stack and route the HCI data to user space for VPAL daemon. So most o=
f the VPAL logic is at user space.

2. Virtual PAL core:
Virtual PAL core implements a full feature of AMP PAL layer which is used t=
o transfer MAC802.11 data and control to Bluetooth HCI interface. It compos=
ed of PAL Manager, Physical Link Manager, Logical Link Manager and Data Man=
ager.

2.1 PAL Manager
PAL Manager implements operations that are global to the PAL, this includes=
 responding to host requests for AMP info and PAL version as well as perfor=
ming PAL reset.
Supports below HCI Commands:
#define HCI_OP_READ_LOCAL_AMP_VERSION 2.1 of [2]
#define HCI_OP_READ_LOCAL_AMP_INFO 0x1409 2.2 of [2]
#define HCI_OP_RESET 0x0c03 7.3.2 of [1]

2.2 Physical link Manager
Physical link handles physical links
Physical link managers and maintains the state machine which is trigged by =
HCI command, and info the states and commands result through HCI event and =
command status. Physical link manager uses mac_engine_call_back_functions t=
o drive the MAC 802.11. See Figure 3.1 of[2] for state machine. VPAL need t=
o cover all the state machine to test the Bluetooth-3.0 HS code.

2.2.1 Supports below HCI Commands:
#define HCI_OP_READ_LOCAL_AMP_ASSOC 0X140a
#define HCI_OP_CREATE_PHYSICAL_LINK 0X0435
#define HCI_OP_WRITE_REMOTE_AMP_ASSOC 0X140b
#define HCI_OP_ACCEPT_PHYSICAL_LINK 0X0436
#define HCI_EV_CHANNEL_SELECTED 0X41
#define HCI_EV_PHYSICAL_LINK_COMPLETE 0X40
#define HCI_OP_DISCONN_PHYSICAL_LINK 0X0437
#define HCI_EV_DISCONN_PHYSICAL_LINK_COMPLETE 0X42
...
Above commands are used to create and disconnect the physical link

2.2.2 Below mac_engine_call_back functions are used to call the functions o=
f Mac802.11 engine
start_mac();
auth_request();
auth_indcation();
auth_response();
auth_confirm();
assoc_request();
assoc_indication();
assoc_response();
assoc_confirm();
4-way_request();
4-way_indication();
4_way_response();
4_way_confirm();
...

2.2.3 Channel Selection
Use the Preferred Channel List TLV in AMP_ASSOC in AMP_ASSOC to select chan=
nel
Prefer to use 5 MHZ band to avoid collision with BRDER
Shall not use 40 MHz channel width in the 2.4 GHz ISM band
for simple, currently, just ignore the regulatory info

2.2.4 Starting the AMP network
Starting AMP networking needs to send Beacons which are used to advertise M=
AC capabilities.
The maximum beacon period shall be Max80211BeaconPeriod.=20
The SSID information element for AMP devices shall be of the form 'AMP-xx-x=
x-
xx-xx-xx-xx'
AMP beacons shall be indicated as ESS-style beacons in the capability infor=
mation
At virtual 802.11 plugin, a field named channel will be added to show which=
 channel will be used. Since the 802.11 plugin uses the Ethernet to broadca=
st the beacon=20

struct {
	__le64 timestamp;
	__le16 beacon_int;
	__le16 capab_info;
	U8 ssid[21];
	...
} beacon;

2.2.5 Establishing the 802.11 link
Establishing 802.11 link experience authentication and association process.
auth_request();
auth_indcation();
auth_response();
auth_confirm();
is used to authenticate
assoc_request();
assoc_indication();
assoc_response();
assoc_confirm();
is used to associate;
SSID and MAC address is not match, associate will fail

2.2.6 Address Fields of Data Frames
Use 4 address;
RA equal to DA, TA equal to SA;

2.2.7 Physical Link Maintenance
Supervision Request should be send if no data get before LSTO. If no superv=
ision Reply got then the link is lost.

2.2.8 Physical Link Security
For simple, currently, Security will not be supported
However
4-way_request();
4-way_indication();
4_way_response();
4_way_confirm();
Still will be used, and the virtual 802.11 plugin will simulate the 4way-ha=
ndshake error.

2.3 Physical Link Support For QOS
Currently, Guaranteed Link will not be supported.

3. Logical Link Manager
It is used to manage the logical link.
Below HCI command needs to be supported to create, modify and delete the lo=
gical link

#define HCI_OP_CREATE_LOGICAL_LINK 0x0438
#define HCI_OP_ACCEPT_LOGICAL_LINK 0x0439
#define HCI_OP_DISCONN_LOGICAL_LINK 0x043a
#define HCI_OP_LOGICAL_LINK_CANCEL 0x043b
#define HCI_OP_FLOW_SPEC_MODIFY 0X43C

HCI must include logical handler in handle field of ACL header
PAL must include the physical handle in handle field of ACL header

4. Data Manager
Max80211PALPDUSize is used to determine the PDU size.
HCI header will be removed and the LLC SNAP and 802.11 MAC header will be a=
dded. 4 address style MAC header will be used.

4.1 Local Interference
Currently, for simple, it will not touch the interference stuff. Since Virt=
ual 80211 plugin uses Ethernet to transfer the data.=20

5. MAC 80211 Engine
MAC 80211 engine is used to acquire MAC 80211 resource. It is implemented i=
n plugin style, so we can use different implementations to access 80211.
We can have a plugin to talk to physical MAC 80211 so even do not have phys=
ical AMP controller, we also can have Bluez-3.0 HS support. That is the nex=
t step. And there is still many job need to do to achieve it.
Currently, we only plan to implement Virtual 80211 plugin targeting to test=
 the Bluetooth-3.0 HS kernel implementation.

5.1 Virtual 802.11 Plugin
It targets to use Ethernet network to simulate 802.11 network. And TCP or U=
DP will be used to transfer data. The data flow is as below:

L2CAP ACL data:
L2CAP <---> Virtual HCI <---> Vitual PAL DATA Manager <---> Virtual 802.11 =
plugin <---> TCP/UDP <---> Ethernet=20

It also needs to implement mac_engine_call_back_functions to create and mai=
ntain the physical link see section 2.=20

5.2 Virtual 802.11 Configure
It is the user configure interface to simulate the exception/err of the MAC=
80211 layer. And configure the parameters of the MAC802.11
For example:
1). Reject to start MAC(beacon)
2). Do not response Authentication
3). Do not response assoc
4). 4-way handshake error
5). Stop MAC(beacon) to simulate the lost of physical link
6). throw away some frames to test ERTM

[1] BLUETOOTH SPECIFICATION Version 4.0 [Vol 2]
[2] BLUETOOTH SPECIFICATION Version 4.0 [Vol 5]


--_002_FC2FB65B4D919844ADE4BE3C2BB739AD70ABDD61shsmsx501ccrcor_
Content-Type: application/pdf; name="figure1.pdf"
Content-Description: figure1.pdf
Content-Disposition: attachment; filename="figure1.pdf"; size=5922;
	creation-date="Fri, 04 Nov 2011 16:22:49 GMT";
	modification-date="Fri, 04 Nov 2011 16:22:49 GMT"
Content-Transfer-Encoding: base64

JVBERi0xLjUNCiW1tbW1DQoxIDAgb2JqDQo8PC9UeXBlL0NhdGFsb2cvUGFnZXMgMiAwIFIvTGFu
Zyhlbi1VUykgL1N0cnVjdFRyZWVSb290IDExIDAgUi9PdXRsaW5lcyA4IDAgUi9NYXJrSW5mbzw8
L01hcmtlZCB0cnVlPj4+Pg0KZW5kb2JqDQoyIDAgb2JqDQo8PC9UeXBlL1BhZ2VzL0NvdW50IDEv
S2lkc1sgMyAwIFJdID4+DQplbmRvYmoNCjMgMCBvYmoNCjw8L1R5cGUvUGFnZS9QYXJlbnQgMiAw
IFIvUmVzb3VyY2VzPDwvRm9udDw8L0YxIDUgMCBSPj4vUHJvY1NldFsvUERGL1RleHQvSW1hZ2VC
L0ltYWdlQy9JbWFnZUldID4+L01lZGlhQm94WyAwIDAgNTk2LjI1IDg0M10gL0NvbnRlbnRzIDQg
MCBSL0dyb3VwPDwvVHlwZS9Hcm91cC9TL1RyYW5zcGFyZW5jeS9DUy9EZXZpY2VSR0I+Pi9UYWJz
L1MvU3RydWN0UGFyZW50cyAwPj4NCmVuZG9iag0KNCAwIG9iag0KPDwvRmlsdGVyL0ZsYXRlRGVj
b2RlL0xlbmd0aCAyMDI5Pj4NCnN0cmVhbQ0KeJzVGmtvVTfse6X+h3ws0whJnKeEmEYLG9OQkOi2
L5MmNLUwVthUQGz/fnbOyznXJ3dFgLhFarm+jh+x41ei7jxRd+/eeXz66EyZe/fU/bNTZdXz46Oc
dcigfARto4LktU3KQtZFXV8cH11+dXxktPPqPf5V3x0f4aofFP56qfYtfYrIDx6fKsVY24m1sRq8
8rg8GZ1jVCVqSHnmedTFkEi7kfT98+OjOw+tMtrSjzq/PD5KThn8h3+sdRqsCi7rVNT5K9IKd+Hk
ya3zl6SpSd6ajLjnZwj9VoT+OEGjTcVPUDVBweRYJujjCVpcCHGCPhMpvBahMu5zEXohQq8r9MG5
sGnAXcFm3OHcNUoPQzKKZ0ZZjOBM1MWpgK4C+43wQlTq3wka8CdN0Dci9I8J6nzMYYL+LuLK2321
vYVBVtF67RP3sw23kWWTXeHPbSni5kYb3GhbtB2l+MIdMnGHdCmhnD2H7GJIDpnlfSpFZ7/rkLLJ
/rrBBnxS1yuiMmCCtvnzuZ41G3sadYJD8j1rufMBOlSEnvN1McTs52SDlaQj5iQAHbj3nU0KZLSQ
62/BWzH7POsoCxuyYLYn5wFdDsRqvilnEtYiQQHWJLgaUqAtjXggSloMtw9JtJ0c59F0KWJGJFfI
zHY/i6lMPnHXs+2SMdC36LsbbPCVyE2uUz5V/XMq+rAcQeV9uOiYPjbli8WqAtCqWWOd55Om6hEj
IS9kc7BUxO7BFe2fdupLkwHArQtM9CMMu/VMs8Nca+eTX+b9zBElWe89JoPV1stqy0kMt1L7wDmf
/NYhIicPm91K/JOn20ScHPqpTFwRudMhYjeIZO1jQ2SOLthy+NC6uUxaDri2YMcCDenb81lJKcx+
ertDWo6fGEK0dQ3pLEptRKjrMNyqpdNaF90hslGtmqxzQ8OK4tkOZbkCtXjC7JBW/EhadYikDSJl
8KeFyPs5ghib55M0x1eLB32OIJezbcGGPbhKxH3SEXnjMGa/1rtn263DmIYjsBARY0VP6BXqlaj1
O9Haz0WovG+vOz3mRn1oSvW5RbdvOjQ2YkSKdYMyaDcS+fWkQ2UjHKS8piJHmgsR+s8MtTHOG/1W
tIlsqTc3oCDL8HdHaTlQOeNo+/nO3eoQaYos5wz1SZAcJRxnnY7rVLsPR0qxEHZSrDTCcRmjAXkO
njB/QCWXvLFy2ATrqZ5kOi5ppGFoRGgn1IAcYgG7RQMNw687ROSgB4DNQ2iIWFE+Gdrbpo1W11ts
uBqGciEr20W27E0a+U7Y882Y1SVPPR7gHqNYKB2aWFPmYqOMDoY4W5NjIlhLIxHACtfybvInsRKX
e8xOvvMbPaxLumTOtVfy+Y3mk/ynoXE+2yLlNMdAuanoCT2FL2rTE/3OkX4br67JOBBIeI8hK3r1
igJcQBmtjk5d0ddOiwCMbWYAtJ9GchnqJ4+tRmq+xvjlBMBCf1zCGHIBEfBicppDlFx05in2UyBC
TABPQyzUCCwWuHguvKcuHSmA8xpCBZQ4AEBjzQ7RUi4jAHqQQ2eMhsbMFSNSZTsmIwIANn60BDXx
A8BU/0Ua6CAVYHUmtoGuISqgYClVAeiJlSiXlBnlsFUQrdM02hhtHQobUYlEPXQgfg4TfGIzln1I
Ihs5Nznsz9GpIgDROJyEv6YrT1Pk8ZqcxmS634vhUA6SjzpBMneDpAVs6pMKqdAVEBrBujrpCFjB
Q3ViiwZC5B1AtKBT9dlxCQMMREcvIQDaGr9iGN5orH53AIzLsISz5ZKyg3nYKognZqqLPN30RKYa
lICmZyQ9FvwAu4BFrHHJAhiJLqp5DGQmNBjUxK0/Mx7DAs6Uy8lsc8gKSJYJU/kH2PpgIGSKGasD
9zE8zK0XjgCm2LCEAQaii2I1gTQIkRL9DoAxqSvY50ZOns4OWAHRMlPd7FzNj4tizmK44x7mbG59
cAQsUo1LGGAguihGJVezF1hy6RB2AYzLsIQBGkl5/XfQKojWcW1EW0rb8XQvteV4/ncBc306LZkB
E9HMowH/mk7/zueFwbiAceRC7oazw5NetEnzTMSnVIvGFKhCHW8+fT17c/W3B0dkIs+3fa538lAy
3dUdTvEnvxWRx+/B1ikc0/FjTXuCPF4K1ExAw7BzaRDkspweGOTYEPlI054gj5d8ieS4kAv1M5Wh
/JBCvl6U76YvRS+Q/UieDMkec+PLzFC65fd0onAPQg0oPqbae5s6Ar+aAVDK2DJ6jMGlSACgl3p8
yRqQ4xQiGrY8wH058kjRJMqXDsViwqIu2tLrrCWayE2Y3LDJjdXizqvLBYssI+f4gWd7RRYTLo0U
GFm9iZoor3DUDzunK7KQ63UzI/tA3C/53N18yiq/FJFfw8mjUQd1suhSpParivxQHDB+2uP/f3fY
xTrJ5eJ2LmCjPJh1th6YGEF7GIh86anzc71NkW0vayxr8UoMG/Pd9Ae/eek99Gyf7OLZRsb10mD8
b3utwJ689FDFEOp3ruPkFy/0fqpO7dPOg5c5rsbi7W5c5TfTpx2d5bKJXohgKcw4f6y3FnHjMQOW
Otk3DDtlU9yYZpo6/OFEbvzYIubGCUp9Kr/Mm2029U0IjZeHkVRO1HXR4NfkCUAYIdHFGQGwL8uI
ESJlZAKU+rhxeCFF/Rt28KQ7rhjmz7bUaTYBXJkAhIFMnB+WuHoTRfPnEYMLuhQTzEkPWZXpEP0H
7iJ4Jw0KZW5kc3RyZWFtDQplbmRvYmoNCjUgMCBvYmoNCjw8L1R5cGUvRm9udC9TdWJ0eXBlL1Ry
dWVUeXBlL05hbWUvRjEvQmFzZUZvbnQvQXJpYWwvRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL0Zv
bnREZXNjcmlwdG9yIDYgMCBSL0ZpcnN0Q2hhciAzMi9MYXN0Q2hhciAxMjEvV2lkdGhzIDQxIDAg
Uj4+DQplbmRvYmoNCjYgMCBvYmoNCjw8L1R5cGUvRm9udERlc2NyaXB0b3IvRm9udE5hbWUvQXJp
YWwvRmxhZ3MgMzIvSXRhbGljQW5nbGUgMC9Bc2NlbnQgOTA1L0Rlc2NlbnQgLTIxMC9DYXBIZWln
aHQgNzI4L0F2Z1dpZHRoIDQ0MS9NYXhXaWR0aCAyNjY1L0ZvbnRXZWlnaHQgNDAwL1hIZWlnaHQg
MjUwL0xlYWRpbmcgMzMvU3RlbVYgNDQvRm9udEJCb3hbIC02NjUgLTIxMCAyMDAwIDcyOF0gPj4N
CmVuZG9iag0KNyAwIG9iag0KPDwvVGl0bGUoKS9BdXRob3IoSW50ZWwgVXNlcikvU3ViamVjdCgp
L0tleXdvcmRzKCkvQ3JlYXRpb25EYXRlKEQ6MjAxMTExMDQxNjIyNDkpIC9Nb2REYXRlKEQ6MjAx
MTExMDQxNjIyNDkpIC9Qcm9kdWNlcij+/wBNAGkAYwByAG8AcwBvAGYAdACuACAATwBmAGYAaQBj
AGUAIABWAGkAcwBpAG8ArgAgADIAMAAwADcpL0NyZWF0b3Io/v8ATQBpAGMAcgBvAHMAbwBmAHQA
rgAgAE8AZgBmAGkAYwBlACAAVgBpAHMAaQBvAK4AIAAyADAAMAA3KT4+DQplbmRvYmoNCjggMCBv
YmoNCjw8L1R5cGUvT3V0bGluZXMvRmlyc3QgOSAwIFIvTGFzdCAxMCAwIFI+Pg0KZW5kb2JqDQo5
IDAgb2JqDQo8PC9UaXRsZShWaXJ0dWFsX0FNUF9QQUxfUkZDLnZzZCkvUGFyZW50IDggMCBSL0Zp
cnN0IDEwIDAgUi9MYXN0IDEwIDAgUi9Db3VudCAtMS9EZXN0WyAzIDAgUi9YWVogMCA4NDEgMF0g
Pj4NCmVuZG9iag0KMTAgMCBvYmoNCjw8L1RpdGxlKFBhZ2UtMSkvUGFyZW50IDkgMCBSL0Rlc3Rb
IDMgMCBSL1hZWiAwIDg0MSAwXSA+Pg0KZW5kb2JqDQoxNiAwIG9iag0KPDwvVHlwZS9PYmpTdG0v
TiAyOS9GaXJzdCAyMDkvRmlsdGVyL0ZsYXRlRGVjb2RlL0xlbmd0aCA1NTc+Pg0Kc3RyZWFtDQp4
nMWVT2sbMRDF74F8h3dsL9kdjaRdQQj00ksgmCS30EObLCaQxsV/oPn2fdLEBWNXVn3JxW8tj37a
mTcai0cPGRAUMiLxOUFU4PKqwvFJApyDG/io0H6A89Dk4QK8528RnvscGYS4EZEIlxDDyGgMOVow
MEQdxhChikSgeqSRIQHSa4JGiPRcHqjK9ZE65JMgTnp4vpAjUviiSqYIJORNDhLzBzmRsMvLbpaD
etx2d93X5/lmOXVfXtafZsvF47Rafe6uH9B/Qzebo0RdXZ2f7W6a5RBmezxI4REQjwcOYHGZaMO5
UlLSauR+WhexJCa+4YTQEBNzU7Ajspd9aQOX7XfFdlpOu2k1babFtJfWav2VrV4++03X6HL2OB3f
Qt+9wDv45pKwKZ+m+XKa8LTY/HiZSmV8vTKV7RfijNBQN8/LMJx+ULCDxtMJgxHqha0SxkII9Vat
EpIR5HSCNXNouIEcOYF3MICDJXAEnVC61fPr/L1JQkNDxoZLHOu5W0xDdlERPScpYkQ8va+c9VU8
XBzZnvh9PokNkbySB0CR0SQV4TAoIibORE1sHwdEkWhiFGcUZxQ1ihpFjaJGUaOoUdQoahQ1ihrF
F8p+Tvdvv6bubr3cPK7vWYXbxWLN5JbTa/max2tOOCeqW8DfX2+m3+vr6Q3yzrrZ/Fw95L/IYKF5
ea9Cu4U6KOnfsi3prhws8AeJb5ZQkYP98N9t0SDHO6cm2646P/sDRS/+zw0KZW5kc3RyZWFtDQpl
bmRvYmoNCjQxIDAgb2JqDQpbIDI3OCAwIDAgMCAwIDAgMCAwIDMzMyAzMzMgMCAwIDI3OCAzMzMg
Mjc4IDI3OCA1NTYgNTU2IDU1NiAwIDAgMCAwIDAgNTU2IDAgMCAwIDAgMCAwIDU1NiAwIDY2NyAw
IDcyMiA3MjIgNjY3IDYxMSAwIDcyMiAyNzggMCAwIDU1NiA4MzMgMCAwIDY2NyAwIDAgNjY3IDYx
MSA3MjIgNjY3IDk0NCAwIDAgMCAwIDAgMCAwIDU1NiAwIDU1NiAwIDUwMCAwIDU1NiAyNzggNTU2
IDU1NiAyMjIgMCA1MDAgMjIyIDgzMyA1NTYgNTU2IDU1NiAwIDMzMyA1MDAgMjc4IDU1NiAwIDcy
MiA1MDAgNTAwXSANCmVuZG9iag0KNDIgMCBvYmoNCjw8L1R5cGUvWFJlZi9TaXplIDQyL1dbIDEg
NCAyXSAvUm9vdCAxIDAgUi9JbmZvIDcgMCBSL0lEWzxGNUREMEM3MDdBRkNEOTREODlGMTZDNkQ2
MDhENjM5RT48RjVERDBDNzA3QUZDRDk0RDg5RjE2QzZENjA4RDYzOUU+XSAvRmlsdGVyL0ZsYXRl
RGVjb2RlL0xlbmd0aCAxMjI+Pg0Kc3RyZWFtDQp4nDXOyQ3CQAyF4TeBANmYCWu2HmiKDnLlyJFW
kCiCVqgjTPyDD/70ZFuyFGuaXOy1NPOAt+GeRvYx8rtRXI1yhJdRXaQk3gV10EMLv9kwb97+yUEC
C1hCCitYwwYyyKGAEirYgocANexgDwc4wgnO0MR3g5e+fG8LxA0KZW5kc3RyZWFtDQplbmRvYmoN
CnhyZWYNCjAgNDMNCjAwMDAwMDAwMTEgNjU1MzUgZg0KMDAwMDAwMDAxNyAwMDAwMCBuDQowMDAw
MDAwMTQwIDAwMDAwIG4NCjAwMDAwMDAxOTYgMDAwMDAgbg0KMDAwMDAwMDQyOSAwMDAwMCBuDQow
MDAwMDAyNTMzIDAwMDAwIG4NCjAwMDAwMDI2OTIgMDAwMDAgbg0KMDAwMDAwMjkxNiAwMDAwMCBu
DQowMDAwMDAzMTg3IDAwMDAwIG4NCjAwMDAwMDMyNDggMDAwMDAgbg0KMDAwMDAwMzM3NSAwMDAw
MCBuDQowMDAwMDAwMDEyIDY1NTM1IGYNCjAwMDAwMDAwMTMgNjU1MzUgZg0KMDAwMDAwMDAxNCA2
NTUzNSBmDQowMDAwMDAwMDE1IDY1NTM1IGYNCjAwMDAwMDAwMTYgNjU1MzUgZg0KMDAwMDAwMDAx
NyA2NTUzNSBmDQowMDAwMDAwMDE4IDY1NTM1IGYNCjAwMDAwMDAwMTkgNjU1MzUgZg0KMDAwMDAw
MDAyMCA2NTUzNSBmDQowMDAwMDAwMDIxIDY1NTM1IGYNCjAwMDAwMDAwMjIgNjU1MzUgZg0KMDAw
MDAwMDAyMyA2NTUzNSBmDQowMDAwMDAwMDI0IDY1NTM1IGYNCjAwMDAwMDAwMjUgNjU1MzUgZg0K
MDAwMDAwMDAyNiA2NTUzNSBmDQowMDAwMDAwMDI3IDY1NTM1IGYNCjAwMDAwMDAwMjggNjU1MzUg
Zg0KMDAwMDAwMDAyOSA2NTUzNSBmDQowMDAwMDAwMDMwIDY1NTM1IGYNCjAwMDAwMDAwMzEgNjU1
MzUgZg0KMDAwMDAwMDAzMiA2NTUzNSBmDQowMDAwMDAwMDMzIDY1NTM1IGYNCjAwMDAwMDAwMzQg
NjU1MzUgZg0KMDAwMDAwMDAzNSA2NTUzNSBmDQowMDAwMDAwMDM2IDY1NTM1IGYNCjAwMDAwMDAw
MzcgNjU1MzUgZg0KMDAwMDAwMDAzOCA2NTUzNSBmDQowMDAwMDAwMDM5IDY1NTM1IGYNCjAwMDAw
MDAwNDAgNjU1MzUgZg0KMDAwMDAwMDAwMCA2NTUzNSBmDQowMDAwMDA0MTExIDAwMDAwIG4NCjAw
MDAwMDQ0MTAgMDAwMDAgbg0KdHJhaWxlcg0KPDwvU2l6ZSA0My9Sb290IDEgMCBSL0luZm8gNyAw
IFIvSURbPEY1REQwQzcwN0FGQ0Q5NEQ4OUYxNkM2RDYwOEQ2MzlFPjxGNUREMEM3MDdBRkNEOTRE
ODlGMTZDNkQ2MDhENjM5RT5dID4+DQpzdGFydHhyZWYNCjQ3MzINCiUlRU9GDQp4cmVmDQowIDAN
CnRyYWlsZXINCjw8L1NpemUgNDMvUm9vdCAxIDAgUi9JbmZvIDcgMCBSL0lEWzxGNUREMEM3MDdB
RkNEOTREODlGMTZDNkQ2MDhENjM5RT48RjVERDBDNzA3QUZDRDk0RDg5RjE2QzZENjA4RDYzOUU+
XSAvUHJldiA0NzMyL1hSZWZTdG0gNDQxMD4+DQpzdGFydHhyZWYNCjU3NDcNCiUlRU9G

--_002_FC2FB65B4D919844ADE4BE3C2BB739AD70ABDD61shsmsx501ccrcor_--
