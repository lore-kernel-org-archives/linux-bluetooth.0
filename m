Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruud Beukema <ruudbeukema@gmail.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Message-Id: <1146125380.8784.39.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Capture HCI traffic between an embeddec BlueCore and Host
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
Date: Thu, 27 Apr 2006 10:09:40 +0200

Hi,

As one might recall from an earlier mail from my colleague Han Hoekstra,
I'm writing a HCI monitoring program in order to log the HCI
communication between an embedded BC-Host combination. The goal of the
program is to store the HCI packets in a file which has a format that
can be reread and re-interpreted by the hcidump program. In reaction to
this previous mail it was said that all information needed could be
found in the hcidump program's source code.

As far as I could derive from this source code the hcidump program puts
a 12-byte HCIDUMP HEADER in front of the original HCI packet and then
the whole hcidump packet is stored. What I discovered after comparing my
program's output with the hcidump file (in the setup where a BlueCore
dongle is attached to a PC) is that between the HCIDUMP HEADER and the
original HCI packet another byte is present.

This byte seems to hold the HCI packet type, which is used when the
hcidump program reads in a dumped log file. According to CSR
documentation this byte is appended in the MUX layer. To keep my program
independent from the BlueZ stack I have to recreate the value of this
byte. My guess is that the value of this byte depends on information
given in the BCSP header.

>>From a CSR powerpoint presentation I found out the BCSP packet header's
"protocol type nibble" can hold the following values (with their
meanings):
Protocol 0 is for ACK’s only
Protocol 1 is for Link Establishment
Protocol 5 is for Commands/Events
Protocol 6 is for ACL Data
Protocol 7 is for SCO Data

The HCI packet types defined are these
HCI_COMMAND_PKT 0x01
HCI_ACLDATA_PKT 0x02
HCI_SCODATA_PKT 0x03
HCI_EVENT_PKT   0x04
HCI_VENDOR_PKT  0xFF

I have BCSP header information available in my program and I have to
give this packet type byte a value. The problem here is that when I see
a protocol 5 (for COMMANDS and EVENTS) I still don't know whether it's a
HCI_COMMAND_PKT or a HCI_EVENT_PKT.

So, the main question: is my guess as described above right? And if not,
how can I provide the packet type byte?

A second (seemingly) less important question is what the HCIDUMP
HEADER's "pad" field stands for. I always see this one as being 0x00
using hcidump so I just follow this in my program, but this is off
course not very neat.

Thanks in advance!

Ruud



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
