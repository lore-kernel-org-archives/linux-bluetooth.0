Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
Subject: Re: [Bluez-devel] business card transfer problem
In-reply-to: <1269.1082534936@www62.gmx.net>
To: franz keuner <franz_keuner@gmx.net>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   bluez-devel@lists.sourceforge.net
Message-id: <1082540241.1939.57.camel@gryffindor>
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_YnoaWtHZwr3HG7WF5zZrcg)"
References: <1269.1082534936@www62.gmx.net>
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
Date: Wed, 21 Apr 2004 13:16:03 +0200


--Boundary_(ID_YnoaWtHZwr3HG7WF5zZrcg)
Content-type: text/plain
Content-transfer-encoding: 7BIT

   You might want to take a look at the hcid.conf man page in the CVS
version, which contains almost all the details you need in order to make
all this work,

Edouard

On Wed, 2004-04-21 at 10:08, franz keuner wrote:

> hi steve,
> 
> thanks for your quick answer. 
> that's the answer of my linux computer to hciconfig hci0 class
> 
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 192:8  SCO MTU: 64:8
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
> 
> i don't know what i have to change exactly here...
> 
> i read the bluetooth assigned numbers document. would i have to enter 
> 
> hciconfig hci0 class 0x100104
> 
> to make the right changes class? (the 1st hex number representing obex file
> transfer and the rest represting a desktop computer)
> 
> and if that's right, is the pda in contrast to the phone ignoring this
> mistake because it's possible to receive businesscards from the pda?
> 
> regards,
> 
> franz
> 
> > Hi Franz,
> > Make sure you have the correct class-of-device setting on the Linux box.
> > (See hciconfig(8).) Phones and PDAs often don't even bother doing an SDP
> > search if the device-class obtained by device discovery doesn't contain
> > the correct hint bits.
> > 
> > Cheers,
> > Steve
> > 
> > On Tue, 2004-04-20 at 09:56, franz keuner wrote:
> > > hi marcel,
> > > 
> > > for quite a while i had no questions concerning bluez and my Sony
> > Ericsson
> > > P900 ;-)
> > > with your help i made a lot of progress.
> > > 
> > > now i'm trying to send and receive businesscards (version2.1) between
> > the
> > > linux computer with bluez and the mobile phone.
> > > 
> > > i installed the openobex package for suse 9.0 and the openobex
> > applications.
> > > 
> > > i can send a businesscard from the linux computer to the mobile phone
> > using
> > > the obextest tool from the applications package.
> > > 
> > > but if i try to receive a businesscard from the mobile phone on the
> > linux
> > > computer with the opd program the phone reports a failure trying to
> > transfer
> > > the businesscard to the linux computer.
> > > 
> > > but it works if i try to send the same businesscard from the phone to a
> > pda.
> > > the pda receives the businesscard correctly.
> > > 
> > > and if try to receive the businesscard from the pda on the linux
> > computer
> > > with the opd program this is also working.
> > > 
> > > i'm sure i'm listening on the right channels. maybe the problem is that
> > the
> > > phone can't communicate with the opd program waiting for a connection...
> > > 
> > > do you have any ideas or hints?
> > > 
> > > regards,
> > > 
> > > franz
> > > 
> > > hcidump shows the following trying to the send from the phone to the
> > linux
> > > computer:
> > > 
> > > hcidump r
> > > HCIDump - HCI packet analyzer ver 1.5
> > > device: hci0 snap_len: 1028 filter: 0xffffffff
> > > > HCI Event: Connect Request(0x04) plen 10
> > > < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> > > > HCI Event: Command Status(0x0f) plen 4
> > > > HCI Event: Connect Complete(0x03) plen 11
> > > < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> > > > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> > > > HCI Event: Command Complete(0x0e) plen 6
> > > < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4

-- 
Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
Schlumberger

--Boundary_(ID_YnoaWtHZwr3HG7WF5zZrcg)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
&nbsp;&nbsp; You might want to take a look at the hcid.conf man page in the CVS version, which contains almost all the details you need in order to make all this work,<BR>
<BR>
Edouard<BR>
<BR>
On Wed, 2004-04-21 at 10:08, franz keuner wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#483689"><I>hi steve,

