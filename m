Return-Path: <lintner@c-lab.de>
Message-ID: <4132FF52.3070305@c-lab.de>
Date: Mon, 30 Aug 2004 12:20:02 +0200
From: Johannes <lintner@c-lab.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
References: <412DC001.3000307@c-lab.de> <1093519463.2581.3.camel@pegasus>
In-Reply-To: <1093519463.2581.3.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------050303090308000007080609"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050303090308000007080609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

sorry, but my time run out last week.
I put hcidump -x on, but I'm not familiar with the output, it gives to me.
Perhaps you can help me.
But this might be the section, that is relevant to my problem:

<>> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0068
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0068 result 0 status 0
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0068 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0068 flags 0x0000 clen 4
    MTU 1024
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 672
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x68 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 
667 max_retrans 0 credits 3
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x68 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0068
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0068
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16

The String I send to the server is 12bytes long, the other String 
6bytes, but I can't find any messages for these Strings.

Greetings Johannes


Marcel Holtmann wrote:

>Hi Johannes,
>
>  
>
>>I have the following problem.
>>I want to communicate from a mobile phone to an PC with the BlueZ-Stack 
>>and backwards.
>>In the beginning, I only want to sent short Strings. the way from the 
>>phone to the PC works, but the way backwards won't run.
>>The server side (PC) tells me, that it send the string (6 bytes long), 
>>the client (phone) do receive a connection, but the transported String 
>>is empty (is.read() = -1).
>>Is it possible, that the BlueZ implementation is the problem? I am sure, 
>>that my source (Java) works correct  (on my opinion the problem can 
>>cause on two reasons: the BlueZ Stack or the Bluetooth-Stack on my 
>>mobile phone).
>>    
>>
>
>go ahead and run "hcidump -x" on the Linux side to see what is going on.
>
>Regards
>
>Marcel
>
>
>
>
>  
>


--------------050303090308000007080609
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
sorry, but my time run out last week.<br>
I put hcidump -x on, but I'm not familiar with the output, it gives to
me.<br>
Perhaps you can help me.<br>
But this might be the section, that is relevant to my problem:<br>
<br>
<><small>&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0068<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0068 result 0 status 0<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0068 flags 0x0000 result 0 clen 0<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0068 flags 0x0000 clen 4<br>
&nbsp;&nbsp;&nbsp; MTU 1024<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 18<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4<br>
&nbsp;&nbsp;&nbsp; MTU 672<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x68 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 18<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 14 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size
667 max_retrans 0 credits 3<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x68 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0068<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0068<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&lt; HCI Command: Disconnect(0x01|0x0006) plen 3<br>
&nbsp; 29 00 13<br>
&gt; HCI Event: Command Status(0x0f) plen 4<br>
&nbsp; 00 01 06 04<br>
&gt; HCI Event: Disconn Complete(0x05) plen 4<br>
&nbsp; 00 29 00 16<br>
<br>
</small></>The String I send to the server is 12bytes long, the other
String 6bytes, but I can't find any messages for these Strings.<br>
<br>
Greetings Johannes<br>
<br>
<br>
Marcel Holtmann wrote:
<blockquote cite="mid1093519463.2581.3.camel@pegasus" type="cite">
  <pre wrap="">Hi Johannes,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I have the following problem.
I want to communicate from a mobile phone to an PC with the BlueZ-Stack 
and backwards.
In the beginning, I only want to sent short Strings. the way from the 
phone to the PC works, but the way backwards won't run.
The server side (PC) tells me, that it send the string (6 bytes long), 
the client (phone) do receive a connection, but the transported String 
is empty (is.read() = -1).
Is it possible, that the BlueZ implementation is the problem? I am sure, 
that my source (Java) works correct  (on my opinion the problem can 
cause on two reasons: the BlueZ Stack or the Bluetooth-Stack on my 
mobile phone).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
go ahead and run "hcidump -x" on the Linux side to see what is going on.

Regards

Marcel




  </pre>
</blockquote>
<br>
</body>
</html>

--------------050303090308000007080609--
