Return-Path: <cyrus@holtmann.org>
From: "Ge, Ethan" <ethan.ge@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>, "jpawlowski@google.com"
	<jpawlowski@google.com>, "mansito@chromium.org" <mansito@chromium.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Can't update remote name in function of "hci_check_pending_name"
 because of discov->state == DISCOVERY_STOPPED
Date: Mon, 11 May 2015 16:04:58 +0000
Message-ID: <86D221DC0B85F94D9B05B97827669A3403C482C6@PGSMSX106.gar.corp.intel.com>
Content-Type: multipart/alternative;
	boundary="_000_86D221DC0B85F94D9B05B97827669A3403C482C6PGSMSX106garcor_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_86D221DC0B85F94D9B05B97827669A3403C482C6PGSMSX106garcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We found this issue in Chromebook with kernel 3.14. From btmon, Stack recei=
ved event of Remote Name Req Complete with Device name "Name: VGP-BMS21", b=
ut it's after @ Discovering: 0x00 (7).

It means le_scan_disable_work_complete set discover status to STOPPED for s=
tarting new discovery which caused hci_check_pending_name return without up=
date the name information because discovery status is STOPPED. Then user sp=
ace will always get null name, even hci_remote_name_evt shows everything is=
 correct at HCI layer.

Is it possible setting LE Set Scan Enable to disable after Remote Name Req =
Complete? Or adding condition for hci_discovery_set_state(hdev, DISCOVERY_S=
TOPPED) in function of le_scan_disable_work_complete?


static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
                                                       u16 opcode)
{
           /* General inquiry access code (GIAC) */
           u8 lap[3] =3D { 0x33, 0x8b, 0x9e };
           struct hci_cp_inquiry cp;
           int err;

           if (status) {
                     BT_ERR("Failed to disable LE scanning: status %d", sta=
tus);
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
                                           hci_discovery_set_state(hdev,
                                                                           =
DISCOVERY_STOPPED);


static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *c=
onn,
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



@ Discovering: 0x01 (7)

...
....
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

--_000_86D221DC0B85F94D9B05B97827669A3403C482C6PGSMSX106garcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:MingLiU;
	panose-1:2 2 5 9 0 0 0 0 0 0;}
@font-face
	{font-family:MingLiU;
	panose-1:2 2 5 9 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:MingLiU;
	panose-1:2 2 5 9 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:MingLiU;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:MingLiU;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-TW" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt;color:#222222">Hi,<o:p></o:p></span></p>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#222222;ba=
ckground:white">We found this issue in Chromebook with&nbsp;kernel 3.14. Fr=
om btmon, </span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family=
:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Stack received eve=
nt of </span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:#222222">Remote Name Req Comp=
lete with Device name &#8220;Name: VGP-BMS21&#8221;</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-se=
rif&quot;;color:black">, but it&#8217;s after </span><span lang=3D"EN-US" s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&q=
uot;;color:#222222">@ Discovering: 0x00 (7).</span><span lang=3D"EN-US" sty=
le=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quo=
t;"><o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#222222">I=
t means </span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">le_scan_disable_work=
_complete set discover status to STOPPED for starting new discovery which c=
aused hci_check_pending_name return without update the name information bec=
ause discovery status is STOPPED. Then user space will always get null name=
, even hci_remote_name_evt shows everything is correct at HCI layer. <o:p><=
/o:p></span></pre>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">Is it possible setting LE Set Scan Enable to disable after Remote=
 Name Req Complete? Or adding condition for hci_discovery_set_state(hdev, D=
ISCOVERY_STOPPED) in function of le_scan_disable_work_complete?<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">static void le_scan_disable_work_complete(struct hci_dev *hdev, u=
8 status,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &nbsp; u16 opcode)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">{<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* G=
eneral inquiry access code (GIAC) */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 l=
ap[3] =3D { 0x33, 0x8b, 0x9e };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct hci_cp_inquiry cp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
err;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
status) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;Failed=
 to disable LE scanning: status %d&quot;, status);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdev=
-&gt;discovery.scan_start =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swit=
ch (hdev-&gt;discovery.type) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 DISCOV_TYPE_LE:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_dev_lock(hdev);=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_discovery_set_s=
tate(hdev, DISCOVERY_STOPPED);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_dev_unlock(hdev=
);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 DISCOV_TYPE_INTERLEAVED:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_dev_lock(hdev);=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_bit(HCI_QU=
IRK_SIMULTANEOUS_DISCOVERY,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &am=
p;hdev-&gt;quirks)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If we were running LE onl=
y scan, change discovery<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * state. If we were running =
both LE and BR/EDR inquiry<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * simultaneously, and BR/EDR=
 inquiry is already<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * finished, stop discovery, =