thanks for your quick answer. 
that's the answer of my linux computer to hciconfig hci0 class

hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 192:8  SCO MTU: 64:8
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized

i don't know what i have to change exactly here...

i read the bluetooth assigned numbers document. would i have to enter 

hciconfig hci0 class 0x100104

to make the right changes class? (the 1st hex number representing obex file
transfer and the rest represting a desktop computer)

and if that's right, is the pda in contrast to the phone ignoring this
mistake because it's possible to receive businesscards from the pda?

regards,

franz

&gt; Hi Franz,
&gt; Make sure you have the correct class-of-device setting on the Linux box.
&gt; (See hciconfig(8).) Phones and PDAs often don't even bother doing an SDP
&gt; search if the device-class obtained by device discovery doesn't contain
&gt; the correct hint bits.
&gt; 
&gt; Cheers,
&gt; Steve
&gt; 
&gt; On Tue, 2004-04-20 at 09:56, franz keuner wrote:
&gt; &gt; hi marcel,
&gt; &gt; 
&gt; &gt; for quite a while i had no questions concerning bluez and my Sony
&gt; Ericsson
&gt; &gt; P900 ;-)
&gt; &gt; with your help i made a lot of progress.
&gt; &gt; 
&gt; &gt; now i'm trying to send and receive businesscards (version2.1) between
&gt; the
&gt; &gt; linux computer with bluez and the mobile phone.
&gt; &gt; 
&gt; &gt; i installed the openobex package for suse 9.0 and the openobex
&gt; applications.
&gt; &gt; 
&gt; &gt; i can send a businesscard from the linux computer to the mobile phone
&gt; using
&gt; &gt; the obextest tool from the applications package.
&gt; &gt; 
&gt; &gt; but if i try to receive a businesscard from the mobile phone on the
&gt; linux
&gt; &gt; computer with the opd program the phone reports a failure trying to
&gt; transfer
&gt; &gt; the businesscard to the linux computer.
&gt; &gt; 
&gt; &gt; but it works if i try to send the same businesscard from the phone to a
&gt; pda.
&gt; &gt; the pda receives the businesscard correctly.
&gt; &gt; 
&gt; &gt; and if try to receive the businesscard from the pda on the linux
&gt; computer
&gt; &gt; with the opd program this is also working.
&gt; &gt; 
&gt; &gt; i'm sure i'm listening on the right channels. maybe the problem is that
&gt; the
&gt; &gt; phone can't communicate with the opd program waiting for a connection...
&gt; &gt; 
&gt; &gt; do you have any ideas or hints?
&gt; &gt; 
&gt; &gt; regards,
&gt; &gt; 
&gt; &gt; franz
&gt; &gt; 
&gt; &gt; hcidump shows the following trying to the send from the phone to the
&gt; linux
&gt; &gt; computer:
&gt; &gt; 
&gt; &gt; hcidump r
&gt; &gt; HCIDump - HCI packet analyzer ver 1.5
&gt; &gt; device: hci0 snap_len: 1028 filter: 0xffffffff
&gt; &gt; &gt; HCI Event: Connect Request(0x04) plen 10
&gt; &gt; &lt; HCI Command: Accept Connection Request(0x01|0x0009) plen 7
&gt; &gt; &gt; HCI Event: Command Status(0x0f) plen 4
&gt; &gt; &gt; HCI Event: Connect Complete(0x03) plen 11
&gt; &gt; &lt; HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
&gt; &gt; &gt; HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
&gt; &gt; &gt; HCI Event: Command Complete(0x0e) plen 6
&gt; &gt; &lt; HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4</I></FONT></PRE>
</BLOCKQUOTE>
<PRE><TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Edouard Lafargue &lt;<A HREF="mailto:ELafargue@montrouge.sns.slb.com"><U>ELafargue@montrouge.sns.slb.com</U></A>&gt;<BR>
Schlumberger
</TD>
</TR>
</TABLE>
</PRE>
</BODY>
</HTML>

--Boundary_(ID_YnoaWtHZwr3HG7WF5zZrcg)--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
