Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <406B17A4.8000607@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Steven Singer <steven.singer@csr.com>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco / csr final notes
References: <406A9E23.9000406@soft.uni-linz.ac.at>     <1080730774.2674.6.camel@pegasus> <406AAFFF.6040504@soft.uni-linz.ac.at>     <406ADF3E.4020502@csr.com> <406AE027.7030000@soft.uni-linz.ac.at> <406AF150.8080105@csr.com>
In-Reply-To: <406AF150.8080105@csr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Date: Wed, 31 Mar 2004 20:10:28 +0100

Steven Singer wrote:
> Simon Vogl wrote:
> 
>>Steven Singer wrote:
>>
>>>Is the problem that the link spontaneously changes from correct to noisy
>>>in the middle of a link, or is it that when you start up a link it's
>>>either OK for the durection of the link, or noisy for the duration of
>>>the link and then when you tear it down and start a fresh link, the next
>>>one is, independently, correct our noisy?
>>>
>>>If it's the latter case, is the first link after a full reset (BCCMD
>>>reset or power cycle - not merely an HCI reset) ever noisy?
>>>
>>
>>the latter is the case. Whenever a fresh sco link starts, I have a 50% chance of
>>getting the wrong byte order..
> 
> 
> Assuming it never happens for the first link, then it might be known issue
> H16.169 (aka. B.104). This is present in 16.4 firmware and is fixed in
> 16.14. The following is the documentation of this issue from the 16.14
> release note (I've marked the relevant section with >>>chevrons<<<):
> 
> ------------------------------------------------------------------------
> Appendix D – Issues Addressed Relative to HCI 16.4
> 
> [...]
> 
> ID:          B.104, H16.169
> Severity:    High
> Description:
> 
> If a system routes HCI SCO channels over USB, there is a high
> probability that if two SCO channels are opened, and then one of them is
> closed, then the firmware will crash. This problem has not been seen if
> only one SCO channel is routed over USB. There is a related, but
> technically independent, problem. >>>If a USB SCO link is closed, and
> then a new USB SCO link is opened, it is possible for the second link’s
> from-air audio to be badly distorted.<<<
> 
> The audio distortion problem occurs only where both SCO links use 16-bit
> samples. The distortion occurs where the host does not collect all of
> the bytes from the last HCI SCO packet of the first SCO link. The second
> SCO link reuses the first link’s endpoint, and the link’s data
> incorrectly starts with the first link’s few uncollected bytes. >>>This
> can be an odd number of bytes, misaligning all subsequent 16-bit samples
> by one byte.<<<
> 
> The same audio distortion misalignment can result from a race hazard
> within the chip, even if the host takes all of the link’s trailing
> bytes when closing the SCO link. In practice, the race hazard is the
> primary cause of this problem arising. The distortion issue is similar
> to issue H13.154, but that issue concerned from-host SCO USB traffic.
> 
> (HCI builds’ release notes have never claimed support for SCO over USB,
> mainly because of the lack of suitable test equipment, so it is arguable
> whether this issue should be categorised as being of “high” importance.)
> 
> Remedy
> Both problems have been substantially improved in HCI 16.14. This avoids
> the issue that causes the chip to crash. The same defensive code also
> avoids the audio distortion problem.
> ------------------------------------------------------------------------
> 
> I think this confirms your observations. The error is a missing byte and
> not an endian-ness switch. Upgrading your firmware should fix the
> problem, otherwise, swallowing a byte when you notice the problem should
> also ressurect the audio quality. Alternatively, you could always switch
> to 8 bit samples.
> 
> Release notes are available on the CSR support web site if you have
> suitable access permissions.
> 
> 	- Steven

Just out of interest, how does one upgrade the firmware on a USB device 
using a CSR chip ?

I have this device: -

bash-2.05b# hciconfig hci0 version
hci0:   Type: USB
         BD Address: 00:A0:96:1F:42:BF ACL MTU: 192:8  SCO MTU: 64:8
         HCI Ver: 1.1 (0x1) HCI Rev: 0x135 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x135
         Manufacturer: Cambridge Silicon Radio (10)

bash-2.05b# hciconfig hci0 revision
hci0:   Type: USB
         BD Address: 00:A0:96:1F:42:BF ACL MTU: 192:8  SCO MTU: 64:8
         HCI 13.10
         Chip version: BlueCore01b
         Max key size: 56 bit
         SCO mapping:  HCI



Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
