Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruud Beukema <ruudbeukema@gmail.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/alternative; boundary="=-cUloKRdIBAfEGt3F6cS7"
Message-Id: <1146059734.19102.28.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] externally monitoring uart HCI data with the use of hcidump
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
Date: Wed, 26 Apr 2006 15:55:34 +0200


--=-cUloKRdIBAfEGt3F6cS7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I'm writing a HCI monitoring program which is able to capture HCI
traffic between a BlueCore and a Host independent from the BlueZ stack.
The program's output is a log of all HCI traffic in a format that can be
reread and interpret using the hcidump --read-dump=hcidumplog

The reaction on an earlier mail from my colleague (Han Hoekstra) didn't
solve the problem unfortunately, so I'll try to reformulate our problem
in more detail hoping you can help us out.

We're able to extract the BCSP packet from the SLIP layer. We're also
able to derive the HCI packet from the BCSP packet. But then, to put the
HCI packet in a hcidump usable format, a HCIDUMP HEADER must be put in
front of the HCI packet. This is where a first question is about.
According to the hcidump source code the HCI packet's header is a 12
byte header containing
    -    HCI packet length (2 byte)
    -    HCI packet direction (1 byte)
    -    HCI packet pad (1 byte)
    -    HCI timestamp seconds (4 byte)
    -    HCI timestamp microseconds (4 byte)

What's the pad byte's function/value?

Now the second question. When I retrieve a HCI packet and put a HCIDUMP
HEADER in front of it, it is not re-readable using hcidump. According to
the hci_dump function in hci.c (line: 2666) the first databyte of the
frame data holds the packet type which forms the starting point of the
interpretation of the HCI packet in hcidump. This packet type byte is an
extra byte not present in the real communication, but necessary for
hcidump to work properly. I can find the defines for the different
packet types (bluetooth/hci.h) but I can't figure out where and how this
byte is calculated or given a value. I first thought this byte was given
a value depending on the contents of the BCSP packet header, but I can
find no relationship between the two to be honest. (Maybe due to seeing
too much HEX code the last few days). So the question here is:

How to calculate the packet type byte between the HCIDUMP HEADER and the
original HCI packet?

I'd really appreciate your help!

Regards

Ruud

--=-cUloKRdIBAfEGt3F6cS7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.10.1">
</HEAD>
<BODY>
Hi,<BR>
<BR>
I'm writing a HCI monitoring program which is able to capture HCI traffic between a BlueCore and a Host independent from the BlueZ stack. The program's output is a log of all HCI traffic in a format that can be reread and interpret using the <B>hcidump --read-dump=</B><B><I>hcidumplog</I></B><BR>
<BR>
The reaction on an earlier mail from my colleague (Han Hoekstra) didn't solve the problem unfortunately, so I'll try to reformulate our problem in more detail hoping you can help us out.<BR>
<BR>
We're able to extract the BCSP packet from the SLIP layer. We're also able to derive the HCI packet from the BCSP packet. But then, to put the HCI packet in a <I>hcidump</I> usable format, a HCIDUMP HEADER must be put in front of the HCI packet. This is where a first question is about. According to the <I>hcidump</I> source code the HCI packet's header is a 12 byte header containing<BR>
&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; HCI packet length (2 byte)<BR>
&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; HCI packet direction (1 byte)<BR>
&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; <FONT COLOR="#ff0000"><B>HCI packet pad (1 byte)</B></FONT><BR>
&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; HCI timestamp seconds (4 byte)<BR>
&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; HCI timestamp microseconds (4 byte)<BR>
<BR>
<B>What's the </B><B><I>pad </I></B><B>byte's function/value?</B><BR>
<BR>
Now the second question. When I retrieve a HCI packet and put a HCIDUMP HEADER in front of it, it is not re-readable using <I>hcidump</I>. According to the hci_dump function in hci.c (<B>line:</B> 2666) the first databyte of the frame data holds the packet type which forms the starting point of the interpretation of the HCI packet in <I>hcidump</I>. This packet type byte is an extra byte not present in the real communication, but necessary for <I>hcidump</I> to work properly. I can find the defines for the different packet types (bluetooth/hci.h) but I can't figure out where and how this byte is calculated or given a value. I first thought this byte was given a value depending on the contents of the BCSP packet header, but I can find no relationship between the two to be honest. (Maybe due to seeing too much HEX code the last few days). So the question here is:<BR>
<BR>
<B>How to calculate the packet type byte between the HCIDUMP HEADER and the original HCI packet?</B><BR>
<BR>
I'd really appreciate your help!<BR>
<BR>
Regards<BR>
<BR>
Ruud
</BODY>
</HTML>

--=-cUloKRdIBAfEGt3F6cS7--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
