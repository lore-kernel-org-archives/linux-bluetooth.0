Return-Path: <cyrus@holtmann.org>
From: <james.steele@accenture.com>
To: <marcel@holtmann.org>, <Andrei.Emeltchenko.news@gmail.com>
CC: <pkrystad@codeaurora.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 3/3] Bluetooth: Add AMP initialization
Date: Mon, 21 Nov 2011 16:23:15 +0000
Message-ID: <81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE@048-CH1MPN1-102.048d.mgd.msft.net>
Content-Type: multipart/alternative;
	boundary="_000_81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE048CH1MPN110204_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE048CH1MPN110204_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel, Andrei,

>> > > > However since we are talking about controller init. Can someone pl=
ease
>> > > > first propose a list of how we init AMP vs BR/EDR/LE controllers i=
nstead
>> > > > of just dumping code here. I think it needs some clear strategy on=
 how
>> > > > to do it.
>> > >
>> > > AMP controller is initialized following way in Code Aurora code:
>> > >
>> > > Common part:
>> > >
>> > > <------8<--------------------------------------------------
>> > > |  /* Mandatory initialization */
>> > > |
>> > > |  /* Reset */
>> > > |  if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
>> > > |          set_bit(HCI_RESET, &hdev->flags);
>> > > |          hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
>> > > |  }
>> >
>> > this check for QUIRK_NO_RESET is pointless. That is just there for old
>> > Bluetooth 1.0b controllers. Or broken hardware. Let's assume the AMP
>> > controllers are fine and just issue OP_RESET.
>> >
>> > > |  /* Read Local Version */
>> > > |  hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
>> > > |
>> > > |  /* Read HCI Flow Control Mode */
>> > > |  hci_send_cmd(hdev, HCI_OP_READ_FLOW_CONTROL_MODE, 0, NULL);
>> > > |
>> > > |  /* Read Buffer Size (ACL mtu, max pkt, etc.) */
>> > > |  hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
>> > > |
>> > > |  /* Read Data Block Size (ACL mtu, max pkt, etc.) */
>> > > |  hci_send_cmd(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
>> > > <------8<------------------------------------------------------
>> >
>> > This is not a generic sequence. We will not be reading flow control or
>> > data block size commands. It will heavily fail on older controllers.
>>
>> What about following code (basically BR/EDR initialization is the same a=
s
>> now and only amp_init is new). I use now virtual AMP device so any init =
is
>> good, I need Read Version and Read AMP info commands.
>>
>> static void bredr_init(struct hci_dev *hdev)
>> {
>>       struct hci_cp_delete_stored_link_key cp;
>>       __le16 param;
>>       __u8 flt_type;
>>
>>       /* Mandatory initialization */
>>       /* Reset */
>>       if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
>>               set_bit(HCI_RESET, &hdev->flags);
>>               hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
>>       }
>>
>>       /* Read Local Supported Features */
>>       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
>>
>>       /* Read Local Version */
>>       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
>>
>>       /* Read Buffer Size (ACL mtu, max pkt, etc.) */
>>       hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
>>
>>       /* Read BD Address */
>>       hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
>>
>>       /* Read Class of Device */
>>       hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
>>
>>       /* Read Local Name */
>>       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
>>
>>       /* Read Voice Setting */
>>       hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
>>
>>       /* Optional initialization */
>>       /* Clear Event Filters */
>>       flt_type =3D HCI_FLT_CLEAR_ALL;
>>       hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
>>
>>       /* Connection accept timeout ~20 secs */
>>       param =3D cpu_to_le16(0x7d00);
>>       hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
>>
>>       bacpy(&cp.bdaddr, BDADDR_ANY);
>>       cp.delete_all =3D 1;
>>       hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp)=
;
>> }
>>
>> static void amp_init(struct hci_dev *hdev)
>> {
>>       /* Mandatory initialization */
>>       /* Reset */
>>       hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
>>
>>       /* Read Local Version */
>>       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
>>
>>       /* Read Buffer Size (ACL mtu, max pkt, etc.) */
>>       hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
>>
>>       /* Read AMP Info */
>>       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
>> }
>
> actually I think the READ_AMP_INFO is wrong here. It should be only
> executed based on an AMP_Get_Info_Request during a connection setup
> procedure.

You can read the AMP info over HCI upon receiving a request by A2MP, but th=
ere are reasons to issue the READ_AMP_INFO command in advance.  For example=
, you need the Controller_Type for responding to the AMP_Discover_Request. =
 Also you may (tenuously) want the know the Max_PDU_Size in advance for sel=
ecting SDU sizes (w.r.t. segmentation).

Certainly READ_AMP_INFO is a command intended to be issued during controlle=
r initialization, the majority of the values should not change during the l=
ifetime of the controller, and only once that command has been issued will =
the Controller commence sending AMP_Status_Change_Events to communicate cha=
nges in status.  At a minimum READ_AMP_INFO must be issued for each AMP_Dis=
cover_Request (and AMP_Get_Info_Request) received; but if AMP discovery is =
slower, then transitioning a channel to an AMP link will be slower.