otherwise BR/EDR inquiry<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will stop discovery when f=
inished.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(HCI_INQUIRY, &=
amp;hdev-&gt;flags))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_discovery_set_state(hdev,<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DISCOVERY_STOPPED);<br>
<br>
<br>
static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *c=
onn,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp; bdaddr_t *bdaddr, u8 *name, u8 name_len)<br>
{<br>
&nbsp;&nbsp;&nbsp; struct discovery_state *discov =3D &amp;hdev-&gt;discove=
ry;<br>
&nbsp;&nbsp;&nbsp; struct inquiry_entry *e;<br>
<br>
&nbsp;&nbsp;&nbsp; /* Update the mgmt connected state if necessary. Be care=
ful with<br>
&nbsp;&nbsp;&nbsp; &nbsp;* conn objects that exist but are not (yet) connec=
ted however.<br>
&nbsp;&nbsp;&nbsp; &nbsp;* Only those in BT_CONFIG or BT_CONNECTED states c=
an be<br>
&nbsp;&nbsp;&nbsp; &nbsp;* considered connected.<br>
&nbsp;&nbsp;&nbsp; &nbsp;*/<br>
&nbsp;&nbsp;&nbsp; if (conn &amp;&amp;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (conn-&gt;state =3D=3D BT_CONFIG || c=
onn-&gt;state =3D=3D BT_CONNECTED) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; !test_and_set_bit(HCI_CONN_MGMT_CONNE=
CTED, &amp;conn-&gt;flags))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mgmt_device_connected(hdev, conn, 0, =
name, name_len);<br>
<br>
&nbsp;&nbsp;&nbsp; if (discov-&gt;state =3D=3D DISCOVERY_STOPPED)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>
<br>
<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:14.0pt;color:#222222">@ Disc=
overing: 0x01 (7)</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;colo=
r:#222222">&nbsp;&nbsp;<br>
<br>
...<br>
.... &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 39.027238<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<br>
&lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; [hci0] 39.027342<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address: 90:7F:61:0F:24:41 (OUI =
90-7F-61)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Page scan repetition mode: R1 (0=
x01)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Page scan mode: Mandatory (0x00)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Clock offset: 0x7774<br>
&gt; HCI Event: Command Status (0x0f) plen 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; [hci0] 39.028072<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) ncmd 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<br>
&lt; HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [hci0] 39.060051<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Scanning: Disabled (0x00)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter duplicates: Disabled (0x0=
0)<br>
&gt; HCI Event: Command Complete (0x0e) plen 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 39.062071<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE Set Scan Enable (0x08|0x000c) ncmd 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:14.0pt;color:#222222">@ Disc=
overing: 0x00 (7)</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;colo=
r:#222222"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;color=
:#222222"><br>
&gt; HCI Event: Remote Host Supported Features (0x3d) plen 14&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 39.536284<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address: 90:7F:61:0F:24:41 (OUI =
90-7F-61)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0x00 0x00 0x00 0x00 0x=
00 0x00 0x00 0x00<br>
</span><span lang=3D"EN-US" style=3D"font-size:14.0pt;color:#222222">&gt; H=
CI Event: Remote Name Req Complete (0x07) plen 255&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [hci0] 39.628124<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address: 90:7F:61:0F:24:41 (OUI =
90-7F-61)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: VGP-BMS21</span><span lang=
=3D"EN-US" style=3D"font-size:11.0pt;color:#222222"><br>
&lt; HCI Command: LE Set Random Address (0x08|0x0005) plen 6&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; [hci0] 44.786231<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address: 24:AF:E7:B5:2D:00 (Non-=
Resolvable)<br>
&gt; HCI Event: Command Complete (0x0e) plen 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 44.946206<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE Set Random Address (0x08|0x0005) ncmd 1<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<br>
&lt; HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 44.946270<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Active (0x01)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interval: 22.500 msec (0x0024)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Window: 11.250 msec (0x0012)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Own address type: Random (0x01)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter policy: Accept all advert=
isement (0x00)<br>
&gt; HCI Event: Command Complete (0x0e) plen 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 44.947201<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE Set Scan Parameters (0x08|0x000b) ncmd 1<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<br>
&lt; HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [hci0] 44.947296<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Scanning: Enabled (0x01)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter duplicates: Enabled (0x01=
)<br>
&gt; HCI Event: Command Complete (0x0e) plen 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 44.948203<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE Set Scan Enable (0x08|0x000c) ncmd 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [hci0] 44.948266<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Access code: 0x9e8b33 (General I=
nquiry)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Length: 10.24s (0x08)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Num responses: 0<br>
&gt; HCI Event: Command Status (0x0f) plen 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; [hci0] 44.949207<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Inquiry (0x01|0x0001) ncmd 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Success (0x00)<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Rega=
rds,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Etha=
n<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_86D221DC0B85F94D9B05B97827669A3403C482C6PGSMSX106garcor_--
