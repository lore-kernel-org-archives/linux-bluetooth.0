Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001c01c41380$83c390b0$fcca010a@lysydziadek>
From: "zubiwat" <zubiwat@poczta.onet.pl>
To: "devel Bluetooth" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0019_01C41388.E4907950"
Subject: [Bluez-devel] BT not responding
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Mar 2004 23:20:14 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0019_01C41388.E4907950
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi
Why my BT device isn't responding when I'm sending any commands for =
example to read BT_ADDR like this: 0x01 0x00 0x09.
It doesn't respond to me, even with an error code - nothing.
But when I use first code from blueZ hciconfig like this

 int  clen =3D 0, i;                /* Command len */
 static int csr_seq =3D 0;     /* Sequence number of command */
 int  divisor;

         /* Try to read the build ID of the CSR chip */
 clen =3D 5 + (5 + 6) * 2;
         /* HCI header */
 cmd[0] =3D HCI_COMMAND_PKT;
 cmd[1] =3D 0x09;  /* CSR command */
 cmd[2] =3D 0xfc;  /* MANUFACTURER_SPEC */
 cmd[3] =3D 1 + (5 + 6) * 2; /* len */
         /* CSR MSG header */
 cmd[4] =3D 0xC2;  /* first+last+channel=3DBCC */
         /* CSR BCC header */
 cmd[5] =3D 0x00;  /* type =3D GET-REQ */
 cmd[6] =3D 0x00;  /* - msB */
 cmd[7] =3D 5 + 4;  /* len */
 cmd[8] =3D 0x00;  /* - msB */
 cmd[9] =3D csr_seq & 0xFF;/* seq num */
 cmd[10] =3D (csr_seq >> 8) & 0xFF; /* - msB */
 csr_seq++;
 cmd[11] =3D 0x19;  /* var_id =3D CSR_CMD_BUILD_ID */
 cmd[12] =3D 0x28;  /* - msB */
 cmd[13] =3D 0x00;  /* status =3D STATUS_OK */
 cmd[14] =3D 0x00;  /* - msB */
         /* CSR BCC payload */
 memset(cmd + 15, 0, 6 * 2);

  do{
    for (i=3D0; i < clen+1; i++) PutByteU0 (cmd[i]);

    read_hci_event(resp,100);

  }while (resp[1] !=3D 0xff);


         /* Try to read the current speed of the CSR chip */
 clen =3D 5 + (5 + 4)*2;
         /* -- HCI header */
 cmd[0] =3D HCI_COMMAND_PKT;
 cmd[1] =3D 0x09;  /* CSR command */
 cmd[2] =3D 0xfc;  /* MANUFACTURER_SPEC */
 cmd[3] =3D 1 + (5 + 4)*2; /* len */
         /* -- CSR BCC header -- */
 cmd[9] =3D csr_seq & 0xFF; /* seq num */
 cmd[10] =3D (csr_seq >> 8) & 0xFF; /* - msB */
 csr_seq++;
 cmd[11] =3D 0x02;  /* var_id =3D CONFIG_UART */
 cmd[12] =3D 0x68;  /* - msB */

         /* Now, create the command that will set the UART speed */
         /* CSR BCC header */
 cmd[5] =3D 0x02;   /* type =3D SET-REQ */
 cmd[6] =3D 0x00;   /* - msB */
 cmd[9] =3D csr_seq & 0xFF; /* seq num */
 cmd[10] =3D (csr_seq >> 8) & 0xFF;/* - msB */
 csr_seq++;

 divisor =3D (921600*64+7812)/15625;

        /* No parity, one stop bit -> divisor |=3D 0x0000; */
 cmd[15] =3D (divisor) & 0xFF;  /* divider */
 cmd[16] =3D (divisor >> 8) & 0xFF; /* - msB */
             /* The rest of the payload will be 0x00 */

    for (i=3D0; i < clen; i++) PutByteU0 (cmd[i]);

