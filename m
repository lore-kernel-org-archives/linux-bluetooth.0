Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404C38C7.5040805@soft.uni-linz.ac.at>
From: "Dr. Simon Vogl" <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: [Fwd: Re: [Bluez-devel] sco links]
Content-Type: multipart/mixed;
 boundary="------------010301070905070906010208"
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
Date: Mon, 08 Mar 2004 10:11:35 +0100

This is a multi-part message in MIME format.
--------------010301070905070906010208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
it seems like this is the answer to sco quality problems - I see lots of 
packets arriving on
a different channel, but patched to a size of 48:

  < HCI Command: Add SCO Connection(0x01|0x0007) plen 4
 > HCI Event: Command Status(0x0f) plen 4
 > HCI Event: Max Slots Change(0x1b) plen 3
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0070
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0070 result 0 status 0
 > HCI Event: Number of Completed Packets(0x13) plen 5
 > HCI Event: Connect Complete(0x03) plen 11
< SCO data: handle 0x002c dlen 48
 > SCO data: handle 0x0035 dlen 48
 > SCO data: handle 0x002c dlen 48
 > SCO data: handle 0x002c dlen 48
 > SCO data: handle 0x002c dlen 48
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0070 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0070 flags 0x0000 clen 0
< SCO data: handle 0x002c dlen 48
< SCO data: handle 0x002c dlen 48


 > HCI Event: Mode Change(0x14) plen 6
 > HCI Event: Mode Change(0x14) plen 6
 > HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
 > HCI Event: Command Status(0x0f) plen 4
 > HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
< SCO data: handle 0x002c dlen 48
 > HCI Event: Max Slots Change(0x1b) plen 3
 > HCI Event: Command Status(0x0f) plen 4
 > SCO data: handle 0x002e dlen 48
 > SCO data: handle 0x002c dlen 48
 > SCO data: handle 0x002c dlen 48
< SCO data: handle 0x002c dlen 48
< SCO data: handle 0x002c dlen 48
 > SCO data: handle 0x002c dlen 48

It seems to me like the alternate handle id is created by a shift and or 
operation (id | (id>>1))...
Can anyone knowing the usb driver better than me comment on this?
thx
Simon


--------------010301070905070906010208
Content-Type: message/rfc822;
 name="Re: [Bluez-devel] sco links"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [Bluez-devel] sco links"

Return-Path: <Carl.Orsborn@csr.com>
Received: from mail1.edvz.uni-linz.ac.at (mail1.edvz.uni-linz.ac.at [140.78.3.68])
	by zeus.soft.uni-linz.ac.at (8.11.7p1+Sun/8.11.1) with ESMTP id i23G8qj05391
	for <vogl@soft.uni-linz.ac.at>; Wed, 3 Mar 2004 17:08:52 +0100 (MET)
Received: from mailsweeperjp.CSR.COM ([202.214.225.228])
	by mail1.edvz.uni-linz.ac.at (8.12.10/8.12.9) with ESMTP id i23G8kRR043780
	for <vogl@soft.uni-linz.ac.at>; Wed, 3 Mar 2004 17:08:48 +0100 (CET)
	(envelope-from Carl.Orsborn@csr.com)
Received: from exchangejp.csr.com (unverified) by mailsweeperjp.CSR.COM
    (Content Technologies SMTPRS 4.3.1) with ESMTP id
    <T681fd50e02c0a879019c4@mailsweeperjp.CSR.COM> for
    <vogl@soft.uni-linz.ac.at>; Thu, 4 Mar 2004 01:10:55 +0900
Received: from EXCHANGE02.csr.com ([192.168.137.45]) by exchangejp.csr.com
    with Microsoft SMTPSVC (5.0.2195.6713); Wed, 3 Mar 2004 16:10:22 +0000
Received: from csr.com ([192.168.143.41]) by EXCHANGE02.csr.com with
    Microsoft SMTPSVC (5.0.2195.5329); Wed, 3 Mar 2004 16:10:14 +0000
Message-ID: <40460366.4060903@csr.com>
Date: Wed, 03 Mar 2004 16:10:14 +0000
From: Carl Orsborn <cjo@csr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)
    Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Vogl <vogl@soft.uni-linz.ac.at>
Subject: Re: [Bluez-devel] sco links
References: <4045E93F.4040900@soft.uni-linz.ac.at>
In-Reply-To: <4045E93F.4040900@soft.uni-linz.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2004 16:10:14.0469 (UTC)
    FILETIME=[03158750:01C4013A]

Hi, Simon.

Not my normal domain, but the normal cause of misaligning by
1 byte is that USB uses an isochronous (i.e., unreliable) channel
for SCO, and one can send an odd number of bytes in a USB packet,
so losing a packet leads to the offset.  Audio samples are normally
16-bit numbers over HCI.

In the CSR firmware we have to recognise the situation (by looking
for SCO HCI headers) and we nudge the stream index by 1 if needed.
(Old versions of CSR firmware don't have this fix.)

I recall seeing a report that someone had coded this trick in
a USB host driver, possibly in a commercial stack.

Just a guess.

Carl

Simon Vogl wrote:

> hi,
> can anyone help me with my sco link? in about 50% of cases, the audio data
> has an offset of one byte, resulting in terrible noise. I think I saw a
> flag in a packet header somewhere that indicates the number of bytes to 
> skip
> until the audio data starts -- I looked through the bt specs several 
> times now
> but can't find it again. Anyone has a clue for this?
> Simon
> 



**********************************************************************
The information transmitted is intended only for the person or
entity to which it is addressed and may contain confidential 
and/or privileged material. 
Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by 
persons or entities other than the intended recipient is 
prohibited. 
If you received this in error, please contact the sender and 
delete the material from any computer.
**********************************************************************

--------------010301070905070906010208--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