>
> And even the READ_BUFFER_SIZE is the wrong command since by default the
> AMP controller is in block based flow control mode. So you would need to
> read the flow control mode first actually.

Correct, although reading the flow control mode on an AMP controller after =
a HCI_Reset *should* always return "data block mode" (as that is the defaul=
t).  The READ_BUFFER_SIZE should only be used if HCI_Write_Flow_Control_Mod=
e has been issued first (and successfully enabled packet based flow control=
).  Instead I believe we should issue the HCI_Read_Data_Block_Size command,=
 where the correct information is then provided for the host stack (with it=
s "new" data block flow control model for AMP controllers).  I don't think =
there is any requirement forcing an AMP controller to implement packet base=
d flow control, so if there is no data block flow control model in the host=
 yet then initialization has to be prepared to fail upon trying to configur=
e packet based flow control mode.

Also for AMP Controller initialization, the HCI_Set_Event_Mask_Page_2 comma=
nd should be issued to ensure the AMP related events are provided by the co=
ntroller (by default they are turned off).  A suitable HCI_Set_Event_Mask c=
ommand may also be needed if using enhanced flush on the AMP controller.  E=
vent filters also apply to AMP controllers IIRC, so if following the BR/EDR=
 example you may want to clear them too (although I imagine such initializa=
tion could be added when required).

Regards,
James


________________________________
Subject to local law, communications with Accenture and its affiliates incl=
uding telephone calls and emails (including content), may be monitored by o=
ur systems for the purposes of security and the assessment of internal comp=
liance with Accenture policy.
___________________________________________________________________________=
___________

www.accenture.com

--_000_81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE048CH1MPN110204_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif"}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
span.EmailStyle17
	{font-family:"Calibri","sans-serif";
	color:windowtext}
.MsoChpDefault
	{}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.WordSection1
	{}
-->
</style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Marcel, Andrei,</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; &gt; However since we are talking=
 about controller init. Can someone please</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; &gt; first propose a list of how =
we init AMP vs BR/EDR/LE controllers instead</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; &gt; of just dumping code here. I=
 think it needs some clear strategy on how</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; &gt; to do it.</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt;</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; AMP controller is initialized fol=
