Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404D6D91.9050602@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [Bluez-devel] sco links]
References: <404C38C7.5040805@soft.uni-linz.ac.at> <404C64E9.7080106@superbug.demon.co.uk>
In-Reply-To: <404C64E9.7080106@superbug.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 09 Mar 2004 08:09:05 +0100

Hi James,
no problem, I can test whatever you like (except that I don't own a BT=20
analyser).
ad 1) is there some debug output I can enable in the, say, hci_usb=20
driver? Where should I add code there?
ad 2) noise is quite normal, I think, but it should not lead to the=20
'inverted stream' problem: If the header itself
    is alright, there might be noise in the data, but not a lost byte....

Give me a shovel, I start digging ;)
Simon

James Courtier-Dutton wrote:

> This problem might be related to how we deal with SCO in the bluez=20
> driver.
> Basically, we receive an URB with 10 usb frames it it, equivalent to=20
> 10ms.
> 3 usb frames make up a single SCO frame for the headset profile.
> We just assume that the first usb frame we get is the beginning of a=20
> SCO frame. We then just work on from there.
> First frame is header, get length from that header, grab the rest of=20
> the SCO frame based on header length.
> I have not determined in which situations this assumption is wrong.
> Here are some ideas, but I need to prove them right or wrong.
> 1) missed interrupt, so an urb gets lost.
> 2) air radio noise causing some of the HCI SCO data to be lost. I have=20
> been told that what happens on the air radio will not effect the=20
> contents of HCI SCO packets, as the CSR chip should fill in lost=20
> samples with predicted samples.
>
> The problem is that there is no CRC check in HCI SCO frames, so=20
> detecting whether some usb frame is the SCO header or not is difficult.
>
> Any suggestions?
>
> Cheers
> James
>
>
> Dr. Simon Vogl wrote:
>
>> Hi all,
>> it seems like this is the answer to sco quality problems - I see lots=20
>> of packets arriving on
>> a different channel, but patched to a size of 48:
>>
>>  < HCI Command: Add SCO Connection(0x01|0x0007) plen 4
>>  > HCI Event: Command Status(0x0f) plen 4
>>  > HCI Event: Max Slots Change(0x1b) plen 3
>>  > ACL data: handle 0x0029 flags 0x02 dlen 12
>>    L2CAP(s): Connect req: psm 1 scid 0x0070
>> < ACL data: handle 0x0029 flags 0x02 dlen 16
>>    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0070 result 0 status 0
>>  > HCI Event: Number of Completed Packets(0x13) plen 5
>>  > HCI Event: Connect Complete(0x03) plen 11
>> < SCO data: handle 0x002c dlen 48
>>  > SCO data: handle 0x0035 dlen 48
>>  > SCO data: handle 0x002c dlen 48
>>  > SCO data: handle 0x002c dlen 48
>>  > SCO data: handle 0x002c dlen 48
>>  > ACL data: handle 0x0029 flags 0x02 dlen 12
>>    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
>> < ACL data: handle 0x0029 flags 0x02 dlen 14
>>    L2CAP(s): Config rsp: scid 0x0070 flags 0x0000 result 0 clen 0
>> < ACL data: handle 0x0029 flags 0x02 dlen 12
>>    L2CAP(s): Config req: dcid 0x0070 flags 0x0000 clen 0
>> < SCO data: handle 0x002c dlen 48
>> < SCO data: handle 0x002c dlen 48
>>
>>
>>  > HCI Event: Mode Change(0x14) plen 6
>>  > HCI Event: Mode Change(0x14) plen 6
>>  > HCI Event: Connect Request(0x04) plen 10
>> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>>  > HCI Event: Command Status(0x0f) plen 4
>>  > HCI Event: Connect Complete(0x03) plen 11
>> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>> < SCO data: handle 0x002c dlen 48
>>  > HCI Event: Max Slots Change(0x1b) plen 3
>>  > HCI Event: Command Status(0x0f) plen 4
>>  > SCO data: handle 0x002e dlen 48
>>  > SCO data: handle 0x002c dlen 48
>>  > SCO data: handle 0x002c dlen 48
>> < SCO data: handle 0x002c dlen 48
>> < SCO data: handle 0x002c dlen 48
>>  > SCO data: handle 0x002c dlen 48
>>
>> It seems to me like the alternate handle id is created by a shift and=20
>> or operation (id | (id>>1))...
>> Can anyone knowing the usb driver better than me comment on this?
>> thx
>> Simon
>>
>>
>> ----------------------------------------------------------------------=
--
>>
>> Subject:
>> Re: [Bluez-devel] sco links
>> From:
>> Carl Orsborn <cjo@csr.com>
>> Date:
>> Wed, 03 Mar 2004 16:10:14 +0000
>> To:
>> Simon Vogl <vogl@soft.uni-linz.ac.at>
>>
>> To:
>> Simon Vogl <vogl@soft.uni-linz.ac.at>
>>
>> Return-Path:
>> <Carl.Orsborn@csr.com>
>> Received:
>> from mail1.edvz.uni-linz.ac.at (mail1.edvz.uni-linz.ac.at=20
>> [140.78.3.68]) by zeus.soft.uni-linz.ac.at (8.11.7p1+Sun/8.11.1) with=20
>> ESMTP id i23G8qj05391 for <vogl@soft.uni-linz.ac.at>; Wed, 3 Mar 2004=20
>> 17:08:52 +0100 (MET)
>> Received:
>> from mailsweeperjp.CSR.COM ([202.214.225.228]) by=20
>> mail1.edvz.uni-linz.ac.at (8.12.10/8.12.9) with ESMTP id=20
>> i23G8kRR043780 for <vogl@soft.uni-linz.ac.at>; Wed, 3 Mar 2004=20
>> 17:08:48 +0100 (CET) (envelope-from Carl.Orsborn@csr.com)
>> Received:
>> from exchangejp.csr.com (unverified) by mailsweeperjp.CSR.COM=20
>> (Content Technologies SMTPRS 4.3.1) with ESMTP id=20
>> <T681fd50e02c0a879019c4@mailsweeperjp.CSR.COM> for=20
>> <vogl@soft.uni-linz.ac.at>; Thu, 4 Mar 2004 01:10:55 +0900
>> Received:
>> from EXCHANGE02.csr.com ([192.168.137.45]) by exchangejp.csr.com with=20
>> Microsoft SMTPSVC (5.0.2195.6713); Wed, 3 Mar 2004 16:10:22 +0000
>> Received:
>> from csr.com ([192.168.143.41]) by EXCHANGE02.csr.com with Microsoft=20
>> SMTPSVC (5.0.2195.5329); Wed, 3 Mar 2004 16:10:14 +0000
>> Message-ID:
>> <40460366.4060903@csr.com>
>> User-Agent:
>> Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)=20
>> Gecko/20030624 Netscape/7.1 (ax)
>> X-Accept-Language:
>> en-us, en
>> MIME-Version:
>> 1.0
>> References:
>> <4045E93F.4040900@soft.uni-linz.ac.at>
>> In-Reply-To:
>> <4045E93F.4040900@soft.uni-linz.ac.at>
>> Content-Type:
>> text/plain; charset=3Dus-ascii; format=3Dflowed
>> Content-Transfer-Encoding:
>> 7bit
>> X-OriginalArrivalTime:
>> 03 Mar 2004 16:10:14.0469 (UTC) FILETIME=3D[03158750:01C4013A]
>>
>>
>> Hi, Simon.
>>
>> Not my normal domain, but the normal cause of misaligning by
>> 1 byte is that USB uses an isochronous (i.e., unreliable) channel
>> for SCO, and one can send an odd number of bytes in a USB packet,
>> so losing a packet leads to the offset.  Audio samples are normally
>> 16-bit numbers over HCI.
>>
>> In the CSR firmware we have to recognise the situation (by looking
>> for SCO HCI headers) and we nudge the stream index by 1 if needed.
>> (Old versions of CSR firmware don't have this fix.)
>>
>> I recall seeing a report that someone had coded this trick in
>> a USB host driver, possibly in a commercial stack.
>>
>> Just a guess.
>>
>> Carl
>>
>> Simon Vogl wrote:
>>
>>> hi,
>>> can anyone help me with my sco link? in about 50% of cases, the=20
>>> audio data
>>> has an offset of one byte, resulting in terrible noise. I think I saw=
 a
>>> flag in a packet header somewhere that indicates the number of bytes=20
>>> to skip
>>> until the audio data starts -- I looked through the bt specs several=20
>>> times now
>>> but can't find it again. Anyone has a clue for this?
>>> Simon
>>>
>>
>>


--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=FCr Pervasive Computing, Johannes Kepler Universit=E4t Linz
Altenberger Stra=DFe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
