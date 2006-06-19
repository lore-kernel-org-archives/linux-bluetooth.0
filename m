Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606182250k5370c838g3ea9dcc6a0d0ebcf@mail.gmail.com>
Date: Mon, 19 Jun 2006 11:20:29 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <167599168834.168834167599@fh-wolfenbuettel.de>
MIME-Version: 1.0
References: <167599168834.168834167599@fh-wolfenbuettel.de>
Subject: Re: [Bluez-devel] sending SAP messages on rfcomm?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0343034486=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0343034486==
Content-Type: multipart/alternative;
	boundary="----=_Part_55758_18283174.1150696229679"

------=_Part_55758_18283174.1150696229679
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi *G=F6tz,*

On 6/16/06, G=F6tz Issel <g.issel@fh-wolfenbuettel.de> wrote:
>
> Hi,
> I am still trying to get the remote SimAccessProfile SAP to work. I habe
> a BT scanner too now, showing me all in detail down to single bits and I
> saw that my sent messages are not being sent.
>
> This is what I have done:
>
> --> search for devices that offer SAP service (standard sdp search and
> filter out "the good ones")
>
> --> pairing with the SIM-Server mobile phone using 16 digits pin as
> required, works fine
>
> --> connect to the phone via rfcomm on the channel given by sdp search
> before (i.e. nokia 6810 needs #4, siemens s65 wants #6 etc) and here the
> phone asks again for allowance to access the SIM. Good sign so far.
>     ...
>    // allocate a socket
>    rfcomm_sock =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>
>    // set the connection parameters (who to connect to)
>    addr.rc_family =3D AF_BLUETOOTH;
>    addr.rc_channel =3D (uint8_t) dest_channel;  // dest_channel depends
> on mobile phone
>
>    str2ba( dest, &addr.rc_bdaddr );  // dest is the string of the
> bdaddr of mobile phone
>
>        printf("\r\nrfcomm connect to %s on channel %i",dest,dest_channel)=
;
>        fflush(stdout);
>
>    // connect to server
>    status =3D connect(rfcomm_sock, (struct sockaddr *)&addr, sizeof(addr)=
);
>    ...
>
> --> now sending the 1st sap message "CONNECT_REQ" like this (bad style,
> i know, only testing)
>
> int send_connect_req(int sock)
> {
>    int status;
>    unsigned char message[12] =3D {};
>
>    message [0]  =3D 0x00; // message ID, here connection req
>    message [1]  =3D 0x01; // number of parameters
>    message [2]  =3D 0x00; // reserved
>    message [3]  =3D 0x00; // reserved
>    message [4]  =3D 0x00; // parameter ID, here MaxMsgSize
>    message [5]  =3D 0x00; // reserved
>    message [6]  =3D 0x00; // parameter length high byte
>    message [7]  =3D 0x02; // parameter length low byte
>    message [8]  =3D 0x01; // parameter value high byte
>    message [9]  =3D 0x18; // parameter value low byte
>    message [10] =3D 0x00; // padding byte
>    message [11] =3D 0x00; // padding byte
>
>    status =3D write(sock, &message, sizeof(message));
>    return status;
> }
>
>
> --> using hcidump shows, that the essage is sent in some way,look at end
> of  http://sap.goetzi.de/hci_dump_sap_1st_msg.txt
>
> I have the feeling i am missing something. Any suggestions? Is "write()"
> the correct way? Do I have to define a new type of packet somewhere
> first? I amlost and my deadline for handing in my project at uni is
> coming closer. Any help appreciated, please.


In fact, a few days ago, I was also trying to do the same experiment.
I think that you are doing it correctly, i.e the sap connection request
looks ok to me.
Try changing the maxmasg size parameter of the request to something else.
So what happens after you send the connect req?
Don't you get any response back from the phone?


Regards,
Mayank

------=_Part_55758_18283174.1150696229679
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi <strong>G=F6tz,</strong></div>
<div>&nbsp;</div>
<div><span class=3D"gmail_quote">On 6/16/06, <b class=3D"gmail_sendername">=
G=F6tz Issel</b> &lt;<a href=3D"mailto:g.issel@fh-wolfenbuettel.de">g.issel=
@fh-wolfenbuettel.de</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br>I am still trying to get =
the remote SimAccessProfile SAP to work. I habe<br>a BT scanner too now, sh=
owing me all in detail down to single bits and I
<br>saw that my sent messages are not being sent.<br><br>This is what I hav=
e done:<br><br>--&gt; search for devices that offer SAP service (standard s=
dp search and<br>filter out &quot;the good ones&quot;)<br><br>--&gt; pairin=
g with the SIM-Server mobile phone using 16 digits pin as
<br>required, works fine<br><br>--&gt; connect to the phone via rfcomm on t=
he channel given by sdp search<br>before (i.e. nokia 6810 needs #4, siemens=
 s65 wants #6 etc) and here the<br>phone asks again for allowance to access=
 the SIM. Good sign so far.
<br>&nbsp;&nbsp;&nbsp;&nbsp;...<br>&nbsp;&nbsp; // allocate a socket<br>&nb=
sp;&nbsp; rfcomm_sock =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)=
;<br><br>&nbsp;&nbsp; // set the connection parameters (who to connect to)<=
br>&nbsp;&nbsp; addr.rc_family =3D AF_BLUETOOTH;<br>&nbsp;&nbsp; addr.rc_ch=
annel
 =3D (uint8_t) dest_channel;&nbsp;&nbsp;// dest_channel depends<br>on mobil=
e phone<br><br>&nbsp;&nbsp; str2ba( dest, &amp;addr.rc_bdaddr );&nbsp;&nbsp=
;// dest is the string of the<br>bdaddr of mobile phone<br><br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;\r\nrfcomm connect to %s on channel %=
i&quot;,dest,dest_channel);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fflush(stdout);<br><br>&nbsp;&nbsp=
; // connect to server<br>&nbsp;&nbsp; status =3D connect(rfcomm_sock, (str=
uct sockaddr *)&amp;addr, sizeof(addr));<br>&nbsp;&nbsp; ...<br><br>--&gt; =
now sending the 1st sap message &quot;CONNECT_REQ&quot; like this (bad styl=
e,
<br>i know, only testing)<br><br>int send_connect_req(int sock)<br>{<br>&nb=
sp;&nbsp; int status;<br>&nbsp;&nbsp; unsigned char message[12] =3D {};<br>=
<br>&nbsp;&nbsp; message [0]&nbsp;&nbsp;=3D 0x00; // message ID, here conne=
ction req<br>&nbsp;&nbsp; message [1]&nbsp;&nbsp;=3D 0x01; // number of par=
ameters
<br>&nbsp;&nbsp; message [2]&nbsp;&nbsp;=3D 0x00; // reserved<br>&nbsp;&nbs=
p; message [3]&nbsp;&nbsp;=3D 0x00; // reserved<br>&nbsp;&nbsp; message [4]=
&nbsp;&nbsp;=3D 0x00; // parameter ID, here MaxMsgSize<br>&nbsp;&nbsp; mess=
age [5]&nbsp;&nbsp;=3D 0x00; // reserved<br>&nbsp;&nbsp; message [6]&nbsp;&=
nbsp;=3D 0x00; // parameter length high byte
<br>&nbsp;&nbsp; message [7]&nbsp;&nbsp;=3D 0x02; // parameter length low b=
yte<br>&nbsp;&nbsp; message [8]&nbsp;&nbsp;=3D 0x01; // parameter value hig=
h byte<br>&nbsp;&nbsp; message [9]&nbsp;&nbsp;=3D 0x18; // parameter value =
low byte <br>&nbsp;&nbsp; message [10] =3D 0x00; // padding byte<br>&nbsp;&=
nbsp; message [11] =3D 0x00; // padding byte
<br><br>&nbsp;&nbsp; status =3D write(sock, &amp;message, sizeof(message));=
<br>&nbsp;&nbsp; return status;<br>}<br><br><br>--&gt; using hcidump shows,=
 that the essage is sent in some way,look at end<br>of&nbsp;&nbsp;<a href=
=3D"http://sap.goetzi.de/hci_dump_sap_1st_msg.txt">
http://sap.goetzi.de/hci_dump_sap_1st_msg.txt</a><br><br>I have the feeling=
 i am missing something. Any suggestions? Is &quot;write()&quot;<br>the cor=
rect way? Do I have to define a new type of packet somewhere<br>first? I am=
lost and my deadline for handing in my project at uni is
<br>coming closer. Any help appreciated, please.</blockquote>
<div>&nbsp;</div>
<div>In fact, a few days ago, I was also trying to do the same experiment.<=
/div>
<div>I think that you are doing it correctly, i.e the sap connection reques=
t looks ok to me.</div>
<div>Try changing the maxmasg size parameter of the request to something el=
se.</div>
<div>So what happens after you send the connect req?</div>
<div>Don't you get any response back from the phone?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div><br>&nbsp;</div>

------=_Part_55758_18283174.1150696229679--


--===============0343034486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0343034486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0343034486==--