lowing way in Code Aurora code:</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt;</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; Common part:</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt;</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; &lt;------8&lt;------------------=
--------------------------------</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;/* Mandatory initializati=
on */</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; |</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;/* Reset */</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;if (!test_bit(HCI_QUIRK_N=
O_RESET, &amp;hdev-&gt;quirks)) {</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;set_bit(HCI_RESET, &amp;hdev-&gt;flags);</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;}</p>
<p class=3D"MsoNormal">&gt;&gt; &gt;</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; this check for QUIRK_NO_RESET is point=
less. That is just there for old</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; Bluetooth 1.0b controllers. Or broken =
hardware. Let's assume the AMP</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; controllers are fine and just issue OP=
_RESET.</p>
<p class=3D"MsoNormal">&gt;&gt; &gt;</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;/* Read Local Version */<=
/p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;hci_send_cmd(hdev, HCI_OP=
_READ_LOCAL_VERSION, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; |</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;/* Read HCI Flow Control =
Mode */</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;hci_send_cmd(hdev, HCI_OP=
_READ_FLOW_CONTROL_MODE, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; |</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;/* Read Buffer Size (ACL =
mtu, max pkt, etc.) */</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;hci_send_cmd(hdev, HCI_OP=
_READ_BUFFER_SIZE, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; |</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;/* Read Data Block Size (=
ACL mtu, max pkt, etc.) */</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; | &nbsp;hci_send_cmd(hdev, HCI_OP=
_READ_DATA_BLOCK_SIZE, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; &gt; &lt;------8&lt;------------------=
------------------------------------</p>
<p class=3D"MsoNormal">&gt;&gt; &gt;</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; This is not a generic sequence. We wil=
l not be reading flow control or</p>
<p class=3D"MsoNormal">&gt;&gt; &gt; data block size commands. It will heav=
ily fail on older controllers.</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; What about following code (basically BR/EDR=
 initialization is the same as</p>
<p class=3D"MsoNormal">&gt;&gt; now and only amp_init is new). I use now vi=
rtual AMP device so any init is</p>
<p class=3D"MsoNormal">&gt;&gt; good, I need Read Version and Read AMP info=
 commands.</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; static void bredr_init(struct hci_dev *hdev=
)</p>
<p class=3D"MsoNormal">&gt;&gt; {</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; struct hci_cp_delete_s=
tored_link_key cp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; __le16 param;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; __u8 flt_type;</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Mandatory initializ=
ation */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Reset */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; if (!test_bit(HCI_QUIR=
K_NO_RESET, &amp;hdev-&gt;quirks)) {</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; set_bit(HCI_RESET, &amp;hdev-&gt;flags);</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; }</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Local Supporte=
d Features */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_LOCAL_FEATURES, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Local Version =
*/</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_LOCAL_VERSION, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Buffer Size (A=
CL mtu, max pkt, etc.) */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_BUFFER_SIZE, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read BD Address */<=
/p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_BD_ADDR, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Class of Devic=
e */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_CLASS_OF_DEV, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Local Name */<=
/p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_LOCAL_NAME, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Voice Setting =
*/</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_VOICE_SETTING, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Optional initializa=
tion */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Clear Event Filters=
 */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; flt_type =3D HCI_FLT_C=
LEAR_ALL;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_SET_EVENT_FLT, 1, &amp;flt_type);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Connection accept t=
imeout ~20 secs */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; param =3D cpu_to_le16(=
0x7d00);</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_WRITE_CA_TIMEOUT, 2, &amp;param);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; bacpy(&amp;cp.bdaddr, =
BDADDR_ANY);</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; cp.delete_all =3D 1;</=
p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &amp;cp);</p>
<p class=3D"MsoNormal">&gt;&gt; }</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; static void amp_init(struct hci_dev *hdev)<=
/p>
<p class=3D"MsoNormal">&gt;&gt; {</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Mandatory initializ=
ation */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Reset */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_RESET, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Local Version =
*/</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_LOCAL_VERSION, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read Buffer Size (A=
CL mtu, max pkt, etc.) */</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_BUFFER_SIZE, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; /* Read AMP Info */</p=
>
<p class=3D"MsoNormal">&gt;&gt; &nbsp; &nbsp; &nbsp; hci_send_cmd(hdev, HCI=
_OP_READ_LOCAL_AMP_INFO, 0, NULL);</p>
<p class=3D"MsoNormal">&gt;&gt; }</p>
<p class=3D"MsoNormal">&gt;&nbsp;</p>
<p class=3D"MsoNormal">&gt; actually I think the READ_AMP_INFO is wrong her=
e. It should be only</p>
<p class=3D"MsoNormal">&gt; executed based on an AMP_Get_Info_Request durin=
g a connection setup</p>
<p class=3D"MsoNormal">&gt; procedure.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">You can read the AMP info over HCI upon receiving a =
request by A2MP, but there are reasons to issue the READ_AMP_INFO command i=
n advance.&nbsp; For example, you need the Controller_Type for responding t=
o the AMP_Discover_Request.&nbsp; Also you may
 (tenuously) want the know the Max_PDU_Size in advance for selecting SDU si=
zes (w.r.t. segmentation).</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Certainly READ_AMP_INFO is a command intended to be =
issued during controller initialization, the majority of the values should =
not change during the lifetime of the controller, and only once that comman=
d has been issued will the Controller
 commence sending AMP_Status_Change_Events to communicate changes in status=
.&nbsp; At a minimum READ_AMP_INFO must be issued for each AMP_Discover_Req=
uest (and AMP_Get_Info_Request) received; but if AMP discovery is slower, t=
hen transitioning a channel to an AMP
 link will be slower.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">&gt; </p>
<p class=3D"MsoNormal">&gt; And even the READ_BUFFER_SIZE is the wrong comm=
and since by default the</p>
<p class=3D"MsoNormal">&gt; AMP controller is in block based flow control m=
ode. So you would need to</p>
<p class=3D"MsoNormal">&gt; read the flow control mode first actually.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Correct, although reading the flow control mode on a=
n AMP controller after a HCI_Reset *<b>should</b>* always return &#8220;dat=
a block mode&#8221; (as that is the default).&nbsp; The READ_BUFFER_SIZE sh=
ould only be used if HCI_Write_Flow_Control_Mode has
 been issued first (and successfully enabled packet based flow control).&nb=
sp; Instead I believe we should issue the HCI_Read_Data_Block_Size command,=
 where the correct information is then provided for the host stack (with it=
s &quot;new&quot; data block flow control model
 for AMP controllers).&nbsp; I don&#8217;t think there is any requirement f=
orcing an AMP controller to implement packet based flow control, so if ther=
e is no data block flow control model in the host yet then initialization h=
as to be prepared to fail upon trying to configure
 packet based flow control mode.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Also for AMP Controller initialization, the HCI_Set_=
Event_Mask_Page_2 command should be issued to ensure the AMP related events=
 are provided by the controller (by default they are turned off).&nbsp; A s=
uitable HCI_Set_Event_Mask command may
 also be needed if using enhanced flush on the AMP controller.&nbsp; Event =
filters also apply to AMP controllers IIRC, so if following the BR/EDR exam=
ple you may want to clear them too (although I imagine such initialization =
could be added when required).</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Regards,</p>
<p class=3D"MsoNormal">James</p>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"2">Subject to local law, commun=
ications with Accenture and its affiliates including telephone calls and em=
ails (including content), may be monitored by our systems for the purposes =
of security and the assessment of internal
 compliance with Accenture policy.<br>
___________________________________________________________________________=
___________<br>
<br>
www.accenture.com<br>
</font>
</body>
</html>

--_000_81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE048CH1MPN110204_--