It answers like this: 04 FF 13 C2 01 00 09 00 02 00 02 68 00 00 BF 0E 00 =
00 00 00=20
What is it? Is it kind of special bits of csr chip or what?
I know it is event but after this BT responds only for bad commands like =
this 04 10 01 fe  but when I try read BT_ADDR it's quiet.
What this code is up to?=20
Please send me UART specification or sth where it's written how to set =
this up and howto communicate with csr chip. It's very important for me =
!
I spent almost 2 weeks to find out how to communicate whit it and =
nothing works good. I don't know where to find some info. I looked =
almost everywhere?

Regards

Maciej

Maciej Zubilewicz

------=_NextPart_000_0019_01C41388.E4907950
Content-Type: text/html;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-2">
<META content=3D"MSHTML 5.50.4134.600" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Why my BT device isn't responding when =
I'm sending=20
any commands for example to read BT_ADDR like this: 0x01 0x00 =
0x09.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>It doesn't respond to me, even with an =
error code -=20
nothing.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>But when I use first code from blueZ =
hciconfig like=20
this</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp;int&nbsp; clen =3D 0,=20
i;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
/* Command len */<BR>&nbsp;static int csr_seq =3D =
0;&nbsp;&nbsp;&nbsp;&nbsp; /*=20
Sequence number of command */<BR>&nbsp;int&nbsp;=20
divisor;<BR></STRONG></FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</STRONG=
></FONT><FONT=20
face=3DArial size=3D2><STRONG>&nbsp;/* Try to read the build ID of the =
CSR chip=20
*/<BR>&nbsp;clen =3D 5 + (5 + 6) * 2;<BR>&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;=20
&nbsp;/* HCI header */<BR>&nbsp;cmd[0] =3D =
HCI_COMMAND_PKT;<BR>&nbsp;cmd[1] =3D=20
0x09;&nbsp;&nbsp;/* CSR command */<BR>&nbsp;cmd[2] =3D =
0xfc;&nbsp;&nbsp;/*=20
MANUFACTURER_SPEC */<BR>&nbsp;cmd[3] =3D 1 + (5 + 6) * 2;&nbsp;/* len=20
*/<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* CSR MSG header=20
*/<BR>&nbsp;cmd[4] =3D 0xC2;&nbsp;&nbsp;/* first+last+channel=3DBCC=20
*/<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* CSR BCC header=20
*/<BR>&nbsp;cmd[5] =3D 0x00;&nbsp;&nbsp;/* type =3D GET-REQ =
*/<BR>&nbsp;cmd[6] =3D=20
0x00;&nbsp;&nbsp;/* - msB */<BR>&nbsp;cmd[7] =3D 5 + 4;&nbsp;&nbsp;/* =
len=20
*/<BR>&nbsp;cmd[8] =3D 0x00;&nbsp;&nbsp;/* - msB */<BR>&nbsp;cmd[9] =3D =
csr_seq=20
&amp; 0xFF;/* seq num */<BR>&nbsp;cmd[10] =3D (csr_seq &gt;&gt; 8) &amp; =

