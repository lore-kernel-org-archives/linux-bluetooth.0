Return-Path: <Steven.Singer@csr.com>
Message-ID: <406AF150.8080105@csr.com>
Date: Wed, 31 Mar 2004 17:26:56 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Simon Vogl <vogl@soft.uni-linz.ac.at>
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco / csr final notes
References: <406A9E23.9000406@soft.uni-linz.ac.at>
    <1080730774.2674.6.camel@pegasus> <406AAFFF.6040504@soft.uni-linz.ac.at>
    <406ADF3E.4020502@csr.com> <406AE027.7030000@soft.uni-linz.ac.at>
In-Reply-To: <406AE027.7030000@soft.uni-linz.ac.at>
Content-Type: text/plain; charset=windows-1252
List-ID: <bluez-devel.lists.sourceforge.net>

Simon Vogl wrote:
> Steven Singer wrote:
>> Is the problem that the link spontaneously changes from correct to noisy
>> in the middle of a link, or is it that when you start up a link it's
>> either OK for the durection of the link, or noisy for the duration of
>> the link and then when you tear it down and start a fresh link, the next
>> one is, independently, correct our noisy?
>> 
>> If it's the latter case, is the first link after a full reset (BCCMD
>> reset or power cycle - not merely an HCI reset) ever noisy?
>> 
> the latter is the case. Whenever a fresh sco link starts, I have a 50% chance of
> getting the wrong byte order..

Assuming it never happens for the first link, then it might be known issue
H16.169 (aka. B.104). This is present in 16.4 firmware and is fixed in
16.14. The following is the documentation of this issue from the 16.14
release note (I've marked the relevant section with >>>chevrons<<<):

------------------------------------------------------------------------
Appendix D – Issues Addressed Relative to HCI 16.4

[...]

ID:          B.104, H16.169
Severity:    High
Description:

If a system routes HCI SCO channels over USB, there is a high
probability that if two SCO channels are opened, and then one of them is
closed, then the firmware will crash. This problem has not been seen if
only one SCO channel is routed over USB. There is a related, but
technically independent, problem. >>>If a USB SCO link is closed, and
then a new USB SCO link is opened, it is possible for the second link’s
from-air audio to be badly distorted.<<<

The audio distortion problem occurs only where both SCO links use 16-bit
samples. The distortion occurs where the host does not collect all of
the bytes from the last HCI SCO packet of the first SCO link. The second
SCO link reuses the first link’s endpoint, and the link’s data
incorrectly starts with the first link’s few uncollected bytes. >>>This
can be an odd number of bytes, misaligning all subsequent 16-bit samples
by one byte.<<<

The same audio distortion misalignment can result from a race hazard
within the chip, even if the host takes all of the link’s trailing
bytes when closing the SCO link. In practice, the race hazard is the
primary cause of this problem arising. The distortion issue is similar
to issue H13.154, but that issue concerned from-host SCO USB traffic.

(HCI builds’ release notes have never claimed support for SCO over USB,
mainly because of the lack of suitable test equipment, so it is arguable
whether this issue should be categorised as being of “high” importance.)

Remedy
Both problems have been substantially improved in HCI 16.14. This avoids
the issue that causes the chip to crash. The same defensive code also
avoids the audio distortion problem.
------------------------------------------------------------------------

I think this confirms your observations. The error is a missing byte and
not an endian-ness switch. Upgrading your firmware should fix the
problem, otherwise, swallowing a byte when you notice the problem should
also ressurect the audio quality. Alternatively, you could always switch
to 8 bit samples.

Release notes are available on the CSR support web site if you have
suitable access permissions.

	- Steven
-- 



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