0xFF;&nbsp;/* - msB */<BR>&nbsp;csr_seq++;<BR>&nbsp;cmd[11] =3D=20
0x19;&nbsp;&nbsp;/* var_id =3D CSR_CMD_BUILD_ID */<BR>&nbsp;cmd[12] =3D=20
0x28;&nbsp;&nbsp;/* - msB */<BR>&nbsp;cmd[13] =3D 0x00;&nbsp;&nbsp;/* =
status =3D=20
STATUS_OK */<BR>&nbsp;cmd[14] =3D 0x00;&nbsp;&nbsp;/* - msB=20
*/<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* CSR BCC payload=20
*/<BR>&nbsp;memset(cmd + 15, 0, 6 * 2);</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp; =
do{<BR>&nbsp;&nbsp;&nbsp; for (i=3D0;=20
i &lt; clen+1; i++) PutByteU0 (cmd[i]);</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp;&nbsp;&nbsp;=20
read_hci_event(resp,100);</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp; }while (resp[1] !=3D=20
0xff);</STRONG></FONT></DIV>
<DIV><STRONG><FONT face=3DArial size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;=20
&nbsp;/* Try to read the current speed of the CSR chip */<BR>&nbsp;clen =
=3D 5 + (5=20
+ 4)*2;<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* -- HCI header=20
*/<BR>&nbsp;cmd[0] =3D HCI_COMMAND_PKT;<BR>&nbsp;cmd[1] =3D =
0x09;&nbsp;&nbsp;/* CSR=20
command */<BR>&nbsp;cmd[2] =3D 0xfc;&nbsp;&nbsp;/* MANUFACTURER_SPEC=20
*/<BR>&nbsp;cmd[3] =3D 1 + (5 + 4)*2;&nbsp;/* len=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* -- CSR =
BCC header=20
-- */<BR>&nbsp;cmd[9] =3D csr_seq &amp; 0xFF;&nbsp;/* seq num =
*/<BR>&nbsp;cmd[10]=20
=3D (csr_seq &gt;&gt; 8) &amp; 0xFF;&nbsp;/* - msB=20
*/<BR>&nbsp;csr_seq++;<BR>&nbsp;cmd[11] =3D 0x02;&nbsp;&nbsp;/* var_id =
=3D=20
CONFIG_UART */<BR>&nbsp;cmd[12] =3D 0x68;&nbsp;&nbsp;/* - msB=20
*/</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;=20
&nbsp;/* Now, create the command that will set the UART speed=20
*/<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* CSR BCC header=20
*/<BR>&nbsp;cmd[5] =3D 0x02;&nbsp;&nbsp;&nbsp;/* type =3D SET-REQ =
*/<BR>&nbsp;cmd[6]=20
=3D 0x00;&nbsp;&nbsp;&nbsp;/* - msB */<BR>&nbsp;cmd[9] =3D csr_seq &amp; =

0xFF;&nbsp;/* seq num */<BR>&nbsp;cmd[10] =3D (csr_seq &gt;&gt; 8) &amp; =
0xFF;/* -=20
msB */<BR>&nbsp;csr_seq++;</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp;divisor =3D=20
(921600*64+7812)/15625;</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* No =
parity, one=20
stop bit -&gt; divisor |=3D 0x0000; */<BR>&nbsp;cmd[15] =3D (divisor) =
&amp;=20
0xFF;&nbsp;&nbsp;/* divider */<BR>&nbsp;cmd[16] =3D (divisor &gt;&gt; 8) =
&amp;=20
0xFF;&nbsp;/* - msB */<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &nbsp;/* The rest of the payload will be 0x00=20
*/<BR></STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>&nbsp;&nbsp;&nbsp; for (i=3D0; =
i &lt; clen;=20
i++) PutByteU0 (cmd[i]);</STRONG></FONT></DIV>
<DIV><STRONG><FONT face=3DArial size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>It answers like this: 04 FF 13 C2 01 00 =
09 00 02 00=20
02 68 00 00 BF 0E 00 00 00 00 </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>What is it? Is it kind of special bits =
of csr chip=20
or what?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I know it is event but after this BT =
responds only=20
for bad commands like this 04 10 01 fe&nbsp; but when I try read BT_ADDR =
it's=20
quiet.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>What this code is up to? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Please send me UART specification or =
sth where it's=20
written how to set this up and howto communicate with csr chip. It's =
very=20
important for me !</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I spent almost 2 weeks to find out how =
to=20
communicate whit it and nothing works good. I don't know where to find =
some=20
info. I&nbsp;looked almost&nbsp;everywhere?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Maciej</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Maciej =
Zubilewicz</FONT></DIV></BODY></HTML>

------=_NextPart_000_0019_01C41388.E4907950--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
